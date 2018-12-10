Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE328C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D652082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D652082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLJWVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:21:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56325 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJWVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:21:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7458820862; Mon, 10 Dec 2018 23:21:00 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 360D02037D;
        Mon, 10 Dec 2018 23:21:00 +0100 (CET)
Date:   Mon, 10 Dec 2018 23:21:02 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, cyrille.pitchen@microchip.com,
        stable@vger.kernel.org, Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: atmel-quadspi: disallow building on ebsa110
Message-ID: <20181210232102.13ab5178@bbrezillon>
In-Reply-To: <20181210203837.2118450-1-arnd@arndb.de>
References: <20181210203837.2118450-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Should be prefixed with "spi: atmel-quadspi: " now ;-).

On Mon, 10 Dec 2018 21:38:16 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> I ran into a link-time error with the atmel-quadspi driver on the
> EBSA110 platform:
> 
> drivers/mtd/built-in.o: In function `atmel_qspi_run_command':
> :(.text+0x1ee3c): undefined reference to `_memcpy_toio'
> :(.text+0x1ee48): undefined reference to `_memcpy_fromio'
> 
> The problem is that _memcpy_toio/_memcpy_fromio are not available on
> that platform, and we have to prevent building the driver there.
> 
> In case we want to backport this to older kernels: between linux-4.8
> and linux-4.20, the Kconfig entry was in drivers/mtd/spi-nor/Kconfig
> but had the same problem.
> 
> Link: https://lore.kernel.org/patchwork/patch/812860/
> Fixes: 161aaab8a067 ("mtd: atmel-quadspi: add driver for Atmel QSPI controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 55d5ffb50750..9f89cb134549 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -93,7 +93,7 @@ config SPI_AT91_USART
>  
>  config SPI_ATMEL_QUADSPI
>  	tristate "Atmel Quad SPI Controller"
> -	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
> +	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
>  	depends on OF && HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.

