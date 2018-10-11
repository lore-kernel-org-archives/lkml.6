Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B53C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8213F20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QqnvfrjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8213F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJKHvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:51:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35609 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJKHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so3286710pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQdgKCn/bUcvd4Br0t1av29yxKn0HH2crs0trsCjZig=;
        b=QqnvfrjOuLJL+o80kwEM6qYiHn0sy8kw7gXZmCstlzgpaTG3KZqajuzVHpQ0/sFT0M
         GgwrOaDxSW0Xk6DbnGFZzipweTUnxmQFulXD04QsigOvs+4JBeRDO9OmXboeZJzJXmlT
         9fcx7z5VGj2C7HVs1qfcfubyZJhpic6HWpYhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQdgKCn/bUcvd4Br0t1av29yxKn0HH2crs0trsCjZig=;
        b=GSIF+eiFcI1vB9+8cnD3AJDxd99g9m1cwYysL4HCwQKEjNKDCXO9nOK9J+U5hskSpx
         68F31/aDvQqN/ed/YV1N0ZHB9BPoTFR2TLHJ4wgj3UIiGnjG7GF9ge5BNWDOKzoSIZ92
         BeX6IoNtFuTGgMXZH4lqzcfqWSbqtaHkeZ2JLFmI0cVctnUqqxxYzJHYc37nJt1SGoSw
         VEdh+ODxpOIVjGZny0xTOP6cg1jNfdR1D+PK7FPvu9DOSnTiu4Qeo0PG1r4rjGRzOuba
         pVfm9QILZuy8JrPApdEZ6lhsP5LTr2s1WE0V1/pbXkblaLuHchueUecMM/5RY43J8P6U
         jNdA==
X-Gm-Message-State: ABuFfohXEbQ18Wf4k2ARNNIungbFq7wleEqrIGiWvb5YIB8fd/bATLPB
        zlGh2FQFV8CTSjAyJyk2EDnfen5Icf8=
X-Google-Smtp-Source: ACcGV60OeEfa3KCZ/kUGezk7hN7oOaeQIOP2MjQZBjsY8UYfF8TYdVII5lAGVX0MQzYl/ny4PdjmOQ==
X-Received: by 2002:a62:d40d:: with SMTP id a13-v6mr37693607pfh.23.1539217554665;
        Wed, 10 Oct 2018 17:25:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t64-v6sm35947232pfb.44.2018.10.10.17.25.48
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
Subject: [PATCH security-next v5 27/30] LoadPin: Initialize as ordered LSM
Date:   Wed, 10 Oct 2018 17:18:43 -0700
Message-Id: <20181011001846.30964-28-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 -----
 security/Kconfig           | 2 +-
 security/loadpin/loadpin.c | 8 +++++++-
 security/security.c        | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e88c725a43b8..e6893ff9ca2b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,10 +2092,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 2f8dc1f59cae..550bd7032ab2 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -241,7 +241,7 @@ source security/integrity/Kconfig
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "integrity,selinux,smack,tomoyo,apparmor"
+	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index a2dc146b6364..640d9c69cf2e 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,13 +184,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin) = {
+	.name = "loadpin",
+	.init = loadpin_init,
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index b40c4c212892..6ad1262aa6ab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -265,7 +265,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
-- 
2.17.1

