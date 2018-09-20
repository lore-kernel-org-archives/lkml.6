Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE2F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmHSvquy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE2F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeITWJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:09:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbeITWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so4623419pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWzVaz65MKOFvzUCdA5Zt3k9LUCJU0yAHm9/W2sVfrg=;
        b=NmHSvquyVwWM5EYyOaYCn4xms5XkmybqswEuH7T4vmTUdBalpkPS/aBKJwUVml8Rn5
         0htvK+3kZSjLKzyLmiFZVy193Y5iB4FcamsMjX4IbsfUQpsSIsDi4LSfImCgCWrEOgF5
         bKkSvD5dVpruKJr9uMMtm9e5ZIOIl03ARYByU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWzVaz65MKOFvzUCdA5Zt3k9LUCJU0yAHm9/W2sVfrg=;
        b=X+R3MN0qjAmtdlY9YIgSMeAlAE+ILfI6UQOJ+if4yd/5Y+4ZvjzdPA58gmKkvwnR0F
         5CUPI7L39KbAf2+xG2MFIPo7fq0FUZK5qvrC3pnVAwbPGm6VdCW4MylvVhpO4J17fh7g
         wjaLpwU3kE+EsMHZLAbOSVY3Y93nuo33/6TYGWxNSa0RJUhrCghc9Ahi5nIcFRw3Ezca
         iJzrkNKipk85YF/ZwrRP0jT1VWQWmpL56WeD/+Yj1vQ/Ujlq8jEjAizDyYiXrG8NR/Ov
         eY4BF1k07zhojss3vzCzUnYjXLyxN3NchL6oLVbhmDLDAYcPzVNMy975RUwN6X8HsNSn
         9yEQ==
X-Gm-Message-State: APzg51BVlPMA1Y5lspBoOfvNDKqOeo3cwRt+Kh9j8XPsglOkX5y6iF4W
        Vhmn4/V6+sqARdRZ0LEPNzZRWQ==
X-Google-Smtp-Source: ANB0VdbaFQ9OJXKZfLVfGLjFbPuPzWebuyKsGNg0KAvCt6mzDPeOgSE2tm3DcZZCLJpDMuWdLiiHhg==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr37781909pgc.119.1537460629574;
        Thu, 20 Sep 2018 09:23:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p19-v6sm38003864pgk.28.2018.09.20.09.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
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
Subject: [PATCH security-next v2 05/26] LSM: Convert from initcall to struct lsm_info
Date:   Thu, 20 Sep 2018 09:23:17 -0700
Message-Id: <20180920162338.21060-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for doing more interesting LSM init probing, this converts
the existing initcall system into an explicit call into a function pointer
from a section-collected struct lsm_info array.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/init.h      |  2 --
 include/linux/lsm_hooks.h | 12 ++++++++++++
 include/linux/module.h    |  1 -
 security/integrity/iint.c |  1 +
 security/security.c       | 14 +++++---------
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 77636539e77c..9c2aba1dbabf 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -133,7 +133,6 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
 #endif
 
 extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_entry_t __start_lsm_info[], __end_lsm_info[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -236,7 +235,6 @@ extern bool initcall_debug;
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
-#define security_initcall(fn)	___define_initcall(fn,, .lsm_info)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97a020c616ad..ad04761e5587 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,6 +2039,18 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+struct lsm_info {
+	int (*init)(void);
+};
+
+extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+
+#define security_initcall(lsm)						\
+	static struct lsm_info __lsm_##lsm				\
+		__used __section(.lsm_info.init)			\
+		__aligned(sizeof(unsigned long))			\
+		= { .init = lsm, }
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..264979283756 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -123,7 +123,6 @@ extern void cleanup_module(void);
 #define late_initcall_sync(fn)		module_init(fn)
 
 #define console_initcall(fn)		module_init(fn)
-#define security_initcall(fn)		module_init(fn)
 
 /* Each module must use one module_init(). */
 #define module_init(initfn)					\
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 5a6810041e5c..70d21b566955 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
diff --git a/security/security.c b/security/security.c
index 41a5da2c7faf..e74f46fba591 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,16 +43,12 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
-static void __init do_security_initcalls(void)
+static void __init major_lsm_init(void)
 {
-	initcall_t call;
-	initcall_entry_t *ce;
+	struct lsm_info *lsm;
 
-	ce = __start_lsm_info;
-	while (ce < __end_lsm_info) {
-		call = initcall_from_entry(ce);
-		call();
-		ce++;
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm->init();
 	}
 }
 
@@ -82,7 +78,7 @@ int __init security_init(void)
 	/*
 	 * Load all the remaining security modules.
 	 */
-	do_security_initcalls();
+	major_lsm_init();
 
 	return 0;
 }
-- 
2.17.1

