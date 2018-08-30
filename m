Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23771C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECF820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECF820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHaCXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:23:17 -0400
Received: from muru.com ([72.249.23.125]:55104 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeHaCXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:23:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 44C4380BD;
        Thu, 30 Aug 2018 22:22:51 +0000 (UTC)
Date:   Thu, 30 Aug 2018 15:18:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Message-ID: <20180830221853.GX7523@atomide.com>
References: <20180425142922.128233-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425142922.128233-1-tony@atomide.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee,

* Tony Lindgren <tony@atomide.com> [180425 07:31]:
> It currently only works if the parent bus uses "simple-bus". We
> currently try to probe children with non-existing compatible values.
> And we're missing .probe.
> 
> I noticed this while testing devices configured to probe using ti-sysc
> interconnect target module driver. For that we also may want to rebind
> the driver, so let's remove __init and __exit.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> This is OK to wait for v4.18 merge window as the related dts node has
> not yet been updated to probe via ti-sysc interconnect target driver.

Sorry I just noticed this is still pending, it should be
applied as a fix for the -rc series.

Do you want me to resend the patch?

Regards,

Tony

>  drivers/mfd/omap-usb-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -548,8 +548,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
>  }
>  
>  static const struct of_device_id usbhs_child_match_table[] = {
> -	{ .compatible = "ti,omap-ehci", },
> -	{ .compatible = "ti,omap-ohci", },
> +	{ .compatible = "ti,ehci-omap", },
> +	{ .compatible = "ti,ohci-omap3", },
>  	{ }
>  };
>  
> @@ -875,6 +875,7 @@ static struct platform_driver usbhs_omap_driver = {
>  		.pm		= &usbhsomap_dev_pm_ops,
>  		.of_match_table = usbhs_omap_dt_ids,
>  	},
> +	.probe		= usbhs_omap_probe,
>  	.remove		= usbhs_omap_remove,
>  };
>  
> @@ -884,9 +885,9 @@ MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
>  
> -static int __init omap_usbhs_drvinit(void)
> +static int omap_usbhs_drvinit(void)
>  {
> -	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
> +	return platform_driver_register(&usbhs_omap_driver);
>  }
>  
>  /*
> @@ -898,7 +899,7 @@ static int __init omap_usbhs_drvinit(void)
>   */
>  fs_initcall_sync(omap_usbhs_drvinit);
>  
> -static void __exit omap_usbhs_drvexit(void)
> +static void omap_usbhs_drvexit(void)
>  {
>  	platform_driver_unregister(&usbhs_omap_driver);
>  }
> -- 
> 2.17.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
