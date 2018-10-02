Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C37C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825F221471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8EI0tWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825F221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJBHfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:52 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35290 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJBHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:51 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so1097505itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Od7O88ILjGHU6yw3qklE8z4x9u6hVSoQhlqZnNDtzvw=;
        b=M8EI0tWVCEDCe+Y+qe+Z/WJI8t7D8im8HfaGvLTdciXrU7LZ9AsjBH9Zg5Zbo8z/wX
         +WnxVKMkc1mk/WkhvIWukkEewzDMDrbNc+IBnsgDqMcds4PxRu9Wfvdz8Z5Kt9CWEWXK
         vc/bqnsc85qE+XNy2JWdhC+ToOTgpHEU9qVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Od7O88ILjGHU6yw3qklE8z4x9u6hVSoQhlqZnNDtzvw=;
        b=lmo1RKDyZ2eP5TDVyq3umxJ/bVv3fr12SnzM2G3i1tMuAKSKlTHF6u4rxdXWnhpgXO
         wP6mokNxBz7a8+mOvxNYuJ9sE2kH8u876Yy6d6UQ6zJbxKa3xt8o4W6mpA5p+L1Kha18
         NwNg9U8I5CIEfpDKtd4dmZGo6Fgb4fu5Y+sJW6acJ3+wVX3sjP4JKPTC1Eb3EnVESzuS
         JY7wUHsSjC8la/NruwtzR07lhdTVbOW4atXlHrpUJF+WGiYo59CkkTf1p6s3kzVQKlCS
         bSazZ2cjrIiRlgAjIKQ3IpV6/an0OYog+h7bntdZQKrmOxZI4XM8Bvuk58fQjLzt0nlA
         vrnQ==
X-Gm-Message-State: ABuFfoiK0w3+QS10cMETYuGbxcME+Y4Kr9NSGRJkXzGoovwLQC9wHFJ3
        qriCwk+YYWtOe3n4+zbRFBOIIw==
X-Google-Smtp-Source: ACcGV61jMH1pvj94hPs6bbPnXVIfG8pjI47Ty8CKBgcn1JixgvGodvLyvI+WGs7IvOdPOr6SJSqFsQ==
X-Received: by 2002:a63:4a64:: with SMTP id j36-v6mr6400775pgl.168.1538441722721;
        Mon, 01 Oct 2018 17:55:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z70-v6sm245317pgd.64.2018.10.01.17.55.13
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
Subject: [PATCH security-next v4 13/32] LoadPin: Rename "enable" to "enforce"
Date:   Mon,  1 Oct 2018 17:54:46 -0700
Message-Id: <20181002005505.6112-14-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoadPin's "enable" setting is really about enforcement, not whether
or not the LSM is using LSM hooks. Instead, split this out so that LSM
enabling can be logically distinct from whether enforcement is happening
(for example, the pinning happens when the LSM is enabled, but the pin
is only checked when "enforce" is set). This allows LoadPin to continue
to operate sanely in test environments once LSM enable/disable is
centrally handled (i.e. we want LoadPin to be enabled separately from
its enforcement).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/loadpin/Kconfig   |  4 ++--
 security/loadpin/loadpin.c | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index dd01aa91e521..8653608a3693 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -10,10 +10,10 @@ config SECURITY_LOADPIN
 	  have a root filesystem backed by a read-only device such as
 	  dm-verity or a CDROM.
 
-config SECURITY_LOADPIN_ENABLED
+config SECURITY_LOADPIN_ENFORCING
 	bool "Enforce LoadPin at boot"
 	depends on SECURITY_LOADPIN
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
-	  "loadpin.enabled=1".
+	  "loadpin.enforcing=1".
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 0716af28808a..d8a68a6f6fef 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -44,7 +44,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
 	kfree(pathname);
 }
 
-static int enabled = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENABLED);
+static int enforcing = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCING);
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
@@ -60,8 +60,8 @@ static struct ctl_path loadpin_sysctl_path[] = {
 
 static struct ctl_table loadpin_sysctl_table[] = {
 	{
-		.procname       = "enabled",
-		.data           = &enabled,
+		.procname       = "enforcing",
+		.data           = &enforcing,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
@@ -97,7 +97,7 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 					   loadpin_sysctl_table))
 			pr_notice("sysctl registration failed!\n");
 		else
-			pr_info("load pinning can be disabled.\n");
+			pr_info("enforcement can be disabled.\n");
 	} else
 		pr_info("load pinning engaged.\n");
 }
@@ -128,7 +128,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 	/* This handles the older init_module API that has a NULL file. */
 	if (!file) {
-		if (!enabled) {
+		if (!enforcing) {
 			report_load(origin, NULL, "old-api-pinning-ignored");
 			return 0;
 		}
@@ -151,7 +151,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 		 * Unlock now since it's only pinned_root we care about.
 		 * In the worst case, we will (correctly) report pinning
 		 * failures before we have announced that pinning is
-		 * enabled. This would be purely cosmetic.
+		 * enforcing. This would be purely cosmetic.
 		 */
 		spin_unlock(&pinned_root_spinlock);
 		check_pinning_enforcement(pinned_root);
@@ -161,7 +161,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	}
 
 	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
-		if (unlikely(!enabled)) {
+		if (unlikely(!enforcing)) {
 			report_load(origin, file, "pinning-ignored");
 			return 0;
 		}
@@ -186,10 +186,11 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 
 void __init loadpin_add_hooks(void)
 {
-	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
+	pr_info("ready to pin (currently %senforcing)\n",
+		enforcing ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
-module_param(enabled, int, 0);
-MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
+module_param(enforcing, int, 0);
+MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
-- 
2.17.1

