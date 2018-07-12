Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6244213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8vC9508"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6244213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbeGLVJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:09:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37742 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732734AbeGLVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:09:02 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so8699277itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMzWSBgtb8LHVnXQWshz1/WUgIMb3gqmPHpiqnlenwY=;
        b=g8vC9508d5Vdba4L9k1d7e1NVXfthoEMMJx4t4bKUHzUh6g0r6cqvBN70oeVUxeUyu
         lCiK44wkmTYcY8pJoFpMtv38Mwy8IjCZC1e+WWNmAYLMniTWVYpwcKz5le6SEC1MkEUd
         z8AjIhkyXWOgWnI9ms2ul65DwQZLZhzJwiXCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMzWSBgtb8LHVnXQWshz1/WUgIMb3gqmPHpiqnlenwY=;
        b=lMN0cq/afEn+EwDRcvV6tegwxv6meWf/4YQOfDX1hfpHh4lJ3y1rxNwKNC6dMV6LDw
         OMOgjqL4RBffOThgHEpQ52qJdgJ7zVJ/tl/HVyenO2d/TdUelVEgm7gDApVzV+rk715Q
         WP5Yq9mgekizvCZL4I+wHwrNwrgQv9mXEEygLZcSr8z+v1hjFOVDXmwQnB5jTxg0Wk6B
         h/qL7pMwyF5j8I3+Js7gPpmhBHc1zCnPc//Vvf1da+r/Azy004jZplj/t573q+9bM6p3
         FcHOCtEP5MPjQsFyPxcW1p+pXkkOE9GwhETDgHwypp28ICpsf7pLr9TSTTL7pqenc18u
         5g1g==
X-Gm-Message-State: AOUpUlHg2o3W0df/uUl0tu3KLrOlHbi/x8rtAlisB7jPiX6Sw0mLufzY
        kiTlNrD5+13DEyEA/PJiYEGYtg==
X-Google-Smtp-Source: AAOMgpcuS9eWyz6YSVU+3UvKrPesD2Ejm47mdW49ftlHEZABT2nU6Wejerm3BYIK/F0BpA8wTHuiRA==
X-Received: by 2002:a24:33c1:: with SMTP id k184-v6mr2681835itk.76.1531429063574;
        Thu, 12 Jul 2018 13:57:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x94-v6sm3017190ita.18.2018.07.12.13.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:57:42 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:57:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, robert.walker@arm.com,
        mike.leach@linaro.org
Subject: Re: [PATCH 6/6] coresight: etm-perf: Add support for ETR backend
Message-ID: <20180712205740.GA22128@xps15>
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
 <1531318599-8840-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531318599-8840-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Jul 11, 2018 at 03:16:39PM +0100, Suzuki K Poulose wrote:
