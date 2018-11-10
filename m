Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB4C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3557208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3557208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeKKGPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:15:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40530 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbeKKGPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:15:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 033A4224CD; Sat, 10 Nov 2018 21:29:15 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id CEF2920701;
        Sat, 10 Nov 2018 21:29:04 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: nvmem: use devm_nvmem_register()
Date:   Sat, 10 Nov 2018 21:29:02 +0100
Message-Id: <20181110202903.18261-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the resource managed variant of nvmem_register().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 36ab183c42f1..2a7220d8b02d 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -93,7 +93,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 
 	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
-	rtc->nvmem = nvmem_register(nvmem_config);
+	rtc->nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
 	if (IS_ERR(rtc->nvmem))
 		return PTR_ERR(rtc->nvmem);
 
@@ -107,12 +107,7 @@ EXPORT_SYMBOL_GPL(rtc_nvmem_register);
 
 void rtc_nvmem_unregister(struct rtc_device *rtc)
 {
-	if (IS_ERR_OR_NULL(rtc->nvmem))
-		return;
-
 	/* unregister the old ABI */
 	if (rtc->nvram)
 		rtc_nvram_unregister(rtc);
-
-	nvmem_unregister(rtc->nvmem);
 }
-- 
2.19.1

