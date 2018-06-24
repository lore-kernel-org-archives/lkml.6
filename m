Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07A224EFF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/N9FoqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A224EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFXNPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeFXNPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:15:35 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B018524B00;
        Sun, 24 Jun 2018 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529846135;
        bh=Onezk75OoaFT+wLIYdd3drArLE0R56XsqDqJXGc92wQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/N9FoqEVrEdg1HVB9q2WW6xZXuXjpHfcH6YvktJFgJcOXar2+tPqRuv7ABA1BXk5
         CqDqV1/YjYFu69oOFLmQRwkWo7kKfPOKBzvuawG3NHNRadADDp3sLVvQgFU5HmGJbH
         47paviKvOmzYQ8oRokA5LfsmH7bmkoQ2djrSs1go=
Date:   Sun, 24 Jun 2018 14:15:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180624141530.0ea4fd10@archlinux>
In-Reply-To: <20180622110501.31733-1-geert@linux-m68k.org>
References: <20180622110501.31733-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 13:05:01 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I've applied to the togreg branch of iio.git.  Thanks

Jonathan

> ---
> v4:
>   - Rebase to v4.18-rc1 (applies to next-20180622, too),
> 
> v3:
>   - Add Acked-by,
>   - Rebase to v4.17-rc1,
> 
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/iio/adc/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9da79070357c7d93..434923dd6f1e3d66 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -157,7 +157,6 @@ config AT91_SAMA5D2_ADC
>  	tristate "Atmel AT91 SAMA5D2 ADC"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on HAS_IOMEM
> -	depends on HAS_DMA
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> @@ -647,7 +646,6 @@ config SD_ADC_MODULATOR
>  config STM32_ADC_CORE
>  	tristate "STMicroelectronics STM32 adc core"
>  	depends on ARCH_STM32 || COMPILE_TEST
> -	depends on HAS_DMA
>  	depends on OF
>  	depends on REGULATOR
>  	select IIO_BUFFER

