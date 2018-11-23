Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D92BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gDAHnhUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA8B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393525AbeKWSmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:42:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42226 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbeKWSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:42:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAN7xVhT070549;
        Fri, 23 Nov 2018 01:59:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542959971;
        bh=5y01K78eceI8vVUZ4RQidg6M1quCMIqKPDZEdd/KYpY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gDAHnhUsMCV2ndSx6PVw61iUsIo+4DPqxbe4I9DIAhBPvGIVluejuUgWp4Y+JzDiz
         Mi4cNkNBIL35fvANZuzfuU9MfLUiCCJLeMrpXhqXKQR553ctJkcIhfKIy8voaNbQuc
         ZiydpjjweSrBVvXux56MzLd8VtMUG/+tQfArRwAg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAN7xVLX024938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 01:59:31 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 01:59:31 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 01:59:31 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAN7xSf9017028;
        Fri, 23 Nov 2018 01:59:29 -0600
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: Improve phy related runtime PM
 calls
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-3-tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
Date:   Fri, 23 Nov 2018 13:29:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181117133755.9129-3-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 17/11/18 7:07 PM, Tony Lindgren wrote:
> I noticed that phy_pm_runtime_get_sync() and phy_pm_runtime_put() are not
> currently doing anything for phy-mapphone-mdm6600, only the sysfs interface
> for works for "auto" and "on".
> 
> This is because of the shared GPIO pins between mdm6600 USB port and n_gsm
> port. We have not enabled runtime PM for the phy driver until after we've
> booted up mdm6600 properly to the USB mode. Otherwise phy_create() would
> have called pm_runtime_enable() and pm_runtime_no_callbacks() automatically
> on init.
> 
> Let's fix this by registering the phy a bit later after we've powered up the
> mdm6600 USB port.
> 
> And as the PM runtime support is only needed for the n_gsm mode and not for
> USB, we can allow the device to idle between phy_mdm6600_power_on() and
> phy_mdm6600_power_off(). Note that for suspend, runtime_pm is already
> disabled for the phy so we need to check for phy_pm_runtime_enabled().
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 71 +++++++++++++++------
>  1 file changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
>  #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
> @@ -124,12 +125,22 @@ static int phy_mdm6600_power_on(struct phy *x)
>  {
>  	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
>  	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
> +	int error;
>  
>  	if (!ddata->enabled)
>  		return -ENODEV;
>  
> +	error = pinctrl_pm_select_default_state(ddata->dev);
> +	if (error)
> +		dev_warn(ddata->dev, "%s: error with default_state: %i\n",
> +			 __func__, error);
> +
>  	gpiod_set_value_cansleep(enable_gpio, 1);
>  
> +	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
> +	if (phy_pm_runtime_enabled(ddata->generic_phy))
> +		phy_pm_runtime_put(ddata->generic_phy);

phy_*() API's are generally added to be used by the consumer driver. I guess in
this case we can directly use pm_runtime_enabled(x).

Thanks
Kishon
