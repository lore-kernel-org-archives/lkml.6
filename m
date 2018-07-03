Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC55C223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC55C223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeGCWAn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:00:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52823 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753288AbeGCWAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1106A207BD; Wed,  4 Jul 2018 00:00:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D227203D9;
        Wed,  4 Jul 2018 00:00:37 +0200 (CEST)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 00/32] Allow dynamic allocations during NAND chip identification phase
Date:   Tue,  3 Jul 2018 23:59:57 +0200
Message-Id: <20180703220029.19565-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series make a quite deep change in the NAND framework. Until now,
the NAND chip identification phase could be done in two manners from the
controller driver perspective:

1/ Call nand_scan()

  or

1/ Call nand_scan_ident()
2/ Do some controller-dependent configuration
3/ Call nand_scan_tail().

The fact that the identifaction could be split in two operations
involved that in the NAND framework, it was not possible to do any
dynamic allocation without risking a memory leak. What if the core
allocates a structure, then the driver between nand_scan_ident() and
nand_scan_tail() decides it cannot handle the chip and errors out?
The structure allocated by the core is lost: it is a memory leak. One
solution could have been to add a nand_scan_ident_cleanup() function,
but that would mean patching all the drivers anyway to make them call
this function when something fails between nand_scan_ident() and
nand_scan_tail().

To avoid this situation, we migrate all drivers to use nand_scan(). But
because drivers need to do some configuration before nand_scan_tail(), a
first hook is offered, embedded in the nand_hw_ctrl structure, called
->attach_chip(). Drivers that need to tweak their configuration after
nand_scan_ident() should implement it. Any dynamically allocated space
in ->attach_chip() must be freed in the second hook: ->detach_chip().

The ->detach_chip() does not have to be called upon error in the
controller driver probe function. The nand_cleanup() helper already
exists for that and will do the call if needed. Of course, this helper
must be called on error after a successful nand_scan(), just like
before.

Once all drivers not using nand_scan() (yet) are migrated,
nand_scan_ident() and nand_scan_tail() are unexported and only available
internally.

A previous work [1] removed the ONFI/JEDEC parameter pages and instead
allocated a nand_parameters structure in nand_chip, embedding both
generic entries and ONFI-related ones. The deal was, once dynamic
allocation possible, allocate in nand_scan_ident() the ONFI strcuture
only if actually needed. This is done in the last patches.

All these changes have been tested with the GPMI driver and tested by
the 0-day robot. They apply now on top of another previous series that
cleaned the error path of all the drivers touched in this series.

Thank you,
Miquèl

[1] http://lists.infradead.org/pipermail/linux-mtd/2018-March/079456.html

Changes since v1:
=================
* Rebased on top of nand/next.
* Light rewording of the cover letter about the possibility to have a
  nand_scan_ident_cleanup() function (just as example of how this series
  could have been done differently).
* Changed the hooks to reside in the nand_hw_ctrl structure instead of
  being part of nand_ecc_ctrl as these hooks are more
  controller-related.


Miquel Raynal (32):
  mtd: rawnand: add hooks that may be called during nand_scan()
  mtd: rawnand: brcmnand: convert driver to nand_scan()
  mtd: rawnand: cafe: convert driver to nand_scan()
  mtd: rawnand: davinci: convert driver to nand_scan()
  mtd: rawnand: denali: convert to nand_scan()
  mtd: rawnand: fsl_elbc: convert driver to nand_scan()
  mtd: rawnand: fsl_ifc: convert driver to nand_scan()
  mtd: rawnand: fsmc: convert driver to nand_scan()
  mtd: rawnand: gpmi: convert driver to nand_scan()
  mtd: rawnand: hisi504: convert driver to nand_scan()
  mtd: rawnand: jz4780: convert driver to nand_scan()
  mtd: rawnand: lpc32xx_mlc: convert driver to nand_scan()
  mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
  mtd: rawnand: marvell: convert driver to nand_scan()
  mtd: rawnand: mtk: convert driver to nand_scan()
  mtd: rawnand: mxc: convert driver to nand_scan()
  mtd: rawnand: nandsim: convert driver to nand_scan()
  mtd: rawnand: omap2: convert driver to nand_scan()
  mtd: rawnand: s3c2410: convert driver to nand_scan()
  mtd: rawnand: sh_flctl: move all NAND chip related setup in one
    function
  mtd: rawnand: sh_flctl: convert driver to nand_scan()
  mtd: rawnand: sunxi: convert driver to nand_scan()
  mtd: rawnand: tango: convert driver to nand_scan()
  mtd: rawnand: txx9ndfmc: convert driver to nand_scan()
  mtd: rawnand: vf610: convert driver to nand_scan()
  mtd: rawnand: atmel: convert driver to nand_scan()
  mtd: rawnand: sm_common: convert driver to nand_scan_with_ids()
  mtd: rawnand: docg4: convert driver to nand_scan()
  mtd: rawnand: qcom: convert driver to nand_scan()
  mtd: rawnand: jz4740: convert driver to nand_scan()
  mtd: rawnand: do not export nand_scan_[ident|tail]() anymore
  mtd: rawnand: allocate dynamically ONFI parameters during detection

 drivers/mtd/nand/raw/atmel/nand-controller.c |  70 ++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c     |  43 ++-
 drivers/mtd/nand/raw/cafe_nand.c             | 131 ++++---
 drivers/mtd/nand/raw/davinci_nand.c          | 186 +++++-----
 drivers/mtd/nand/raw/denali.c                | 134 +++----
 drivers/mtd/nand/raw/docg4.c                 |  51 +--
 drivers/mtd/nand/raw/fsl_elbc_nand.c         |  15 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c          |  15 +-
 drivers/mtd/nand/raw/fsmc_nand.c             | 144 ++++----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c   |  52 +--
 drivers/mtd/nand/raw/hisi504_nand.c          |  74 ++--
 drivers/mtd/nand/raw/jz4740_nand.c           |  42 ++-
 drivers/mtd/nand/raw/jz4780_nand.c           |  30 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c           | 105 +++---
 drivers/mtd/nand/raw/lpc32xx_slc.c           |  73 ++--
 drivers/mtd/nand/raw/marvell_nand.c          | 201 ++++++-----
 drivers/mtd/nand/raw/mtk_nand.c              |  71 ++--
 drivers/mtd/nand/raw/mxc_nand.c              | 132 +++----
 drivers/mtd/nand/raw/nand_base.c             | 132 +++++--
 drivers/mtd/nand/raw/nand_micron.c           |   6 +-
 drivers/mtd/nand/raw/nand_timings.c          |  12 +-
 drivers/mtd/nand/raw/nandsim.c               |  78 ++--
 drivers/mtd/nand/raw/omap2.c                 | 517 +++++++++++++--------------
 drivers/mtd/nand/raw/qcom_nandc.c            |  67 ++--
 drivers/mtd/nand/raw/s3c2410.c               |  26 +-
 drivers/mtd/nand/raw/sh_flctl.c              |  53 ++-
 drivers/mtd/nand/raw/sm_common.c             |  35 +-
 drivers/mtd/nand/raw/sunxi_nand.c            |  38 +-
 drivers/mtd/nand/raw/tango_nand.c            |  36 +-
 drivers/mtd/nand/raw/txx9ndfmc.c             |  25 +-
 drivers/mtd/nand/raw/vf610_nfc.c             | 123 +++----
 include/linux/mtd/rawnand.h                  |  23 +-
 include/linux/mtd/sh_flctl.h                 |   1 +
 33 files changed, 1414 insertions(+), 1327 deletions(-)

-- 
2.14.1

