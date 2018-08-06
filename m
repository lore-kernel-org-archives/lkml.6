Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCB8219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCB8219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeHFLaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:30:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeHFLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:30:23 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1fmbiA-0002UC-JT; Mon, 06 Aug 2018 11:21:58 +0200
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
Subject: [PATCH 2/2] mtd: nand: fsl-ifc: fixup SRAM init for newer ctrl versions
Date:   Mon,  6 Aug 2018 11:21:37 +0200
Message-Id: <20180806092137.9287-3-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180806092137.9287-1-kurt@linutronix.de>
References: <20180806092137.9287-1-kurt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of the IFC controller use a different method of initializing the
internal SRAM: Instead of reading from flash, a bit in the NAND configuration
register has to be set in order to trigger the self-initializing process.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 18 ++++++++++++++++++
 include/linux/fsl_ifc.h             |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index e4f5792dc589..384d5e12b05c 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -30,6 +30,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/fsl_ifc.h>
+#include <linux/iopoll.h>
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
@@ -769,6 +770,23 @@ static int fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 	uint32_t csor = 0, csor_8k = 0, csor_ext = 0;
 	uint32_t cs = priv->bank;
 
+	if (ctrl->version > FSL_IFC_VERSION_1_1_0) {
+		u32 ncfgr, status;
+		int ret;
+
+		/* Trigger auto initialization */
+		ncfgr = ifc_in32(&ifc_runtime->ifc_nand.ncfgr);
+		ifc_out32(ncfgr | IFC_NAND_NCFGR_SRAM_INIT_EN, &ifc_runtime->ifc_nand.ncfgr);
+
+		/* Wait until done */
+		ret = readx_poll_timeout(ifc_in32, &ifc_runtime->ifc_nand.ncfgr,
+					 status, !(status & IFC_NAND_NCFGR_SRAM_INIT_EN),
+					 10, 1000);
+		if (ret)
+			dev_err(priv->dev, "Failed to initialize SRAM!\n");
+		return ret;
+	}
+
 	/* Save CSOR and CSOR_ext */
 	csor = ifc_in32(&ifc_global->csor_cs[cs].csor);
 	csor_ext = ifc_in32(&ifc_global->csor_cs[cs].csor_ext);
diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
index 3fdfede2f0f3..5f343b796ad9 100644
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -274,6 +274,8 @@
  */
 /* Auto Boot Mode */
 #define IFC_NAND_NCFGR_BOOT		0x80000000
+/* SRAM Initialization */
+#define IFC_NAND_NCFGR_SRAM_INIT_EN	0x20000000
 /* Addressing Mode-ROW0+n/COL0 */
 #define IFC_NAND_NCFGR_ADDR_MODE_RC0	0x00000000
 /* Addressing Mode-ROW0+n/COL0+n */
-- 
2.11.0

