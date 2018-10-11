Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6EC46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFA20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aswPjPNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CFA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJKHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44733 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJKHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id p25-v6so3289255pli.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=piFJbUUnA3DqTyvccR0Ze8PG9upbNm6UGtvVT6YJ0+U=;
        b=aswPjPNs9bK0tyjPisDP2i0c3HxiZJd9dkzq0IXlaPWuNK/z/NLKaysyb/tEQZqYWj
         yuGe5dqHCdG/xOcXFanWAqPLhny9RIpqjtlmHncMmOeuzfPAtcL0wcwGNsgThWiWIPSO
         3SeL8e8kMJ2pbTd18YM/XwjcsAG1VY1VIQRhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=piFJbUUnA3DqTyvccR0Ze8PG9upbNm6UGtvVT6YJ0+U=;
        b=Bby2Sj/ibqVLddRzMSR5AhYZvt7Pt1Sn4qS5OH1vJJXA6cdCBo+nk6m2FMu+MlbPjt
         AuUmArgaosu1eKqaADKmO1NrWOB27gn1q8wN7GYXnZ3PkHgkJgvc2rV4jLofVd4wJt7V
         kE3vg21IUknlMu94Q6rVTUOkniYvfrii0gMeeyM9ZLjnaVTELgZJy5ua6l2k8U1XQuro
         nYfZDKMpdbg3pF82aFWabXKAyo9U3LH9P5ovHH8HdHTMJhkOGjIA5nVdmLglarCCnfkY
         miUmKX+vWnOAQR+rCA0j/ELGyM8Iqm63rdw8wLpwiRXG70EACn9Aal1mHFV00a41qOTf
         ns6A==
X-Gm-Message-State: ABuFfojPOeKk2/VpBRyKLZvFvw++ZrTUsmvKidznqMgANTD8uZKyFYbL
        nzeqTvPTAQDL1EXlGEHGraHcWw==
X-Google-Smtp-Source: ACcGV61GWZ/jEH6+pjl/Cg7EY2qZq9fOqxOtf2HYn5v8u6IR+5Y73sAiWB+W5hGJ2mYIohWFcE/jNQ==
X-Received: by 2002:a17:902:6e17:: with SMTP id u23-v6mr36037411plk.28.1539217556469;
        Wed, 10 Oct 2018 17:25:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c28-v6sm82620821pfk.48.2018.10.10.17.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH security-next v5 28/30] Yama: Initialize as ordered LSM
Date:   Wed, 10 Oct 2018 17:18:44 -0700
Message-Id: <20181011001846.30964-29-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 8 +++++++-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e6893ff9ca2b..833ec0f03795 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2087,10 +2087,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 550bd7032ab2..f2a04f922ede 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -241,7 +241,7 @@ source security/integrity/Kconfig
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
+	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/security.c b/security/security.c
index 6ad1262aa6ab..2eb8afdd945d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -264,7 +264,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..eb1da1303d2e 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,15 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+DEFINE_LSM(yama) = {
+	.name = "yama",
+	.init = yama_init,
+};
-- 
2.17.1

