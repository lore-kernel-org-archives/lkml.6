Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE3CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44AC2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="mUV5kHw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfAKU5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:57:07 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:60654 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfAKU5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:57:01 -0500
Received: from trochilidae.toradex.int (unknown [37.17.239.109])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 151595C07C2;
        Fri, 11 Jan 2019 21:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547240220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=EZuop56TD2TeVHsCHrHRufvslIjfMqbihVRqyfb2Fqk=;
        b=mUV5kHw2C2xl897ojBJhpNm9dF6bjk97CTCggizvR8p3EKQ52rflrVPupN2PXhNNdU387C
        iCAe3r7iXd+A3MtZf/8NTgsCCiUZO/uk5qFRhwFMfgTfm7dCAilB/BIDzzmkfsJGKqhyWP
        SgztigVDIk65VQ4G1Mxetxu0iWLaHC8=
From:   Stefan Agner <stefan@agner.ch>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     huxm@marvell.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] bluetooth: btmrvl_sdio: improve printk messages
Date:   Fri, 11 Jan 2019 21:56:56 +0100
Message-Id: <20190111205657.2792-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_* variants to print messages in drivers.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/bluetooth/btmrvl_sdio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index fb3d03928460..6f9a1735039d 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -62,13 +62,14 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
 static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 {
 	struct btmrvl_sdio_card *card = priv;
+	struct device *dev = &card->func->dev;
 	struct btmrvl_plt_wake_cfg *cfg = card->plt_wake_cfg;
 
-	pr_info("%s: wake by bt\n", __func__);
+	dev_info(dev, "wake by bt\n");
 	cfg->wake_by_bt = true;
 	disable_irq_nosync(irq);
 
-	pm_wakeup_event(&card->func->dev, 0);
+	pm_wakeup_event(dev, 0);
 	pm_system_wakeup();
 
 	return IRQ_HANDLED;
@@ -87,7 +88,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 
 	if (!dev->of_node ||
 	    !of_match_node(btmrvl_sdio_of_match_table, dev->of_node)) {
-		pr_err("sdio platform data not available\n");
+		dev_err(dev, "sdio platform data not available\n");
 		return -1;
 	}
 
-- 
2.20.1

