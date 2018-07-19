Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDB220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGKrQ3VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDB220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeGSGYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:24:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46036 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeGSGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:24:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so3318915pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XauJIXq5BPA7vMbmdLiyJTCgFs43VaX4MfpstHCy340=;
        b=ZGKrQ3VP/gSmsZ/XVFuLGqCV1WKMWvaA6tKfEinuXQ+rlzrqiqISZwwYnzzHiQnFcc
         RxoNJdKy8TdEzOO2HTfRLZ4xiBSiosloesdnFSHNVDgC8EeEyn7b+IgPI/IShg0jyrcX
         ua6xCueA+fc+aGt9sfGqsI5iBJVkp8dBqolfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XauJIXq5BPA7vMbmdLiyJTCgFs43VaX4MfpstHCy340=;
        b=lx4SDjbulc05D8CqhAZMAlrgxp4oXMbtH8vZsZGNM2h1C8nU/HYi7+VrjMdgIoTkc8
         RI3DTHOsZvZlJRu3WeUeTuB8m12jAiVBaPB6G+ohYgICRD0klG7hIB7KN9Nac1sQrMaE
         thrrWs5vquUTe1oq+Dr3Kpe641JJUlSAn9kfFUdZ55HyCp1BhTLtzBFb1Fu35zTDkGUH
         JL00Vix/OZa7MzzCypEPx6Bk6aaqTEOTIFaB8Z0pJHbXchp6iiRKuoV7yjA5pHcbeBhP
         qgcv4aTWpIjiXLZefzBVlUFBE58hM8vG8/6MnEZqYQwK8jswfyUWXOZe9/zJCCs+m92D
         PY5w==
X-Gm-Message-State: AOUpUlHxoc3K24jTZWF9P4FfwgjdsIr+w13Cr40LQrdZveGyChOi+pZa
        rjxPgnin06gcO4Itz1BZKxrDlA==
X-Google-Smtp-Source: AAOMgpeE7JW6NFhykxBCzgexxJlIZQW54dWhngXZmDJpU2CHNuPyih/TNDl5tlzqSdrh57DGs501xQ==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr8712568pgm.222.1531978969176;
        Wed, 18 Jul 2018 22:42:49 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9-v6sm6312745pgv.31.2018.07.18.22.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 22:42:48 -0700 (PDT)
Date:   Wed, 18 Jul 2018 22:42:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
Message-ID: <20180719054200.GB30024@minitux>
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:

> commit '8c1b7dc9b: firmware: qcom: scm: Expose download-mode control'
> added support for download-mode control using the scm firmware
> driver for platforms which require a secure call to write the magic
> cookie into the tcsr location.
> 
> For platforms which *do not* need an scm call and where the kernel can
> write the cookie by a direct read/write, add similar support in the
> msm-poweroff driver.
> Similar to the scm driver, the msm-poweroff driver clears the cookie
> during a clean reboot.
> 
> Download mode using msm-poweroff driver can be enabled by including
> msm-poweroff.download_mode=1 on the command line.
> 

Should have thought about this when I wrote the scm code...

I would prefer if we could find a way to consolidate the two
implementations behind the same Kconfig and command line parameters.

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../bindings/power/reset/msm-poweroff.txt          |  3 ++
>  drivers/power/reset/Kconfig                        | 11 +++++++
>  drivers/power/reset/msm-poweroff.c                 | 38 ++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> index ce44ad3..9dd489f 100644
> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> @@ -8,6 +8,9 @@ settings.
>  Required Properties:
>  -compatible: "qcom,pshold"
>  -reg: Specifies the physical address of the ps-hold register
> +Optional Properties:
> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> +		 download mode control register
>  
>  Example:
>  
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index df58fc8..0c97e34 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
>  	help
>  	  Power off and restart support for Qualcomm boards.
>  
> +config POWER_RESET_MSM_DOWNLOAD_MODE

How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
both drivers?

> +	bool "Qualcomm download mode enabled by default"
> +	depends on POWER_RESET_MSM
> +	help
> +	  A device with "download mode" enabled will upon an unexpected
> +	  warm-restart enter a special debug mode that allows the user to
> +	  "download" memory content over USB for offline postmortem analysis.
> +	  The feature can be enabled/disabled on the kernel command line.
> +
> +	  Say Y here to enable "download mode" by default.
> +
>  config POWER_RESET_OCELOT_RESET
>  	bool "Microsemi Ocelot reset driver"
>  	depends on MSCC_OCELOT || COMPILE_TEST
> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
> index 01b8c71..c33eac5 100644
> --- a/drivers/power/reset/msm-poweroff.c
> +++ b/drivers/power/reset/msm-poweroff.c
> @@ -18,11 +18,20 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/reboot.h>
> +#include <linux/regmap.h>
>  #include <linux/pm.h>
>  
> +static bool download_mode = IS_ENABLED(CONFIG_POWER_RESET_MSM_DOWNLOAD_MODE);
> +module_param(download_mode, bool, 0);

Iirc it's possible to have multiple implementations of __setup() for the
same string. I'm uncertain if this would be considered okay though.

> +
> +#define QCOM_SET_DLOAD_MODE 0x10
>  static void __iomem *msm_ps_hold;
> +static struct regmap *tcsr_regmap;
> +static unsigned int dload_mode_offset;
> +
>  static int deassert_pshold(struct notifier_block *nb, unsigned long action,
>  			   void *data)
>  {
> @@ -44,9 +53,30 @@ static void do_msm_poweroff(void)
>  
>  static int msm_restart_probe(struct platform_device *pdev)
>  {
> +	int ret;
> +	struct of_phandle_args args;
>  	struct device *dev = &pdev->dev;
>  	struct resource *mem;
>  
> +	if (download_mode) {
> +		ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +						       "qcom,dload-mode", 1, 0,
> +						       &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		tcsr_regmap = syscon_node_to_regmap(args.np);
> +		of_node_put(args.np);
> +		if (IS_ERR(tcsr_regmap))
> +			return PTR_ERR(tcsr_regmap);
> +
> +		dload_mode_offset = args.args[0];
> +
> +		/* Enable download mode by writing the cookie */
> +		regmap_write(tcsr_regmap, dload_mode_offset,
> +			     QCOM_SET_DLOAD_MODE);
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	msm_ps_hold = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(msm_ps_hold))
> @@ -59,6 +89,13 @@ static int msm_restart_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void msm_restart_shutdown(struct platform_device *pdev)
> +{
> +	/* Clean shutdown, disable download mode to allow normal restart */
> +	if (download_mode)
> +		regmap_write(tcsr_regmap, dload_mode_offset, 0x0);
> +}
> +
>  static const struct of_device_id of_msm_restart_match[] = {
>  	{ .compatible = "qcom,pshold", },
>  	{},
> @@ -71,6 +108,7 @@ static int msm_restart_probe(struct platform_device *pdev)
>  		.name = "msm-restart",
>  		.of_match_table = of_match_ptr(of_msm_restart_match),
>  	},
> +	.shutdown = msm_restart_shutdown,
>  };

Implementation looks good.

Regards,
Bjorn
