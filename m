Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0852C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700ED20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700ED20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeIDRIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:08:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38902 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeIDRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:08:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AD62D207B4; Tue,  4 Sep 2018 14:43:30 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BD0C204AE;
        Tue,  4 Sep 2018 14:43:30 +0200 (CEST)
Date:   Tue, 4 Sep 2018 14:43:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] spi: spi-mem: Add a driver for NXP FlexSPI
 controller
Message-ID: <20180904144329.35cf27de@bbrezillon>
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Fri, 31 Aug 2018 15:59:57 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> - Add a driver for NXP FlexSPI host controller
> 
>  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
>  which supports two SPI channels and up to 4 external devices.
>  Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional data lines)
>  i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up to 8
>  bidirectional data lines.
> 
>  FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
>  controller with advanced features.
> 
> - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
>  filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
>  LX2160ARDB is having two NOR slave device connected on single bus A
>  i.e. A0 and A1 (CS0 and CS1).
>  LX2160AQDS is having two NOR slave device connected on separate buses
>  one flash on A0 and second on B1 i.e. (CS0 and CS3).
>  Verified this driver on following SPI NOR flashes:
>     Micron, mt35xu512aba[3], [Read - 1 bit mode]
>     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> 
> Patch 1 adds variable size in spi_device struct, to save the
> size of connected slave device.
> Patch 2 adds flags for octal I/O data transfer.
> Support for octal flash commands and other framework changes would going to be done in different
> patch set.
> Patch 3 adds a driver for the NXP FlexSPI controller, driver is based on
> new spi-mem framework.

Can we please omit octa mode support for now and focus on
single/dual/quad SPI support? That is, drop patch 2, and do not set the
OCTAL flags in patch 3.

Regards,

Boris

> Patch 4 add binding file for this driver.
> Patch 5 add device node property for FlexSPI driver for lx2160 SoC.
> Patch 6 enables the config option.
> Patch 7 add MAINTAINERS file.
> 
> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=9721
> [3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=63445
> 
> This series adds below patches:
> Yogesh Gaur (7):
>   spi: add slave device size in spi_device struct
>   spi: add flags for octal I/O data transfer
>   spi: spi-mem: Add a driver for NXP FlexSPI controller
>   dt-bindings: spi: add binding file for NXP FlexSPI driver
>   arm64: dts: lx2160a: add fspi node property
>   arm64: defconfig: enable NXP FlexSPI driver
>   MAINTAINERS: add maintainers for the NXP FlexSPI driver
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   42 +
>  MAINTAINERS                                        |    6 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   21 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/mtd/devices/m25p80.c                       |    6 +
>  drivers/mtd/spi-nor/spi-nor.c                      |    2 +
>  drivers/spi/Kconfig                                |   10 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-nxp-fspi.c                         | 1242 ++++++++++++++++++++
>  include/linux/spi/spi.h                            |    4 +
>  11 files changed, 1347 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>  create mode 100644 drivers/spi/spi-nxp-fspi.c
> 

