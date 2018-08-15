Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E418EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80205214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZKlbFck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80205214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHOWQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:16:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37298 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:16:19 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so3430292itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfX+HJUzcWSeDWDaWpWI2mbnNLINc5wiN7a0euIR2Gg=;
        b=YZKlbFckZPMRWftqh5PKqlX2CRhsbzChw1+woQkdjWW5oJwTZGxPMSMe15lIMJB/HX
         e+eV1R3kHWmo+212tDI42FJyH9MXSJavsWDdlNiV34Pe3SZ9FfW9vK9/3agU01cBsjKx
         3OOUnwMI6OjYpiuAIjZwFvyd3n0IHiT/JLVUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfX+HJUzcWSeDWDaWpWI2mbnNLINc5wiN7a0euIR2Gg=;
        b=FjiA1V57Sw00ZWCZfd5M2MmKHCA172EsVYH/p23cxYphCyTXnTX+JYIxr+9rE4/U1l
         WIOEaxGIuXNzYz72sMx02H0rJeYGPgLmv9gyMZ4AlPE/9U02ZFTPNvj/E1m3O3ajlvXV
         2UGTT5JZD7KpK3lKYnzZFXenwRAYEqi50Ko+sohulf6UcQWKAcF0ew7XHRs6eZXQnB2Y
         1Tuxzc3kfe43WQDWiG/HEV2wqNGh5p0QYFnkmi8FHdpiRPbX0ixlEPhWHZf7w20lgN+d
         YCwTBzTTUeqmmK/H5et18A7rC1F/XAcZByJFKO6D5UxnWtSIrNMVZq5Y8OWb3UvhJP24
         PXgQ==
X-Gm-Message-State: AOUpUlEV118ePCH59+f7ua3KDWBQqIfTU0xLAaJBY/Si8aO5izOfClo4
        5krpt4W0TIJNRhbaBNQG4K30ew==
X-Google-Smtp-Source: AA+uWPxKoEwNQc6Q9vc4zHGyNb0rbvkB1T/brNUPVfbVf641BGfUef378DrdjF2V8rB4Vhx/kfgdGQ==
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr23631316jas.72.1534360971733;
        Wed, 15 Aug 2018 12:22:51 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1369657iti.15.2018.08.15.12.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:22:49 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:22:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 03/13] coresight: tmc-etb/etf: Prepare to handle errors
 enabling
Message-ID: <20180815192246.GA11625@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:41:45PM +0100, Suzuki K Poulose wrote:
> Prepare to handle errors in enabling the hardware and
> report it back to the core driver.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 71 +++++++++++++++----------
>  1 file changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 4156c95..ceb4b30 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -15,7 +15,7 @@
>  static int tmc_set_etf_buffer(struct coresight_device *csdev,
>  			      struct perf_output_handle *handle);
>  
> -static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> +static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -34,6 +34,12 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> +static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> +{
> +	__tmc_etb_enable_hw(drvdata);
> +	return 0;
> +}
> +
>  static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>  {
>  	char *bufp;
> @@ -76,7 +82,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> -static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
> +static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -92,6 +98,12 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> +static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
> +{
> +	__tmc_etf_enable_hw(drvdata);
> +	return 0;
> +}
> +
>  static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>  {
>  	CS_UNLOCK(drvdata->base);
> @@ -174,8 +186,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
>  		drvdata->buf = buf;
>  	}
>  
> -	drvdata->mode = CS_MODE_SYSFS;
> -	tmc_etb_enable_hw(drvdata);
> +	ret = tmc_etb_enable_hw(drvdata);
> +	if (!ret)
> +		drvdata->mode = CS_MODE_SYSFS;
> +	else
> +		/* Free up the buffer if we failed to enable */
> +		used = false;
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> @@ -194,27 +210,25 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
>  	struct perf_output_handle *handle = data;
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (drvdata->reading) {
> +	do {
>  		ret = -EINVAL;
> -		goto out;
> -	}
> +		if (drvdata->reading)
> +			break;
> +		/*
> +		 * In Perf mode there can be only one writer per sink.  There
> +		 * is also no need to continue if the ETB/ETF is already
> +		 * operated from sysFS.
> +		 */
> +		if (drvdata->mode != CS_MODE_DISABLED)
> +			break;
>  
> -	/*
> -	 * In Perf mode there can be only one writer per sink.  There
> -	 * is also no need to continue if the ETB/ETR is already operated
> -	 * from sysFS.
> -	 */
> -	if (drvdata->mode != CS_MODE_DISABLED) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	ret = tmc_set_etf_buffer(csdev, handle);
> -	if (!ret) {
> -		drvdata->mode = CS_MODE_PERF;
> -		tmc_etb_enable_hw(drvdata);
> -	}
> -out:
> +		ret = tmc_set_etf_buffer(csdev, handle);
> +		if (ret)
> +			break;
> +		ret  = tmc_etb_enable_hw(drvdata);
> +		if (!ret)
> +			drvdata->mode = CS_MODE_PERF;
> +	} while (0);
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	return ret;
> @@ -271,6 +285,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>  static int tmc_enable_etf_link(struct coresight_device *csdev,
>  			       int inport, int outport)
>  {
> +	int ret;
>  	unsigned long flags;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> @@ -280,11 +295,13 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>  		return -EBUSY;
>  	}
>  
> -	tmc_etf_enable_hw(drvdata);
> -	drvdata->mode = CS_MODE_SYSFS;
> +	ret = tmc_etf_enable_hw(drvdata);
> +	if (!ret)
> +		drvdata->mode = CS_MODE_SYSFS;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
> +	if (!ret)
> +		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>  	return 0;

We need to tell the caller if an error as occured:

        return ret;

>  }
>  
> @@ -579,7 +596,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>  		 * can't be NULL.
>  		 */
>  		memset(drvdata->buf, 0, drvdata->size);
> -		tmc_etb_enable_hw(drvdata);
> +		__tmc_etb_enable_hw(drvdata);
>  	} else {
>  		/*
>  		 * The ETB/ETF is not tracing and the buffer was just read.
> -- 
> 2.7.4
> 
