Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522701367; cv=none;
        d=google.com; s=arc-20160816;
        b=SqIngtYgmO4Tbp+1Yr1zt1JUYRRW8/UCibErvD2r2I094hzpSEXt8qvf9rPD0orWaG
         65+1/+YQTaFaMSI8jvL/83uAkUtN3QoRJB65TMlHmgjdokRUEcxczKpdvvqCygGLG/xX
         2m81ZqQbKMlUrYSiraEu4WrwTlOzq9Z0Ax0EgQxoIDofPbYSYXM4b7hnk40yrWwXo6wR
         qBLNxRxFYBOLmcfMfL7stqHBBbDpv0FsYQbhjTKoc15byOXEcs+0uZdY6hfNdeR91a5L
         h4FcGEAsnV6H3SJriKDtZnJTub5ztqJa3BBe6UhwdSMDlsjoILnhdK5TMgeoUshnsK2X
         ZOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=U+gYwYEsk5Cnl+UDCu4TBUGdDz9cAC2GgRFKIj0Mx48=;
        b=A1Uqjkj/hVKNIXQKHnIH/VOU4bcod6lPOVDqMi17aAdOXcc222ig3NfKrU+okCgedZ
         4+h7TT9frQLKm7o1dh1tRw2mVCUuhX6qLhWQLICTHcrM9yUGl6W7Vq4tdJpvG7XkL95v
         kaOC9c6IcCMlAI5thmS4wmeMA13+N2yWCq0FeHIGS7+PJX44PEPR1Vk+Gj4OOh1vc8d/
         VCnNDOlUoG4kiJ60HPBYjCn1fHdNxMCN1z682lCk9EiFSG5Nedr7DdyUhuay8EdoqxHb
         q8fFBs9E73ocQjrvmjPRGhXIk7vs8lpfRnUoS6/QLwS2x08eAb+8BU/NILyNZ3a1cS+B
         OOlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Itxg5uSc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Itxg5uSc;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+U+ooFS55FzRW+rfQ20PoxbRJRuFS10W6Z7Mi3kecYptB0CQeq7tduj78qiFMmM6Lzet5Nvw==
Date: Mon, 2 Apr 2018 14:36:04 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 4/6] coresight: tmc: Hook callback for panic kdump
Message-ID: <20180402203604.GD15452@xps15>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
 <1522379724-30648-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522379724-30648-5-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330884321271490?=
X-GMAIL-MSGID: =?utf-8?q?1596668109933865205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:15:22AM +0800, Leo Yan wrote:
> Since Coresight panic kdump functionality has been ready, this patch is
> to hook panic callback function for ETB/ETF driver.  The driver data
> structure has allocated a buffer when the session started, so simply
> save tracing data into this buffer when panic happens and update buffer
> related info for kdump.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index e2513b7..d20d546 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -504,6 +504,35 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
>  	CS_LOCK(drvdata->base);
>  }
>  
> +static void tmc_panic_cb(void *data)

I would call the function tmc_kdump_panic_cb()... That way there is absolutely
no confusion as to what it does.

> +{
> +	struct coresight_device *csdev = (struct coresight_device *)data;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
> +			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
> +		return;
> +
> +	if (drvdata->mode == CS_MODE_DISABLED)
> +		return;

This is racy - between the check and acquiring the spinlock someone may beat you
to it.

> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);

        if (drvdata->mode == CS_MODE_DISABLED)
                goto out;

        drvdata->mode = CS_MODE_DISABLED

> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	tmc_flush_and_stop(drvdata);
> +	tmc_etb_dump_hw(drvdata);
> +
> +	CS_LOCK(drvdata->base);
> +
> +	/* Update buffer info for panic dump */
> +	csdev->kdump_buf = drvdata->buf;
> +	csdev->kdump_buf_sz = drvdata->len;

out:
> +
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +}
> +
>  static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.enable		= tmc_enable_etf_sink,
>  	.disable	= tmc_disable_etf_sink,
> @@ -512,6 +541,7 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.set_buffer	= tmc_set_etf_buffer,
>  	.reset_buffer	= tmc_reset_etf_buffer,
>  	.update_buffer	= tmc_update_etf_buffer,
> +	.panic_cb	= tmc_panic_cb,
>  };
>  
>  static const struct coresight_ops_link tmc_etf_link_ops = {
> -- 
> 2.7.4
> 
