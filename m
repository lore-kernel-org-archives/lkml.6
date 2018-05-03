Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeECTuS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:50:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41568 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeECTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:50:17 -0400
X-Google-Smtp-Source: AB8JxZpz59sNKVu7H3T41X19oDYcTdlAZ5reom/kJ1w/1yug0OnIRjVjHvr89bshrwSYSsXENiYH1Q==
Date: Thu, 3 May 2018 13:50:13 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 07/27] coresight: tmc: Hide trace buffer handling for
 file read
Message-ID: <20180503195013.GC11425@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-8-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-8-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:37AM +0100, Suzuki K Poulose wrote:
> At the moment we adjust the buffer pointers for reading the trace
> data via misc device in the common code for ETF/ETB and ETR. Since
> we are going to change how we manage the buffer for ETR, let us
> move the buffer manipulation to the respective driver files, hiding
> it from the common code. We do so by adding type specific helpers
> for finding the length of data and the pointer to the buffer,
> for a given length at a file position.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 +++++++++++
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 34 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.c     | 41 ++++++++++++++-----------
>  drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++
>  4 files changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index e2513b7..2113e93 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -120,6 +120,24 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> +/*
> + * Return the available trace data in the buffer from @pos, with
> + * a maximum limit of @len, updating the @bufpp on where to
> + * find it.
> + */
> +ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +				  loff_t pos, size_t len, char **bufpp)
> +{
> +	ssize_t actual = len;
> +
> +	/* Adjust the len to available size @pos */
> +	if (pos + actual > drvdata->len)
> +		actual = drvdata->len - pos;
> +	if (actual > 0)
> +		*bufpp = drvdata->buf + pos;
> +	return actual;
> +}
> +
>  static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
>  {
>  	int ret = 0;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index bff46f2..53a17a8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -92,6 +92,40 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> +/*
> + * Return the available trace data in the buffer @pos, with a maximum
> + * limit of @len, also updating the @bufpp on where to find it.
> + */
> +ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +			    loff_t pos, size_t len, char **bufpp)
> +{
> +	ssize_t actual = len;
> +	char *bufp = drvdata->buf + pos;
> +	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
> +
> +	/* Adjust the len to available size @pos */
> +	if (pos + actual > drvdata->len)
> +		actual = drvdata->len - pos;
> +
> +	if (actual <= 0)
> +		return actual;
> +
> +	/*
> +	 * Since we use a circular buffer, with trace data starting
> +	 * @drvdata->buf, possibly anywhere in the buffer @drvdata->vaddr,
> +	 * wrap the current @pos to within the buffer.
> +	 */
> +	if (bufp >= bufend)
> +		bufp -= drvdata->size;
> +	/*
> +	 * For simplicity, avoid copying over a wrapped around buffer.
> +	 */
> +	if ((bufp + actual) > bufend)
> +		actual = bufend - bufp;
> +	*bufpp = bufp;
> +	return actual;
> +}
> +
>  static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
>  {
>  	const u32 *barrier;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 0ea04f5..7a4e84f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -131,35 +131,40 @@ static int tmc_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +					loff_t pos, size_t len, char **bufpp)
> +{
> +	switch (drvdata->config_type) {
> +	case TMC_CONFIG_TYPE_ETB:
> +	case TMC_CONFIG_TYPE_ETF:
> +		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
> +	case TMC_CONFIG_TYPE_ETR:
> +		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
> +	}
> +
> +	return  -EINVAL;

Extra space betwen return and -EINVAL.

> +}
> +
>  static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>  			loff_t *ppos)
>  {
> +	char *bufp;
> +	ssize_t actual;
>  	struct tmc_drvdata *drvdata = container_of(file->private_data,
>  						   struct tmc_drvdata, miscdev);
> -	char *bufp = drvdata->buf + *ppos;
> +	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
> +	if (actual <= 0)
> +		return 0;
>  
> -	if (*ppos + len > drvdata->len)
> -		len = drvdata->len - *ppos;
> -
> -	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
> -		if (bufp == (char *)(drvdata->vaddr + drvdata->size))
> -			bufp = drvdata->vaddr;
> -		else if (bufp > (char *)(drvdata->vaddr + drvdata->size))
> -			bufp -= drvdata->size;
> -		if ((bufp + len) > (char *)(drvdata->vaddr + drvdata->size))
> -			len = (char *)(drvdata->vaddr + drvdata->size) - bufp;
> -	}
> -
> -	if (copy_to_user(data, bufp, len)) {
> +	if (copy_to_user(data, bufp, actual)) {
>  		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
>  		return -EFAULT;
>  	}
>  
> -	*ppos += len;
> +	*ppos += actual;
> +	dev_dbg(drvdata->dev, "%zu bytes copied\n", actual);
>  
> -	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
> -		__func__, len, (int)(drvdata->len - *ppos));
> -	return len;
> +	return actual;
>  }
>  
>  static int tmc_release(struct inode *inode, struct file *file)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index cdff853..9cbc4d5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -184,10 +184,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etb_cs_ops;
>  extern const struct coresight_ops tmc_etf_cs_ops;
>  
> +ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +				loff_t pos, size_t len, char **bufpp);
>  /* ETR functions */
>  int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
>  int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
>  extern const struct coresight_ops tmc_etr_cs_ops;
> +ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +				loff_t pos, size_t len, char **bufpp);
>  
>  
>  #define TMC_REG_PAIR(name, lo_off, hi_off)				\
> -- 
> 2.7.4
> 
