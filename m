Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeEaWQn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:16:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37450 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeEaWQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:16:40 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        stefan@agner.ch, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
Date: Fri,  1 Jun 2018 00:16:31 +0200
Message-Id: <20180531221637.6017-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_TLS_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         TO_DN_NONE(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This third revision is again a rather major overhaul. The driver
is now able to select a sensible ECC strenght automatically.

Review of the timing code uncovered few issues. Fixing them lead to
a tighter timing which lead to a performance increase of about 35%.
The in kernel speed test measures 11770/15058 KiB/s write/read speed.

Still open is the OOB layout discrepancy issue:
When using HW BCH support, the location of the ECC bytes changes
depending on whether extra OOB bytes (tag data) are transmitted or
not... Writing/Reading should always be with tag enabled or always
without. I am not sure how to solve this correctly, maybe disallow
using OOB data with HW ECC completely? Or just leave as is?

--
Stefan

Changes since v1:
- Split controller and NAND chip structure
- Add BCH support
- Allow to select algorithm and strength using device tree
- Improve HW ECC error reporting and use DEC_STATUS_BUF only
- Use SPDX license identifier
- Use per algorithm mtd_ooblayout_ops
- Use setup_data_interface callback for NAND timing configuration

Changes since v2:
- Set clock rate using assigned-clocks
- Use BIT() macro
- Fix and improve timing calculation
- Improve ECC error handling
- Store OOB layout for tag area in Tegra chip structure
- Update/fix bindings
- Use more specific variable names (replace "value")
- Introduce nand-is-boot-medium
- Choose sensible ECC strenght automatically
- Use wait_for_completion_timeout
- Print register dump on completion timeout
- Unify tegra_nand_(read|write)_page in tegra_nand_page_xfer

Lucas Stach (2):
  ARM: dts: tegra: add Tegra20 NAND flash controller node
  ARM: dts: tegra: enable NAND flash on Colibri T20

Stefan Agner (4):
  mtd: rawnand: add Reed-Solomon error correction algorithm
  mtd: rawnand: add an option to specify NAND chip as a boot device
  mtd: rawnand: tegra: add devicetree binding
  mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver

 .../devicetree/bindings/mtd/nand.txt          |    4 +
 .../bindings/mtd/nvidia-tegra20-nand.txt      |   64 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    |   16 +
 arch/arm/boot/dts/tegra20.dtsi                |   15 +
 drivers/mtd/nand/raw/Kconfig                  |    6 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/nand_base.c              |    4 +
 drivers/mtd/nand/raw/tegra_nand.c             | 1143 +++++++++++++++++
 include/linux/mtd/rawnand.h                   |    7 +
 10 files changed, 1267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

-- 
2.17.0
