Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84713ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D78D208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jb216WyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D78D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIPFwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so5782895plp.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ff2uCXniP35yOceinbpCsTgz/UM9QN0S8uqhE84wjE8=;
        b=jb216WyHsxVPsMBQCNVAs+o6i3gjvUOjAXzF3tfKSQ1AwYem9gRRSonYvA1d2xn8qx
         Kwl/gfbfpxJ70fF0HjcSiDULLWBjBilQFBgMiyKqjB240Gtyjb3X488uSl6R6vqYbGfw
         G5NSX99o+527m7Z+KT+0GKnVzyT9xoFT7w4RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ff2uCXniP35yOceinbpCsTgz/UM9QN0S8uqhE84wjE8=;
        b=klvt2WDQLH1EVNoHMitUHXZUIWIsvGN3+96XAfzEqmVOOIwUZkaFcYYiPpFKTD29aQ
         iVdFmwc5l5sE80JA2MYjJgkxZaaN7KNPP12xrKHCK9ayF0s1l1ZjrW9eQ/+fH2sD8kac
         07Tw9cNo2wLVpa8s/p1YqVw7Qq24SaJAe2S45dQMEghbUpLevlwLnrYJj936aBjW/g9X
         Q+gTyRr3dRRftfXOaM6jq0aBGbRek5SHKrAokP0pUM4/MiO7CRbpWZwkmsNeWSCtuqmt
         ZhOhAhzG2tZahwX2cZPsj/mRVlWc/I6fTKGMynZqt/aI3HIblSG5YhG/xgkjG3h6AqqP
         glPw==
X-Gm-Message-State: APzg51BeT9bpszdea95u9aqjp/8+a2satjfC9HEdMhsd4hiLGFY9jOPL
        +hYNNLCpi3Hgixxdb1VdAR9cpg==
X-Google-Smtp-Source: ANB0VdYd+iGdFv8UyIKEiydt+NBiF3Lg7A+qpiP125RIvA/eYCyVam91t2a1ojgz0N9fbzG9W6kjIw==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr18505314pld.169.1537057874805;
        Sat, 15 Sep 2018 17:31:14 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j15-v6sm12933689pfn.52.2018.09.15.17.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
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
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/18] LSM: Lift LSM selection out of individual LSMs
Date:   Sat, 15 Sep 2018 17:30:52 -0700
Message-Id: <20180916003059.1046-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to adjust LSM selection logic in the future, this moves the
selection logic up out of the individual LSMs, making their init functions
only run when actually enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  1 -
 security/apparmor/lsm.c    |  6 ---
 security/security.c        | 75 ++++++++++++++++++++++++++------------
 security/selinux/hooks.c   | 10 -----
 security/smack/smack_lsm.c |  3 --
 security/tomoyo/tomoyo.c   |  2 -
 6 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8a3a6cd26f03..6e71e1c47fa1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2094,7 +2094,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6cd630b34c3b..56c0982b48cd 100644
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
index da2a923f2609..3fedbee5f3ec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,13 +43,63 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static struct lsm_info *exclusive __initdata;
+
+/* Mark an LSM's enabled flag, if it exists. */
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	if (lsm->enabled)
+		*lsm->enabled = enabled;
+}
+
+/* Is an LSM allowed to be enabled? */
+static bool __init lsm_enabled(struct lsm_info *lsm)
+{
+	/* Report explicit disabling. */
+	if (lsm->enabled && !*lsm->enabled) {
+		pr_info("%s disabled with boot parameter\n", lsm->name);
+		return false;
+	}
+
+	/* If LSM isn't exclusive, ignore exclusive LSM selection rules. */
+	if (lsm->type != LSM_TYPE_EXCLUSIVE)
+		return true;
+
+	/* Disabled if another exclusive LSM already selected. */
+	if (exclusive)
+		return false;
+
+	/* Disabled if this LSM isn't the chosen one. */
+	if (strcmp(lsm->name, chosen_lsm) != 0)
+		return false;
+
+	return true;
+}
+
+/* Check if LSM should be enabled. Mark any that are disabled. */
+static void __init maybe_enable_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_enabled(lsm);
+
+	/* Record enablement. */
+	set_enabled(lsm, enabled);
+
+	/* If selected, initialize the LSM. */
+	if (enabled) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
+			exclusive = lsm;
+		}
+		lsm->init();
+	}
+}
+
 static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->type == type)
-			lsm->init();
+			maybe_enable_lsm(lsm);
 	}
 }
 
@@ -128,29 +178,6 @@ static int lsm_append(char *new, char **result)
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
index 78b5afc188f3..5478abf51f3a 100644
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
index 1e1ace718e75..6e127c357ca2 100644
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
index a280d4eab456..0471390409c5 100644
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

