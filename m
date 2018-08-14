Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE79FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838C921653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVwqypsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838C921653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbeHNU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:28:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46229 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeHNU2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:28:50 -0400
Received: by mail-io0-f196.google.com with SMTP id x5-v6so2374463iop.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oofgLZYiJj1L40Wdxf9XvV5bmhkQP3ZD5kH0jPqtQx0=;
        b=JVwqypsXs9bsNQHfe2UxuB1fQFx6Iny1LKRiMkxMICOZn5vhScqOTcAkTvSLvKVKZQ
         o5/0iGjp1xndxHCZ00f1wGTzDC4kL7bYoUtyhXhhZqXIocm7/6Uliv1Nd+A0UVzhQSea
         /ip9NdoouacVEpTu+mrcJB2dm9TDUosyYk4P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oofgLZYiJj1L40Wdxf9XvV5bmhkQP3ZD5kH0jPqtQx0=;
        b=I/7WoCsideum1mA2+aOuS4ji26hc0J6zqumUAOM/d1vm0ePDG7obyaNjtVutXYmRjX
         XF/tP0F7nj8LC7hazaiCLfr+fW9DjGlNCZQ7Zr9olkMI0KERt//loAmuLwlkx1Kgv1/6
         Pzkc+XksJBXn1WfZbiUklbv87BRsTzxZW0TyqAYn26AVN7LBgQyrZHS8NJqQXxYa9LHc
         vNEAUMlPz5h/g6c8u1ArsCSNXe+wDK8ghmnR7C4g3zvGkeawNM96QmH4PzlH7yipW9KF
         RLT8kVz2U2dNsjKRh5j+Lt3uWryjEAVT6vE2EBfRiFI4IbpjjOGKjxYzwUXG+JNl+YIm
         5rBQ==
X-Gm-Message-State: AOUpUlHJTgtP56WCMHzRlPP6I66x6OYWgnaA2xmkaAOTRXFMbqcWGh6F
        FI0X2qbcbaxSMbvOC7g7oo0l1Q==
X-Google-Smtp-Source: AA+uWPy8j2K7wPkIcues2uOFSPGLT2WYg4mqGg3k05LZSsOa+IkpjDG3ChzwvfabOfIupggYOxweeQ==
X-Received: by 2002:a5e:9b14:: with SMTP id j20-v6mr20391003iok.193.1534268439464;
        Tue, 14 Aug 2018 10:40:39 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p18-v6sm947463ioh.39.2018.08.14.10.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:40:38 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:40:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 06/13] coresight: etb10: Handle errors enabling the device
Message-ID: <20180814174035.GA13135@xps15>
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

Hi Suzuki,

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

I also have to do hackish things with my work on
CPU-wide trace scenarios because drvdata->mode is of type local_t.  Instead of
living with it I'll send out a patch later today that moves it to a u32 like ETF
and ETR.

Please look at it and if you're happy, add it to this patchset and do your 
modifications on top of it.

Thanks,
Mathieu

>  		dev_dbg(drvdata->dev, "ETB enabled\n");
> +
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
