Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D67C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234D21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234D21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeI0Vnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:43:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43268 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0Vnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:43:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g5Y9X-00025s-NQ; Thu, 27 Sep 2018 15:24:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][mtd-next] mtd: rawnand: fix spelling mistake "card_registred" -> "card_registered"
Date:   Thu, 27 Sep 2018 16:24:31 +0100
Message-Id: <20180927152431.6031-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake struct field name, rename it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/r852.c | 14 +++++++-------
 drivers/mtd/nand/raw/r852.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index b08aa0a5a074..39be65b35ac2 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -637,7 +637,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 {
 	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
-	WARN_ON(dev->card_registred);
+	WARN_ON(dev->card_registered);
 
 	mtd->dev.parent = &dev->pci_dev->dev;
 
@@ -654,7 +654,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 		goto error3;
 	}
 
-	dev->card_registred = 1;
+	dev->card_registered = 1;
 	return 0;
 error3:
 	nand_release(dev->chip);
@@ -672,13 +672,13 @@ static void r852_unregister_nand_device(struct r852_device *dev)
 {
 	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
-	if (!dev->card_registred)
+	if (!dev->card_registered)
 		return;
 
 	device_remove_file(&mtd->dev, &dev_attr_media_type);
 	nand_release(dev->chip);
 	r852_engine_disable(dev);
-	dev->card_registred = 0;
+	dev->card_registered = 0;
 }
 
 /* Card state updater */
@@ -692,7 +692,7 @@ static void r852_card_detect_work(struct work_struct *work)
 	dev->card_unstable = 0;
 
 	/* False alarm */
-	if (dev->card_detected == dev->card_registred)
+	if (dev->card_detected == dev->card_registered)
 		goto exit;
 
 	/* Read media properties */
@@ -1033,7 +1033,7 @@ static int r852_resume(struct device *device)
 
 
 	/* If card status changed, just do the work */
-	if (dev->card_detected != dev->card_registred) {
+	if (dev->card_detected != dev->card_registered) {
 		dbg("card was %s during low power state",
 			dev->card_detected ? "added" : "removed");
 
@@ -1043,7 +1043,7 @@ static int r852_resume(struct device *device)
 	}
 
 	/* Otherwise, initialize the card */
-	if (dev->card_registred) {
+	if (dev->card_registered) {
 		r852_engine_enable(dev);
 		dev->chip->select_chip(dev->chip, 0);
 		nand_reset_op(dev->chip);
diff --git a/drivers/mtd/nand/raw/r852.h b/drivers/mtd/nand/raw/r852.h
index 1eed2fc2fa42..bc67f5bf67e8 100644
--- a/drivers/mtd/nand/raw/r852.h
+++ b/drivers/mtd/nand/raw/r852.h
@@ -129,7 +129,7 @@ struct r852_device {
 	/* card status area */
 	struct delayed_work card_detect_work;
 	struct workqueue_struct *card_workqueue;
-	int card_registred;		/* card registered with mtd */
+	int card_registered;		/* card registered with mtd */
 	int card_detected;		/* card detected in slot */
 	int card_unstable;		/* whenever the card is inserted,
 					   is not known yet */
-- 
2.17.1

