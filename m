Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B133C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064E821527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D38RnnI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeIRV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:56:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33448 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbeIRV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:56:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so1272116pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CPG8akTEe5nknGys2KRr3Yc3bqIq5jfumsPKby5uuts=;
        b=D38RnnI7BqArzcN892W9T379rEFRg/WdIWr9nt80u7gLkVgeKZtcbQfw4Tt599LjtS
         Y+/72Oc+7ZqzikpVyJ30O4dyyThkFv72oesgO15J/QZcSanDksUbrFtNm3AAnjVwRfWX
         +x4vb/V+/iehBobXoA7K2o+njOcXL25pdyxCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPG8akTEe5nknGys2KRr3Yc3bqIq5jfumsPKby5uuts=;
        b=jkb7whJNdy1cr5YIgU++0u7S0uJowxHa5cGI/W6VBP/PyaGcjis2msqIdeWnNliHvs
         aMlXaaiIbNn2yuqnFEPtCQSODT83KsBKvuy7bRI7ULd0PO2Az4QY2/T1VCKjfsjgeXNt
         VzRYfuCkTM81/8yQw68rolXBcR/lSou/ohu0aoYF5Rj3jcFvwUegKWdw4XDHD71ffSw1
         z0ciGfWO+fQjt4LWirLi18L7Q8LMHIDpTPkvDu2v5DpsKRO4Hzcz52F7NyG2NBpMplqA
         6/dXm/Shtg6m/ESp6SUNMQNODdkRumW2FFWwVcVLvD8afVTqsVd9zDTlMhPxO0zOjMny
         PR3w==
X-Gm-Message-State: APzg51DXfNWUeSOt/RF7I0xTDJREGVo6XGdGbY1XKot98Q5d5O2lpjjS
        bfh6sTcpmtATZHLoZedk5OhCyg==
X-Google-Smtp-Source: ANB0Vdags2RW4WoamlxY62I4wyv8B4VuQuCpEVc1CBiWOnk6Y5glBqbgl3rvTC4tuT3BPFAQKonlcA==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr29205691pgg.434.1537287788449;
        Tue, 18 Sep 2018 09:23:08 -0700 (PDT)
Received: from centauri ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id m27-v6sm26056283pff.152.2018.09.18.09.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 09:23:07 -0700 (PDT)
Date:   Tue, 18 Sep 2018 18:23:05 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2 1/2] remoteproc: qcom: Rename Hexagon v5 PAS driver
Message-ID: <20180918162305.GA7753@centauri>
References: <20180914173552.20370-1-bjorn.andersson@linaro.org>
 <20180914173552.20370-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914173552.20370-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:35:51AM -0700, Bjorn Andersson wrote:
> The Hexagon v5 ADSP driver is used for more than only the ADSP and
> there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
> qcom_q6v5_pas in order to better suite this.
> 
> Cc: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/Kconfig                    | 27 ++++++++++---------
>  drivers/remoteproc/Makefile                   |  2 +-
>  .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}      |  0
>  .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
>  4 files changed, 17 insertions(+), 16 deletions(-)
>  rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (100%)
>  rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

Hello Bjorn,

I would have expected the second rename to be in patch 2/2.

Kind regards,
Niklas

> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 052d4dd347f9..425e502c6471 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -84,8 +84,16 @@ config KEYSTONE_REMOTEPROC
>  	  It's safe to say N here if you're not interested in the Keystone
>  	  DSPs or just want to use a bare minimum kernel.
>  
> -config QCOM_ADSP_PIL
> -	tristate "Qualcomm ADSP Peripheral Image Loader"
> +config QCOM_RPROC_COMMON
> +	tristate
> +
> +config QCOM_Q6V5_COMMON
> +	tristate
> +	depends on ARCH_QCOM
> +	depends on QCOM_SMEM
> +
> +config QCOM_Q6V5_PAS
> +	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
>  	depends on OF && ARCH_QCOM
>  	depends on QCOM_SMEM
>  	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> @@ -98,15 +106,7 @@ config QCOM_ADSP_PIL
>  	select QCOM_SCM
>  	help
>  	  Say y here to support the TrustZone based Peripherial Image Loader
> -	  for the Qualcomm ADSP remote processors.
> -
> -config QCOM_RPROC_COMMON
> -	tristate
> -
> -config QCOM_Q6V5_COMMON
> -	tristate
> -	depends on ARCH_QCOM
> -	depends on QCOM_SMEM
> +	  for the Qualcomm Hexagon v5 based remote processors.
>  
>  config QCOM_Q6V5_PIL
>  	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
> @@ -120,8 +120,9 @@ config QCOM_Q6V5_PIL
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
>  	help
> -	  Say y here to support the Qualcomm Peripherial Image Loader for the
> -	  Hexagon V5 based remote processors.
> +	  Say y here to support the TrustZone based Peripherial Image Loader
> +	  for the Qualcomm Hexagon v5 based remote processors. This is commonly
> +	  used to control subsystems such as ADSP, Compute and Sensor.
>  
>  config QCOM_Q6V5_WCSS
>  	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 03332fa7e2ee..eb86c8ba5a87 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
> +obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
>  obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
>  obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
>  obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_mss.c
> similarity index 100%
> rename from drivers/remoteproc/qcom_q6v5_pil.c
> rename to drivers/remoteproc/qcom_q6v5_mss.c
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_q6v5_pas.c
> similarity index 98%
> rename from drivers/remoteproc/qcom_adsp_pil.c
> rename to drivers/remoteproc/qcom_q6v5_pas.c
> index d4339a6da616..2478ef3cd519 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -364,11 +364,11 @@ static struct platform_driver adsp_driver = {
>  	.probe = adsp_probe,
>  	.remove = adsp_remove,
>  	.driver = {
> -		.name = "qcom_adsp_pil",
> +		.name = "qcom_q6v5_pas",
>  		.of_match_table = adsp_of_match,
>  	},
>  };
>  
>  module_platform_driver(adsp_driver);
> -MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
> +MODULE_DESCRIPTION("Qualcomm Hexagon v5 Peripheral Authentication Service driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.18.0
> 
