Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB98C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0E22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhQ9KECE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA0E22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbeKOCPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:15:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51544 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeKOCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:15:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so15988632wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DHzral12+yq87z0TwMZLb6YMgGFBj0dfzsiIXz+ftss=;
        b=bhQ9KECEQXxIkac4uAXyWM4hyDokN+z3C9zArUboj3y4jPeTtNQhAVy9F8Px8P22/5
         LfppZzFZvxWKdcUZPcgj71uvhFUeaK3BSeFLOsVTNgKWZlGNJXw5y2mKEdT3vhRusVtO
         B3scaIYTrGI0FRdl2ZcCw5/NzdQa9jj5MK8b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DHzral12+yq87z0TwMZLb6YMgGFBj0dfzsiIXz+ftss=;
        b=I1wXKCvYrCpcCNAcD/e6Z6L2IX2vrcwU8NV3NkAmu1GzOliJhKhcfHpLVl/iKqbEqH
         LewVjDFqqlAqIFhoG1M2VwK+foZlBilOuivWXYPEO4XtBCXlOPHBgWNnikJJJ0s0xo4E
         3uymyUiDfsM3R/I/s7L8pCGqazt01upwTcNdLq8EMr7bUVuYn4ep+r2WMYGCC04PxhCf
         3S+qrpuhDvptPSwkFV87EZixtHraPVkmDZ+YOaRnZVAKJHO8hKZhwjrgzA+Pv6tqsBSj
         6TwVsUeMfmnp3bYt4TRL2ivdR37ZXbXyeOgLgcAAcDgFgXa3nMFk2rSJ4LlFdqeP8NE/
         lUHA==
X-Gm-Message-State: AGRZ1gLSZMeskwJEO4qL8xdTAuc71ndVysbXnKphwtRXaIpuQaufPNvE
        G26cwf2DBYNdu+GKHnoQIjuEsg==
X-Google-Smtp-Source: AJdET5eKTDGEu7GenPcqGjTj2hsSxcnRYQ6SV7cJTMJoT06mh0Qaozk9llQ9Vt0Uwmi8MJqZzjA68w==
X-Received: by 2002:a1c:b645:: with SMTP id g66-v6mr2450331wmf.25.1542211900046;
        Wed, 14 Nov 2018 08:11:40 -0800 (PST)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id j125-v6sm15702290wmb.12.2018.11.14.08.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:11:39 -0800 (PST)
Subject: Re: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent
 phy_get/ulpi_init during suspend/resume
To:     Roger Quadros <rogerq@ti.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org
Cc:     vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "linux-stable # = v4 . 13" <stable@vger.kernel.org>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com>
 <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org>
Date:   Wed, 14 Nov 2018 18:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After I apply this patch on 4.14 (or receive it with 4.14.70) I see a regression with
the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
In boot log I get:

