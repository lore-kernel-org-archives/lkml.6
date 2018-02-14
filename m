Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x225ql8uBh/GyGqFgfSPG/cLDNeIUT2mDDXRTar7j5x/7XDRUnaLfFgw53tChBDosTDaN8fj3
ARC-Seal: i=1; a=rsa-sha256; t=1518568921; cv=none;
        d=google.com; s=arc-20160816;
        b=OOj5g35qXvzDQTMEdM/bSV5fjbM7efJ/7QQWNnMC6QG1S/abVkI2nqaDX85TPuXnOL
         e1BwGwdbrZiJKa5BfDrQGi+1cjHDy1T4IWdKv2uIBftMTEoJTmFcc9LdvyEKlNDSF6+S
         iqyJ1nLiYzKPDfSwwA56iw0A0QEtf5/7UmA2ZSJhje1ydYgYUFwRRMJwH/6SVagRxWwK
         ht1zgF0rYTmcMxMSdQrLFtFJYQhLhZbBwykqt2FeyVtmyifJ6jWwi0d1aopjh3yv5POK
         0Sk/PHcAcyIvwuCiVuS6C5kSgRW6I6bTfw1RtzIS0JeWLi5XB8BThLZx0VdcI8ksbLqn
         70Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=voh95FnExFzIQBsvlOjF1HWeQ650Tf33PGVUXiNYA3c=;
        b=utZutaDuisrDZoQwWoYrnD4MTsHSpmfTyV9GeyuzGUvCetY+4LK7XTJY2DlmXpKhLF
         wQQ9Jh8lzYVoPR20W2s1PIUmcTe0fk7rDDvHhw9EagaNQ8doZtu77gjoyZvPiUxKEBB3
         AeG9i1GSDUR3CwzNO+pXniAaszwqy1dPZw8vU8/sU2sJlfKNYqzYnzeeUIlKDWGCNJH0
         cRLzckUQtuuP/uImvuOh56x7f8pjlOmsySYD81+u9vXNRx8FM3Z5EEWKkC57NvRuSTUJ
         Ivu5Ch9x0OHLdF7UjKTSdYpXmKl+7xdFrSbTU5ui0HDyYRvfRWJVG9/JiT4C8yyo0OOU
         5JRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784BE217D8
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
Subject: [PATCH v2 05/11] firmware: use helpers for setting up a temporary cache timeout
Date: Tue, 13 Feb 2018 16:41:42 -0800
Message-Id: <20180214004148.14452-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334925387411584?=
X-GMAIL-MSGID: =?utf-8?q?1592334925387411584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We only use the timeout for the firmware fallback mechanism
except for trying to set the timeout during the cache setup
for resume/suspend. For those cases, setting the timeout should
be a no-op, so just reflect this in code by adding helpers for it.

This change introduces no functional changes.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 49 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 59dba794ce1a..2d819875348d 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -191,13 +191,6 @@ static inline bool fw_is_builtin_firmware(const struct firmware *fw)
 }
 #endif
 
-static int loading_timeout = 60;	/* In seconds */
-
-static inline long firmware_loading_timeout(void)
-{
-	return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
-}
-
 static void fw_state_init(struct fw_priv *fw_priv)
 {
 	struct fw_state *fw_st = &fw_priv->fw_st;
@@ -282,6 +275,32 @@ static const struct firmware_fallback_config fw_fallback_config = {
 	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
 };
 
+static int old_timeout;
+static int loading_timeout = 60;	/* In seconds */
+
+static inline long firmware_loading_timeout(void)
+{
+	return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
+}
+
+/*
+ * use small loading timeout for caching devices' firmware because all these
+ * firmware images have been loaded successfully at lease once, also system is
+ * ready for completing firmware loading now. The maximum size of firmware in
+ * current distributions is about 2M bytes, so 10 secs should be enough.
+ */
+static void fw_fallback_set_cache_timeout(void)
+{
+	old_timeout = loading_timeout;
+	loading_timeout = 10;
+}
+
+/* Restores the timeout to the value last configured during normal operation */
+static void fw_fallback_set_default_timeout(void)
+{
+	loading_timeout =  old_timeout;
+}
+
 static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
 {
 	return __fw_state_check(fw_priv, FW_STATUS_DONE);
@@ -1206,6 +1225,8 @@ static int fw_sysfs_fallback(struct firmware *fw, const char *name,
 }
 
 static inline void kill_pending_fw_fallback_reqs(bool only_kill_custom) { }
+static inline void fw_fallback_set_cache_timeout(void) { }
+static inline void fw_fallback_set_default_timeout(void) { }
 
 static inline int register_sysfs_loader(void)
 {
@@ -1752,7 +1773,6 @@ static void __device_uncache_fw_images(void)
 static void device_cache_fw_images(void)
 {
 	struct firmware_cache *fwc = &fw_cache;
-	int old_timeout;
 	DEFINE_WAIT(wait);
 
 	pr_debug("%s\n", __func__);
@@ -1760,16 +1780,7 @@ static void device_cache_fw_images(void)
 	/* cancel uncache work */
 	cancel_delayed_work_sync(&fwc->work);
 
-	/*
-	 * use small loading timeout for caching devices' firmware
-	 * because all these firmware images have been loaded
-	 * successfully at lease once, also system is ready for
-	 * completing firmware loading now. The maximum size of
-	 * firmware in current distributions is about 2M bytes,
-	 * so 10 secs should be enough.
-	 */
-	old_timeout = loading_timeout;
-	loading_timeout = 10;
+	fw_fallback_set_cache_timeout();
 
 	mutex_lock(&fw_lock);
 	fwc->state = FW_LOADER_START_CACHE;
@@ -1779,7 +1790,7 @@ static void device_cache_fw_images(void)
 	/* wait for completion of caching firmware for all devices */
 	async_synchronize_full_domain(&fw_cache_domain);
 
-	loading_timeout = old_timeout;
+	fw_fallback_set_default_timeout();
 }
 
 /**
-- 
2.16.1
