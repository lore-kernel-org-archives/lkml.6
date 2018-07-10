Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7363B208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7363B208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeGJPzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:55:25 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:42524 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeGJPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:55:24 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52454 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fcuz4-0004lR-3I; Tue, 10 Jul 2018 17:55:22 +0200
Subject: Re: [PATCH] drm/tinydrm: add backlight dependency for ili9341
To:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>
Cc:     Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180709152106.990066-1-arnd@arndb.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <42317727-5159-7cc2-f6a8-18c8f97b9e6e@tronnes.org>
Date:   Tue, 10 Jul 2018 17:55:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709152106.990066-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 09.07.2018 17.20, skrev Arnd Bergmann:
> This tinydrm driver fails to link without the backlight support:
>
> drivers/gpu/drm/tinydrm/ili9341.o: In function `ili9341_probe':
> ili9341.c:(.text+0x578): undefined reference to `devm_of_find_backlight'
>
> Fixes: 3fa0e8f6f960 ("drm/tinydrm: new driver for ILI9341 display panels")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/tinydrm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
> index 7a8008b0783f..16f4b5c91f1b 100644
> --- a/drivers/gpu/drm/tinydrm/Kconfig
> +++ b/drivers/gpu/drm/tinydrm/Kconfig
> @@ -23,6 +23,7 @@ config TINYDRM_ILI9225
>   config TINYDRM_ILI9341
>   	tristate "DRM support for ILI9341 display panels"
>   	depends on DRM_TINYDRM && SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
>   	select TINYDRM_MIPI_DBI
>   	help
>   	  DRM driver for the following Ilitek ILI9341 panels:

There was some work done to make backlight optional, but I see now that
it failed to take into account the possibility of the driver being
builtin and BACKLIGHT_CLASS_DEVICE being a module.

This is from include/linux/backlight.h:

#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
struct backlight_device *of_find_backlight(struct device *dev);
struct backlight_device *devm_of_find_backlight(struct device *dev);
#else
static inline struct backlight_device *of_find_backlight(struct device *dev)
{
     return NULL;
}

static inline struct backlight_device *
devm_of_find_backlight(struct device *dev)
{
     return NULL;
}
#endif


Anyways, thanks for fixing this:
Acked-by: Noralf Trønnes <noralf@tronnes.org>

David Lechner do you apply this?

Noralf.

