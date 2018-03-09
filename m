Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520636977; cv=none;
        d=google.com; s=arc-20160816;
        b=oUkr1C82hFmbpo2lo5VS124yZoTfMTWyYFkXV5kaCBFvisslpIWeY/J1YBVP5CfGeX
         u+VC4t5XpDup6MrvHb0SDx8caKAbxW3q4uINaqMLrG/1fhHDzajfP13oy2A7ZvqnWaGW
         i4zVu2T4E4xnAV3xMmpwYqvbranJuxETw8oKBjnN27l2Wb6LwaOhvkXRb0QaLy7L7F6i
         v6FBXZZT/YqiwmJfUg+2RxxhdOhug2a2/uws0KWpKJ7l5WdodMpVf3dl6Pa6cmHks4pz
         o2cbZevHmI1/+eby9zOc3UbbKs/kRpxYzicy+4sx6CQFwcR3c8f762w3ldz6xekNz5Pm
         u3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uGMcrkEOeTgEmayqpZ9Z1uBt4nbq8u4a9XMY9h4E3wY=;
        b=VP81ccDPagvhyDeVbHL0YsrXDc8MsTTFqTNQUNdT3ptjk9E0q3gsUWFdFJJZrOcmve
         r0tgF/eO/szWuWhJ1UjDxOOQRydV/HONGFh9Qim1ABg7gZw0Uzw9BI/6tBBEd7KWVWKR
         eBR3u7C1b1/VBNlE471A604Md9UM69aPe08Cy9DwJV6mJfurUMAD8ryBLoFRgZfd8iug
         fzqDzW7oDVxmKPGIO8pRkk9NgQt0DzRAR64jKVv91UP1pZoq61Kdx9BgRBT1bpz/AF0w
         jz7XqiOa3j4W5LZTIFgU8GaOx1akcnUq976SDSiRYbJNEAlpX/np0eVZus3408yKA1+l
         PzbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mXApy5wN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mXApy5wN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsIdmxoUOPgM8YP6F+0OZFMZBwc6D2T/fe5l8RexLFsq7FdG7CN727ClIv0C1ROR02XaPKRyA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org
Subject: [PATCH] firmware: add a function to load optional firmware v2
Date: Fri,  9 Mar 2018 18:09:25 -0500
Message-Id: <20180309230925.3573-1-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180309221243.15489-2-andresx7@gmail.com>
References: <20180309221243.15489-2-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594503439621024078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the firmware loader only exposes one silent path for querying
optional firmware, and that is request_firmware_direct(). This function
also disables the usermodehelper fallback which might not always be the
desired behaviour.

This patch introduces request_firmware_optional(), which will not
produce error/warning messages if the firmware file is not found, but
will still attempt to query the usermodehelper for the optional
firmware. Effectively, FW_OPT_UEVENT | FW_OPT_FALLBACK | FW_OPT_NO_WARN.

v2: add header prototype, use updated opt_flags

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---

Sorry, I messed up the v1 patch and sent the wrong one from before I
rebased.

 drivers/base/firmware_class.c | 26 +++++++++++++++++++++++++-
 include/linux/firmware.h      |  2 ++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 7dd36ace6152..4e1eddea241b 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -1181,7 +1181,7 @@ static int fw_sysfs_fallback(struct firmware *fw, const char *name,
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
 
-	dev_warn(device, "Falling back to user helper\n");
+	dev_warn(device, "Falling back to user helper for %s\n", name);
 	return fw_load_from_user_helper(fw, name, device, opt_flags);
 }
 #else /* CONFIG_FW_LOADER_USER_HELPER */
@@ -1351,6 +1351,30 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 }
 EXPORT_SYMBOL(request_firmware);
 
+/**
+ * request_firmware_optional: - request for an optional fw module
+ * @firmware_p: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ *
+ * This function is similar in behaviour to request_firmware(), except
+ * it doesn't produce warning messages when the file is not found.
+ **/
+int
+request_firmware_optional(const struct firmware **firmware_p, const char *name,
+			  struct device *device)
+{
+	int ret;
+
+	/* Need to pin this module until return */
+	__module_get(THIS_MODULE);
+		ret = _request_firmware(firmware_p, name, device, NULL, 0,
+				FW_OPT_UEVENT | FW_OPT_NO_WARN );
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL(request_firmware_optional);
+
 /**
  * request_firmware_direct: - load firmware directly without usermode helper
  * @firmware_p: pointer to firmware image
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index d4508080348d..6f386eeb8efc 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -46,6 +46,8 @@ int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
+int request_firmware_optional(const struct firmware **fw, const char *name,
+			      struct device *device);
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
-- 
2.14.1
