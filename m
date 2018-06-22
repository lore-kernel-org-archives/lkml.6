Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14C243FB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA14C243FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933678AbeFVOuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFVOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D8D09288FB4
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] firmware: add more flexible request_firmware_async function
Date:   Fri, 22 Jun 2018 16:49:50 +0200
Message-Id: <20180622144951.17464-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
References: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

So far we got only one function for loading firmware asynchronously:
request_firmware_nowait. It didn't allow much customization of firmware
loading process - there is only one bool uevent argument. Moreover this
bool also controls user helper in an unclear way.

Some drivers need more flexible helper providing more options. This
includes control over uevent or warning for the missing firmware. Of
course this list may grow up in the future.

To handle this easily this patch adds a generic request_firmware_async
function. It takes struct with options as an argument which will allow
extending it in the future without massive changes.

This is a really cheap change (no new independent API) which works
nicely with the existing code. The old request_firmware_nowait is kept
as a simple helper calling new helper.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[rebased to v4.18-rc1]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/base/firmware_loader/main.c | 41 ++++++++++++++++++++++++-----
 include/linux/firmware.h            | 20 ++++++++++++++
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 0943e7065e0e..e1d2ba570ea3 100644
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
@@ -845,8 +846,34 @@ request_firmware_nowait(
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
 
+int __request_firmware_async(struct module *module, const char *name,
+			     struct firmware_opts *fw_opts, struct device *dev,
+			     void *context,
+			     void (*cont)(const struct firmware *fw, void *context))
+{
+	unsigned int opt_flags = FW_OPT_UEVENT;
+
+	if (fw_opts->optional)
+		opt_flags |= FW_OPT_NO_WARN;
+
+	return __request_firmware_nowait(module, opt_flags, name, dev,
+					 GFP_KERNEL, context, cont);
+}
+EXPORT_SYMBOL(__request_firmware_async);
+
 #ifdef CONFIG_PM_SLEEP
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2dd566c91d44..ad2fc6e7fee7 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -27,6 +27,10 @@ struct builtin_fw {
 	unsigned long size;
 };
 
+struct firmware_opts {
+	bool optional;
+};
+
 /* We have to play tricks here much like stringify() to get the
    __COUNTER__ macro to be expanded as we want it */
 #define __fw_concat1(x, y) x##y
@@ -52,6 +56,10 @@ int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
 	const char *name, struct device *device, void *buf, size_t size);
+int __request_firmware_async(struct module *module, const char *name,
+			     struct firmware_opts *fw_opts, struct device *dev,
+			     void *context,
+			     void (*cont)(const struct firmware *fw, void *context));
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -94,8 +102,20 @@ static inline int request_firmware_into_buf(const struct firmware **firmware_p,
 	return -EINVAL;
 }
 
+int __request_firmware_async(struct module *module, const char *name,
+			     struct firmware_opts *fw_opts, struct device *dev,
+			     void *context,
+			     void (*cont)(const struct firmware *fw, void *context))
+{
+	return -EINVAL;
+}
+
 #endif
 
 int firmware_request_cache(struct device *device, const char *name);
 
+#define request_firmware_async(name, fw_opts, dev, context, cont)	\
+	__request_firmware_async(THIS_MODULE, name, fw_opts, dev,	\
+				 context, cont)
+
 #endif
-- 
2.17.1

