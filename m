Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755604AbeEHTmq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:42:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44048 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEHTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:42:45 -0400
X-Google-Smtp-Source: AB8JxZpcmQb9fzFExE1X5CVOO1z3M3sI+XyZPC7OsIht/eRVDAGTJJAFc0rlPIOyPsp+05C0CKaXVQ==
Date: Tue, 8 May 2018 13:42:41 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 26/27] coresight: perf: Remove reset_buffer call back
 for sinks
Message-ID: <20180508194241.GC3389@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-27-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-27-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:56AM +0100, Suzuki K Poulose wrote:
> Right now we issue an update_buffer() and reset_buffer() call backs
> in succession when we stop tracing an event. The update_buffer is
> supposed to check the status of the buffer and make sure the ring buffer
> is updated with the trace data. And we store information about the
> size of the data collected only to be consumed by the reset_buffer
> callback which always follows the update_buffer. This was originally
> designed for handling future IPs which could trigger a buffer overflow
> interrupt. This patch gets rid of the reset_buffer callback altogether
> and performs the actions in update_buffer, making it return the size
> collected. We can always add the support for handling the overflow
> interrupt case later.
> 
> This removes some not-so pretty hack (storing the new head in the
> size field for snapshot mode) and cleans it up a little bit.

IPs with an overflow interrupts will be arriving shortly, so it is not like the
future is uncertain - they are coming.  Right now the logic is there - I don't
see a real need to consolidate things only to split it again in the near future.

