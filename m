Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E42146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPqugvUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74E42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeKUQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:26:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45663 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:26:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so3822792plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Xu/UvSAaQ43MnGLyI7x2xvvJP/BrN1NmUuBzaUg/lI=;
        b=hPqugvUqlhYsIEp01Nxaerf5SC05QhODExqLF/Q2NrCEim8OOZjz3S0yDEU2t2KmXe
         vAAeNzsttI0lgtPIIgK1C5dwfgG0bHBd7brk4W2sGlbdLv4iWRcCnSvjmMYCf7Km136F
         j6ba4KsQY36WCPvif2BV4ZOy0XoZtdgSe0jbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Xu/UvSAaQ43MnGLyI7x2xvvJP/BrN1NmUuBzaUg/lI=;
        b=aZyDRKlwSz7TBdVhjzWaC9UcpLBH919fKujEqQlXQJkZZ8dnaguHzYC3wI/TxeCvWY
         twqQdbGZHIgKk9fApnZ8NIlLwsmVqlef48psJW/d9upOhuiSjmerkDxMJeKWQBymytqe
         QRWRHgYGu2iY7erVTaFM1xILjnvaD0QeNOmSRoxvr9Jk8xVBhm/zLNGfSLhzJFJlVk6f
         bN93w1yAbX/PIaQQsMxGZDCdICyjW3mVphO0IgucQn5SGf0fCCLq+f0HHKi5QdCKeP/t
         jGsSsukB/gN+RdFggB0lpLyEBV8C1zGOqe9IgyfJxSFjjg3dNIfeKTrJgHs0AkPSUJ7F
         V4ZA==
X-Gm-Message-State: AGRZ1gJG6tJgx6tn8TfaAEEQiV2WuEU8uIsJno/UJLPu1hOFJezLnB8p
        T1nW4Cell5vtJnzY9Ojt+POVNg==
X-Google-Smtp-Source: AJdET5dFlKJ8a16W31ztw9KtAoBXJBt2lvXZ2CpLGGF2q3GlAtsiiSU+OTEayCCgEZ7mMSePBQsmFQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr4739240pgg.207.1542779619382;
        Tue, 20 Nov 2018 21:53:39 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id w184sm16611936pgd.34.2018.11.20.21.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:53:38 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:23:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
Message-ID: <20181121055336.rrwaxanivp2nkpyh@vireshk-i7>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
 <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 05:49, Anson Huang wrote:
> Put return value checks of calling imx_init_from_nvmem_cells()
> into one block to save one condition block for normal case.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/imx_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c924396..bb6754a 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -742,9 +742,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  
>  	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
>  		ret = imx_init_from_nvmem_cells(pdev);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
>  		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
>  			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
>  				ret);
>  			return ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
