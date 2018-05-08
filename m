Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755975AbeEHWEe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:04:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46882 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755845AbeEHWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:04:31 -0400
X-Google-Smtp-Source: AB8JxZr1Y7Yf8LVvWjhilD8IffttecA0xIg0u06v34DsZTiAMYhvWInsXRsdTpE6tuNecFnCmjfnMA==
Date: Tue, 8 May 2018 16:04:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 27/27] coresight: etm-perf: Add support for ETR backend
Message-ID: <20180508220427.GD3389@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-28-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-28-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:57AM +0100, Suzuki K Poulose wrote:
> Add necessary support for using ETR as a sink in ETM perf tracing.
> We try make the best use of the available modes of buffers to
> try and avoid software double buffering.
> 
> We can use the perf ring buffer for ETR directly if all of the
> conditions below are met :
>  1) ETR is DMA coherent
>  2) perf is used in snapshot mode. In full tracing mode, we cannot
>     guarantee that the ETR will stop before it overwrites the data
>     at the beginning of the trace buffer leading to loss of trace
>     data. (The buffer which is being consumed by the perf is still
>     hidden from the ETR).
>  3) ETR supports save-restore with a scatter-gather mechanism
>     which can use a given set of pages we use the perf ring buffer
>     directly. If we have an in-built TMC ETR Scatter Gather unit,
>     we make use of a circular SG list to restart from a given head.
>     However, we need to align the starting offset to 4K in this case.
>     With CATU and ETR Save restore feature, we don't have to necessarily
>     align the head of the buffer.
> 
> If the ETR doesn't support either of this, we fallback to software
> double buffering.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> 
> Note: The conditions above need some rethink.
> 
> For (1) : We always sync the buffer for CPU, before we update the
> pointers. So, we should be safe here and should be able to remove
> this condition.
> 
> (2) is a bit more of problem, as the ETR (without SFIFO_2 mode)
> doesn't stop writing out the trace buffer, eventhough we exclude
> the part of the ring buffer currently consumed by perf, leading
> to loss of data. Also, since we don't have an interrupt (without
> SFIFO_2), we can't wake up the userspace reliably to consume
> the data.
> 
> One possible option is to use an hrtimer to wake up the userspace
> early enough, using a low wakeup mark. But that doesn't necessarily
> guarantee that the ETR will not wrap around overwriting the data,
> as we can't modify the ETR pointers, unless we disable it, which
> could again potentially cause data loss in Circular Buffer mode.
> We may still be able to detect if there was a data loss by checking
> how far the userspace has consumed the data.

I thought about timers before but as you point out it comes with a wealth of
problems.  Not having a buffer overflow interrupt is just a HW limitation we
need to live with until something better comes along.

> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 387 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
>  2 files changed, 386 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 8159e84..3e9ba02 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -31,6 +31,32 @@ struct etr_flat_buf {
>  };
>  
>  /*
> + * etr_perf_buffer - Perf buffer used for ETR
> + * @etr_buf		- Actual buffer used by the ETR
> + * @snaphost		- Perf session mode
> + * @head		- handle->head at the beginning of the session.
> + * @nr_pages		- Number of pages in the ring buffer.
> + * @pages		- Pages in the ring buffer.
> + * @flags		- Capabilities of the hardware buffer used in the
> + *			  session. If flags == 0, we use software double
> + *			  buffering.
> + */
> +struct etr_perf_buffer {
> +	struct etr_buf		*etr_buf;
> +	bool			snapshot;
> +	unsigned long		head;
> +	int			nr_pages;
> +	void			**pages;
> +	u32			flags;
> +};
> +
> +/* Convert the perf index to an offset within the ETR buffer */
> +#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> +
> +/* Lower limit for ETR hardware buffer in double buffering mode */
> +#define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
> +
> +/*
>   * The TMC ETR SG has a page size of 4K. The SG table contains pointers
>   * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
>   * 4K (i.e, 16KB or 64KB). This implies that a single OS page could
> @@ -1164,7 +1190,7 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
>  }
>  
> -static int __maybe_unused
> +static int
>  tmc_restore_etr_buf(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
>  		    unsigned long r_offset, unsigned long w_offset,
>  		    unsigned long size, u32 status)
> @@ -1415,10 +1441,361 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	return ret;
>  }
>  
> +/*
> + * tmc_etr_setup_perf_buf: Allocate ETR buffer for use by perf. We try to
> + * use perf ring buffer pages for the ETR when we can. In the worst case
> + * we fallback to software double buffering. The size of the hardware buffer
> + * in this case is dependent on the size configured via sysfs, if we can't
> + * match the perf ring buffer size. We scale down the size by half until
> + * it reaches a limit of 1M, beyond which we give up.
> + */
> +static struct etr_perf_buffer *
> +tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
> +		       void **pages, bool snapshot)
> +{
> +	int i;
> +	struct etr_buf *etr_buf;
> +	struct etr_perf_buffer *etr_perf;
> +	unsigned long size;
> +	unsigned long buf_flags[] = {
> +					ETR_BUF_F_RESTORE_FULL,
> +					ETR_BUF_F_RESTORE_MINIMAL,
> +					0,
> +				    };
> +
> +	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
> +	if (!etr_perf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	size = nr_pages << PAGE_SHIFT;
> +	/*
> +	 * TODO: We need to refine the following rule.
> +	 *
> +	 * We can use the perf ring buffer for ETR only if it is coherent
> +	 * and used in snapshot mode.
> +	 *
> +	 * The ETR (without SFIFO_2 mode) cannot stop writing when a
> +	 * certain limit is reached, nor can it interrupt driver.
> +	 * We can protect the data which is being consumed by the
> +	 * userspace, by hiding it from the ETR's tables. So, we could
> +	 * potentially loose the trace data only for the current session
> +	 * session if the ETR wraps around.
> +	 */
> +	if (tmc_etr_has_cap(drvdata, TMC_ETR_COHERENT) && snapshot) {
> +		for (i = 0; buf_flags[i]; i++) {
> +			etr_buf = tmc_alloc_etr_buf(drvdata, size,
> +						 buf_flags[i], node, pages)

Indentation

> +			if (!IS_ERR(etr_buf)) {
> +				etr_perf->flags = buf_flags[i];
> +				goto done;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * We have to now fallback to software double buffering.
> +	 * The tricky decision is choosing a size for the hardware buffer.
> +	 * We could start with drvdata->size (configurable via sysfs) and
> +	 * scale it down until we can allocate the data.
> +	 */
> +	etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);

The above comment doesn't match the code.  We start with a buffer size equal to
what was requested and then fall back to drvdata->size if something goes wrong.

I don't see why drvdata->size gets involved at all.  I would simply try to
reduce @size until we get a successful allocation.

> +	if (!IS_ERR(etr_buf))
> +		goto done;
> +	size = drvdata->size;
> +	do {
> +		etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
> +		if (!IS_ERR(etr_buf))
> +			goto done;
> +		size /= 2;
> +	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
> +
> +	kfree(etr_perf);
> +	return ERR_PTR(-ENOMEM);
> +
> +done:
> +	etr_perf->etr_buf = etr_buf;
> +	return etr_perf;
> +}
> +
> +
> +static void *tmc_etr_alloc_perf_buffer(struct coresight_device *csdev,
> +					int cpu, void **pages, int nr_pages,
> +					bool snapshot)
> +{
> +	struct etr_perf_buffer *etr_perf;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +
> +	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
> +					     nr_pages, pages, snapshot);
> +	if (IS_ERR(etr_perf)) {
> +		dev_dbg(drvdata->dev, "Unable to allocate ETR buffer\n");
> +		return NULL;
> +	}
> +
> +	etr_perf->snapshot = snapshot;
> +	etr_perf->nr_pages = nr_pages;
> +	etr_perf->pages = pages;
> +
> +	return etr_perf;
> +}
> +
> +static void tmc_etr_free_perf_buffer(void *config)
> +{
> +	struct etr_perf_buffer *etr_perf = config;
> +
> +	if (etr_perf->etr_buf)
> +		tmc_free_etr_buf(etr_perf->etr_buf);
> +	kfree(etr_perf);
> +}
> +
> +/*
> + * Pad the etr buffer with barrier packets to align the head to 4K aligned
> + * offset. This is required for ETR SG backed buffers, so that we can rotate
> + * the buffer easily and avoid a software double buffering.
> + */
> +static long tmc_etr_pad_perf_buffer(struct etr_perf_buffer *etr_perf, long head)
> +{
> +	long new_head;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	head = PERF_IDX2OFF(head, etr_perf);
> +	new_head = ALIGN(head, SZ_4K);
> +	if (head == new_head)
> +		return head;
> +	/*
> +	 * If the padding is not aligned to barrier packet size
> +	 * we can't do much.
> +	 */
> +	if ((new_head - head) % CORESIGHT_BARRIER_PKT_SIZE)
> +		return -EINVAL;
> +	return tmc_etr_buf_insert_barrier_packets(etr_buf, head,
> +						  new_head - head);
> +}
> +
> +static int tmc_etr_set_perf_buffer(struct coresight_device *csdev,
> +				   struct perf_output_handle *handle,
> +				   void *config)
> +{
> +	int rc;
> +	unsigned long flags;
> +	long head, new_head;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_perf_buffer *etr_perf = config;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	etr_perf->head = handle->head;
> +	head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> +	switch (etr_perf->flags) {
> +	case ETR_BUF_F_RESTORE_MINIMAL:
> +		new_head = tmc_etr_pad_perf_buffer(etr_perf, head);
> +		if (new_head < 0)
> +			return new_head;
> +		if (head != new_head) {
> +			rc = perf_aux_output_skip(handle, new_head - head);
> +			if (rc)
> +				return rc;
> +			etr_perf->head = handle->head;
> +			head = new_head;
> +		}
> +		/* Fall through */
> +	case ETR_BUF_F_RESTORE_FULL:
> +		rc = tmc_restore_etr_buf(drvdata, etr_buf,
> +					 head, head, handle->size, 0);
> +		break;
> +	case 0:
> +		/* Nothing to do here. */
> +		rc = 0;
> +		break;
> +	default:
> +		dev_warn(drvdata->dev, "Unexpected flags in etr_perf buffer\n");
> +		WARN_ON(1);
> +		rc = -EINVAL;
> +	}
> +
> +	/*
> +	 * This sink is going to be used in perf mode. No other session can
> +	 * grab it from us. So set the perf mode specific data here. This will
> +	 * be released just before we disable the sink from update_buffer call
> +	 * back.
> +	 */
> +	if (!rc) {
> +		spin_lock_irqsave(&drvdata->spinlock, flags);
> +		if (WARN_ON(drvdata->perf_data))
> +			rc = -EBUSY;
> +		else
> +			drvdata->perf_data = etr_perf;
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	}
> +	return rc;
> +}
> +
> +/*
> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
> + * buffer to the perf ring buffer.
> + */
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +{
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +	long bytes, to_copy;
> +	unsigned long head = etr_perf->head;
> +	unsigned long pg_idx, pg_offset, src_offset;
> +	char **dst_pages, *src_buf;
> +
> +	head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> +	pg_idx = head >> PAGE_SHIFT;
> +	pg_offset = head & (PAGE_SIZE - 1);
> +	dst_pages = (char **)etr_perf->pages;
> +	src_offset = etr_buf->offset;
> +	to_copy = etr_buf->len;
> +
> +	while (to_copy > 0) {
> +		/*
> +		 * We can copy minimum of :
> +		 *  1) what is available in the source buffer,
> +		 *  2) what is available in the source buffer, before it
> +		 *     wraps around.
> +		 *  3) what is available in the destination page.
> +		 * in one iteration.
> +		 */
> +		bytes = tmc_etr_buf_get_data(etr_buf, src_offset, to_copy,
> +					     &src_buf);
> +		if (WARN_ON_ONCE(bytes <= 0))
> +			break;
> +		if (PAGE_SIZE - pg_offset <  bytes)
> +			bytes = PAGE_SIZE - pg_offset;
> +
> +		memcpy(dst_pages[pg_idx] + pg_offset, src_buf, bytes);
> +		to_copy -= bytes;
> +		/* Move destination pointers */
> +		pg_offset += bytes;
> +		if (pg_offset == PAGE_SIZE) {
> +			pg_offset = 0;
> +			if (++pg_idx == etr_perf->nr_pages)
> +				pg_idx = 0;
> +		}
> +
> +		/* Move source pointers */
> +		src_offset += bytes;
> +		if (src_offset >= etr_buf->size)
> +			src_offset -= etr_buf->size;
> +	}
> +}
> +
> +/*
> + * XXX: What is the expected behavior here in the following cases ?
> + *  1) Full trace mode, without double buffering : What should be the size
> + *     reported back when the buffer is full and has wrapped around. Ideally,
> + *     we should report for the lost trace to make sure the "head" in the ring
> + *     buffer comes back to the position as in the trace buffer, rather than
> + *     returning "total size" of the buffer.

I agree with the above strategy as there isn't much else to do.  But do we
actually have a DMA coherent ETR SG or CATU?  From the documentation available
to me I don't see it for ERT SG and I don't have the one for CATU.  My hope
would be to get an IP with an overflow interrupt _before_ one that is DMA
coherent.


> + * 2) In snapshot mode, should we always return "full buffer size" ?

Snapshot mode is currently broken, something I intend to fix shortly.  Until
then and to follow what is done for other IPs I think it is best to return the
full size.

> + */
> +static unsigned long
> +tmc_etr_update_perf_buffer(struct coresight_device *csdev,
> +			   struct perf_output_handle *handle,
> +			   void *config)
> +{
> +	bool double_buffer, lost = false;
> +	unsigned long flags, offset, size = 0;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_perf_buffer *etr_perf = config;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	double_buffer = (etr_perf->flags == 0);
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (WARN_ON(drvdata->perf_data != etr_perf)) {
> +		lost = true;
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		goto out;
> +	}
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	tmc_flush_and_stop(drvdata);
> +
> +	tmc_sync_etr_buf(drvdata);
> +	CS_UNLOCK(drvdata->base);
> +	/* Reset perf specific data */
> +	drvdata->perf_data = NULL;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	offset = etr_buf->offset + etr_buf->len;
> +	if (offset > etr_buf->size)
> +		offset -= etr_buf->size;
> +
> +	if (double_buffer) {
> +		/*
> +		 * If we use software double buffering, update the ring buffer.
> +		 * And the size is what we have in the hardware buffer.
> +		 */
> +		size = etr_buf->len;
> +		tmc_etr_sync_perf_buffer(etr_perf);
> +	} else {
> +		/*
> +		 * If the hardware uses perf ring buffer the size of the data
> +		 * we have is from the old-head to the current head of the
> +		 * buffer. This also means in non-snapshot mode, we have lost
> +		 * one-full-buffer-size worth data, if the buffer wraps around.
> +		 */
> +		unsigned long old_head;
> +
> +		old_head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> +		size = (offset - old_head + etr_buf->size) % etr_buf->size;
> +	}
> +
> +	/*
> +	 * Update handle->head in snapshot mode. Also update the size to the
> +	 * hardware buffer size if there was an overflow.
> +	 */
> +	if (etr_perf->snapshot) {
> +		if (double_buffer)
> +			handle->head += size;
> +		else
> +			handle->head = offset;
> +		if (etr_buf->full)
> +			size = etr_buf->size;
> +	}
> +
> +	lost |= etr_buf->full;
> +out:
> +	if (lost)
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +	return size;
> +}
> +
>  static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
>  {
> -	/* We don't support perf mode yet ! */
> -	return -EINVAL;
> +	int rc = 0;
> +	unsigned long flags;
> +	struct etr_perf_buffer *etr_perf;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	/*
> +	 * There can be only one writer per sink in perf mode. If the sink
> +	 * is already open in SYSFS mode, we can't use it.
> +	 */
> +	if (drvdata->mode != CS_MODE_DISABLED) {
> +		rc = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	etr_perf = drvdata->perf_data;
> +	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
> +		rc = -EINVAL;
> +		goto unlock_out;
> +	}
> +
> +	drvdata->mode = CS_MODE_PERF;
> +	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
> +
> +unlock_out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return rc;
>  }
>  
>  static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
> @@ -1459,6 +1836,10 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  static const struct coresight_ops_sink tmc_etr_sink_ops = {
>  	.enable		= tmc_enable_etr_sink,
>  	.disable	= tmc_disable_etr_sink,
> +	.alloc_buffer	= tmc_etr_alloc_perf_buffer,
> +	.update_buffer	= tmc_etr_update_perf_buffer,
> +	.set_buffer	= tmc_etr_set_perf_buffer,
> +	.free_buffer	= tmc_etr_free_perf_buffer,
>  };
>  
>  const struct coresight_ops tmc_etr_cs_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 185dc12..aa42f5d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -197,6 +197,7 @@ struct etr_buf {
>   * @trigger_cntr: amount of words to store after a trigger.
>   * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>   *		device configuration register (DEVID)
> + * @perf_data:	PERF buffer for ETR.
>   * @sysfs_data:	SYSFS buffer for ETR.
>   */
>  struct tmc_drvdata {
> @@ -218,6 +219,7 @@ struct tmc_drvdata {
>  	u32			trigger_cntr;
>  	u32			etr_caps;
>  	struct etr_buf		*sysfs_buf;
> +	void			*perf_data;
>  };
>  
>  struct etr_buf_operations {
> -- 
> 2.7.4
> 
