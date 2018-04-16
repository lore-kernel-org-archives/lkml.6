Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917488; cv=none;
        d=google.com; s=arc-20160816;
        b=IikVbSInusJGoSI7wYRFCnQ+zgyq1RkYrF2TbN4B5XVU71Thzvw5CbDTT+rJvFmvsi
         pxiR6WVs5mNd8QgEkaLmVgq7yvSD3Opxx2yOOtQKwsepK4VRQ8Wmp1qve5GAUTimi4PD
         Le5Uq11WIbixRE3WtGV1/Am+B35fjDP10HClVH5dhQ9fD2WCTAj0EjxfTHnIr6URyiNt
         VaMKSXFZCC+k1sEbQwwvBRjtFpUhKaY40TffZbMryB1Hagvs75TNZ9x2wFBuh3rjFC0M
         SadrDYqBhYyC4NCnTz0iwgBiQvLSpLJgxEuwuHdKjxBDBnRtqpvzgotYe/Uvye68VaHf
         NClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BDB39gni7NYB96wEPMGglZ+K36ylZrTWrPmUdfeoeGM=;
        b=j2jJVKVQpDVCRrdFiDz97YDqQ5MS1yuDNXX88l6Fb17oHp5ZjEtbrthh12yEPvDdCH
         p8p1KHzawPDSvFlbqI+Uck5tg2yKcn9m7ky9WuSi6VrA8wXhNjbJrVZ59HoHOS5t8anY
         MsnFJaGgN16vQhjK7NSM21JS1dETl5CXMOEUlpzWXgLpEViYESVE9sfYKdSjnLXxIAZ7
         0hM1NPiYuQNgjZnysj7ZrEqyI3ozV0inqlYkmg/FMbdVAwTgffk8enRZltE9qNmgZWTy
         H4G3rPAJoDk3Mi7ULj/MVEbil7f4lsRAtDOtjfTrh3rU7uC12/cZUQlo3jtXmEgUeTAC
         /Jww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HGzZkOO5;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HGzZkOO5;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48cZb46/2Km0Dxd2AMDlF32D+T6hhIYvrO60oR4vupZ6nOIv6rwfBciP/l1OQhnnSi60wlqnQ==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 4/8] firmware: add functions to load firmware without warnings v3
Date: Mon, 16 Apr 2018 18:24:23 -0400
Message-Id: <20180416222427.29683-5-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416222427.29683-1-andresx7@gmail.com>
References: <20180416222427.29683-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943305003671369?=
X-GMAIL-MSGID: =?utf-8?q?1597943305003671369?=
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
index 5baadad3012d..14ded1de84bf 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -631,6 +631,30 @@ firmware_request(const struct firmware **firmware_p, const char *name,
 }
 EXPORT_SYMBOL(firmware_request);
 
+/**
+ * firmware_request_nowarn: - request for an optional fw module
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
  * firmware_request_direct: - load firmware directly without usermode helper
  * @firmware_p: pointer to firmware image
@@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
 }
 
 /**
- * firmware_request_nowait - asynchronous version of firmware_request
+ * firmware_request_nowait2 - asynchronous version of firmware_request
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
+ * firmware_request_nowait - compatibility version of firmware_request_nowait2
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
