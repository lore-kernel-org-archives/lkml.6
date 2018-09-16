Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F0ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C921477
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYdbjjnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIPFwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44485 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeIPFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so5918885pff.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Q3mcDF1Iy+AcAiBKA1xOkax77BkrDyqj4tYhY6FxOU=;
        b=OYdbjjnP+4pUdSlKS3IllhrM6tfxmk8S05p1bdi2Clng4x+WiVYoYSyp16do6zrazv
         I48L5xu4zB+bQ/LQivc+/JS5+BgnvPs0rhrLCGnRmgwvgBUSEidI74LCH1AnK9vYvGr7
         4KhkJ6vyOm1/NKO+gSuvFehqWx+v4qldOVoyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Q3mcDF1Iy+AcAiBKA1xOkax77BkrDyqj4tYhY6FxOU=;
        b=NgxqIAHJjcrdwv0589kLVv27XNK49h32uRLQXiimDlnkhcU+w22aCX0qy0jr9BLVWq
         HDhTYKIcrRmtKe1To6y6NEiGGAOS56wOf4s0ujs1tkJqyVP1vEuYzS04ezBR6JTtopPp
         GK2UkEtiS+A7ASKkwYKtuu74xBVBWbZWS0VVDJctfJ/XZxuaBTuM6QDwEpyBni8ZNQ/T
         ckEIbXPffYlR2qsqrJA3axq9vfFZCGYDXqkqp+uPdn+/EZwpKSHnU8GBGbA9dYWEI2Ub
         jweTNjK+xZYW8DaYlIJqqBOZRG2cjUG7k7aepLzAKA6yDmJUKT190vm/6K1Sgg5PHBDQ
         URaw==
X-Gm-Message-State: APzg51BFDHybGHxYtQIZYXYnSeuvAYULL4aDXZ52I8pwCQTp76x8H1Q9
        Ssa766SzFP4TOlA9bQ7JvrO10w==
X-Google-Smtp-Source: ANB0VdYfNB49UnJN4Z2Wa6bYXlH4fBOWNXZuvmQ3adQGPnsgsWjbxGp8XdbzYKX0en0x7xwmLSe8NQ==
X-Received: by 2002:a63:8f17:: with SMTP id n23-v6mr15987784pgd.131.1537057875922;
        Sat, 15 Sep 2018 17:31:15 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j27-v6sm20611906pfj.91.2018.09.15.17.31.08
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
Subject: [PATCH 13/18] LoadPin: Initialize as LSM_TYPE_MINOR
Date:   Sat, 15 Sep 2018 17:30:54 -0700
Message-Id: <20180916003059.1046-14-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts LoadPin to use the new LSM_TYPE_MINOR marking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/loadpin/loadpin.c | 11 +++++++++--
 security/security.c        |  1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 89e6ec8eac07..5e0ca4a05091 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2107,10 +2107,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 0716af28808a..8798d0b9b8e9 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,12 +184,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
-	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
+	pr_info("ready to pin\n");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin)
+	.enabled = &enabled,
+	.type = LSM_TYPE_MINOR,
+	.init = loadpin_init,
+END_LSM;
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enabled, int, 0);
 MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
diff --git a/security/security.c b/security/security.c
index 19afd7949426..65d7ba1bc1ef 100644
--- a/security/security.c
+++ b/security/security.c
@@ -126,7 +126,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 	lsm_init(LSM_TYPE_MINOR);
 
 	/*
-- 
2.17.1

