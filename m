Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979201; cv=none;
        d=google.com; s=arc-20160816;
        b=m93D6b0Mn4ZU7XgtyMVkgLUglwDwOVv5foQBEhVgkMd6BYzzPCCfpsiuEO4dyFH1JP
         e+DW7mnDpFgnvreGGDlM4VW7bisuP+dNtVJrzQUxpq8muWi4hlJjTBocMFE+jBiLAZ5G
         FI8OkUv0BOdsw7KmC1NDQeFvvP73aiA81tU+zMZ/K6vgBIQCF7kh3rEUlE1ccaB+gr70
         9YHtEw6s56WwWjl7PqntIcnRvlwgi/6rUq4uQrN21Ssc2jiNu8BETQXlOgyxcG6pEL5y
         gnHqICE7sC8pVHgsaZJOil64LNQlfoPQ/52mBq0twnInRUS1TdFS+9eaMGCkX6hq3DQp
         /y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=EOp+Rizsx0z01ttDCzMbbtRUQ8A9gR0CH2/cwHNKg/8=;
        b=WW4vKGjU5hWuw14VPv8ow3o+0RAerpW8GxxJ+va64eDFqumgYQy+c5ZMWRsuVLSXca
         tymp2hcz49m4UyMsQIG4qADYT7WtYCiu238zKwR8F0Sqz0VD+kTw5AEwhTF2OVCJr1rT
         VV5PzqbtAdkZtoRSdHfr/1IC3wNfAcT3Q+q41l61DP18EcboqR5tHkilhC1BsYesykww
         V+eSFt1a7kYx1NiZfvk6L+LsbbEHBTspKEPGKBMYJZPUnP8d845GSKLXokKumjYCb5Ew
         eqjRea3ClwGUeser5YAQqmjysm1UMDMCiY8xdjQGwnRgTQb6epTETsfH8937fsGJrgKY
         Tbhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QZSGMIde;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QZSGMIde;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49d2lNG/5RQhUCv4qE9+vFmjncUN+LwNuRAid+yvrnTUkdF6QVc2O1fkIF6QLsvtEZ1XVvZ3g==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 5/9] firmware: add functions to load firmware without warnings v4
Date: Tue, 17 Apr 2018 11:33:03 -0400
Message-Id: <20180417153307.3693-6-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598008015463324966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the firmware loader only exposes one silent path for querying
optional firmware, and that is firmware_request_direct(). This function
also disables the fallback path, which might not always be the
desired behaviour. [0]

This patch introduces variations of firmware_request() and
firmware_request_nowait() that enable the caller to disable the
undesired warning messages. This is equivalent to adding FW_OPT_NO_WARN,
to the old behaviour.

v2: add header prototype, use updated opt_flags
v3: split debug message to separate patch
    added _nowait variant
    added documentation
v4: fix kernel-doc style

[0]: https://git.kernel.org/linus/c0cc00f250e1

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 .../driver-api/firmware/request_firmware.rst       | 13 ++++--
 drivers/base/firmware_loader/main.c                | 52 ++++++++++++++++++++--
 include/linux/firmware.h                           |  6 +++
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 7632f8807472..913e7d2e0cb7 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -20,6 +20,11 @@ firmware_request
 .. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request
 
+firmware_request_nowarn
+-----------------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
+   :functions: firmware_request_nowarn
+
 firmware_request_direct
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
@@ -36,13 +41,13 @@ Asynchronous firmware requests
 Asynchronous firmware requests allow driver code to not have to wait
 until the firmware or an error is returned. Function callbacks are
 provided so that when the firmware or an error is found the driver is
-informed through the callback. firmware_request_nowait() cannot be called
+informed through the callback. firmware_request_nowait2() cannot be called
 in atomic contexts.
 
-firmware_request_nowait
------------------------
+firmware_request_nowait2
+------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_nowait
+   :functions: firmware_request_nowait2
 
 Special optimizations on reboot
 ===============================
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index d028cd3257f7..e449ac990dc9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -631,6 +631,30 @@ firmware_request(const struct firmware **firmware_p, const char *name,
 }
 EXPORT_SYMBOL(firmware_request);
 
+/**
+ * firmware_request_nowarn() - request for an optional fw module
+ * @firmware: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ *
+ * This function is similar in behaviour to firmware_request(), except
+ * it doesn't produce warning messages when the file is not found.
+ **/
+int
+firmware_request_nowarn(const struct firmware **firmware, const char *name,
+			struct device *device)
+{
+	int ret;
+
+	/* Need to pin this module until return */
+	__module_get(THIS_MODULE);
+	ret = _firmware_request(firmware, name, device, NULL, 0,
+				FW_OPT_UEVENT | FW_OPT_NO_WARN);
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(firmware_request_nowarn);
+
 /**
  * firmware_request_direct() - load firmware directly without usermode helper
  * @firmware_p: pointer to firmware image
@@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
 }
 
 /**
- * firmware_request_nowait() - asynchronous version of firmware_request
+ * firmware_request_nowait2() - asynchronous version of firmware_request
  * @module: module requesting the firmware
  * @uevent: sends uevent to copy the firmware image if this flag
  *	is non-zero else the firmware copy must be done manually.
+ * @warn: enable warnings
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
  * @gfp: allocation flags
@@ -778,8 +803,8 @@ static void firmware_request_work_func(struct work_struct *work)
  *		- can't sleep at all if @gfp is GFP_ATOMIC.
  **/
 int
-firmware_request_nowait(
-	struct module *module, bool uevent,
+firmware_request_nowait2(
+	struct module *module, bool uevent, bool warn,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -799,7 +824,8 @@ firmware_request_nowait(
 	fw_work->context = context;
 	fw_work->cont = cont;
 	fw_work->opt_flags = FW_OPT_NOWAIT |
-		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
+		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
+		(warn ? 0 : FW_OPT_NO_WARN);
 
 	if (!uevent && fw_cache_is_setup(device, name)) {
 		kfree_const(fw_work->name);
@@ -818,6 +844,24 @@ firmware_request_nowait(
 	schedule_work(&fw_work->work);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(firmware_request_nowait2);
+
+/**
+ * firmware_request_nowait() - compatibility version of firmware_request_nowait2
+ *
+ * This is equivalent to calling firmware_request_nowait2 with warnings enabled.
+ *
+ * Refer to firmware_request_nowait2 for further details.
+ **/
+int
+firmware_request_nowait(
+	struct module *module, bool uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return firmware_request_nowait2(module, uevent, true, name, device,
+					gfp, context, cont);
+}
 EXPORT_SYMBOL(firmware_request_nowait);
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index db8351a42405..2623d3f853ba 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -42,6 +42,12 @@ struct builtin_fw {
 #if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
 int firmware_request(const struct firmware **fw, const char *name,
 		     struct device *device);
+int firmware_request_nowarn(const struct firmware **fw, const char *name,
+			    struct device *device);
+int firmware_request_nowait2(
+	struct module *module, bool uevent, bool warn,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
 int firmware_request_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
-- 
2.14.1
