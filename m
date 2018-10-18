Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581A8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C49C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C49C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJRNIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:08:20 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:30816 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeJRNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:08:20 -0400
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 18 Oct 2018
 13:09:06 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/2] mtd: rawnand: meson: add Amlogic NAND driver support
Date:   Thu, 18 Oct 2018 13:09:03 +0800
Message-ID: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.


Changes since v4 at [5]:
 - remove the initial default divider(CLK_DIV_MASK) in meson_nfc_clk_init()
 - dt-bindings: remove staus, add "rx" and "tx" clock, and node rename

Changes since v3 at [4]:
 - remove partition table and some used props from dt-bindings 

Changes since v2 at [3]:
 - remove some hardcode time value, like twb
 - use dev wait R/B instead of nand_soft_waitrdy
 - implement nfc ecc init by ecc helper
 - rework nfc buffer init to register the maximun buffer when several chips
 - free nfc buffer when error and cleanup
 - add variable to teack all the already assigned CS lines
 - fix mtd->name use the first cs line only
 - remove dt "nand-enable-scrambler" and use NAND_NEED_SCRAMBLING instead.
 - move setuping ECC fileds after the identification phase
 - use nand_scan() and attach_chip()
 - check one event to return IRQ_NONE
 - delete cast when of_device_get_match_data
 - use nand_controller_init() helper
 - remove nfc driver complains when calling devm_ioremap_resource
 - clear irqs before setting up irq handler

Changes since v1 at [1]:
  - adopt property amlogic,nand-enable-scrambler - thanks Martin
  - drop nand pins in DT
  - convert clk access to emmc clkc model 
  - fix regiser field definition alignment
  - drop nand-user-mode 
  - parse cs id from DT
  - rework n2m, m2n function
  - explain why insert two "IDLE" command
  - implement exec_op()
  - drop meson_nfc_get_nand_chip_dts()
  - release resource once error occur in meson_nfc_nand_chips_init(), 
  - call nand_cleanup(nand) once mtd_device_register fail

Items not addressed ( or confirmed ) in this version:
  - convert to ECC conf helper() 
  - convert to dma coherent API
  - how to construct mtd->name

[1] https://lkml.kernel.org/r/20180613161314.14894-1-yixun.lan@amlogic.com
[2] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com
[3] https://lkml.kernel.org/r/20180719094612.5833-1-yixun.lan@amlogic.com
[4] https://lkml.kernel.org/r/1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com/
[5] https://lore.kernel.org/r/1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com/

Liang Yang (2):
  dt-bindings: nand: meson: add Amlogic NAND controller driver
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../devicetree/bindings/mtd/amlogic,meson-nand.txt |   60 +
 drivers/mtd/nand/raw/Kconfig                       |   10 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/meson_nand.c                  | 1370 ++++++++++++++++++++
 4 files changed, 1441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
1.9.1