I agree the part about overloading buf->data_size with the head of the ring
buffer when operating in snapshot mode isn't pretty (though well documented).
If anything that can be improve, i.e add a buf->head and things will be clear.
Once again this could be part of another patchset.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c    | 56 +++++------------------
>  drivers/hwtracing/coresight/coresight-etm-perf.c |  9 +---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c  | 58 +++++-------------------
>  include/linux/coresight.h                        |  5 +-
>  4 files changed, 26 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index d9c2f87..b13712a 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -322,37 +322,7 @@ static int etb_set_buffer(struct coresight_device *csdev,
>  	return ret;
>  }
>  
> -static unsigned long etb_reset_buffer(struct coresight_device *csdev,
> -				      struct perf_output_handle *handle,
> -				      void *sink_config)
> -{
> -	unsigned long size = 0;
> -	struct cs_buffers *buf = sink_config;
> -
> -	if (buf) {
> -		/*
> -		 * In snapshot mode ->data_size holds the new address of the
> -		 * ring buffer's head.  The size itself is the whole address
> -		 * range since we want the latest information.
> -		 */
> -		if (buf->snapshot)
> -			handle->head = local_xchg(&buf->data_size,
> -						  buf->nr_pages << PAGE_SHIFT);
> -
> -		/*
> -		 * Tell the tracer PMU how much we got in this run and if
> -		 * something went wrong along the way.  Nobody else can use
> -		 * this cs_buffers instance until we are done.  As such
> -		 * resetting parameters here and squaring off with the ring
> -		 * buffer API in the tracer PMU is fine.
> -		 */
> -		size = local_xchg(&buf->data_size, 0);
> -	}
> -
> -	return size;
> -}
> -
> -static void etb_update_buffer(struct coresight_device *csdev,
> +static unsigned long etb_update_buffer(struct coresight_device *csdev,
>  			      struct perf_output_handle *handle,
>  			      void *sink_config)
>  {
> @@ -361,13 +331,13 @@ static void etb_update_buffer(struct coresight_device *csdev,
>  	u8 *buf_ptr;
>  	const u32 *barrier;
>  	u32 read_ptr, write_ptr, capacity;
> -	u32 status, read_data, to_read;
> -	unsigned long offset;
> +	u32 status, read_data;
> +	unsigned long offset, to_read;
>  	struct cs_buffers *buf = sink_config;
>  	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
>  	if (!buf)
> -		return;
> +		return 0;
>  
>  	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
>  
> @@ -472,18 +442,17 @@ static void etb_update_buffer(struct coresight_device *csdev,
>  	writel_relaxed(0x0, drvdata->base + ETB_RAM_WRITE_POINTER);
>  
>  	/*
> -	 * In snapshot mode all we have to do is communicate to
> -	 * perf_aux_output_end() the address of the current head.  In full
> -	 * trace mode the same function expects a size to move rb->aux_head
> -	 * forward.
> +	 * In snapshot mode we have to update the handle->head to point
> +	 * to the new location.
>  	 */
> -	if (buf->snapshot)
> -		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
> -	else
> -		local_add(to_read, &buf->data_size);
> -
> +	if (buf->snapshot) {
> +		handle->head = (cur * PAGE_SIZE) + offset;
> +		to_read = buf->nr_pages << PAGE_SHIFT;
> +	}
>  	etb_enable_hw(drvdata);
>  	CS_LOCK(drvdata->base);
> +
> +	return to_read;
>  }
>  
>  static const struct coresight_ops_sink etb_sink_ops = {
> @@ -492,7 +461,6 @@ static const struct coresight_ops_sink etb_sink_ops = {
>  	.alloc_buffer	= etb_alloc_buffer,
>  	.free_buffer	= etb_free_buffer,
>  	.set_buffer	= etb_set_buffer,
> -	.reset_buffer	= etb_reset_buffer,
>  	.update_buffer	= etb_update_buffer,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 4e5ed65..5096def 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -342,15 +342,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  		if (!sink_ops(sink)->update_buffer)
>  			return;
>  
> -		sink_ops(sink)->update_buffer(sink, handle,
> +		size = sink_ops(sink)->update_buffer(sink, handle,
>  					      event_data->snk_config);
> -
> -		if (!sink_ops(sink)->reset_buffer)
> -			return;
> -
> -		size = sink_ops(sink)->reset_buffer(sink, handle,
> -						    event_data->snk_config);
> -
>  		perf_aux_output_end(handle, size);
>  	}
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 0a32734..75ef5c4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -360,36 +360,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
>  	return ret;
>  }
>  
> -static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
> -					  struct perf_output_handle *handle,
> -					  void *sink_config)
> -{
> -	long size = 0;
> -	struct cs_buffers *buf = sink_config;
> -
> -	if (buf) {
> -		/*
> -		 * In snapshot mode ->data_size holds the new address of the
> -		 * ring buffer's head.  The size itself is the whole address
> -		 * range since we want the latest information.
> -		 */
> -		if (buf->snapshot)
> -			handle->head = local_xchg(&buf->data_size,
> -						  buf->nr_pages << PAGE_SHIFT);
> -		/*
> -		 * Tell the tracer PMU how much we got in this run and if
> -		 * something went wrong along the way.  Nobody else can use
> -		 * this cs_buffers instance until we are done.  As such
> -		 * resetting parameters here and squaring off with the ring
> -		 * buffer API in the tracer PMU is fine.
> -		 */
> -		size = local_xchg(&buf->data_size, 0);
> -	}
> -
> -	return size;
> -}
> -
> -static void tmc_update_etf_buffer(struct coresight_device *csdev,
> +static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  				  struct perf_output_handle *handle,
>  				  void *sink_config)
>  {
> @@ -398,17 +369,17 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
>  	const u32 *barrier;
>  	u32 *buf_ptr;
>  	u64 read_ptr, write_ptr;
> -	u32 status, to_read;
> -	unsigned long offset;
> +	u32 status;
> +	unsigned long offset, to_read;
>  	struct cs_buffers *buf = sink_config;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
>  	if (!buf)
> -		return;
> +		return 0;
>  
>  	/* This shouldn't happen */
>  	if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
> -		return;
> +		return 0;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -497,18 +468,14 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
>  		}
>  	}
>  
> -	/*
> -	 * In snapshot mode all we have to do is communicate to
> -	 * perf_aux_output_end() the address of the current head.  In full
> -	 * trace mode the same function expects a size to move rb->aux_head
> -	 * forward.
> -	 */
> -	if (buf->snapshot)
> -		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
> -	else
> -		local_add(to_read, &buf->data_size);
> -
> +	/* In snapshot mode we have to update the head */
> +	if (buf->snapshot) {
> +		handle->head = (cur * PAGE_SIZE) + offset;
> +		to_read = buf->nr_pages << PAGE_SHIFT;
> +	}
>  	CS_LOCK(drvdata->base);
> +
> +	return to_read;
>  }
>  
>  static const struct coresight_ops_sink tmc_etf_sink_ops = {
> @@ -517,7 +484,6 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.alloc_buffer	= tmc_alloc_etf_buffer,
>  	.free_buffer	= tmc_free_etf_buffer,
>  	.set_buffer	= tmc_set_etf_buffer,
> -	.reset_buffer	= tmc_reset_etf_buffer,
>  	.update_buffer	= tmc_update_etf_buffer,
>  };
>  
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c0e1568..41b3729 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -212,10 +212,7 @@ struct coresight_ops_sink {
>  	int (*set_buffer)(struct coresight_device *csdev,
>  			  struct perf_output_handle *handle,
>  			  void *sink_config);
> -	unsigned long (*reset_buffer)(struct coresight_device *csdev,
> -				      struct perf_output_handle *handle,
> -				      void *sink_config);
> -	void (*update_buffer)(struct coresight_device *csdev,
> +	unsigned long (*update_buffer)(struct coresight_device *csdev,
>  			      struct perf_output_handle *handle,
>  			      void *sink_config);
>  };
> -- 
> 2.7.4
> 
