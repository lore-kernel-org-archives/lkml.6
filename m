Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00CC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686B0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeLRVQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:16:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43330 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbeLRVQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:16:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5C2F2207D9; Tue, 18 Dec 2018 22:16:11 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D2BC206FF;
        Tue, 18 Dec 2018 22:16:01 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: class: reimplement devm_rtc_device_register
Date:   Tue, 18 Dec 2018 22:15:58 +0100
Message-Id: <20181218211558.13136-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement devm_rtc_device_register using devm_rtc_allocate_device and
__rtc_register_device so there is only one path left to register rtc
devices.

Also mark it as deprecated so new drivers will hopefully use
devm_rtc_allocate_device and rtc_register_device that are less race prone
and allow avoiding the 2038, 2070, 2100 and 2106 bugs properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 157 ++++++++++----------------------------------
 1 file changed, 36 insertions(+), 121 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 6d364085bd86..8a878fbeb2f0 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -277,82 +277,6 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
 		rtc->offset_secs = 0;
 }
 
-/**
- * rtc_device_register - register w/ RTC class
- * @dev: the device to register
- *
- * rtc_device_unregister() must be called when the class device is no
- * longer needed.
- *
- * Returns the pointer to the new struct class device.
- */
-static struct rtc_device *rtc_device_register(const char *name,
-					      struct device *dev,
-					      const struct rtc_class_ops *ops,
-					      struct module *owner)
-{
-	struct rtc_device *rtc;
-	struct rtc_wkalrm alrm;
-	int id, err;
-
-	id = rtc_device_get_id(dev);
-	if (id < 0) {
-		err = id;
-		goto exit;
-	}
-
-	rtc = rtc_allocate_device();
-	if (!rtc) {
-		err = -ENOMEM;
-		goto exit_ida;
-	}
-
-	rtc->id = id;
-	rtc->ops = ops;
-	rtc->owner = owner;
-	rtc->dev.parent = dev;
-
-	dev_set_name(&rtc->dev, "rtc%d", id);
-
-	rtc_device_get_offset(rtc);
-
-	/* Check to see if there is an ALARM already set in hw */
-	err = __rtc_read_alarm(rtc, &alrm);
-
-	if (!err && !rtc_valid_tm(&alrm.time))
-		rtc_initialize_alarm(rtc, &alrm);
-
-	rtc_dev_prepare(rtc);
-
-	err = cdev_device_add(&rtc->char_dev, &rtc->dev);
-	if (err) {
-		dev_warn(&rtc->dev, "%s: failed to add char device %d:%d\n",
-			 name, MAJOR(rtc->dev.devt), rtc->id);
-
-		/* This will free both memory and the ID */
-		put_device(&rtc->dev);
-		goto exit;
-	} else {
-		dev_dbg(&rtc->dev, "%s: dev (%d:%d)\n", name,
-			MAJOR(rtc->dev.devt), rtc->id);
-	}
-
-	rtc_proc_add_device(rtc);
-
-	dev_info(dev, "rtc core: registered %s as %s\n",
-			name, dev_name(&rtc->dev));
-
-	return rtc;
-
-exit_ida:
-	ida_simple_remove(&rtc_ida, id);
-
-exit:
-	dev_err(dev, "rtc core: unable to register %s, err = %d\n",
-			name, err);
-	return ERR_PTR(err);
-}
-
 /**
  * rtc_device_unregister - removes the previously registered RTC class device
  *
@@ -372,51 +296,6 @@ static void rtc_device_unregister(struct rtc_device *rtc)
 	put_device(&rtc->dev);
 }
 
-static void devm_rtc_device_release(struct device *dev, void *res)
-{
-	struct rtc_device *rtc = *(struct rtc_device **)res;
-
-	rtc_nvmem_unregister(rtc);
-	rtc_device_unregister(rtc);
-}
-
-/**
- * devm_rtc_device_register - resource managed rtc_device_register()
- * @dev: the device to register
- * @name: the name of the device
- * @ops: the rtc operations structure
- * @owner: the module owner
- *
- * @return a struct rtc on success, or an ERR_PTR on error
- *
- * Managed rtc_device_register(). The rtc_device returned from this function
- * are automatically freed on driver detach. See rtc_device_register()
- * for more information.
- */
-
-struct rtc_device *devm_rtc_device_register(struct device *dev,
-					const char *name,
-					const struct rtc_class_ops *ops,
-					struct module *owner)
-{
-	struct rtc_device **ptr, *rtc;
-
-	ptr = devres_alloc(devm_rtc_device_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	rtc = rtc_device_register(name, dev, ops, owner);
-	if (!IS_ERR(rtc)) {
-		*ptr = rtc;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return rtc;
-}
-EXPORT_SYMBOL_GPL(devm_rtc_device_register);
-
 static void devm_rtc_release_device(struct device *dev, void *res)
 {
 	struct rtc_device *rtc = *(struct rtc_device **)res;
@@ -503,6 +382,42 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
 }
 EXPORT_SYMBOL_GPL(__rtc_register_device);
 
+/**
+ * devm_rtc_device_register - resource managed rtc_device_register()
+ * @dev: the device to register
+ * @name: the name of the device (unused)
+ * @ops: the rtc operations structure
+ * @owner: the module owner
+ *
+ * @return a struct rtc on success, or an ERR_PTR on error
+ *
+ * Managed rtc_device_register(). The rtc_device returned from this function
+ * are automatically freed on driver detach.
+ * This function is deprecated, use devm_rtc_allocate_device and
+ * rtc_register_device instead
+ */
+struct rtc_device *devm_rtc_device_register(struct device *dev,
+					const char *name,
+					const struct rtc_class_ops *ops,
+					struct module *owner)
+{
+	struct rtc_device *rtc;
+	int err;
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return rtc;
+
+	rtc->ops = ops;
+
+	err = __rtc_register_device(owner, rtc);
+	if (err)
+		return ERR_PTR(err);
+
+	return rtc;
+}
+EXPORT_SYMBOL_GPL(devm_rtc_device_register);
+
 static int __init rtc_init(void)
 {
 	rtc_class = class_create(THIS_MODULE, "rtc");
-- 
2.20.0

