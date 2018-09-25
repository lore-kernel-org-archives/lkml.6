Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21171C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D027020C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCVgRcnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D027020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIYGaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41585 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeIYGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so1224943pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pya6MC5far/FOfcushoRqmIT4FUPYgdqjyBKbeVxUoc=;
        b=UCVgRcncAb7cIHCs1DGQLChJ9vknqvr/KNTZmJDV0LdfEJZVVSzD0shsoQEJqe4PXs
         UwUKLSseT07JL4uz0zHBV/9Cr9zChAdT+lUVenHyPtM4SBk4R7WFHN9YiF2IFf3WNuZP
         U7JVbVyivOeCwc8DrjTpiDsGGtbIWs3Baj5WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pya6MC5far/FOfcushoRqmIT4FUPYgdqjyBKbeVxUoc=;
        b=i4uKUCBvJcKFZLC7RI+F67RnoWzxxuNnGTuC8QAJ418pqwNEUf2Y9UoLuS2qTCTXo/
         0p2C3aKvjuOCRnNF6sCDy6xI8RsdvuIXBXL7/H71wqFcD+7Pv20hjiVIgfSvZquWEAyY
         ZxPGNpLF8hpo4gwlzrB57chkspWbQ9XuCTTaL2a20Xu5v+Bp7XkdootLalZpXo22wzEH
         G6SxJx21pKf4oklVvuGNAcnPL/OQ7fOHiTD7MMh525mDQCe4sg7vyOCEYZo1WMIZCuuh
         WdkUi8f4nlCqzhu+PGbSUp73NXhSgGzO8fuxg9TIT8rsJfZ4xRz0TqUo5yeKGXt+TGJW
         mcyg==
X-Gm-Message-State: ABuFfog7jqRoyKt0XOqOqJa28uzTZTcfb93VbhfgnjVN59xBKlljPUy1
        Etsqp7WPG5p4PZt410KZUb0WwA==
X-Google-Smtp-Source: ACcGV61imBdMwuASY8sKrVNwy7MU0PyosXE4NK2RARP8Q0lXckzuclV+DhQ1RewxW4ZTB/zjK+qb0A==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr1024051pfk.92.1537835119907;
        Mon, 24 Sep 2018 17:25:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e123-v6sm635695pfg.3.2018.09.24.17.25.15
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
Subject: [PATCH security-next v3 24/29] LoadPin: Initialize as ordered LSM
Date:   Mon, 24 Sep 2018 17:18:27 -0700
Message-Id: <20180925001832.18322-25-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  | 5 -----
 security/Kconfig           | 2 +-
 security/loadpin/loadpin.c | 7 ++++++-
 security/security.c        | 1 -
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ab23f1bc6d77..9df08955f684 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2097,10 +2097,5 @@ extern void __init yama_add_hooks(void);
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
index 7ec86dbdb6b8..e20c2a3143e7 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -293,7 +293,7 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "integrity"
+	default "loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d8a68a6f6fef..7abdf4619b46 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,13 +184,18 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforcing ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin)
+	.init = loadpin_init,
+END_LSM;
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforcing, int, 0);
 MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index f1c3581d870f..cb25f321e044 100644
--- a/security/security.c
+++ b/security/security.c
@@ -305,7 +305,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
-- 
2.17.1

