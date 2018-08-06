Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04BC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40720219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40720219ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeHFLa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:30:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44770 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeHFLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:30:25 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1fmbiA-0002UC-25; Mon, 06 Aug 2018 11:21:58 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: nand: fsl-ifc: check result of SRAM initialization
Date:   Mon,  6 Aug 2018 11:21:36 +0200
Message-Id: <20180806092137.9287-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180806092137.9287-1-kurt@linutronix.de>
References: <20180806092137.9287-1-kurt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRAM initialization might fail. If that happens further NAND operations
won't be successful. Therefore, the chip init routine should fail if the SRAM
initialization didn't work.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 24f59d0066af..e4f5792dc589 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -761,7 +761,7 @@ static const struct nand_controller_ops fsl_ifc_controller_ops = {
 	.attach_chip = fsl_ifc_attach_chip,
 };
 
-static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
+static int fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 {
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc_runtime = ctrl->rregs;
@@ -805,12 +805,16 @@ static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 	wait_event_timeout(ctrl->nand_wait, ctrl->nand_stat,
 			   msecs_to_jiffies(IFC_TIMEOUT_MSECS));
 
-	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC)
+	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC) {
 		pr_err("fsl-ifc: Failed to Initialise SRAM\n");
+		return -ETIMEDOUT;
+	}
 
 	/* Restore CSOR and CSOR_ext */
 	ifc_out32(csor, &ifc_global->csor_cs[cs].csor);
 	ifc_out32(csor_ext, &ifc_global->csor_cs[cs].csor_ext);
+
+	return 0;
 }
 
 static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
@@ -914,8 +918,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		chip->ecc.algo = NAND_ECC_HAMMING;
 	}
 
-	if (ctrl->version >= FSL_IFC_VERSION_1_1_0)
-		fsl_ifc_sram_init(priv);
+	if (ctrl->version >= FSL_IFC_VERSION_1_1_0) {
+		int ret;
+
+		ret = fsl_ifc_sram_init(priv);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
-- 
2.11.0

