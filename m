Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5BC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9886C22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9886C22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKMBzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50307 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeKMBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:36 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gMEel-00012b-L1; Mon, 12 Nov 2018 17:01:43 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH v2 1/2] firmware: add nowarn variant of request_firmware_nowait()
Date:   Mon, 12 Nov 2018 17:01:42 +0100
Message-Id: <20181112160143.4459-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device drivers with optional firmware may still want to use the
asynchronous firmware loading interface. To avoid printing a
warining into the kernel log when the optional firmware is
absent, add a nowarn variant of this interface.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: Add missing documentation, as pointed out by 0-day bot.
---
 drivers/base/firmware_loader/main.c | 92 ++++++++++++++++++++---------
 include/linux/firmware.h            | 12 ++++
 2 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 8e9213b36e31..9fa4ee154147 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -790,34 +790,11 @@ static void request_firmware_work_func(struct work_struct *work)
 	kfree(fw_work);
 }
 
-/**
- * request_firmware_nowait() - asynchronous version of request_firmware
- * @module: module requesting the firmware
- * @uevent: sends uevent to copy the firmware image if this flag
- *	is non-zero else the firmware copy must be done manually.
- * @name: name of firmware file
- * @device: device for which firmware is being loaded
- * @gfp: allocation flags
- * @context: will be passed over to @cont, and
- *	@fw may be %NULL if firmware request fails.
- * @cont: function will be called asynchronously when the firmware
- *	request is over.
- *
- *	Caller must hold the reference count of @device.
- *
- *	Asynchronous variant of request_firmware() for user contexts:
- *		- sleep for as small periods as possible since it may
- *		  increase kernel boot time of built-in device drivers
- *		  requesting firmware in their ->probe() methods, if
- *		  @gfp is GFP_KERNEL.
- *
- *		- can't sleep at all if @gfp is GFP_ATOMIC.
- **/
-int
-request_firmware_nowait(
+
+static int _request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
-	void (*cont)(const struct firmware *fw, void *context))
+	void (*cont)(const struct firmware *fw, void *context), bool nowarn)
 {
 	struct firmware_work *fw_work;
 
@@ -835,7 +812,8 @@ request_firmware_nowait(
 	fw_work->context = context;
 	fw_work->cont = cont;
 	fw_work->opt_flags = FW_OPT_NOWAIT |
-		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
+		(nowarn ? FW_OPT_NO_WARN : 0);
 
 	if (!uevent && fw_cache_is_setup(device, name)) {
 		kfree_const(fw_work->name);
@@ -854,8 +832,68 @@ request_firmware_nowait(
 	schedule_work(&fw_work->work);
 	return 0;
 }
+
+/**
+ * request_firmware_nowait() - asynchronous version of request_firmware
+ * @module: module requesting the firmware
+ * @uevent: sends uevent to copy the firmware image if this flag
+ *	is non-zero else the firmware copy must be done manually.
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ * @gfp: allocation flags
+ * @context: will be passed over to @cont, and
+ *	@fw may be %NULL if firmware request fails.
+ * @cont: function will be called asynchronously when the firmware
+ *	request is over.
+ *
+ *	Caller must hold the reference count of @device.
+ *
+ *	Asynchronous variant of request_firmware() for user contexts:
+ *		- sleep for as small periods as possible since it may
+ *		  increase kernel boot time of built-in device drivers
+ *		  requesting firmware in their ->probe() methods, if
+ *		  @gfp is GFP_KERNEL.
+ *
+ *		- can't sleep at all if @gfp is GFP_ATOMIC.
+ **/
+int request_firmware_nowait(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, uevent, name, device, gfp,
+					context, cont, false);
+
+}
 EXPORT_SYMBOL(request_firmware_nowait);
 
+/**
+ * request_firmware_nowait_nowarn() - async version of request_firmware_nowarn
+ * @module: module requesting the firmware
+ * @uevent: sends uevent to copy the firmware image if this flag
+ *	is non-zero else the firmware copy must be done manually.
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ * @gfp: allocation flags
+ * @context: will be passed over to @cont, and
+ *	@fw may be %NULL if firmware request fails.
+ * @cont: function will be called asynchronously when the firmware
+ *	request is over.
+ *
+ * Similar in function to request_firmware_nowait(), but doesn't print a warning
+ * when the firmware file could not be found.
+ */
+int request_firmware_nowait_nowarn(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, uevent, name, device, gfp,
+					context, cont, true);
+
+}
+EXPORT_SYMBOL(request_firmware_nowait_nowarn);
+
 #ifdef CONFIG_PM_SLEEP
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2dd566c91d44..a6d0bc8273a4 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -48,6 +48,10 @@ int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
+int request_firmware_nowait_nowarn(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
@@ -77,6 +81,14 @@ static inline int request_firmware_nowait(
 	return -EINVAL;
 }
 
+static inline int request_firmware_nowait_nowarn(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return -EINVAL;
+}
+
 static inline void release_firmware(const struct firmware *fw)
 {
 }
-- 
2.19.1

