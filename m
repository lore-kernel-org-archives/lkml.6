Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPvmzxBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC09420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeILT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:29:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:29:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so1087666pff.11;
        Wed, 12 Sep 2018 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIYZkmlAKW9DXMB6mufGujz5hO7WeUIoyhtH0q4lSLQ=;
        b=YPvmzxBJhYf5HKpBTs729PIKgHbXuY/xWQKCme8njWS96JEpC3gPuIhbj9XPGhtCai
         W0VCj0Nm9qaQxiuUhrGdTZpeqb2UFDkGry4YFZ0v2EKgONm6DaxhQaqb+EBIMa/xP0qd
         UAS7Dzz49I9ZnbRtBzDagzTG5eqyv7htmzoIf6kJTN6PNBk+K7G2ZFFULUzb8OFwLhXI
         UQBnDZP4/QQsGk18tV3r1km5GJ4kWwHRtZmwJkST3mwV5GwiFOt3CZrOTHKBX3fzzbX4
         OR3L9D6XDbVDAVG3kenJ7Tq4c8L6n05QV9zkSAPUSaSdGJG0N1qofzMPAP/CkDloMVCr
         wPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mIYZkmlAKW9DXMB6mufGujz5hO7WeUIoyhtH0q4lSLQ=;
        b=qi6oqJeVpOL9ZbHTU3zOt+Tq3thYJ2Pstf7hwZuWJvJ51Qc/CLXTAkJBTpuspRI2gT
         bcwv/b4cU9qk2SNEme8MFySLhLhNX4FV9dO78Qk7DgSh/i++TuROiIhAD8651AJvt/Nt
         2aO371TUOimxoka7Dt8t0qVEWnYgUw9y1C8itrmdSWM5Cg0PRtyWdXzj1Rjsg+8go8U+
         qAL022B6ZgnKs8evse1wUnruog9L8u+jitegNZhIIeWWepLp7C6bidCqqetJp2rTUOD/
         ctdIhuHMeaFT6owj2MkXYHiuIxWuze5IXp47sRPJ1Yba67yBMykYfxZJ9FNLcyB5So2R
         6+CA==
X-Gm-Message-State: APzg51Cy+wJNYfP7SGLDC70OfIfaantLJQAP2sSW5DL+xi/KEaqqx1dV
        sXzY0XddkVs1jks08tHz/Dw=
X-Google-Smtp-Source: ANB0VdYKzuD1pUQJl60qjuklRRBFd35JE2nsu/FxuX2LOgZvn0iSQj7CyujToVoSMVbWj5XSTlITbQ==
X-Received: by 2002:a63:d401:: with SMTP id a1-v6mr2624849pgh.414.1536762308735;
        Wed, 12 Sep 2018 07:25:08 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2124213pgi.87.2018.09.12.07.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:25:08 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 5/5] PM / hibernate: An option to request that snapshot image must be authenticated
Date:   Wed, 12 Sep 2018 22:23:37 +0800
Message-Id: <20180912142337.21955-6-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180912142337.21955-1-jlee@suse.com>
References: <20180912142337.21955-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel option is similar to the option for kernel module signature
verification. When this option is unselected, kernel will be tainted by
restored from a snapshot image without (valid) signature.

When the option is selected, kernel will refuse the system to be restored
from a unauthenticated image. The hibernation resume process will be stopped
, the snapshot image will be discarded and system just boots as normal.

