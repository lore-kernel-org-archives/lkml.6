Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB87C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050E12098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j40WdLdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050E12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeIYGYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:24:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36712 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIYGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so10118371pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FC/QKfEJBIYGajENgFeOjr6c8O9WQvcgfsZ6DqAb1iY=;
        b=j40WdLdyIbYENYwIgFmEWOcifIjaAw3581c2wJaONAih3gdzAeKVhQgA+Bvqc2OX20
         jKeeiiqKlVVGo8An0aCZmJhCN+/At8m4VHwgn0lUvvdJ+EGOvVFTOSwI3nTXgCdrgiTl
         FEq0mmGCl1eLkJ5DYIwwtWnSe3WTyYlbUfI7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FC/QKfEJBIYGajENgFeOjr6c8O9WQvcgfsZ6DqAb1iY=;
        b=sc7n/uIZ0J44HeGpLmwwDJfef3umk7FgCa0F+mqTSbp2PMkjOW7hn+Q+vjtY5bQHN8
         TEs08mhPBwee7HFh4RH8Qgp/PFRB7wxQ6/g2cLb+TsCnj1MCMiWo5mny0mdouCX4yoWk
         /qISJpYzo1gk5SfvA2S2uwG5FzW5leJpGW0UX/a58Wt1TuxOomZvtYY4z+Hi9GGa0pMd
         Sem7q24JbOTmdybSeg9XwWhq9lii0LuqsWi6gCajZ8N5OhOQKogc2xJkz/W0Rjeq+gd/
         flt+5qdjyBf0MnTSsOXjBclck9kOInCuDREflqEIVayAc24pJKBR+TOvebIsHGMDCRq2
         01hA==
X-Gm-Message-State: ABuFfoiEaWUAJXK3+qhkJ47P8xEjFc+QH75Td27Npwkd3huebrqQbpD7
        OpZaGPdbWdI+zBe9nXa+Aq30bw==
X-Google-Smtp-Source: ACcGV61+0XKAShS9YXtlV6HhqybC8QtIfXfrmmicSAk/xG9Q3GAK6Gdii1Yz7F+YokNmEQOnsOtcIQ==
X-Received: by 2002:a62:69c9:: with SMTP id e192-v6mr981027pfc.35.1537834737132;
        Mon, 24 Sep 2018 17:18:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b73-v6sm661299pfj.93.2018.09.24.17.18.48
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
Subject: [PATCH security-next v3 27/29] capability: Initialize as LSM_ORDER_FIRST
Date:   Mon, 24 Sep 2018 17:18:30 -0700
Message-Id: <20180925001832.18322-28-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts capabilities to use the new LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 8 +++++++-
 security/security.c       | 9 ++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b38902ea0be5..950042fb2385 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2098,6 +2098,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern void __init capability_add_hooks(void);
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 2e489d6a3ac8..7a6abaec65de 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1366,10 +1366,16 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
-void __init capability_add_hooks(void)
+static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
 				"capability");
+	return 0;
 }
 
+DEFINE_LSM(capability)
+	.order = LSM_ORDER_FIRST,
+	.init = capability_init,
+END_LSM;
+
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 8b93afa75e3c..ade74b90b73c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -62,6 +62,10 @@ static bool debug __initdata;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
+	/* LSM_ORDER_FIRST is always enabled. */
+	if (lsm->order == LSM_ORDER_FIRST)
+		return true;
+
 	if (WARN_ON(!lsm->enabled))
 		return false;
 
@@ -314,11 +318,6 @@ int __init security_init(void)
 	/* Figure out which LSMs are enabled and disabled. */
 	prepare_lsm_enable();
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	capability_add_hooks();
-
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
 	ordered_lsm_init();
-- 
2.17.1

