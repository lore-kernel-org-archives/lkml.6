Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B42219EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="0AhuFbhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B42219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeHFLha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:37:30 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53134 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeHFLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:37:29 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0B0485C1561;
        Mon,  6 Aug 2018 11:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533547756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvwPUz6hO0t1fGzby698w1FpDP+P7cF9FoOYJMnDjso=;
        b=0AhuFbhwTQ1m1ilQH5AdWX8je7Ycp+6h4VhKj73CWVt91Ls/WnFnxyrAG77Bd7RwN13N8M
        ffTw3n/X+wExXBTGswijHtBhfdh9It76YFFOj2PqqceSajuKqHcShDASxyJDnqLIBmKPbz
        AzEb9G8KhuPVuLpQi5dSy5PPt+uyNFM=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com
Cc:     computersforpeace@gmail.com, dwmw2@infradead.org,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] mtd: rawnand: vf610_nfc: explicitly disable interrupts first
Date:   Mon,  6 Aug 2018 11:29:08 +0200
Message-Id: <20180806092909.28980-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806092909.28980-1-stefan@agner.ch>
References: <20180806092909.28980-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly disable all interrupts on probe. This should be the
default state, but the bootloader could leave the device in any
state. No issues have been observed so far, but it is still worth
fixing it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 740a91c5c86e..52e7811c0bde 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -130,8 +130,13 @@
 #define CONFIG_PAGE_CNT_SHIFT			0
 
 /* NFC_IRQ_STATUS Field */
+#define WERR_IRQ_BIT				BIT(31)
+#define DONE_IRQ_BIT				BIT(30)
 #define IDLE_IRQ_BIT				BIT(29)
+#define WERR_EN_BIT				BIT(22)
+#define DONE_EN_BIT				BIT(21)
 #define IDLE_EN_BIT				BIT(20)
+#define WERR_CLEAR_BIT				BIT(19)
 #define DONE_CLEAR_BIT				BIT(18)
 #define IDLE_CLEAR_BIT				BIT(17)
 
@@ -819,6 +824,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	init_completion(&nfc->cmd_done);
 
+	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, WERR_EN_BIT);
+	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, DONE_EN_BIT);
+	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
+
 	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
 	if (err) {
 		dev_err(nfc->dev, "Error requesting IRQ!\n");
-- 
2.18.0

