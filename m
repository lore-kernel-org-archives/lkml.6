Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E35C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AEB2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7C8Opx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AEB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeIYGXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeIYGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so9911196pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgFNpibwNAtwiWO+o4W2d+eAEj/HAaJpud3NKmHQw+E=;
        b=T7C8Opx6VNnjvVzCxlQNN9r6sRRiTnI0CoBLWyvjA7d7xey3DUxmugdkdi1lNFhqkE
         gNAcn2P+7s98L84rFjurmYR5TrqSWxwmiaw/jKajSHO8g9wr8bU/E55oW43pnv/Adbt9
         NIJYJkeJRfBI9Uhdv5hd/oDpVQNjmb0PjNQzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgFNpibwNAtwiWO+o4W2d+eAEj/HAaJpud3NKmHQw+E=;
        b=UqXKINB8CZ8sYgwg2XFDZELavcJWj0m1QmfdUEaxdb26O7ifNsBKhvvz7t6leKElvl
         ZsgWg1bGHZEo7P+otWqGnd7il1ehcdNQbZtPPma34mGmo4KuBbq5asWIWiat5K55RYLH
         J72Ner1RL3LTAFbJsNEXaCc9P4WN0G+VNF0OOqofQKw01XinzeG7OFmND3Fdg/44c2/l
         dWlb1FsvmzZJJVfW13Sr8P0b/crQxwaPFhNN+4haarPzejZFLhPhmsqnoSzmadwg93WG
         6vyTQISLsviRhg5NbB3de/VxYmOGYA6bqCdcDt7aGwQiQ2gnU0WCgkGnV6Ty4hwhG/nm
         82ug==
X-Gm-Message-State: ABuFfogEa/AFxhsK7XVBLNZ1vm/tr6SF6uNy1uegmg0o2mWnCfVTkMEe
        +YVwcFlSNbHS9RU/6ma4l77hPw==
X-Google-Smtp-Source: ACcGV61+ILWzXzJ7p18z0i50bkVYUAE7SI3LrlETBZ0uCz2GaNhk1wuexwpSDH+kPhxGHZ01O0xKHQ==
X-Received: by 2002:a63:1f0a:: with SMTP id f10-v6mr888903pgf.313.1537834733397;
        Mon, 24 Sep 2018 17:18:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k3-v6sm903594pfk.60.2018.09.24.17.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 15/29] LSM: Lift LSM selection out of individual LSMs
Date:   Mon, 24 Sep 2018 17:18:18 -0700
Message-Id: <20180925001832.18322-16-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a prerequisite to adjusting LSM selection logic in the future, this
moves the selection logic up out of the individual major LSMs, making
their init functions only run when actually enabled. This considers all
LSMs enabled by default unless they specified an external "enable"
variable.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  1 -
 security/apparmor/lsm.c    |  6 ---
 security/security.c        | 84 ++++++++++++++++++++++++--------------
 security/selinux/hooks.c   | 10 -----
 security/smack/smack_lsm.c |  3 --
 security/tomoyo/tomoyo.c   |  2 -
 6 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2a41e8e6f6e5..95798f212dbf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2091,7 +2091,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d03133a267f2..5399c2f03536 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1542,12 +1542,6 @@ static int __init apparmor_init(void)
 {
 	int error;
 
-	if (!apparmor_enabled || !security_module_enable("apparmor")) {
-		aa_info_message("AppArmor disabled by boot time parameter");
-		apparmor_enabled = false;
-		return 0;
-	}
-
 	aa_secids_init();
 
 	error = aa_setup_dfa_engine();
diff --git a/security/security.c b/security/security.c
index a886a978214a..056b36cf6245 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,33 +52,78 @@ static bool debug __initdata;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static bool __init is_enabled(struct lsm_info *lsm)
+{
+	if (!lsm->enabled || *lsm->enabled)
+		return true;
+
+	return false;
+}
+
+/* Mark an LSM's enabled flag, if it exists. */
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	if (lsm->enabled)
+		*lsm->enabled = enabled;
+}
+
+/* Is an LSM allowed to be initialized? */
+static bool __init lsm_allowed(struct lsm_info *lsm)
+{
+	/* Skip if the LSM is disabled. */
+	if (!is_enabled(lsm))
+		return false;
+
+	/* Skip major-specific checks if not a major LSM. */
+	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		return true;
+
+	/* Disabled if this LSM isn't the chosen one. */
+	if (strcmp(lsm->name, chosen_lsm) != 0)
+		return false;
+
+	return true;
+}
+
+/* Check if LSM should be enabled. Mark any that are disabled. */
+static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_allowed(lsm);
+
+	/* Record enablement. */
+	set_enabled(lsm, enabled);
+
+	/* If selected, initialize the LSM. */
+	if (enabled) {
+		int ret;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
@@ -168,29 +213,6 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
-/**
- * security_module_enable - Load given security module on boot ?
- * @module: the name of the module
- *
- * Each LSM must pass this method before registering its own operations
- * to avoid security registration races. This method may also be used
- * to check if your LSM is currently loaded during kernel initialization.
- *
- * Returns:
- *
- * true if:
- *
- * - The passed LSM is the one chosen by user at boot time,
- * - or the passed LSM is configured as the default and the user did not
- *   choose an alternate LSM at boot time.
- *
- * Otherwise, return false.
- */
-int __init security_module_enable(const char *module)
-{
-	return !strcmp(module, chosen_lsm);
-}
-
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3f999ed98cfd..409a9252aeb6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7133,16 +7133,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
-	if (!security_module_enable("selinux")) {
-		selinux_enabled = 0;
-		return 0;
-	}
-
-	if (!selinux_enabled) {
-		pr_info("SELinux:  Disabled at boot.\n");
-		return 0;
-	}
-
 	pr_info("SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4aef844fc0e2..e79fad43a8e3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4834,9 +4834,6 @@ static __init int smack_init(void)
 	struct cred *cred;
 	struct task_smack *tsp;
 
-	if (!security_module_enable("smack"))
-		return 0;
-
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 528b6244a648..39bb994ebe09 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -540,8 +540,6 @@ static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
 
-	if (!security_module_enable("tomoyo"))
-		return 0;
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-- 
2.17.1

