Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D300C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1405240C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1405240C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeGDQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:05:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeGDQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:05:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E08F028765B
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     andresx7@gmail.com, torvalds@linux-foundation.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 1/2] firmware: add request_firmware_nowait_nowarn function
Date:   Wed,  4 Jul 2018 18:04:59 +0200
Message-Id: <20180704160500.22699-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704160500.22699-1-sebastian.reichel@collabora.co.uk>
References: <20180704160500.22699-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we got only one function for loading firmware asynchronously:
request_firmware_nowait. This adds another method for loading async
firmware without generating a warning when the firmware file is missing.
This is useful for devices, which also work without a firmware (i.e.
by using ROM firmware).

This is based on previous work from Rafał Miłecki <rafal@milecki.pl>.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/base/firmware_loader/main.c | 40 ++++++++++++++++++++++++-----
 include/linux/firmware.h            | 12 +++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 0943e7065e0e..ede1a90e075e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -774,7 +774,7 @@ static void request_firmware_work_func(struct work_struct *work)
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
-	put_device(fw_work->device); /* taken in request_firmware_nowait() */
+	put_device(fw_work->device); /* taken in __request_firmware_nowait() */
 
 	module_put(fw_work->module);
 	kfree_const(fw_work->name);
@@ -782,8 +782,9 @@ static void request_firmware_work_func(struct work_struct *work)
 }
 
 /**
- * request_firmware_nowait() - asynchronous version of request_firmware
+ * __request_firmware_nowait() - asynchronous version of request_firmware
  * @module: module requesting the firmware
+ * @opt_flags: flags that control firmware loading process, see FW_OPT_*
  * @uevent: sends uevent to copy the firmware image if this flag
  *	is non-zero else the firmware copy must be done manually.
  * @name: name of firmware file
@@ -804,13 +805,14 @@ static void request_firmware_work_func(struct work_struct *work)
  *
  *		- can't sleep at all if @gfp is GFP_ATOMIC.
  **/
-int
-request_firmware_nowait(
-	struct module *module, bool uevent,
+static int
+__request_firmware_nowait(
+	struct module *module, unsigned int opt_flags,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
 	struct firmware_work *fw_work;
+	bool uevent = !!(opt_flags & FW_OPT_UEVENT);
 
 	fw_work = kzalloc(sizeof(struct firmware_work), gfp);
 	if (!fw_work)
@@ -825,8 +827,7 @@ request_firmware_nowait(
 	fw_work->device = device;
 	fw_work->context = context;
 	fw_work->cont = cont;
-	fw_work->opt_flags = FW_OPT_NOWAIT |
-		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+	fw_work->opt_flags = FW_OPT_NOWAIT | opt_flags;
 
 	if (!uevent && fw_cache_is_setup(device, name)) {
 		kfree_const(fw_work->name);
@@ -845,8 +846,33 @@ request_firmware_nowait(
 	schedule_work(&fw_work->work);
 	return 0;
 }
+
+int request_firmware_nowait(struct module *module, bool uevent,
+			    const char *name, struct device *device, gfp_t gfp,
+			    void *context,
+			    void (*cont)(const struct firmware *fw, void *context))
+{
+	unsigned int opt_flags = (uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+
+	return __request_firmware_nowait(module, opt_flags, name, device, gfp,
+					 context, cont);
+}
 EXPORT_SYMBOL(request_firmware_nowait);
 
+int request_firmware_nowait_nowarn(struct module *module, bool uevent,
+				   const char *name, struct device *dev,
+				   gfp_t gfp, void *context,
+				   void (*cont)(const struct firmware *fw,
+						void *context))
+{
+	unsigned int opt_flags = (uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+	opt_flags |= FW_OPT_NO_WARN;
+
+	return __request_firmware_nowait(module, opt_flags, name, dev, gfp,
+					 context, cont);
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
2.18.0

