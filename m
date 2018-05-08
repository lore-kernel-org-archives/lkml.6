Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755519AbeEHRew (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:34:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44738 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeEHRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:34:51 -0400
X-Google-Smtp-Source: AB8JxZogsQRZVt+UisBVleL1ysH7q+kkhU4djLVeGp8xk/jLC0+xbeQk/Zh7whgE5ovUGjYoe8NXNw==
Date: Tue, 8 May 2018 11:34:47 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 25/27] coresight: etr_buf: Add helper for padding an
 area of trace data
Message-ID: <20180508173447.GB3389@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-26-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-26-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:55AM +0100, Suzuki K Poulose wrote:
> This patch adds a helper to insert barrier packets for a given
> size (aligned to packet size) at given offset in an etr_buf. This
> will be used later for perf mode when we try to start in the
> middle of an SG buffer.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 53 ++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 7551272..8159e84 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1083,18 +1083,59 @@ static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
>  	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
>  }
>  
> +/*
> + * tmc_etr_buf_insert_barrier_packets : Insert barrier packets at @offset upto
> + * @size of bytes in the given buffer. @size should be aligned to the barrier
> + * packet size.
> + *
> + * Returns the new @offset after filling the barriers on success. Otherwise
> + * returns error.
> + */
>  static inline s64
> -tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
> +tmc_etr_buf_insert_barrier_packets(struct etr_buf *etr_buf,
> +				   u64 offset, u64 size)
>  {
>  	ssize_t len;
>  	char *bufp;
>  
> -	len = tmc_etr_buf_get_data(etr_buf, offset,
> -				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
> -	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
> +	if (size < CORESIGHT_BARRIER_PKT_SIZE)
>  		return -EINVAL;
> -	coresight_insert_barrier_packet(bufp);
> -	return offset + CORESIGHT_BARRIER_PKT_SIZE;
> +	/*
> +	 * Normally the size should be aligned to the frame size
> +	 * of the ETR. Even if it isn't, the decoder looks for a
> +	 * barrier packet at a frame size aligned offset. So align
> +	 * the buffer to frame size first and then fill barrier
> +	 * packets.
> +	 */
> +	do {
> +		len = tmc_etr_buf_get_data(etr_buf, offset, size, &bufp);
> +		if (WARN_ON(len <= 0))
> +			return -EINVAL;
> +		/*
> +		 * We are guaranteed that @bufp will point to a linear range
> +		 * of @len bytes, where @len <= @size.
> +		 */
> +		size -= len;
> +		offset += len;
> +		while (len >= CORESIGHT_BARRIER_PKT_SIZE) {
> +			coresight_insert_barrier_packet(bufp);
> +			bufp += CORESIGHT_BARRIER_PKT_SIZE;
> +			len -= CORESIGHT_BARRIER_PKT_SIZE;
> +		}
> +
> +		/* If we reached the end of the buffer, wrap around */
> +		if (offset == etr_buf->size)
> +			offset -= etr_buf->size;
> +	} while (size);
> +
> +	return offset;
> +}
> +
> +static inline s64
> +tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
> +{
> +	return tmc_etr_buf_insert_barrier_packets(etr_buf, offset,
> +					  CORESIGHT_BARRIER_PKT_SIZE);

Indentation

>  }
>  
>  /*
> -- 
> 2.7.4
> 
