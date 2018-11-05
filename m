Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0699FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B186A20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B186A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeKEUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:21:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34391 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeKEUVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:21:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 84B92207B0; Mon,  5 Nov 2018 12:02:30 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 12EB1206D8;
        Mon,  5 Nov 2018 12:02:20 +0100 (CET)
Date:   Mon, 5 Nov 2018 12:02:19 +0100
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
Subject: Re: [PATCH v3 0/6] New QuadSPI driver for Atmel SAMA5D2
Message-ID: <20181105120219.03ab3b4c@bbrezillon>
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

On Mon,  5 Nov 2018 11:36:19 +0100
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

I think you can try to implement the dirmap interface proposed here [1]
and use DMA+TRSFR_READ/WRITE_MEMORY for such direct mappings. This
should optimize path where we really matter about perfs.

> 
> Best Regards,
> Piotr
> 
> v3 changes:
>  - add get_name implementation
>  - email address fix
> 
> v2 changes:
>  - driver is now replacement of existing atmel-quadspi
>  - code was re-written to follow original code structure
>  - deinitialization order fixed
>  - empty atmel_qspi_adjust_op_size function removed
>  - code formatting fixes
>  - use spi_device->max_speed_hz to get spi speed
>  - spi freqency set in spi_controller->setup() hook
>  - address range checkng for 4-bytes addressing
>  - use timeout to avoid infinite waiting
> 
> Piotr Bugalski (6):
>   mtd: spi-nor: atmel-quaspi: Typo fix
>   mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
>   mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi
>     driver
>   mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi
>     driver
>   spi: Add QuadSPI driver for Atmel SAMA5D2
>   dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2

The patch series is

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Mark, if you're okay with the new implementation, would you mind taking
those patches in the spi tree?

Thanks,

Boris

[1]http://patchwork.ozlabs.org/project/linux-mtd/list/?series=73235
