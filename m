Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600DAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E99B25800
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="NNGCBQ9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E99B25800
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754943AbeFYQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:04:24 -0400
Received: from vern.gendns.com ([206.190.152.46]:47932 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754627AbeFYQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AT7xGNkZYwada6fyUNN72iFFjRAjmLAbEX/VcXpmPeU=; b=NNGCBQ9A43bWmVFU/OR+uC3+U4
        mzzQCS2M2YZ+8//qzBHsbs36n23zfXWEkeQQSVHVJY5NVws9rrrk+QpZJymWg5Jwo2Z4nKbXcjqdF
        2NC92L6JFjx3oycNsexPJzzJ56af19aBXu4kizCqh02pA8Vp8vNKxjTqVEm/qpbUXQR7i5+uK14at
        GOVlA7zQZwv8ZFa/RyaTrGgUOWjfLKm249QSrY/EWUZ7zBU3V2v/w1IHWiKiExmyT7gNWwgwutSYb
        EnqIz8oPwU2xeIyWg4XVsHienKu5Qx7R8aL4cPHDM1jQolk14iWycHhq6NY0eqgrtunpP1WHeNoOs
        1rK8ec1g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54100 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXTyX-001BEM-E8; Mon, 25 Jun 2018 12:04:21 -0400
Subject: Re: [PATCH 3/9] ARM: davinci: da850-evm: use aemif platform driver in
 legacy mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <aef6d06b-b322-e2cd-b773-84ba1296c6d2@lechnology.com>
Date:   Mon, 25 Jun 2018 11:04:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152920.11549-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now support board files in the aemif driver. Register a platform
> device instead of using the handcrafted API in da850-evm.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/board-da850-evm.c | 93 ++++++++++++++-----------
>   1 file changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 442c16773f09..0ae7c47ed2b0 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -33,6 +33,7 @@
>   #include <linux/platform_data/gpio-davinci.h>
>   #include <linux/platform_data/mtd-davinci.h>
>   #include <linux/platform_data/mtd-davinci-aemif.h>
> +#include <linux/platform_data/ti-aemif.h>

alphabetical order would be after spi-davinci.h

>   #include <linux/platform_data/spi-davinci.h>
>   #include <linux/platform_data/uio_pruss.h>
>   #include <linux/regulator/machine.h>


> @@ -266,37 +257,58 @@ static struct resource da850_evm_nandflash_resource[] = {
>   	},
>   };
>   
> -static struct platform_device da850_evm_nandflash_device = {
> -	.name		= "davinci_nand",
> -	.id		= 1,
> -	.dev		= {
> -		.platform_data	= &da850_evm_nandflash_data,
> -	},
> -	.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
> -	.resource	= da850_evm_nandflash_resource,
> +static struct resource da850_evm_aemif_resource[] = {
> +	{
> +		.start	= DA8XX_AEMIF_CTL_BASE,
> +		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
> +		.flags	= IORESOURCE_MEM,
> +	}
>   };
>   
> -static struct platform_device *da850_evm_devices[] = {
> -	&da850_evm_nandflash_device,
> -	&da850_evm_norflash_device,
> +static struct aemif_abus_data da850_evm_aemif_abus_data[] = {
> +	{
> +		.cs	= 3,
> +	}
>   };
>   
> -#define DA8XX_AEMIF_CE2CFG_OFFSET	0x10
> -#define DA8XX_AEMIF_ASIZE_16BIT		0x1
> -
> -static void __init da850_evm_init_nor(void)
> -{
> -	void __iomem *aemif_addr;
> -
> -	aemif_addr = ioremap(DA8XX_AEMIF_CTL_BASE, SZ_32K);
> +static struct platform_device da850_evm_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

The existing clock lookup is for "davinci_nand.0". Might need to
change id here.

> +		.dev		= {
> +			.platform_data	= &da850_evm_nandflash_data,
> +		},
> +		.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
> +		.resource	= da850_evm_nandflash_resource,
> +	},
> +	{
> +		.name		= "physmap-flash",
> +		.id		= 0,
> +		.dev		= {
> +			.platform_data  = &da850_evm_norflash_data,
> +		},
> +		.num_resources	= 1,
> +		.resource	= da850_evm_norflash_resource,
> +	}
> +};
>   
> -	/* Configure data bus width of CS2 to 16 bit */
> -	writel(readl(aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET) |
> -		DA8XX_AEMIF_ASIZE_16BIT,
> -		aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET);
> +static struct aemif_platform_data da850_evm_aemif_pdata = {
> +	.cs_offset = 2,
> +	.abus_data = da850_evm_aemif_abus_data,
> +	.num_abus_data = ARRAY_SIZE(da850_evm_aemif_abus_data),
> +	.sub_devices = da850_evm_aemif_devices,
> +	.num_sub_devices = ARRAY_SIZE(da850_evm_aemif_devices),
> +};
>   
> -	iounmap(aemif_addr);
> -}
> +static struct platform_device da850_evm_aemif_device = {
> +	.name		= "ti-aemif",
> +	.dev = {
> +		.platform_data	= &da850_evm_aemif_pdata,
> +	},
> +	.resource	= da850_evm_aemif_resource,
> +	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
> +	.id		= -1,
> +};
>   
>   static const short da850_evm_nand_pins[] = {
>   	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
