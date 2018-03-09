Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520633583; cv=none;
        d=google.com; s=arc-20160816;
        b=TXpOjFnu7BgUeJLH0ZKkYhRKOLjdbhMmgJwKLA5ulCEA4brpykQzq4IvwAXE9/1KyV
         nye1egtq6v6Ni705GBCuzgNmhkK9Qi9cqq2DpQHnd/A9zx+SOHq/KESJ13+PEw+hJJzM
         s5DmbP1LE8qeEfTqxwVEgu7mThlJNscT5IF3lkCIVTRB4YtrBiEYcBefJHf1HW03W9In
         n5S6uCWKTcilfY9//RtGoVs3TQ+1kuAB28xgLV7qdA9e4ncVQIWDURzMWvZvFPyV1TNv
         GLZJATF49kwVDgRGxKPqdRcJsfpFSLWwEMLjMhMVnfOHEg/7kB+3EwlG97C60mGNH85y
         ZibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=00Cn2GQb2Xo6AmIxhogP4Uk/bn6I/CJRENXAGoVeaW8=;
        b=xiQMDanemgQY6BJOaFPX8oPX4Ap61Dylp+yQWXSATSx31YCvtdj9/7tWSKZSRPx5uT
         S9AlUJ1jjz6e6zLM9wakTBMU+ByZOtby+7p4l0Ap9/zUOqT4U6H5iSeDEAz8um6z/5Yg
         VkyxfQlfluJbcrDSlewLEE7U1ZmCc2dBGivOeadcdTuBwCn6QkEDimlrKDnhS5yfHuL+
         9xzg4e2IhnQKs+RwgxR3Yp0qBDExNuFzvC9G5owJnNYQK/U+TrdpD7hTPaMlax2pyKbH
         iG6+OU8aqhAgpwf6pw/DK8SrYBi8f9wJsj1UlBh75o/olpsR8lRGxd9XKRvjnpJNkXqn
         JjwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gOVgA7wQ;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gOVgA7wQ;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs7+HreLh7aU4QeCgjPHI/FFzCtqBEhl3QVJYig5qoscL5tQSrGCLZyvDD0lFiJNbF1V8rriA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org
Subject: [PATCH 1/1] firmware: add a function to load optional firmware
Date: Fri,  9 Mar 2018 17:12:43 -0500
Message-Id: <20180309221243.15489-2-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180309221243.15489-1-andresx7@gmail.com>
References: <20180309221243.15489-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594499880010887490?=
X-GMAIL-MSGID: =?utf-8?q?1594499880010887490?=
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

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_class.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 7dd36ace6152..a5a4dfb90e2f 100644
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
@@ -1351,6 +1351,31 @@ request_firmware(const struct firmware **firmware_p, const char *name,
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
+	ret = _request_firmware(firmware_p, name, device, NULL, 0,
+				FW_OPT_UEVENT | FW_OPT_FALLBACK |
+				FW_OPT_NO_WARN);
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL(request_firmware_optional);
+
 /**
  * request_firmware_direct: - load firmware directly without usermode helper
  * @firmware_p: pointer to firmware image
-- 
2.14.1
