Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F07C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322D920663
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeL3X4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 18:56:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41458 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeL3X4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 18:56:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 157C1207AE; Mon, 31 Dec 2018 00:56:08 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id DBE0C206A6;
        Mon, 31 Dec 2018 00:55:57 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] rtc: nvmem: fix possible use after free
Date:   Mon, 31 Dec 2018 00:55:53 +0100
Message-Id: <20181230235553.31266-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cas of probe failure, devres may free the memory allocated for
rtc->nvram before devm_rtc_release_device() is called. This leads to
rtc_nvram_unregister using it after being freed which may lead to a crash.

This has been shown to happen after commit 461e557b9727 ("rtc: nvmem: use
devm_nvmem_register()")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index ebdfe8e3a1a0..dce518d5e50e 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/rtc.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 
 /*
@@ -45,9 +46,7 @@ static int rtc_nvram_register(struct rtc_device *rtc,
 {
 	int err;
 
-	rtc->nvram = devm_kzalloc(rtc->dev.parent,
-				sizeof(struct bin_attribute),
-				GFP_KERNEL);
+	rtc->nvram = kzalloc(sizeof(struct bin_attribute), GFP_KERNEL);
 	if (!rtc->nvram)
 		return -ENOMEM;
 
@@ -64,7 +63,7 @@ static int rtc_nvram_register(struct rtc_device *rtc,
 	err = sysfs_create_bin_file(&rtc->dev.parent->kobj,
 				    rtc->nvram);
 	if (err) {
-		devm_kfree(rtc->dev.parent, rtc->nvram);
+		kfree(rtc->nvram);
 		rtc->nvram = NULL;
 	}
 
@@ -74,6 +73,8 @@ static int rtc_nvram_register(struct rtc_device *rtc,
 static void rtc_nvram_unregister(struct rtc_device *rtc)
 {
 	sysfs_remove_bin_file(&rtc->dev.parent->kobj, rtc->nvram);
+	kfree(rtc->nvram);
+	rtc->nvram = NULL;
 }
 
 /*
-- 
2.20.1

