Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9566EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EE920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EE920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeFTOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:54:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55822 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753952AbeFTOyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:54:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C56BC2075D; Wed, 20 Jun 2018 16:54:48 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 528CC203EC;
        Wed, 20 Jun 2018 16:54:38 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:54:38 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH 0/2] New QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180620165438.39608554@bbrezillon>
In-Reply-To: <20180618162124.21749-1-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

On Mon, 18 Jun 2018 18:21:22 +0200
Piotr Bugalski <bugalski.piotr@gmail.com> wrote:

> Hello,
> 
> Atmel SAMA5D2 is equipped with two QSPI interfaces. These interfaces can
> work as in SPI-compatible mode or use two / four lines to improve
> communication speed. At the moment there is QSPI driver strongly tied to
> NOR-flash memory and MTD subsystem.
> Intention of this change is to provide new driver which will not be tied
> to MTD and allows using QSPI with NAND-flash memory or other peripherals
> New spi-mem API provides abstraction layer which can disconnect QSPI
> from MTD. This driver doesn't support regular SPI interface, it should
> be used with spi-mem interface only.

Glad to see that people are starting to convert their SPI NOR
controller drivers to the SPI mem approach.

> Unfortunately SAMA5D2 hardware by default supports only NOR-flash
> memory. It allows 24- and 32-bit addressing while NAND-flash requires
> 16-bit long. To workaround hardware limitation driver is a bit more
> complicated.
> 
> Request to spi-mem contains three fiels: opcode (command), address,
> dummy bytes. SAMA5D2 QSPI hardware supports opcode, address, dummy and
> option byte where address field can only be 24- or 32- bytes long.
> Handling 8-bits long addresses is done using option field. For 16-bits
> address behaviour depends of number of requested dummy bits. If there
> are 8 or more dummy cycles, address is shifted and sent with first dummy
> byte. Otherwise opcode is disabled and first byte of address contains
> command opcode (works only if opcode and address use the same buswidth).
> The limitation is when 16-bit address is used without enough dummy
> cycles and opcode is using different buswidth than address. Other modes
> are supported with described workaround.
> 
> It looks like hardware has some limitation in performance. The same issue
> exists in current QSPI driver (MTD/nor-flash) and soft-pack (bare-metal
> library from Atmel). Without using DMA read speed is much worse than
> maximum bandwidth (efficiency 30-40%). Any help with performance
> improvement is highly welcome, especially for NAND-flash memories which
> offers higher capacity than NOR-flash used with previous driver.
> 
> Best Regards,
> Piotr
> 
> Piotr Bugalski (2):
>   spi: Add QuadSPI driver for Atmel SAMA5D2
>   dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2 documentation
> 
>  .../devicetree/bindings/spi/spi_atmel-qspi.txt     |  41 ++
>  drivers/spi/Kconfig                                |   9 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-atmel-qspi.c                       | 480 +++++++++++++++++++++

I'd like a solution where we remove the old driver. I definitely don't
want to have both in parallel. Did you test the new driver with a SPI
NOR to check if it still works correctly? If you did, then I'd suggest
that you add a patch updating defconfigs where the SPI_ATMEL_QUADSPI is
selected and another patch removing the old driver.

>  4 files changed, 531 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt

This should be a simple mv from
Documentation/devicetree/bindings/mtd/atmel-quadspi.txt to
Documentation/devicetree/bindings/spi/spi-atmel-qspi.txt

>  create mode 100644 drivers/spi/spi-atmel-qspi.c
> 

Thanks,

Boris
