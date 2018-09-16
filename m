Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50009ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CA6208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BjbEkjjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CA6208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIPFwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45076 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeIPFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so5907531pfo.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zqm+45y3CwqjDH3PNBS+oFC+JGgE2+c9aAZo0Gv2nRM=;
        b=BjbEkjjcXDwOycmGy1HPB6giilzNOuG85J4iIgDv7cSYhIlikd3/HExfLREe96giP3
         lSjbmNq0u3m245BlSen/nNc+1NIn3mRGw6Lj0whd3sneyMjShzhsR60WzsLaz84EfDu5
         RSyKfCkB4aYFCz4Z2Rd32MV9bkJjNfMShhvp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zqm+45y3CwqjDH3PNBS+oFC+JGgE2+c9aAZo0Gv2nRM=;
        b=SmPO4lbs25FsmCdIgWf8PGvLte18xZWPdFPryBeeqYkcX7pXmQ06gsBYNLs2FbSiLS
         digPNXGeL7qXm2uWYKDPpU+orrDIV6Cj/3DEsG/qXVVHKoPFx04vwjN5mawD+xanhSbA
         EljK7D/433/D6LhAZDMk3ZwlSfQorZVCxu9VW3wSJkvY3zrqpmXyUYT86pRmH3rdp+nU
         4g6TymXPvvZHKnYSZQf+1kfZ0I0mlIPuwLnqebqIFREJTuTyY8lWH4Vr+agmgKBBfiE/
         Fzqq0kYzhbFh5FBRG2OZR3YZFYCfsQ3xpNRuO53C2L4Fz+xp7RuULkDJdn/M8ATmXXm8
         T+OQ==
X-Gm-Message-State: APzg51B0ebuWRU8/B7PTOy9oDUoNHQ58j0IMaF4p7ALMmKEm+bzbWQrQ
        xfxlG2KxD3j81As8OBT/1p9Wrg==
X-Google-Smtp-Source: ANB0VdYZRUFUCBVifNyQyf+lFAYbSeDvSUMm38ouS+NA8SeI8e7eUA2f/puYmLvBMlns9ezIhVgqSw==
X-Received: by 2002:a63:3f45:: with SMTP id m66-v6mr17636170pga.51.1537057877690;
        Sat, 15 Sep 2018 17:31:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h20-v6sm12346360pgg.3.2018.09.15.17.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:14 -0700 (PDT)
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
Subject: [PATCH 14/18] Yama: Initialize as LSM_TYPE_MINOR
Date:   Sat, 15 Sep 2018 17:30:55 -0700
Message-Id: <20180916003059.1046-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts Yama to use the new LSM_TYPE_MINOR marking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 5 -----
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 8 +++++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5e0ca4a05091..0564153130c8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2102,10 +2102,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 65d7ba1bc1ef..c6ca07fc0771 100644
--- a/security/security.c
+++ b/security/security.c
@@ -125,7 +125,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 	lsm_init(LSM_TYPE_MINOR);
 
 	/*
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..e970917926d9 100644
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
+DEFINE_LSM(yama)
+	.type = LSM_TYPE_MINOR,
+	.init = yama_init,
+END_LSM;
-- 
2.17.1

