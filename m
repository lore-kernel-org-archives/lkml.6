Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BBC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C88820685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFI1/nig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C88820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeKUEAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:00:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35337 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeKUEAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:00:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id v1-v6so1334937plo.2;
        Tue, 20 Nov 2018 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHPEnz2laoctEf3FPieGJu6IoQ0LSQbTgAFkh+PqW1Q=;
        b=rFI1/nigi7cYIWY6E9nxvVrJ0paX7b0oZfL2dFF8SdE4KbpDw5FbTLy3yDb205EPb7
         7zAY8UjnX4wpnEcuQyRrkCbcqd5umPgWsELYUkHNYsHPQ0/zEusvpzV4TeziM1A1QrXL
         BDQc46aRF8RJ8Q1bGkUskAQGCmv8lKYgqwCynVJl7p8hjUs+D93F7ZGTBWe+gKUlp80b
         YniCXB45KTHVquh+OYrqph6qwN21b98uS3VkeixpviUuKMax0Xyan51lmw1erdbFl9Vv
         hdTFHUmRIPWsMJXQACULTTFhkOb8YTchuHdcxbr0YZ3fUUCqo35tddq2yyL4zirHe9Wf
         dLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHPEnz2laoctEf3FPieGJu6IoQ0LSQbTgAFkh+PqW1Q=;
        b=BmcN7dlbhfHQHNOgT9YbLvhRDx3+WtKb6jPg0UdfpXjb9hjdBUoP4McCu9E4WQ48xv
         wJECtdk2YNrakXlXvPoXFk8WXmf902XBb3G/EjHlKJSfafAI2Yzq5FVKb2L3q1bPmSsy
         ratZUHfpZ5KiYY3xVGla3yZw2oU6O/3TmkzufKNzx9yXxjSxewaHxHkOJDpRhu5hVI3E
         XaXLM/K9DOmFd5umhBHv+Gj/Ci+gMRPvCz38rFXw8HfuXzj+hnPujzIDHrtB0No39G5D
         XB2rbiTBpJY9HsVdUG0CLDI8q3FNznpXoz6XNxsuiyS/YOl1d80Rh1ipDtB6xTSvyM1u
         L/Hw==
X-Gm-Message-State: AGRZ1gLgnjxIff6s+P/p57zWtFkeMaqiFV5CLCZt+yJTF4isfX9ylD8L
        MI0+0o0jrN+o8+BDH0pRf0g=
X-Google-Smtp-Source: AFSGD/WsZDywfMFEczpBlwYZeXhC7ub4KrSRhF+ky7Z3/aHIesTuDemfn7Q/v6zN6teG2wXex8ulZQ==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr2780557pgt.140.1542734996782;
        Tue, 20 Nov 2018 09:29:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q187sm54365690pfq.128.2018.11.20.09.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:29:56 -0800 (PST)
Date:   Tue, 20 Nov 2018 09:29:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eric Anholt <eric@anholt.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/8] watchdog: bcm2835: Move the driver to the soc/
 directory.
Message-ID: <20181120172955.GD32433@roeck-us.net>
References: <20181120172000.15102-1-eric@anholt.net>
 <20181120172000.15102-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120172000.15102-2-eric@anholt.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:19:53AM -0800, Eric Anholt wrote:
> The binding for the bcm2835 "wdt" actually covers a large range of the
> PM block's register space.  The WDT is not a separate HW block from
> the rest of power domain management, so move the driver to the soc/
> directory in preparation for expanding its role to cover power
> domains.
> 
> This move does result in the driver being made mandatory for the
> BCM2835 platform, which is probably actually reasonable given that
> it's necessary for reboot/halt support.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Keeping drivers out of their domain tends to have the effect of maintainers
not being aware of changes, which in turn tends to result in bad code.
I have seen that happen a lot with hwmon drivers, and  I am not in favor
of it. It would be better to keep the watchdog code where it is and have
it instantiated from a soc parent, which could pass, for example, regmap
information to the driver for register accesses.

If the new SoC approach is to move everything into SoC, you'll be on 
your own. I won't NACK this, but I won't ACK it either.

Guenter

> ---
>  drivers/soc/bcm/Makefile                              |  1 +
>  .../{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c}  |  0
>  drivers/watchdog/Kconfig                              | 11 -----------
>  drivers/watchdog/Makefile                             |  1 -
>  4 files changed, 1 insertion(+), 12 deletions(-)
>  rename drivers/{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c} (100%)
> 
> diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
> index dc4fced72d21..16504eb694b1 100644
> --- a/drivers/soc/bcm/Makefile
> +++ b/drivers/soc/bcm/Makefile
> @@ -1,2 +1,3 @@
> +obj-$(CONFIG_ARCH_BCM2835)      += bcm2835-pm.o
>  obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
>  obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/soc/bcm/bcm2835-pm.c
> similarity index 100%
> rename from drivers/watchdog/bcm2835_wdt.c
> rename to drivers/soc/bcm/bcm2835-pm.c
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333f4782..796e2a593056 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1573,17 +1573,6 @@ config BCM63XX_WDT
>  	  To compile this driver as a loadable module, choose M here.
>  	  The module will be called bcm63xx_wdt.
>  
> -config BCM2835_WDT
> -	tristate "Broadcom BCM2835 hardware watchdog"
> -	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
> -	select WATCHDOG_CORE
> -	help
> -	  Watchdog driver for the built in watchdog hardware in Broadcom
> -	  BCM2835 SoC.
> -
> -	  To compile this driver as a loadable module, choose M here.
> -	  The module will be called bcm2835_wdt.
> -
>  config BCM_KONA_WDT
>  	tristate "BCM Kona Watchdog"
>  	depends on ARCH_BCM_MOBILE || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f69cdff5ad7f..1788537e85af 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -70,7 +70,6 @@ obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>  obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
> -obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
>  obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
>  obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
>  obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
> -- 
> 2.19.1
> 
