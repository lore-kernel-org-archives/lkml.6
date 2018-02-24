Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x2266ZzNuEP6nKh07CWaBq7sp6aRJncSzYkskg+GYVJbzcDDq/N3uIET/ELSS8d5MDSTfzE4C
ARC-Seal: i=1; a=rsa-sha256; t=1519440382; cv=none;
        d=google.com; s=arc-20160816;
        b=0IDzzC2H8Q4/G4ITEsjMtIrrugEaxd2d5uG0vtmT+FayeOcigCa2nDP/YYXD+emuyX
         Xc2E2Z/tZvliJfvAfp//LqeyaFrV9IKyx7FJdr8nLra9WZvKbF2Y0KPfJCRPPctM2qm8
         cFu1IJaXw+QTV7Sy9Iyq8qHfjXyF6Zk1zCteJOKCOLMkA7ktPO0dAyES/6YcGUynXSu/
         heMwXPqQBRjXuautiBRSJxw5J/V/9vEBaObBZS8ZXAhRpbA80tQ9LiUCNwyL63SS8lc7
         xKY3HjgMKfOkZG2H+V+pC4gjsEjBCnB4QYHuN4AGMZc/ka6iw65DgD4ocKIb/48fmtmK
         8ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=v8VJrtvfVSlAN3sTnmbFU0Hew39chG2aa0AwuUivjg8=;
        b=NTuf6iGl9sPJm+ef1NpMOwy+OkKkipfdx04p8VBMcI6BXHteF1WWTO5/sMF+mDJIXl
         dcJMMhXEQGK90EJahBqMrkY6hrHTifl7kt3TcKaLsWmixRDH5tnB1p5i3fdyj6MaYIR+
         MMD+V7Y/gv0go+mTXy/1FdolO0gzKAsEQtKTS0UEIZCr/kdRJPDltgw4ewNm9Jn/DMFy
         56m7cf7iEkCXFO6hjHbzK9h3eh9TgY/PD+BURtpBkkjGsksKFg4uMAerOM9Op8dGogqH
         H0v5ZXED21rcgmBAVMl85x9UECv+Y+agVSkIcImMMs6XutiN94TzNjzAHUDfXgGsvV3m
         pT3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E0F217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 06/11] firmware: move loading timeout under struct firmware_fallback_config
Date: Fri, 23 Feb 2018 18:46:08 -0800
Message-Id: <20180224024613.24078-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248718555025145?=
X-GMAIL-MSGID: =?utf-8?q?1593248718555025145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The timeout is a fallback construct, so we can just stuff the
timeout configuration under struct firmware_fallback_config.

While at it, add a few helpers which vets the use of getting or
setting the timeout as an int. The main use of the timeout is
to set a timeout for completion, and that is used as an unsigned
long. There a few cases however where it makes sense to get or
set the timeout as an int, the helpers annotate these use cases
have been properly vetted for.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 46 ++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 2d819875348d..9757f9fff01e 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -266,21 +266,38 @@ static inline bool fw_state_is_aborted(struct fw_priv *fw_priv)
  *
  * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
  * 	as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
+ * @old_timeout: for internal use
+ * @loading_timeout: the timeout to wait for the fallback mechanism before
+ * 	giving up, in seconds.
  */
 struct firmware_fallback_config {
-	bool force_sysfs_fallback;
+	const bool force_sysfs_fallback;
+	int old_timeout;
+	int loading_timeout;
 };
 
-static const struct firmware_fallback_config fw_fallback_config = {
+static struct firmware_fallback_config fw_fallback_config = {
 	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
+	.loading_timeout = 60,
+	.old_timeout = 60,
 };
 
-static int old_timeout;
-static int loading_timeout = 60;	/* In seconds */
+/* These getters are vetted to use int properly */
+static inline int __firmware_loading_timeout(void)
+{
+	return fw_fallback_config.loading_timeout;
+}
+
+/* These setters are vetted to use int properly */
+static void __fw_fallback_set_timeout(int timeout)
+{
+	fw_fallback_config.loading_timeout = timeout;
+}
 
 static inline long firmware_loading_timeout(void)
 {
-	return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
+	return __firmware_loading_timeout() > 0 ?
+		__firmware_loading_timeout() * HZ : MAX_JIFFY_OFFSET;
 }
 
 /*
@@ -291,14 +308,14 @@ static inline long firmware_loading_timeout(void)
  */
 static void fw_fallback_set_cache_timeout(void)
 {
-	old_timeout = loading_timeout;
-	loading_timeout = 10;
+	fw_fallback_config.old_timeout = __firmware_loading_timeout();
+	__fw_fallback_set_timeout(10);
 }
 
 /* Restores the timeout to the value last configured during normal operation */
 static void fw_fallback_set_default_timeout(void)
 {
-	loading_timeout =  old_timeout;
+	__fw_fallback_set_timeout(fw_fallback_config.old_timeout);
 }
 
 static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
@@ -677,7 +694,7 @@ static void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%d\n", loading_timeout);
+	return sprintf(buf, "%d\n", __firmware_loading_timeout());
 }
 
 /**
@@ -696,9 +713,12 @@ static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 static ssize_t timeout_store(struct class *class, struct class_attribute *attr,
 			     const char *buf, size_t count)
 {
-	loading_timeout = simple_strtol(buf, NULL, 10);
-	if (loading_timeout < 0)
-		loading_timeout = 0;
+	int tmp_loading_timeout = simple_strtol(buf, NULL, 10);
+
+	if (tmp_loading_timeout < 0)
+		tmp_loading_timeout = 0;
+
+	__fw_fallback_set_timeout(tmp_loading_timeout);
 
 	return count;
 }
@@ -721,7 +741,7 @@ static int do_firmware_uevent(struct fw_sysfs *fw_sysfs, struct kobj_uevent_env
 {
 	if (add_uevent_var(env, "FIRMWARE=%s", fw_sysfs->fw_priv->fw_name))
 		return -ENOMEM;
-	if (add_uevent_var(env, "TIMEOUT=%i", loading_timeout))
+	if (add_uevent_var(env, "TIMEOUT=%i", __firmware_loading_timeout()))
 		return -ENOMEM;
 	if (add_uevent_var(env, "ASYNC=%d", fw_sysfs->nowait))
 		return -ENOMEM;
-- 
2.16.2
