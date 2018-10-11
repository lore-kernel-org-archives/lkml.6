Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB0E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EKyGGt0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB0E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJKHu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46114 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJKHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so3263709pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7MAy9mUUeYOMxjwjpwy6gsSU/ScT6gKoTAYP39DmWY=;
        b=EKyGGt0rSKRVrksa4ueW6GHsYaRXgCYj4q0KjP+m+wkKZPKNH5yT42FbOkIELQ1ERS
         rC57Khf/Qiu0U8fYdmIHGZv99rMI9/2oyMttaonvrMCyA7EtVLJ+Nwgvh6pvItnCWsOf
         Sz+6nT4TxBzHHwsf17U09678uG9ZSnhxZZAGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f7MAy9mUUeYOMxjwjpwy6gsSU/ScT6gKoTAYP39DmWY=;
        b=oOsl2oXNUxSNAIKDg2Zl0ZXubCeK28WIt0HHe01PGKUqo5v0Yp+8zDY6hyirkMxJU1
         4vWQWrjuotnDoB7g2uphe5Po6ewwichoYvgqhf/xWPCLwdAkh/NBr7nxFvFj9yGvIsQK
         NZiD8OYlyd4r1Q8sB7dnWSaojtBkhduOLiLs6gPMMeMAQUhE0GWjDmSFmfeMOrIp1b+Z
         eOwq6uCVsJR3NM9DjceIxBwtL+fXApR2i+PaN2vH9cuHdZGUj/RN+1boUCTE8J5lOA4v
         QZxHg0Jj2qIVRqRnZDnw6d07w1pwXrIuURN9xhx3qdHBKNB6Njg334elNlTPTnx0qNvh
         tBAA==
X-Gm-Message-State: ABuFfoiFJBw5JadRBfh7BlXbaWH8r1XJaKyTGlHwpqsLfmwlqAYenUAn
        8wYQsRKJjjiQACRuokg/3TomhQ==
X-Google-Smtp-Source: ACcGV62Mh0fpsW6JhMcZPgXNY6KV/gPsEDH2CbM6vYQ4G2gK3UT02xWAcVWf+GABYsRQKKE6Nxlwuw==
X-Received: by 2002:a63:ed55:: with SMTP id m21-v6mr31611186pgk.147.1539217550287;
        Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n79-v6sm53021033pfk.19.2018.10.10.17.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:45 -0700 (PDT)
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
Subject: [PATCH security-next v5 30/30] capability: Initialize as LSM_ORDER_FIRST
Date:   Wed, 10 Oct 2018 17:18:46 -0700
Message-Id: <20181011001846.30964-31-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts capabilities to use the new LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 9 ++++++++-
 security/security.c       | 5 -----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97898679a505..b728cb448957 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,6 +2092,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern void __init capability_add_hooks(void);
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 2e489d6a3ac8..c928eb3fe784 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1366,10 +1366,17 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
-void __init capability_add_hooks(void)
+static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
 				"capability");
+	return 0;
 }
 
+DEFINE_LSM(capability) = {
+	.name = "capability",
+	.order = LSM_ORDER_FIRST,
+	.init = capability_init,
+};
+
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 004938eb8e70..aa91181133c1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -267,11 +267,6 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	capability_add_hooks();
-
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-- 
2.17.1

