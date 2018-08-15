Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EABFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB452150C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtByhl3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB452150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeHOWbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:31:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44302 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeHOWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:31:42 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so1919299ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Htx65ITGBM0ju1OtwFWNT6dMkh/cZwZWGC2azkJuC6k=;
        b=NtByhl3WoDeU828HgdYFnz31OWVUjmTbIh/Pc1Tnf3HKgHqfx2BhpxpyzsZGvWU1tM
         AgLy2XYq/zXCEwLscnZ27CltQ6pyWbtLrnqz2EwvjIT8D+Zm9RTg+Tu0CEOT1akG+lBL
         OeZSpTcJfFQJFrAifLroLNZ2kM4OxagKOzFDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Htx65ITGBM0ju1OtwFWNT6dMkh/cZwZWGC2azkJuC6k=;
        b=NVWGfd1Gr/VYyL0XLhfYu2jjgt7cc2ZxFJkCAvdLkLzhYwe8Hx+jfVMDFvkDM1D0gk
         ukCn5s4cMJgGU9gwLR8954aJs1MdJwd1TZGVlppDgJ1ktLNFbgvejF2Bf1Slx816KqUU
         Vhnn27jFVjWzgUHGtvDsOVYN46V/qOv51jglyAkdPppxfvEXJDEhjaMGyEXr38pnzZPY
         yfShWPwlvIjTecaRiJa5Ifcxug9wQGhfZjzBBjPOUjuEy50E6V79QgV/g6fwxQQK/iwY
         mB56W8Xcg8gQYeJc/RteFId226biowSr9FwUOXusdo4IHG67Xe12zF1GfDYFWO6Mi8to
         GvwA==
X-Gm-Message-State: AOUpUlGfqe2sYr1E/8d4ZtoSiHhrRpP/O6DJY6PAxsfCbAYuYouis+0/
        3jfLS+QsF4/4BGHdQgww3WTk8w==
X-Google-Smtp-Source: AA+uWPy1Kjcx2F6mSvb1bKcUWGkG3O0oEwwAMTu3UVpBBy6wm+ApGznrHR9njyQZX5MTzH2PATHaQw==
X-Received: by 2002:a6b:1fd1:: with SMTP id f200-v6mr16518697iof.227.1534361891267;
        Wed, 15 Aug 2018 12:38:11 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h13-v6sm3602606iom.1.2018.08.15.12.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:38:10 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:38:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 06/13] coresight: etb10: Handle errors enabling the device
Message-ID: <20180815193807.GB17954@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562915-21558-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:41:48PM +0100, Suzuki K Poulose wrote:
> Prepare the etb10 driver to return errors in enabling
> the device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 9fd77fd..37d2c88 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -107,7 +107,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>  	return depth;
>  }
>  
> -static void etb_enable_hw(struct etb_drvdata *drvdata)
> +static void __etb_enable_hw(struct etb_drvdata *drvdata)
>  {
>  	int i;
>  	u32 depth;
> @@ -135,6 +135,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>  
> +static int etb_enable_hw(struct etb_drvdata *drvdata)
> +{
> +	__etb_enable_hw(drvdata);
> +	return 0;
> +}
> +
>  static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>  {
>  	int ret = 0;
> @@ -150,7 +156,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>  	if (mode == CS_MODE_PERF) {
>  		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  
>  	val = local_cmpxchg(&drvdata->mode,
> @@ -172,12 +178,14 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>  		goto out;

Leaving this here doesn't compile when 'out' is removed below.

>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	etb_enable_hw(drvdata);
> +	ret = etb_enable_hw(drvdata);
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -out:
> -	if (!ret)
> +	if (ret)
> +		local_cmpxchg(&drvdata->mode, mode, CS_MODE_DISABLED);
> +	else
>  		dev_dbg(drvdata->dev, "ETB enabled\n");
> +
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
