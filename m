Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C9C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B2219EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="WRk333VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2B2219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeHFLhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:37:31 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53140 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:37:30 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4A1BD5C16AA;
        Mon,  6 Aug 2018 11:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533547756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+cA6XclAPFZ8iiIDJY3JYH8fHWs8LkgQwhDxMbZoAM=;
        b=WRk333VLEv2lF4XOmITumq1q8lni105uS8Xny2SVoiOuCoGnucuI+69Is76aN7ca8A5VPJ
        PmF102FZW++79uoENJPQwz8ij9YuXzi/P9o4lkEekcQpzanKvhPvlo3gpVPHBfTadDMLbZ
        oV/2yIqy2DXJhqKokZdCrdAv77ffiE0=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com
Cc:     computersforpeace@gmail.com, dwmw2@infradead.org,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] mtd: rawnand: vf610_nfc: handle only idle interrupts
Date:   Mon,  6 Aug 2018 11:29:09 +0200
Message-Id: <20180806092909.28980-3-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806092909.28980-1-stefan@agner.ch>
References: <20180806092909.28980-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two similar sounding interrupts: IDLE and DONE. The DONE
interrupt only reflects the NAND command state, but not DMA or HW
ECC correction. The IDLE interrupt reflects that all components are
idle. The driver can assume that the NAND command finished and that
data have been transferred and corrected.

This driver makes use of the IDLE interrupt only. But before this
patch the driver still handled all interrupts and cleared the DONE
interrupt although not used. This works just fine in practice, but
is not the way it should be done.

This patch makes sure that only the IDLE interrupt is handled and
cleared. To do so we have to clear the status bit in the interrupt
routine. With that it is also save to keep the interrupt always
enabled and just clear the IRQ in the interrupt handler.

This new interrupt handling has been tested for several thousand
boots and did not show any adverse effects.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 52e7811c0bde..39307f4b1c94 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -290,15 +290,6 @@ static inline void vf610_nfc_wr_to_sram(void __iomem *dst, const void *src,
 	}
 }
 
-/* Clear flags for upcoming command */
-static inline void vf610_nfc_clear_status(struct vf610_nfc *nfc)
-{
-	u32 tmp = vf610_nfc_read(nfc, NFC_IRQ_STATUS);
-
-	tmp |= DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
-	vf610_nfc_write(nfc, NFC_IRQ_STATUS, tmp);
-}
-
 static void vf610_nfc_done(struct vf610_nfc *nfc)
 {
 	unsigned long timeout = msecs_to_jiffies(100);
@@ -310,24 +301,29 @@ static void vf610_nfc_done(struct vf610_nfc *nfc)
 	 * vf610_nfc_set implicates such a barrier by using writel
 	 * to write to the register.
 	 */
-	vf610_nfc_set(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
 	vf610_nfc_set(nfc, NFC_FLASH_CMD2, START_BIT);
 
 	if (!wait_for_completion_timeout(&nfc->cmd_done, timeout))
 		dev_warn(nfc->dev, "Timeout while waiting for BUSY.\n");
-
-	vf610_nfc_clear_status(nfc);
 }
 
 static irqreturn_t vf610_nfc_irq(int irq, void *data)
 {
 	struct mtd_info *mtd = data;
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	u32 status;
 
-	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
-	complete(&nfc->cmd_done);
+	status = vf610_nfc_read(nfc, NFC_IRQ_STATUS);
 
-	return IRQ_HANDLED;
+	if (status & IDLE_IRQ_BIT) {
+		status |= IDLE_CLEAR_BIT;
+		vf610_nfc_write(nfc, NFC_IRQ_STATUS, status);
+		complete(&nfc->cmd_done);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
 }
 
 static inline void vf610_nfc_ecc_mode(struct vf610_nfc *nfc, int ecc_mode)
@@ -826,7 +822,9 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, WERR_EN_BIT);
 	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, DONE_EN_BIT);
-	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
+
+	vf610_nfc_set(nfc, NFC_IRQ_STATUS, IDLE_CLEAR_BIT);
+	vf610_nfc_set(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
 
 	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
 	if (err) {
-- 
2.18.0