The hibernation can be triggered without snapshot master key when this
option is unselected. But kernel will be tainted after hibernation resume.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++
 include/linux/kernel.h                          |  3 +-
 kernel/panic.c                                  |  1 +
 kernel/power/Kconfig                            | 11 +++++++
 kernel/power/hibernate.c                        |  8 +++--
 kernel/power/power.h                            |  5 ++++
 kernel/power/snapshot.c                         | 40 +++++++++++++++++++++++--
 kernel/power/user.c                             |  2 +-
 8 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 970d837bd57f..c4be29103865 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3941,6 +3941,12 @@
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		enforce_auth	When HIBERNATION_ENC_AUTH is set, this means
+				that snapshot image without (valid) signature
+				will fail to restore.
+				Note that if HIBERNATION_ENC_AUTH_FORCE is
+				set, that is always true, so this option does
+				nothing.
 
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..61714489cb57 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -598,7 +598,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_UNSAFE_HIBERNATE		18
+#define TAINT_FLAGS_COUNT		19
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..624eb1150361 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -327,6 +327,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_UNSAFE_HIBERNATE ]	= { 'H', ' ', true },
 };
 
 /**
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7c5c30149dbc..3c998fd6dc4c 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -90,6 +90,17 @@ config HIBERNATION_ENC_AUTH
 	  master key of hibernation. The TPM trusted key depends on TPM. The
 	  security of user defined key relies on user space.
 
+config HIBERNATION_ENC_AUTH_FORCE
+	bool "Require hibernate snapshot image to be validly signed"
+	depends on HIBERNATION_ENC_AUTH
+	help
+	  This option will prevent that a snapshot image without (valid)
+	  signature be restored. Without this option, a unauthenticated
+	  snapshot image can be restored but the restored kernel will be
+	  tainted. Which also means that the hibernation can be triggered
+	  without snapshot key but kernel will be tainted without this
+	  option.
+
 config ARCH_SAVE_PAGE_KEYS
 	bool
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 79f4db284126..70a0d630a6c2 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -272,11 +272,11 @@ static int create_image(int platform_mode)
 	int error;
 
 	error = snapshot_prepare_hash(false);
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		return error;
 
 	error = snapshot_prepare_crypto(false, true);
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		goto finish_hash;
 
 	error = dpm_suspend_end(PMSG_FREEZE);
@@ -708,7 +708,7 @@ int hibernate(void)
 	}
 
 	error = snapshot_key_init();
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		return error;
 
 	error = snapshot_create_trampoline();
@@ -1251,6 +1251,8 @@ static int __init hibernate_setup(char *str)
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
+	} else if (!strncmp(str, "enforce_auth", 10)) {
+		snapshot_set_enforce_auth();
 	}
 	return 1;
 }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index d2fc73b2e200..edb63991bcdc 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -36,6 +36,7 @@ struct swsusp_info {
 struct trampoline {
 	bool snapshot_key_valid;
 	int sig_verify_ret;
+	bool enforce_auth;
 	u8 snapshot_key[SNAPSHOT_KEY_SIZE];
 } __aligned(PAGE_SIZE);
 
@@ -51,6 +52,8 @@ extern int snapshot_prepare_crypto(bool may_sleep, bool create_iv);
 extern void snapshot_finish_crypto(void);
 extern int snapshot_prepare_hash(bool may_sleep);
 extern void snapshot_finish_hash(void);
+extern void snapshot_set_enforce_auth(void);
+extern int snapshot_is_enforce_auth(void);
 /* kernel/power/snapshot_key.c */
 extern int snapshot_key_init(void);
 extern bool snapshot_key_initialized(void);
@@ -65,6 +68,8 @@ static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { retu
 static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
+static inline void snapshot_set_enforce_auth(void) {}
+static inline int snapshot_is_enforce_auth(void) { return 0; }
 static inline int snapshot_key_init(void) { return 0; }
 static inline void snapshot_key_trampoline_backup(struct trampoline *t) {}
 static inline void snapshot_key_trampoline_restore(struct trampoline *t) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index dd176df75d2b..803340dfe8ef 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1537,6 +1537,23 @@ static int decrypt_data_page(void *encrypted_page)
 	return ret;
 }
 
+/* enforce the snapshot to be signed */
+#ifdef CONFIG_HIBERNATION_ENC_AUTH_FORCE
+static bool enforce_auth = true;
+#else
+static bool enforce_auth;
+#endif
+
+void snapshot_set_enforce_auth(void)
+{
+	enforce_auth = true;
+}
+
+int snapshot_is_enforce_auth(void)
+{
+	return enforce_auth;
+}
+
 /*
  * Signature of snapshot image
  */
@@ -1603,6 +1620,8 @@ int snapshot_prepare_hash(bool may_sleep)
 	crypto_free_shash(tfm);
 	s4_verify_digest = NULL;
 	s4_verify_desc = NULL;
+	if (!enforce_auth)
+		ret = 0;
 	return ret;
 }
 
@@ -1664,6 +1683,8 @@ int snapshot_image_verify_decrypt(void)
 		pr_warn("Signature verification failed: %d\n", ret);
  error:
 	sig_verify_ret = ret;
+	if (!enforce_auth)
+		ret = 0;
 	return ret;
 }
 
@@ -1751,6 +1772,7 @@ static void load_signature(struct swsusp_info *info)
 
 static void init_sig_verify(struct trampoline *t)
 {
+	t->enforce_auth = enforce_auth;
 	t->sig_verify_ret = sig_verify_ret;
 	t->snapshot_key_valid = snapshot_key_valid;
 	sig_verify_ret = 0;
@@ -1759,11 +1781,25 @@ static void init_sig_verify(struct trampoline *t)
 
 static void handle_sig_verify(struct trampoline *t)
 {
-	if (t->sig_verify_ret)
+	enforce_auth = t->enforce_auth;
+	if (enforce_auth)
+		pr_info("Enforce the snapshot to be validly signed\n");
+
+	if (t->sig_verify_ret) {
 		pr_warn("Signature verification failed: %d\n",
 			t->sig_verify_ret);
-	else if (t->snapshot_key_valid)
+		if (t->snapshot_key_valid)
+			pr_warn("Did not find valid snapshot key.\n");
+		/* taint kernel */
+		if (!enforce_auth) {
+			pr_warn("System resumed from unsafe snapshot - "
+				"tainting kernel\n");
+			add_taint(TAINT_UNSAFE_HIBERNATE, LOCKDEP_STILL_OK);
+			pr_info("%s\n", print_tainted());
+		}
+	} else if (t->snapshot_key_valid) {
 		pr_info("Signature verification passed.\n");
+	}
 }
 #else
 static int
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d5c8f777e8d8..9597f48f01d0 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -261,7 +261,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		error = snapshot_key_init();
-		if (error)
+		if (error && snapshot_is_enforce_auth())
 			return error;
 		error = snapshot_create_trampoline();
 		if (error)
-- 
2.13.6

