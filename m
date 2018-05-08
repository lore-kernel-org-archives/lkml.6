Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbeEHRSH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:18:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43138 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755179AbeEHRSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:18:04 -0400
X-Google-Smtp-Source: AB8JxZrraXdkBH+VmEjtlG21av1fNJdRxxZn89dPEQaIQ6Nw6cLkYaoFTeBjzMPGmyRmjVieWqW6oA==
Date: Tue, 8 May 2018 11:18:00 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 23/27] coresight: tmc-etr: Handle driver mode specific
 ETR buffers
Message-ID: <20180508171800.GA3389@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-24-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-24-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:53AM +0100, Suzuki K Poulose wrote:
> Since the ETR could be driven either by SYSFS or by perf, it
> becomes complicated how we deal with the buffers used for each
> of these modes. The ETR driver cannot simply free the current
> attached buffer without knowing the provider (i.e, sysfs vs perf).
> 
> To solve this issue, we provide:
> 1) the driver-mode specific etr buffer to be retained in the drvdata
> 2) the etr_buf for a session should be passed on when enabling the
>    hardware, which will be stored in drvdata->etr_buf. This will be
>    replaced (not free'd) as soon as the hardware is disabled, after
>    necessary sync operation.
> 
> The advantages of this are :
> 
> 1) The common code path doesn't need to worry about how to dispose
>    an existing buffer, if it is about to start a new session with a
>    different buffer, possibly in a different mode.
> 2) The driver mode can control its buffers and can get access to the
>    saved session even when the hardware is operating in a different
>    mode. (e.g, we can still access a trace buffer from a sysfs mode
>    even if the etr is now used in perf mode, without disrupting the
>    current session.)
> 
> Towards this, we introduce a sysfs specific data which will hold the
> etr_buf used for sysfs mode of operation, controlled solely by the
> sysfs mode handling code.

Thinking further on this... I toyed with the idea of doing the same thing when
working on the original driver and decided against it.  Do we really have a case
where users would want to use sysFS and perf alternatively?  To me this looks
overdesigned.  

