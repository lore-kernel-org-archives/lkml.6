Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeC1LP5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:15:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37538 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeC1LPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:15:41 -0400
X-Google-Smtp-Source: AIpwx49Kt7QD6UVVbOtUEyCSmsRUvbDTtz72BqxwoaEahPb0XSdzargK4RlcRaC2/QM1W44CK5Qx2Q==
Date: Wed, 28 Mar 2018 12:15:37 +0100
From: Lee Jones <lee.jones@linaro.org>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        eddie.huang@mediatek.com, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/16] mfd: mt6397: add MT6323 RTC support into MT6397
 driver
Message-ID: <20180328111537.34xcqzpgjf7gu3zw@dell>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <90320622cb491b9d3251e2ce9d0501422f47660f.1521794177.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90320622cb491b9d3251e2ce9d0501422f47660f.1521794177.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, sean.wang@mediatek.com wrote:

> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add compatible string as "mt6323-rtc" that will make the OF core spawn
> child devices for the RTC subnode of that MT6323 MFD node.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 77b64bd..f71874a 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2014 MediaTek Inc.
> + * Copyright (c) 2014-2018 MediaTek Inc.
>   * Author: Flora Fu, MediaTek
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -23,6 +23,9 @@
>  #include <linux/mfd/mt6397/registers.h>
>  #include <linux/mfd/mt6323/registers.h>
>  
> +#define MT6323_RTC_BASE		0x8000
> +#define MT6323_RTC_SIZE		0x3e
> +
>  #define MT6397_RTC_BASE		0xe000
>  #define MT6397_RTC_SIZE		0x3e
>  
> @@ -30,6 +33,19 @@
>  #define MT6391_CID_CODE		0x91
>  #define MT6397_CID_CODE		0x97
>  
> +static const struct resource mt6323_rtc_resources[] = {
> +	{
> +		.start = MT6323_RTC_BASE,
> +		.end   = MT6323_RTC_BASE + MT6323_RTC_SIZE,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MT6323_IRQ_STATUS_RTC,
> +		.end   = MT6323_IRQ_STATUS_RTC,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};

Please use the DEFINE_RES_* helpers instead.

Defined in: include/linux/ioport.h

>  static const struct resource mt6397_rtc_resources[] = {
>  	{
>  		.start = MT6397_RTC_BASE,
> @@ -55,6 +71,11 @@ static const struct resource mt6397_keys_resources[] = {
>  
>  static const struct mfd_cell mt6323_devs[] = {
>  	{
> +		.name = "mt6323-rtc",
> +		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
> +		.resources = mt6323_rtc_resources,
> +		.of_compatible = "mediatek,mt6323-rtc",
> +	}, {
>  		.name = "mt6323-regulator",
>  		.of_compatible = "mediatek,mt6323-regulator"
>  	}, {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
