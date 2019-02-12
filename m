Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2AEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A562184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I0/FSzXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfBLHOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:14:39 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37582 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfBLHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdX019269;
        Tue, 12 Feb 2019 16:13:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdX019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955614;
        bh=W7SE5qbwsV5rwyJe9i+cPWUmbUQD+IWEIEw4oDfctm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0/FSzXMmmwcZRVqdoNJocDfNuGW9hQQjoC9s67boSMYKaZXGnuTQMmtkks+QGOvG
         COzcdy5n0w2A+KXCxcLENXdh4eSzaUHZifq9S5C9Z8jX37lId3SxHqu8bBkS3L9Fnu
         EGHsCx4235f57Nr1bmSnt4uJ67uG02O/ZJU6A0hwPIWeROwjfeX14bm+lIl/B1bknB
         I8Zdqi6OES0gsiXGJaR7IwokTvdKEt/WeEZeVqDmEwYMtBufDdfSlusM0EHj+54I8i
         X2x8fw1RArjB+LSLPBeL25NGBdn00cD1/siDJmQ+qhBhYt4uUAeo13BhaskQWDSmUg
         Nd9VjJXCqAo9w==
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
Subject: [PATCH v2 09/10] mtd: rawnand: denali: remove DENALI_NR_BANKS macro
Date:   Tue, 12 Feb 2019 16:13:01 +0900
Message-Id: <1549955582-30346-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the runtime-detected denali->nbanks instead of hard-coded
DENALI_NR_BANKS (=4).

The actual number of banks depends on the IP configuration, and
can be less than DENALI_NR_BANKS. It is pointless to touch
registers of unsupported banks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index a162bd1..eb58136 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -40,7 +40,6 @@
 #define DENALI_BANK(denali)	((denali)->active_bank << 24)
 
 #define DENALI_INVALID_BANK	-1
-#define DENALI_NR_BANKS		4
 
 static struct denali_chip *to_denali_chip(struct nand_chip *chip)
 {
@@ -92,7 +91,7 @@ static void denali_enable_irq(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		iowrite32(U32_MAX, denali->reg + INTR_EN(i));
 	iowrite32(GLOBAL_INT_EN_FLAG, denali->reg + GLOBAL_INT_ENABLE);
 }
@@ -101,7 +100,7 @@ static void denali_disable_irq(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		iowrite32(0, denali->reg + INTR_EN(i));
 	iowrite32(0, denali->reg + GLOBAL_INT_ENABLE);
 }
@@ -117,7 +116,7 @@ static void denali_clear_irq_all(struct denali_controller *denali)
 {
 	int i;
 
-	for (i = 0; i < DENALI_NR_BANKS; i++)
+	for (i = 0; i < denali->nbanks; i++)
 		denali_clear_irq(denali, i, U32_MAX);
 }
 
@@ -130,7 +129,7 @@ static irqreturn_t denali_isr(int irq, void *dev_id)
 
 	spin_lock(&denali->irq_lock);
 
-	for (i = 0; i < DENALI_NR_BANKS; i++) {
+	for (i = 0; i < denali->nbanks; i++) {
 		irq_status = ioread32(denali->reg + INTR_STATUS(i));
 		if (irq_status)
 			ret = IRQ_HANDLED;
-- 
2.7.4

