Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FE021848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfBSHwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:52:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42618 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:52:30 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C76BD26DA90;
        Tue, 19 Feb 2019 07:52:27 +0000 (GMT)
Date:   Tue, 19 Feb 2019 08:52:24 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 0/5] MTD: Add Initial Hyperbus support
Message-ID: <20190219085212.355921e5@kernel.org>
In-Reply-To: <20190219063607.29949-1-vigneshr@ti.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sergei and Mason who recently worked on an HyperFlash controller.

On Tue, 19 Feb 2019 12:06:02 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or
> self refresh DRAM(called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
> operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a
> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> This is an early RFC, to know if its okay to use maps framework and existing
> CFI compliant flash support code to support Hyperflash
> Also would like input on different types of HBMC master IPs out there
> and their programming sequences.
> Would appreciate any testing/review.
> 
> Tested on modified TI AM654 EVM with Cypress Hyperflash S26KS512 by
> creating a UBIFS partition and writing and reading files to it.
> Stress tested by writing/reading 16MB flash repeatedly at different
> offsets using dd commmand.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> TI's HBMC controller details at[3]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Vignesh R (5):
>   mtd: cfi_cmdset_0002: Add support for polling status register
>   dt-bindings: mtd: Add binding documentation for Hyperbus memory
>     devices
>   mtd: Add support for Hyperbus memory devices
>   dt-bindings: mtd: Add bindings for TI's AM654 Hyperbus memory
>     controller
>   mtd: hyperbus: Add driver for TI's Hyperbus memory controller
> 
>  .../bindings/mtd/cypress,hyperbus.txt         |   6 +
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt |  27 +++
>  MAINTAINERS                                   |   8 +
>  drivers/mtd/Kconfig                           |   2 +
>  drivers/mtd/Makefile                          |   1 +
>  drivers/mtd/chips/cfi_cmdset_0002.c           |  50 ++++++
>  drivers/mtd/hyperbus/Kconfig                  |  23 +++
>  drivers/mtd/hyperbus/Makefile                 |   4 +
>  drivers/mtd/hyperbus/core.c                   | 167 ++++++++++++++++++
>  drivers/mtd/hyperbus/hbmc_am654.c             | 105 +++++++++++
>  include/linux/mtd/cfi.h                       |   5 +
>  include/linux/mtd/hyperbus.h                  |  73 ++++++++
>  12 files changed, 471 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>  create mode 100644 drivers/mtd/hyperbus/Kconfig
>  create mode 100644 drivers/mtd/hyperbus/Makefile
>  create mode 100644 drivers/mtd/hyperbus/core.c
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
>  create mode 100644 include/linux/mtd/hyperbus.h
> 

