Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IoMlJ4soHVvefgAAmS7hNA
	; Sun, 10 Jun 2018 13:33:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 32960607BB; Sun, 10 Jun 2018 13:33:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AF9DA605A5;
	Sun, 10 Jun 2018 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF9DA605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeFJNdh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:33:37 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:53676 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753462AbeFJNdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:33:35 -0400
Received: from dslb-084-058-101-183.084.058.pools.vodafone-ip.de ([84.58.101.183] helo=reykholt.kaiser.cx)
        by botnar.kaiser.cx with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <martin@kaiser.cx>)
        id 1fS0S8-0002y8-BV; Sun, 10 Jun 2018 15:32:16 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>, stable@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: mxc: set spare area size register explicitly
Date: Sun, 10 Jun 2018 15:31:27 +0200
Message-Id: <1528637487-25172-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
References: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable@vger.kernel.org
---
changes in v2
   - fix the commit message
   - use '/ 2' instead of shift operator for division

BTW is it ok to keep a Reviewed-by tag when updating the patch?

 drivers/mtd/nand/raw/mxc_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 45786e7..26cef21 100644
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
@@ -1274,6 +1274,9 @@ static void preset_v2(struct mtd_info *mtd)
 	writew(config1, NFC_V1_V2_CONFIG1);
 	/* preset operation */
 
+	/* spare area size in 16-bit half-words */
+	writew(mtd->oobsize / 2, NFC_V21_RSLTSPARE_AREA);
+
 	/* Unlock the internal RAM Buffer */
 	writew(0x2, NFC_V1_V2_CONFIG);
 
-- 
2.1.4
