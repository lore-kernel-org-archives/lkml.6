Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07142C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AB02082C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jEHfLEEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AB02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeIYGaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33720 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIYGaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so6824137pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26HwrhgbY9cvM6kiZxqXmx96X44xA2LItbJkK19GtUc=;
        b=jEHfLEEmvCHoHpdkX18SYepWqOJD5LRyua7XSGQhGp2ygtqjv/oHu8rVpid8kjPMBY
         L1R3EvDuejeJXG60ENlSUInWBdp0v0wvMJpEPpDd5zVtE/X8nJgieCMqIcZ0ast6c1vQ
         BXIzX1Wxjs2z5WzbNhL6qkL/wytvy11EK7NB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26HwrhgbY9cvM6kiZxqXmx96X44xA2LItbJkK19GtUc=;
        b=Rsq+JnH/44AO1dmtd8dzdj/5WvFm5ZnC22INKna51kNgYrwATBwj0mlt6OBLdbJVV8
         iRNDE0wIQG3XsnE13X/dlbMQjXFHmF+Sci0VOjziGu9hltOfIMxsN1KI/X8woHtgMSty
         hKHensCronaG93Kuo5X/+/7tPdE/DIZ/pypklYRdWZR5ZgR682ihRBdw6IqQSiDY68og
         vbPeSfgZyacGPJISo6NAwlyndZJwwPGrP133VacSkf3/PPL9IbKMbEYg3iEYxldQwCyA
         NkaXmWV6H9HbK139K58KSMAc58aClgwsjTDsuJyx1wTd0HxOjcA/kLLCAtb30nT3OGUD
         4oJA==
X-Gm-Message-State: ABuFfohsomWOTsodfE9zIx3Gd8paajIRqv3VnUM6AfXe9QMgcFIaW2Z4
        2iz1cJeUr3teHCXacQvuXFC39w==
X-Google-Smtp-Source: ACcGV63ugphL4k+l4lCbKf1vYeL+nBWs/NoSCC1/5e65OIcYkG38MwZn7jzbPEayozc7XA4wdDAgfQ==
X-Received: by 2002:a63:c912:: with SMTP id o18-v6mr885994pgg.331.1537835117337;
        Mon, 24 Sep 2018 17:25:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 3-v6sm683002pfq.10.2018.09.24.17.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:16 -0700 (PDT)
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
Subject: [PATCH security-next v3 25/29] Yama: Initialize as ordered LSM
Date:   Mon, 24 Sep 2018 17:18:28 -0700
Message-Id: <20180925001832.18322-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 7 ++++++-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9df08955f684..5be95c6155b4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,10 +2092,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index e20c2a3143e7..e37de9a44747 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -293,7 +293,7 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "loadpin,integrity"
+	default "yama,loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/security.c b/security/security.c
index cb25f321e044..c4ba5832ef2f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -304,7 +304,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..f2b1f47f98e8 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,14 @@ static void __init yama_init_sysctl(void)
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
+DEFINE_LSM(yama)
+	.init = yama_init,
+END_LSM;
-- 
2.17.1

