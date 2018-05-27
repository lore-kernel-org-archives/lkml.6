Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeE0Vyz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:54:55 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:45016 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeE0Vyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:54:50 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
Date: Sun, 27 May 2018 23:54:36 +0200
Message-Id: <20180527215442.14760-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[26];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This picks up an older patchset written by Lucas Stach which
adds raw NAND flash support for Tegra 2.
http://lists.infradead.org/pipermail/linux-mtd/2015-November/063031.html

The driver has been reworked to implement the ->exec_op callback.
Some smaller changes and bug fixes have been applied too, but I did
not keep track of them. Since the original patchset has been posted
some years back already, I guess review needs to be done from scratch
anyway.

This second revision is a rather major overhaul again. There are some
open issues:
- Driver specific DMA enabled (read/write)_page_raw are non functional
  (I am not sure why, or if this is maybe even not possible at all...)
- OOB layout discrepancy
  When using HW BCH support, the location of the ECC bytes changes
  depending on whether extra OOB bytes (tag data) are transmitted or
  not... Writing/Reading should always be with tag enabled or always
  without. I am not sure how to solve this correctly, maybe disallow
  using OOB data with HW ECC completely?

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

Lucas Stach (4):
  mtd: rawnand: tegra: add devicetree binding
  clk: tegra20: init NDFLASH clock to sensible rate
  ARM: tegra: add Tegra20 NAND flash controller node
  ARM: tegra: enable NAND flash on Colibri T20

Stefan Agner (2):
  mtd: rawnand: add Reed-Solomon error correction algorithm
  mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver

 .../bindings/mtd/nvidia,tegra20-nand.txt      |  62 ++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    |  16 +
 arch/arm/boot/dts/tegra20.dtsi                |  13 +
 drivers/clk/tegra/clk-tegra20.c               |   1 +
 drivers/mtd/nand/raw/Kconfig                  |   6 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/nand_base.c              |   1 +
 drivers/mtd/nand/raw/tegra_nand.c             | 999 ++++++++++++++++++
 include/linux/mtd/rawnand.h                   |   1 +
 10 files changed, 1107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

-- 
2.17.0
