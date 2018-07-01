Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7754C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE023F4A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAE023F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeGARJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:09:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032035AbeGAQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:41:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16617ACD;
        Sun,  1 Jul 2018 16:41:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.17 103/220] mtd: rawnand: mxc: set spare area size register explicitly
Date:   Sun,  1 Jul 2018 18:22:07 +0200
Message-Id: <20180701160912.701235549@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

commit 3f77f244d8ec28e3a0a81240ffac7d626390060c upstream.

The v21 version of the NAND flash controller contains a Spare Area Size
Register (SPAS) at offset 0x10. Its setting defaults to the maximum
spare area size of 218 bytes. The size that is set in this register is
used by the controller when it calculates the ECC bytes internally in
hardware.

Usually, this register is updated from settings in the IIM fuses when
the system is booting from NAND flash. For other boot media, however,
the SPAS register remains at the default setting, which may not work for
the particular flash chip on the board. The same goes for flash chips
whose configuration cannot be set in the IIM fuses (e.g. chips with 2k
sector size and 128 bytes spare area size can't be configured in the IIM
fuses on imx25 systems).

Set the SPAS register explicitly during the preset operation. Derive the
register value from mtd->oobsize that was detected during probe by
decoding the flash chip's ID bytes.

While at it, rename the define for the spare area register's offset to
NFC_V21_RSLTSPARE_AREA. The register at offset 0x10 on v1 controllers is
different from the register on v21 controllers.

Fixes: d484018 ("mtd: mxc_nand: set NFC registers after reset")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/mxc_nand.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -48,7 +48,7 @@
 #define NFC_V1_V2_CONFIG		(host->regs + 0x0a)
 #define NFC_V1_V2_ECC_STATUS_RESULT	(host->regs + 0x0c)
 #define NFC_V1_V2_RSLTMAIN_AREA		(host->regs + 0x0e)
-#define NFC_V1_V2_RSLTSPARE_AREA	(host->regs + 0x10)
+#define NFC_V21_RSLTSPARE_AREA		(host->regs + 0x10)
 #define NFC_V1_V2_WRPROT		(host->regs + 0x12)
 #define NFC_V1_UNLOCKSTART_BLKADDR	(host->regs + 0x14)
 #define NFC_V1_UNLOCKEND_BLKADDR	(host->regs + 0x16)
@@ -1274,6 +1274,9 @@ static void preset_v2(struct mtd_info *m
 	writew(config1, NFC_V1_V2_CONFIG1);
 	/* preset operation */
 
+	/* spare area size in 16-bit half-words */
+	writew(mtd->oobsize / 2, NFC_V21_RSLTSPARE_AREA);
+
 	/* Unlock the internal RAM Buffer */
 	writew(0x2, NFC_V1_V2_CONFIG);
 