[    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
[    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
[    4.536170] dwc3 7600000.dwc3: failed to initialize core
[    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
[    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
[    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
[    4.559606] dwc3 6a00000.dwc3: failed to initialize core
[    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16

I can provide a full log if needed.

Best regards,
Todor



On 12.02.2018 15:30, Roger Quadros wrote:
> In order for ULPI PHYs to work, dwc3_phy_setup() and dwc3_ulpi_init()
> must be doene before dwc3_core_get_phy().
> 
> commit 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
> broke this.
> 
> The other issue is that dwc3_core_get_phy() and dwc3_ulpi_init() should
> be called only once during the life cycle of the driver. However,
> as dwc3_core_init() is called during system suspend/resume it will
> result in multiple calls to dwc3_core_get_phy() and dwc3_ulpi_init()
> which is wrong.
> 
> Fix this by moving dwc3_ulpi_init() out of dwc3_phy_setup()
> into dwc3_core_ulpi_init(). Use a flag 'ulpi_ready' to ensure that
> dwc3_core_ulpi_init() is called only once from dwc3_core_init().
> 
> Use another flag 'phys_ready' to call dwc3_core_get_phy() only once from
> dwc3_core_init().
> 
> Fixes: 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
> Fixes: f54edb539c11 ("usb: dwc3: core: initialize ULPI before trying to get the PHY")
> Cc: linux-stable <stable@vger.kernel.org> # >= v4.13
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Rebased on Felipe's testing/fixes branch.
> 
>  drivers/usb/dwc3/core.c | 47 ++++++++++++++++++++++++++++++++++++-----------
>  drivers/usb/dwc3/core.h |  5 +++++
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 59511f2..f1d838a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -486,6 +486,22 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
>  	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
>  }
>  
> +static int dwc3_core_ulpi_init(struct dwc3 *dwc)
> +{
> +	int intf;
> +	int ret = 0;
> +
> +	intf = DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3);
> +
> +	if (intf == DWC3_GHWPARAMS3_HSPHY_IFC_ULPI ||
> +	    (intf == DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI &&
> +	     dwc->hsphy_interface &&
> +	     !strncmp(dwc->hsphy_interface, "ulpi", 4)))
> +		ret = dwc3_ulpi_init(dwc);
> +
> +	return ret;
> +}
> +
>  /**
>   * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
>   * @dwc: Pointer to our controller context structure
> @@ -497,7 +513,6 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
>  static int dwc3_phy_setup(struct dwc3 *dwc)
>  {
>  	u32 reg;
> -	int ret;
>  
>  	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>  
> @@ -568,9 +583,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  		}
>  		/* FALLTHROUGH */
>  	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
> -		ret = dwc3_ulpi_init(dwc);
> -		if (ret)
> -			return ret;
>  		/* FALLTHROUGH */
>  	default:
>  		break;
> @@ -727,6 +739,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
>  }
>  
>  static int dwc3_core_get_phy(struct dwc3 *dwc);
> +static int dwc3_core_ulpi_init(struct dwc3 *dwc);
>  
>  /**
>   * dwc3_core_init - Low-level initialization of DWC3 Core
> @@ -758,17 +771,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  			dwc->maximum_speed = USB_SPEED_HIGH;
>  	}
>  
> -	ret = dwc3_core_get_phy(dwc);
> +	ret = dwc3_phy_setup(dwc);
>  	if (ret)
>  		goto err0;
>  
> -	ret = dwc3_core_soft_reset(dwc);
> -	if (ret)
> -		goto err0;
> +	if (!dwc->ulpi_ready) {
> +		ret = dwc3_core_ulpi_init(dwc);
> +		if (ret)
> +			goto err0;
> +		dwc->ulpi_ready = true;
> +	}
>  
> -	ret = dwc3_phy_setup(dwc);
> +	if (!dwc->phys_ready) {
> +		ret = dwc3_core_get_phy(dwc);
> +		if (ret)
> +			goto err0a;
> +		dwc->phys_ready = true;
> +	}
> +
> +	ret = dwc3_core_soft_reset(dwc);
>  	if (ret)
> -		goto err0;
> +		goto err0a;
>  
>  	dwc3_core_setup_global_control(dwc);
>  	dwc3_core_num_eps(dwc);
> @@ -841,6 +864,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	phy_exit(dwc->usb2_generic_phy);
>  	phy_exit(dwc->usb3_generic_phy);
>  
> +err0a:
> +	dwc3_ulpi_exit(dwc);
> +
>  err0:
>  	return ret;
>  }
> @@ -1235,7 +1261,6 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  err3:
>  	dwc3_free_event_buffers(dwc);
> -	dwc3_ulpi_exit(dwc);
>  
>  err2:
>  	pm_runtime_allow(&pdev->dev);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 185b960..860d2bc 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -797,7 +797,9 @@ struct dwc3_scratchpad_array {
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
>   * @usb3_generic_phy: pointer to USB3 PHY
> + * @phys_ready: flag to indicate that PHYs are ready
>   * @ulpi: pointer to ulpi interface
> + * @ulpi_ready: flag to indicate that ULPI is initialized
>   * @u2sel: parameter from Set SEL request.
>   * @u2pel: parameter from Set SEL request.
>   * @u1sel: parameter from Set SEL request.
> @@ -895,7 +897,10 @@ struct dwc3 {
>  	struct phy		*usb2_generic_phy;
>  	struct phy		*usb3_generic_phy;
>  
> +	bool			phys_ready;
> +
>  	struct ulpi		*ulpi;
> +	bool			ulpi_ready;
>  
>  	void __iomem		*regs;
>  	size_t			regs_size;
> 