If we are going to go that way we need to enact the same behavior for ETB10 and
ETF...  And take it out of this set as it is already substantial enough.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 59 ++++++++++++++++---------
>  drivers/hwtracing/coresight/coresight-tmc.h     |  2 +
>  2 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 1ef0f62..a35a12f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1162,10 +1162,15 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
>  		helper_ops(catu)->disable(catu, drvdata->etr_buf);
>  }
>  
> -static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> +static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> +			      struct etr_buf *etr_buf)
>  {
>  	u32 axictl, sts;
> -	struct etr_buf *etr_buf = drvdata->etr_buf;
> +
> +	/* Callers should provide an appropriate buffer for use */
> +	if (WARN_ON(!etr_buf || drvdata->etr_buf))
> +		return;
> +	drvdata->etr_buf = etr_buf;
>  
>  	/*
>  	 * If this ETR is connected to a CATU, enable it before we turn
> @@ -1227,13 +1232,16 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>   * also updating the @bufpp on where to find it. Since the trace data
>   * starts at anywhere in the buffer, depending on the RRP, we adjust the
>   * @len returned to handle buffer wrapping around.
> + *
> + * We are protected here by drvdata->reading != 0, which ensures the
> + * sysfs_buf stays alive.
>   */
>  ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  				loff_t pos, size_t len, char **bufpp)
>  {
>  	s64 offset;
>  	ssize_t actual = len;
> -	struct etr_buf *etr_buf = drvdata->etr_buf;
> +	struct etr_buf *etr_buf = drvdata->sysfs_buf;
>  
>  	if (pos + actual > etr_buf->len)
>  		actual = etr_buf->len - pos;
> @@ -1263,7 +1271,14 @@ tmc_etr_free_sysfs_buf(struct etr_buf *buf)
>  
>  static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
>  {
> -	tmc_sync_etr_buf(drvdata);
> +	struct etr_buf *etr_buf = drvdata->etr_buf;
> +
> +	if (WARN_ON(drvdata->sysfs_buf != etr_buf)) {
> +		tmc_etr_free_sysfs_buf(drvdata->sysfs_buf);
> +		drvdata->sysfs_buf = NULL;
> +	} else {
> +		tmc_sync_etr_buf(drvdata);
> +	}
>  }
>  
>  static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
> @@ -1285,6 +1300,8 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  
>  	/* Disable CATU device if this ETR is connected to one */
>  	tmc_etr_disable_catu(drvdata);
> +	/* Reset the ETR buf used by hardware */
> +	drvdata->etr_buf = NULL;
>  }
>  
>  static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
> @@ -1293,7 +1310,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	bool used = false;
>  	unsigned long flags;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -	struct etr_buf *new_buf = NULL, *free_buf = NULL;
> +	struct etr_buf *sysfs_buf = NULL, *new_buf = NULL, *free_buf = NULL;
>  
>  
>  	/*
> @@ -1305,7 +1322,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	 * with the lock released.
>  	 */
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (!drvdata->etr_buf || (drvdata->etr_buf->size != drvdata->size)) {
> +	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
> +	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
>  		spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  		/* Allocate memory with the spinlock released */
>  		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
> @@ -1333,15 +1351,16 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  	 * If we don't have a buffer or it doesn't match the requested size,
>  	 * use the memory allocated above. Otherwise reuse it.
>  	 */
> -	if (!drvdata->etr_buf ||
> -	    (new_buf && drvdata->etr_buf->size != new_buf->size)) {
> +	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
> +	if (!sysfs_buf ||
> +	    (new_buf && sysfs_buf->size != new_buf->size)) {
>  		used = true;
> -		free_buf = drvdata->etr_buf;
> -		drvdata->etr_buf = new_buf;
> +		free_buf = sysfs_buf;
> +		drvdata->sysfs_buf = new_buf;
>  	}
>  
>  	drvdata->mode = CS_MODE_SYSFS;
> -	tmc_etr_enable_hw(drvdata);
> +	tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> @@ -1426,13 +1445,13 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  		goto out;
>  	}
>  
> -	/* If drvdata::etr_buf is NULL the trace data has been read already */
> -	if (drvdata->etr_buf == NULL) {
> +	/* If sysfs_buf is NULL the trace data has been read already */
> +	if (!drvdata->sysfs_buf) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	/* Disable the TMC if need be */
> +	/* Disable the TMC if we are trying to read from a running session */
>  	if (drvdata->mode == CS_MODE_SYSFS)
>  		tmc_etr_disable_hw(drvdata);
>  
> @@ -1446,7 +1465,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  {
>  	unsigned long flags;
> -	struct etr_buf *etr_buf = NULL;
> +	struct etr_buf *sysfs_buf = NULL;
>  
>  	/* config types are set a boot time and never change */
>  	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
> @@ -1461,22 +1480,22 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  		 * buffer. Since the tracer is still enabled drvdata::buf can't
>  		 * be NULL.
>  		 */
> -		tmc_etr_enable_hw(drvdata);
> +		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
>  	} else {
>  		/*
>  		 * The ETR is not tracing and the buffer was just read.
>  		 * As such prepare to free the trace buffer.
>  		 */
> -		etr_buf =  drvdata->etr_buf;
> -		drvdata->etr_buf = NULL;
> +		sysfs_buf = drvdata->sysfs_buf;
> +		drvdata->sysfs_buf = NULL;
>  	}
>  
>  	drvdata->reading = false;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	/* Free allocated memory out side of the spinlock */
> -	if (etr_buf)
> -		tmc_free_etr_buf(etr_buf);
> +	if (sysfs_buf)
> +		tmc_etr_free_sysfs_buf(sysfs_buf);
>  
>  	return 0;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 76a89a6..185dc12 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -197,6 +197,7 @@ struct etr_buf {
>   * @trigger_cntr: amount of words to store after a trigger.
>   * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>   *		device configuration register (DEVID)
> + * @sysfs_data:	SYSFS buffer for ETR.
>   */
>  struct tmc_drvdata {
>  	void __iomem		*base;
> @@ -216,6 +217,7 @@ struct tmc_drvdata {
>  	enum tmc_mem_intf_width	memwidth;
>  	u32			trigger_cntr;
>  	u32			etr_caps;
> +	struct etr_buf		*sysfs_buf;
>  };
>  
>  struct etr_buf_operations {
> -- 
> 2.7.4
> 
