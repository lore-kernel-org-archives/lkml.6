Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D16C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I7fuUbRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfBLHPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:15:03 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37683 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfBLHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdT019269;
        Tue, 12 Feb 2019 16:13:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdT019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955610;
        bh=8Izt7+M0GIMZcso6VHsMqkgTh6a7EcMPGS4x0G6xF04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7fuUbROclvtxjHgSQM1T5JfMt/0sk1vB5Eopd7FuVNPMZxoHeUvaBKW1bleLZ5Jv
         ZpPjejoCnRDtwscbzsVrw7UAcYi0ey0fD1NwBieYM94U+KK3n2r4CPT+sZYov8Y+ko
         gOqXyTvLvPK16ycyyvc8WMWddu6uYeTqe6XA0ket347uuMUyUZQSna7Ib3ae32bOs0
         LSlSvBgOcc3w1uLVKHswDjh/s7JpJh/qcp/Q5PTdSIvx0UTlhgaTSs25x7E7eVOsJQ
         0/3OAVkOvusdumLKmlNIFRscQeyqq5ctueMcXfaqerRf+LXBOvJXGdoBz76bb7JC5d
         XZQsf8r0oI/cw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 05/10] mtd: rawnand: denali: use more precise timeout for NAND_OP_WAITRDT_INSTR
Date:   Tue, 12 Feb 2019 16:12:57 +0900
Message-Id: <1549955582-30346-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, wait_for_completion_timeout() is always passed in the
hard-coded msec_to_jiffies(1000). There is no specific reason for
1000 msec, but it was chosen to be long enough.

With the exec_op() conversion, NAND_OP_WAITRDY_INSTR provides more
precise timeout value, depending on the preceding command. Let's use
it (+ 100 msec) to bail out earlier in error case. The 100 msec extra
is in case the heavy load on the system.

I am still keeping the hard-coded values for other higher level hooks
such as page_read, page_write, etc. We know the value of tR, tPROG, but
we have unknowledge about the data transfer speed of the DMA engine.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add extra 100 msec to the wait-period in case the system is under load

 drivers/mtd/nand/raw/denali.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index bd7df25..7050b1f 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -176,7 +176,7 @@ static void denali_reset_irq(struct denali_nand_info *denali)
 }
 
 static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
-				    uint32_t irq_mask)
+				    u32 irq_mask, unsigned int timeout_ms)
 {
 	unsigned long time_left, flags;
 	uint32_t irq_status;
@@ -195,8 +195,11 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
 	reinit_completion(&denali->complete);
 	spin_unlock_irqrestore(&denali->irq_lock, flags);
 
+	/* Prolong the IRQ wait time in case the system is under heavy load. */
+	timeout_ms += 100;
+
 	time_left = wait_for_completion_timeout(&denali->complete,
-						msecs_to_jiffies(1000));
+						msecs_to_jiffies(timeout_ms));
 	if (!time_left) {
 		dev_err(denali->dev, "timeout while waiting for irq 0x%x\n",
 			irq_mask);
@@ -349,7 +352,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 	 * Once handle all ECC errors, controller will trigger an
 	 * ECC_TRANSACTION_DONE interrupt.
 	 */
-	irq_status = denali_wait_for_irq(denali, INTR__ECC_TRANSACTION_DONE);
+	irq_status = denali_wait_for_irq(denali, INTR__ECC_TRANSACTION_DONE, 1);
 	if (!(irq_status & INTR__ECC_TRANSACTION_DONE))
 		return -EIO;
 
@@ -421,7 +424,7 @@ static int denali_pio_read(struct denali_nand_info *denali, u32 *buf,
 	for (i = 0; i < size / 4; i++)
 		buf[i] = denali->host_read(denali, addr);
 
-	irq_status = denali_wait_for_irq(denali, INTR__PAGE_XFER_INC);
+	irq_status = denali_wait_for_irq(denali, INTR__PAGE_XFER_INC, 1);
 	if (!(irq_status & INTR__PAGE_XFER_INC))
 		return -EIO;
 
@@ -444,7 +447,9 @@ static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
 		denali->host_write(denali, addr, buf[i]);
 
 	irq_status = denali_wait_for_irq(denali,
-				INTR__PROGRAM_COMP | INTR__PROGRAM_FAIL);
+					 INTR__PROGRAM_COMP |
+					 INTR__PROGRAM_FAIL,
+					 1000);
 	if (!(irq_status & INTR__PROGRAM_COMP))
 		return -EIO;
 
@@ -501,7 +506,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	denali_reset_irq(denali);
 	denali->setup_dma(denali, dma_addr, page, write);
 
-	irq_status = denali_wait_for_irq(denali, irq_mask);
+	irq_status = denali_wait_for_irq(denali, irq_mask, 1000);
 	if (!(irq_status & INTR__DMA_CMD_COMP))
 		ret = -EIO;
 	else if (irq_status & ecc_err_mask)
@@ -1168,12 +1173,13 @@ static void denali_exec_out16(struct denali_nand_info *denali, u32 type,
 				   buf[i + 1] << 16 | buf[i]);
 }
 
-static int denali_exec_waitrdy(struct denali_nand_info *denali)
+static int denali_exec_waitrdy(struct denali_nand_info *denali,
+			       unsigned int timeout_ms)
 {
 	u32 irq_stat;
 
 	/* R/B# pin transitioned from low to high? */
-	irq_stat = denali_wait_for_irq(denali, INTR__INT_ACT);
+	irq_stat = denali_wait_for_irq(denali, INTR__INT_ACT, timeout_ms);
 
 	/* Just in case nand_operation has multiple NAND_OP_WAITRDY_INSTR. */
 	denali_reset_irq(denali);
@@ -1212,7 +1218,8 @@ static int denali_exec_instr(struct nand_chip *chip,
 				   instr->ctx.data.len);
 		return 0;
 	case NAND_OP_WAITRDY_INSTR:
-		return denali_exec_waitrdy(denali);
+		return denali_exec_waitrdy(denali,
+					   instr->ctx.waitrdy.timeout_ms);
 	default:
 		WARN_ONCE(1, "unsupported NAND instruction type: %d\n",
 			  instr->type);
-- 
2.7.4

