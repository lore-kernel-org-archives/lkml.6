Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64662C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31876208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31876208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKKGPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:15:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40531 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeKKGPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:15:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4E526208EB; Sat, 10 Nov 2018 21:29:15 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19DD2207B8;
        Sat, 10 Nov 2018 21:29:05 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: nvmem: remove nvmem from struct rtc_device
Date:   Sat, 10 Nov 2018 21:29:03 +0100
Message-Id: <20181110202903.18261-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110202903.18261-1-alexandre.belloni@bootlin.com>
References: <20181110202903.18261-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_nvmem_register allows to avoid tracking the nvmem pointer in the
rtc_device structure.
This ultimately allows to register multiple nvmem devices from an RTC
driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c | 24 ++++++++++--------------
 include/linux/rtc.h |  1 -
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 2a7220d8b02d..ebdfe8e3a1a0 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -25,11 +25,9 @@ rtc_nvram_read(struct file *filp, struct kobject *kobj,
 	       struct bin_attribute *attr,
 	       char *buf, loff_t off, size_t count)
 {
-	struct rtc_device *rtc = attr->private;
-
 	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
 
-	return nvmem_device_read(rtc->nvmem, off, count, buf);
+	return nvmem_device_read(attr->private, off, count, buf);
 }
 
 static ssize_t
@@ -37,14 +35,13 @@ rtc_nvram_write(struct file *filp, struct kobject *kobj,
 		struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct rtc_device *rtc = attr->private;
-
 	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
 
-	return nvmem_device_write(rtc->nvmem, off, count, buf);
+	return nvmem_device_write(attr->private, off, count, buf);
 }
 
-static int rtc_nvram_register(struct rtc_device *rtc, size_t size)
+static int rtc_nvram_register(struct rtc_device *rtc,
+			      struct nvmem_device *nvmem, size_t size)
 {
 	int err;
 
@@ -56,7 +53,7 @@ static int rtc_nvram_register(struct rtc_device *rtc, size_t size)
 
 	rtc->nvram->attr.name = "nvram";
 	rtc->nvram->attr.mode = 0644;
-	rtc->nvram->private = rtc;
+	rtc->nvram->private = nvmem;
 
 	sysfs_bin_attr_init(rtc->nvram);
 
@@ -85,21 +82,20 @@ static void rtc_nvram_unregister(struct rtc_device *rtc)
 int rtc_nvmem_register(struct rtc_device *rtc,
 		       struct nvmem_config *nvmem_config)
 {
-	if (!IS_ERR_OR_NULL(rtc->nvmem))
-		return -EBUSY;
+	struct nvmem_device *nvmem;
 
 	if (!nvmem_config)
 		return -ENODEV;
 
 	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
-	rtc->nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
-	if (IS_ERR(rtc->nvmem))
-		return PTR_ERR(rtc->nvmem);
+	nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
 
 	/* Register the old ABI */
 	if (rtc->nvram_old_abi)
-		rtc_nvram_register(rtc, nvmem_config->size);
+		rtc_nvram_register(rtc, nvmem, nvmem_config->size);
 
 	return 0;
 }
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index c8bb4a2b48c3..40ecdb5a369e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -138,7 +138,6 @@ struct rtc_device {
 
 	bool registered;
 
-	struct nvmem_device *nvmem;
 	/* Old ABI support */
 	bool nvram_old_abi;
 	struct bin_attribute *nvram;
-- 
2.19.1

