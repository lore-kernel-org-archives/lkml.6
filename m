Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534B420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfANV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:27:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34550 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfANV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:27:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B72E0209C2; Mon, 14 Jan 2019 22:27:47 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 88A8D207B6;
        Mon, 14 Jan 2019 22:27:37 +0100 (CET)
Date:   Mon, 14 Jan 2019 22:27:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: lpc32xx: debug: add low-level debug support on
 hsuart
Message-ID: <20190114212738.GB2589@piout.net>
References: <20190114211623.6069-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114211623.6069-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 22:16:23+0100, Alexandre Belloni wrote:
> The lpc32xx has UARTs that are not 8250 compatible. Add support for low
> level debugging on those high speed UARTs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/arm/Kconfig.debug                  | 18 +++++++++++++++---
>  arch/arm/include/debug/lpc32xx_hsuart.S | 22 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/debug/lpc32xx_hsuart.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6d6e0330930b..0d4d64f5d3b7 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -530,7 +530,16 @@ choice
>  		select DEBUG_UART_8250
>  		help
>  		  Say Y here if you want kernel low-level debugging support
> -		  on NXP LPC32xx based platforms.
> +		  on NXP LPC32xx based platforms using an INS16Cx50 compatible
> +		  UART.
> +
> +	config DEBUG_LPC32XX_HSUART
> +		bool "Kernel low-level debugging messages via NXP LPC32xx High Speed  UART"
> +		depends on ARCH_LPC32XX
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on NXP LPC32xx based platforms using an high speed (14-clock)
> +		  UART.
>  
>  	config DEBUG_MESON_UARTAO
>  		bool "Kernel low-level debugging via Meson6 UARTAO"
> @@ -1541,6 +1550,7 @@ config DEBUG_LL_INCLUDE
>  				 DEBUG_IMX6UL_UART || \
>  				 DEBUG_IMX7D_UART
>  	default "debug/ks8695.S" if DEBUG_KS8695_UART
> +	default "debug/lpc32xx_hsuart.S" if DEBUG_LPC32XX_HSUART
>  	default "debug/msm.S" if DEBUG_QCOM_UARTDM
>  	default "debug/netx.S" if DEBUG_NETX_UART
>  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
> @@ -1622,6 +1632,7 @@ config DEBUG_UART_PHYS
>  	default 0x3e000000 if DEBUG_BCM_KONA_UART
>  	default 0x3f201000 if DEBUG_BCM2836
>  	default 0x4000e400 if DEBUG_LL_UART_EFM32
> +	default 0x40014000 if DEBUG_LPC32XX_HSUART
>  	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
>  	default 0x40081000 if DEBUG_LPC18XX_UART0
>  	default 0x40090000 if DEBUG_LPC32XX
> @@ -1716,7 +1727,7 @@ config DEBUG_UART_PHYS
>  		DEBUG_S3C64XX_UART || \
>  		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
>  		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
> -		DEBUG_AT91_UART
> +		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
>  
>  config DEBUG_UART_VIRT
>  	hex "Virtual base address of debug UART"
> @@ -1741,6 +1752,7 @@ config DEBUG_UART_VIRT
>  	default 0xf1c28400 if DEBUG_SUNXI_UART1
>  	default 0xf1f02800 if DEBUG_SUNXI_R_UART
>  	default 0xf31004c0 if DEBUG_MESON_UARTAO
> +	default 0xf4014000 if DEBUG_LPC32XX_HSUART
>  	default 0xf4090000 if DEBUG_LPC32XX
>  	default 0xf4200000 if DEBUG_GEMINI
>  	default 0xf6200000 if DEBUG_PXA_UART1
> @@ -1832,7 +1844,7 @@ config DEBUG_UART_VIRT
>  		DEBUG_S3C64XX_UART || \
>  		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
>  		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
> -		DEBUG_AT91_UART
> +		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
>  
>  config DEBUG_UART_8250_SHIFT
>  	int "Register offset shift for the 8250 debug UART"
> diff --git a/arch/arm/include/debug/lpc32xx_hsuart.S b/arch/arm/include/debug/lpc32xx_hsuart.S
> new file mode 100644
> index 000000000000..e0205368c6ff
> --- /dev/null
> +++ b/arch/arm/include/debug/lpc32xx_hsuart.S
> @@ -0,0 +1,22 @@

I just realized I forgot to add the SPDX identifier, I'll send a v2 in a
few days.

> +#define LPC_HSU_TX		(0x0)
> +#define LPC_HSU_LEVEL		(0x4)
> +#define LPC_HSU_LEVEL_TX	0xFF00
> +
> +	.macro	addruart, rp, rv, tmp
> +	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
> +	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
> +	.endm
> +
> +	.macro	senduart,rd,rx
> +	str	\rd, [\rx, #(LPC_HSU_TX)]
> +	.endm
> +
> +	.macro	waituart,rd,rx
> +	.endm
> +
> +	.macro	busyuart,rd,rx
> +1001:	ldr	\rd, [\rx, #(LPC_HSU_LEVEL)]
> +	ands	\rd, \rd, LPC_HSU_LEVEL_TX
> +	bne	1001b
> +	.endm
> +
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
