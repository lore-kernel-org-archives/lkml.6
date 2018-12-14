Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B8CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6076020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="blauWLTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6076020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeLNJmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:42:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51124 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:42:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBE9fvPB079732;
        Fri, 14 Dec 2018 03:41:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544780517;
        bh=RgMEplXqcA7XenvE7kXXnkZ16PUgjZH6e7t4XYV6eXQ=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=blauWLTn2sR8Hhe8+2l45RVe8UpqMO1h0FGWd8cP8Nv20/rzWycMoYFgqI14PVW4v
         CC6vdR2nojF6de334RnPPXaKSERwH1CqWxpkzstUbqh2g7eP9EhLO+pAzBHHJxPDnA
         I8CDZrzPFw+soXuQ5i2jRcis0aBTsmOzlCA/HuQM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBE9fvWe000958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 03:41:57 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 03:41:56 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 03:41:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBE9fsvi003151;
        Fri, 14 Dec 2018 03:41:55 -0600
Subject: Re: [PATCH 1/4] phy: ti: usb2: Fix logic on -EPROBE_DEFER
To:     <kishon@ti.com>, Tony Lindgren <tony@atomide.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
 <1544022206-2300-2-git-send-email-rogerq@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C137AE2.4080803@ti.com>
Date:   Fri, 14 Dec 2018 11:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1544022206-2300-2-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 05/12/18 17:03, Roger Quadros wrote:
> If clk_get() returns -EPROBE_DEFER then we should just
> return instead of falling back to old clock name.
> 
> Use clk_prepare_enable() and clk_disable_unprepare() instead
> of splitting up prepare/unprepare from enable/disable.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

I think you should pick this one for -next independently of the rest
of the series as Tony's ti-sysc patches might cause this issue to trigger
due to re-ordering of devices.


cheers,
-roger

> ---
>  drivers/phy/ti/phy-omap-usb2.c | 88 ++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index fe909fd..418e7f1 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -135,9 +135,9 @@ static int omap_usb_power_on(struct phy *x)
>  
>  static int omap_usb2_disable_clocks(struct omap_usb *phy)
>  {
> -	clk_disable(phy->wkupclk);
> +	clk_disable_unprepare(phy->wkupclk);
>  	if (!IS_ERR(phy->optclk))
> -		clk_disable(phy->optclk);
> +		clk_disable_unprepare(phy->optclk);
>  
>  	return 0;
>  }
> @@ -146,14 +146,14 @@ static int omap_usb2_enable_clocks(struct omap_usb *phy)
>  {
>  	int ret;
>  
> -	ret = clk_enable(phy->wkupclk);
> +	ret = clk_prepare_enable(phy->wkupclk);
>  	if (ret < 0) {
>  		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
>  		goto err0;
>  	}
>  
>  	if (!IS_ERR(phy->optclk)) {
> -		ret = clk_enable(phy->optclk);
> +		ret = clk_prepare_enable(phy->optclk);
>  		if (ret < 0) {
>  			dev_err(phy->dev, "Failed to enable optclk %d\n", ret);
>  			goto err1;
> @@ -346,63 +346,72 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	otg->set_host		= omap_usb_set_host;
> -	otg->set_peripheral	= omap_usb_set_peripheral;
> -	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
> -		otg->set_vbus		= omap_usb_set_vbus;
> -	if (phy_data->flags & OMAP_USB2_HAS_START_SRP)
> -		otg->start_srp		= omap_usb_start_srp;
> -	otg->usb_phy		= &phy->phy;
> -
> -	platform_set_drvdata(pdev, phy);
> -	pm_runtime_enable(phy->dev);
> -
> -	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
> -	if (IS_ERR(generic_phy)) {
> -		pm_runtime_disable(phy->dev);
> -		return PTR_ERR(generic_phy);
> -	}
> -
> -	phy_set_drvdata(generic_phy, phy);
> -	omap_usb_power_off(generic_phy);
> -
> -	phy_provider = devm_of_phy_provider_register(phy->dev,
> -			of_phy_simple_xlate);
> -	if (IS_ERR(phy_provider)) {
> -		pm_runtime_disable(phy->dev);
> -		return PTR_ERR(phy_provider);
> -	}
>  
>  	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>  	if (IS_ERR(phy->wkupclk)) {
> -		dev_warn(&pdev->dev, "unable to get wkupclk, trying old name\n");
> +		if (PTR_ERR(phy->wkupclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		dev_warn(&pdev->dev, "unable to get wkupclk %ld, trying old name\n",
> +			 PTR_ERR(phy->wkupclk));
>  		phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> +
>  		if (IS_ERR(phy->wkupclk)) {
> -			dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
> -			pm_runtime_disable(phy->dev);
> +			if (PTR_ERR(phy->wkupclk) != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
>  			return PTR_ERR(phy->wkupclk);
>  		} else {
>  			dev_warn(&pdev->dev,
>  				 "found usb_phy_cm_clk32k, please fix DTS\n");
>  		}
>  	}
> -	clk_prepare(phy->wkupclk);
>  
>  	phy->optclk = devm_clk_get(phy->dev, "refclk");
>  	if (IS_ERR(phy->optclk)) {
> +		if (PTR_ERR(phy->optclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_dbg(&pdev->dev, "unable to get refclk, trying old name\n");
>  		phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
> +
>  		if (IS_ERR(phy->optclk)) {
> -			dev_dbg(&pdev->dev,
> -				"unable to get usb_otg_ss_refclk960m\n");
> +			if (PTR_ERR(phy->optclk) != -EPROBE_DEFER) {
> +				dev_dbg(&pdev->dev,
> +					"unable to get usb_otg_ss_refclk960m\n");
> +			}
>  		} else {
>  			dev_warn(&pdev->dev,
>  				 "found usb_otg_ss_refclk960m, please fix DTS\n");
>  		}
>  	}
>  
> -	if (!IS_ERR(phy->optclk))
> -		clk_prepare(phy->optclk);
> +	otg->set_host = omap_usb_set_host;
> +	otg->set_peripheral = omap_usb_set_peripheral;
> +	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
> +		otg->set_vbus = omap_usb_set_vbus;
> +	if (phy_data->flags & OMAP_USB2_HAS_START_SRP)
> +		otg->start_srp = omap_usb_start_srp;
> +	otg->usb_phy = &phy->phy;
> +
> +	platform_set_drvdata(pdev, phy);
> +	pm_runtime_enable(phy->dev);
> +
> +	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
> +	if (IS_ERR(generic_phy)) {
> +		pm_runtime_disable(phy->dev);
> +		return PTR_ERR(generic_phy);
> +	}
> +
> +	phy_set_drvdata(generic_phy, phy);
> +	omap_usb_power_off(generic_phy);
> +
> +	phy_provider = devm_of_phy_provider_register(phy->dev,
> +						     of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		pm_runtime_disable(phy->dev);
> +		return PTR_ERR(phy_provider);
> +	}
> +
>  
>  	usb_add_phy_dev(&phy->phy);
>  
> @@ -413,9 +422,6 @@ static int omap_usb2_remove(struct platform_device *pdev)
>  {
>  	struct omap_usb	*phy = platform_get_drvdata(pdev);
>  
> -	clk_unprepare(phy->wkupclk);
> -	if (!IS_ERR(phy->optclk))
> -		clk_unprepare(phy->optclk);
>  	usb_remove_phy(&phy->phy);
>  	pm_runtime_disable(phy->dev);
>  
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