> Add support for using TMC-ETR as backend for ETM perf tracing.
> We use software double buffering at the moment. i.e, the TMC-ETR
> uses a separate buffer than the perf ring buffer. The data is
> copied to the perf ring buffer once a session completes.
> 
> The TMC-ETR would try to match the larger of perf ring buffer
> or the ETR buffer size configured via sysfs, scaling down to
> a minimum limit of 1MB.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 265 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
>  2 files changed, 265 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 20a0beb..af921da 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -21,6 +21,28 @@ struct etr_flat_buf {
>  };
>  
>  /*
> + * etr_perf_buffer - Perf buffer used for ETR
> + * @etr_buf		- Actual buffer used by the ETR
> + * @snaphost		- Perf session mode
> + * @head		- handle->head at the beginning of the session.
> + * @nr_pages		- Number of pages in the ring buffer.
> + * @pages		- Array of Pages in the ring buffer.
> + */
> +struct etr_perf_buffer {
> +	struct etr_buf		*etr_buf;
> +	bool			snapshot;
> +	unsigned long		head;
> +	int			nr_pages;
> +	void			**pages;
> +};
> +
> +/* Convert the perf index to an offset within the ETR buffer */
> +#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> +
> +/* Lower limit for ETR hardware buffer */
> +#define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
> +
> +/*
>   * The TMC ETR SG has a page size of 4K. The SG table contains pointers
>   * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
>   * 4K (i.e, 16KB or 64KB). This implies that a single OS page could
> @@ -1103,10 +1125,245 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	return ret;
>  }
>  
> +/*
> + * tmc_etr_setup_perf_buf: Allocate ETR buffer for use by perf.
> + * The size of the hardware buffer is dependent on the size configured
> + * via sysfs and the perf ring buffer size. We prefer to allocate the
> + * largest possible size, scaling down the size by half until it
> + * reaches a minimum limit (1M), beyond which we give up.
> + */
> +static struct etr_perf_buffer *
> +tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
> +		       void **pages, bool snapshot)
> +{
> +	struct etr_buf *etr_buf;
> +	struct etr_perf_buffer *etr_perf;
> +	unsigned long size;
> +
> +	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
> +	if (!etr_perf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Try to match the perf ring buffer size if it is larger
> +	 * than the size requested via sysfs.
> +	 */
> +	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
> +		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
> +					    0, node, NULL);
> +		if (!IS_ERR(etr_buf))
> +		goto done;
> +	}
> +
> +	/*
> +	 * Else switch to configured size for this ETR
> +	 * and scale down until we hit the minimum limit.
> +	 */
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
> +				       int cpu, void **pages, int nr_pages,
> +				       bool snapshot)
> +{
> +	struct etr_perf_buffer *etr_perf;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +
> +	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
> +					  nr_pages, pages, snapshot);
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
> +static int tmc_etr_set_perf_buffer(struct coresight_device *csdev,
> +				   struct perf_output_handle *handle,
> +				   void *config)
> +{
> +	int rc = 0;
> +	unsigned long flags;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_perf_buffer *etr_perf = config;
> +
> +	etr_perf->head = handle->head;
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (WARN_ON(drvdata->perf_data))
> +		rc = -EBUSY;
> +	else
> +		drvdata->perf_data = etr_perf;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return rc;
> +}
> +
> +/*
> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
> + * buffer to the perf ring buffer.
> + */
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +{
> +	long bytes, to_copy;
> +	long pg_idx, pg_offset, src_offset;
> +	unsigned long head = etr_perf->head;
> +	char **dst_pages, *src_buf;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
> +
> +	head = PERF_IDX2OFF(etr_perf->head, etr_perf);

I'm puzzled here.  Since etr_perf->head is set in tmc_etr_set_perf_buffer() to
the value of handle->head, its value is always within the range of the perf ring
buffer.  In tmc_etr_alloc_perf_buffer() etr_perf->nr_pages is set to the number
of pages present in that ring buffer.  As such I'm not sure as to why we need
the PERF_IDX2OFF() macro.

It seems to me that "head = etr_perf->head;" above is sufficient.

> +	pg_idx = head >> PAGE_SHIFT;
> +	pg_offset = head & (PAGE_SIZE - 1);
> +	dst_pages = (char **)etr_perf->pages;
> +	src_offset = etr_buf->offset;
> +	to_copy = etr_buf->len;
> +
> +	while (to_copy > 0) {
> +		/*
> +		 * We can copy minimum of :

s/We can copy minimum of :/In one iteration we can copy a minimum of:/

If I'm wrong about the PERF_IDX2OFF(), don't bother respinning just for that.

Thanks,
Mathieu 

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
> +		bytes = min(bytes, (long)(PAGE_SIZE - pg_offset));
> +
> +		memcpy(dst_pages[pg_idx] + pg_offset, src_buf, bytes);
> +
> +		to_copy -= bytes;
> +
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
> + * tmc_etr_update_perf_buffer : Update the perf ring buffer with the
> + * available trace data. We use software double buffering at the moment.
> + *
> + * TODO: Add support for reusing the perf ring buffer.
> + */
> +static unsigned long
> +tmc_etr_update_perf_buffer(struct coresight_device *csdev,
> +			   struct perf_output_handle *handle,
> +			   void *config)
> +{
> +	bool lost = false;
> +	unsigned long flags, size = 0;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etr_perf_buffer *etr_perf = config;
> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
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
> +	tmc_sync_etr_buf(drvdata);
> +
> +	CS_UNLOCK(drvdata->base);
> +	/* Reset perf specific data */
> +	drvdata->perf_data = NULL;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	size = etr_buf->len;
> +	tmc_etr_sync_perf_buffer(etr_perf);
> +
> +	/*
> +	 * Update handle->head in snapshot mode. Also update the size to the
> +	 * hardware buffer size if there was an overflow.
> +	 */
> +	if (etr_perf->snapshot) {
> +		handle->head += size;
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
> @@ -1147,6 +1404,10 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
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
> index 872f63e..487c537 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -170,6 +170,7 @@ struct etr_buf {
>   * @trigger_cntr: amount of words to store after a trigger.
>   * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>   *		device configuration register (DEVID)
> + * @perf_data:	PERF buffer for ETR.
>   * @sysfs_data:	SYSFS buffer for ETR.
>   */
>  struct tmc_drvdata {
> @@ -191,6 +192,7 @@ struct tmc_drvdata {
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
