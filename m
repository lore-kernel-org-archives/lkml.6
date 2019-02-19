Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF259C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49CB217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZvLVbL9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBSGgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:36:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33902 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfBSGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:35:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J6ZIvC014118;
        Tue, 19 Feb 2019 00:35:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550558118;
        bh=vMjuTSIXMXeaeYrqZhQY4vsXFW7YK+4tTXREzreAFCk=;
        h=From:To:CC:Subject:Date;
        b=ZvLVbL9TVZPATvxu0I3UhakpGw36A6wT7IqLPPmxE//2dpXFma2ZIJD+bIvE7qClA
         9o6csKoJaRMJZNQgAeq+VFVV1dAltGpkyhd4rZtpyJPRCpFuAyOmOQnLPwPqwYLg0q
         8I6mPZ60kmkW38M1HXa/9WyuM2iJoLV1w9RstEVk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J6ZIJC017508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 00:35:18 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 00:35:18 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 00:35:18 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J6ZCsw025516;
        Tue, 19 Feb 2019 00:35:13 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>
Subject: [RFC PATCH 0/5] MTD: Add Initial Hyperbus support
Date:   Tue, 19 Feb 2019 12:06:02 +0530
Message-ID: <20190219063607.29949-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
interface between a host system master and one or more slave interfaces.
HyperBus is used to connect microprocessor, microcontroller, or ASIC
devices with random access NOR flash memory(called HyperFlash) or
self refresh DRAM(called HyperRAM).

Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
signal and either Single-ended clock(3.0V parts) or Differential clock
(1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
At bus level, it follows a separate protocol described in HyperBus
specification[1].

HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
operates at >166MHz frequencies.
HyperRAM provides direct random read/write access to flash memory
array.
Framework is modelled along the lines of spi-nor framework. HyperBus
memory controller(HBMC) drivers call hb_register_device() to register a
single HyperFlash device. HyperFlash core parses MMIO access
information from DT, sets up the map_info struct, probes CFI flash and
registers it with MTD framework.

This is an early RFC, to know if its okay to use maps framework and existing
CFI compliant flash support code to support Hyperflash
Also would like input on different types of HBMC master IPs out there
and their programming sequences.
Would appreciate any testing/review.

Tested on modified TI AM654 EVM with Cypress Hyperflash S26KS512 by
creating a UBIFS partition and writing and reading files to it.
Stress tested by writing/reading 16MB flash repeatedly at different
offsets using dd commmand.

HyperBus specification can be found at[1]
HyperFlash datasheet can be found at[2]
TI's HBMC controller details at[3]

[1] https://www.cypress.com/file/213356/download
[2] https://www.cypress.com/file/213346/download
[3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
    Table 12-5741. HyperFlash Access Sequence

Vignesh R (5):
  mtd: cfi_cmdset_0002: Add support for polling status register
  dt-bindings: mtd: Add binding documentation for Hyperbus memory
    devices
  mtd: Add support for Hyperbus memory devices
  dt-bindings: mtd: Add bindings for TI's AM654 Hyperbus memory
    controller
  mtd: hyperbus: Add driver for TI's Hyperbus memory controller

 .../bindings/mtd/cypress,hyperbus.txt         |   6 +
 .../devicetree/bindings/mtd/ti,am654-hbmc.txt |  27 +++
 MAINTAINERS                                   |   8 +
 drivers/mtd/Kconfig                           |   2 +
 drivers/mtd/Makefile                          |   1 +
 drivers/mtd/chips/cfi_cmdset_0002.c           |  50 ++++++
 drivers/mtd/hyperbus/Kconfig                  |  23 +++
 drivers/mtd/hyperbus/Makefile                 |   4 +
 drivers/mtd/hyperbus/core.c                   | 167 ++++++++++++++++++
 drivers/mtd/hyperbus/hbmc_am654.c             | 105 +++++++++++
 include/linux/mtd/cfi.h                       |   5 +
 include/linux/mtd/hyperbus.h                  |  73 ++++++++
 12 files changed, 471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 create mode 100644 drivers/mtd/hyperbus/Kconfig
 create mode 100644 drivers/mtd/hyperbus/Makefile
 create mode 100644 drivers/mtd/hyperbus/core.c
 create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
 create mode 100644 include/linux/mtd/hyperbus.h

-- 
2.20.1

