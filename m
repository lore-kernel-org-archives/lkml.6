Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E77EC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFC21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q2zRZPBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AFC21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJBHgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:36:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32824 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeJBHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:51 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so273571ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/DemNszMlxITv06HPl1T5ZcPYVNjEcB12fyRq50PNM=;
        b=Q2zRZPBczNZpkXgSgkRVQYQ/fJ5lbaKKyPQAmtcj9rtnxBm3biUewKOonSNtv46C+h
         UPe83DG7JvWfCj4dOvhEoZV9t/0zCu7UNOOF5fhpViiULPtzLfO7fkBVo94TYsDr7dOz
         d9YAyMV84rNcaEpIJXSi2eNtDkdMzfJwNirpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/DemNszMlxITv06HPl1T5ZcPYVNjEcB12fyRq50PNM=;
        b=at5yqF6Tu4Uf/EImuzX15/hIfLw70Xf+0v0vpIBy5PWxmiuGy1UpxjqTupnYy0mh33
         hoBHcTZaJPw6V068m2OSV09iFZ9jWfkew2AOAVqZr7YPd2a2vRLjFTDUvsy6EjPL6MVU
         +BnRsTOL2p2TZMRjtYQKRfALjLX1Fryy48pVCqENAUUkb0UIvB1S6yu2kn5sKZNb3672
         iWgyTMPdNCs2rg3MCRHe28w4BMyA9Vak+UN7cBSBL4V1+DySTMvZGAQg7l1TWhqgVqS4
         Q2L5NsAIUb7Bje8KsnPz9+OiKrExMpOYQ5+7SJ7g7xtWMfkfH3rYq4X+4z6JVCfLLb6o
         OOHQ==
X-Gm-Message-State: ABuFfoijmOjSlcKXChY22CHdALyqoy75KLWRhPHBdYJVCdfovE4e0/kU
        Mbs/elTo8foe1srkK5Hro2dzVg==
X-Google-Smtp-Source: ACcGV60MlYjgwL4nOcOt7NemM+Xe/pAARgqlMNHzW/xdJrQyTopdusktwPioAi58gECuXIAKkOm8Eg==
X-Received: by 2002:a62:7f8c:: with SMTP id a134-v6mr13805496pfd.257.1538441721882;
        Mon, 01 Oct 2018 17:55:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p13-v6sm1387932pfd.65.2018.10.01.17.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:19 -0700 (PDT)
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
Subject: [PATCH security-next v4 15/32] LSM: Lift LSM selection out of individual LSMs
Date:   Mon,  1 Oct 2018 17:54:48 -0700
Message-Id: <20181002005505.6112-16-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  |  1 -
 security/apparmor/lsm.c    |  6 ---
 security/security.c        | 84 ++++++++++++++++++++++++--------------
 security/selinux/hooks.c   | 10 -----
 security/smack/smack_lsm.c |  3 --
 security/tomoyo/tomoyo.c   |  2 -
 6 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6ec5a0266f21..9ecb623fb39d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2085,7 +2085,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6ace45704cb6..bc56b058dc75 100644
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
index ebbbb672ced5..4e5e67b82b7b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,33 +52,78 @@ static __initdata bool debug;
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
index e8da99550b67..71a10fedecb3 100644
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
index db8bc6b6d8b0..f243044d5a55 100644
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
index 09f7af130d3a..a46f6bc1e97c 100644
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

