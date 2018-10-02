Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0797EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6A521471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzWFgJJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6A521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJBHf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40716 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeJBHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:55 -0400
Received: by mail-io1-f67.google.com with SMTP id w16-v6so249445iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yrxg82tWglVpM0LzDO19gBRT76KQ+r+VtAnKxAjxaGw=;
        b=kzWFgJJmS3sGwMbhNznLZsOBUAz1QENcpGjEqbWWNbeSotA3wPZoRBriJAu0E9Hyfy
         +X0HBhlQ2CNggRnx1zBoH/78G01MXdVG4J8UKQlH91ta37YOPNNz1JgV8AyYbsFjOR0q
         smkmCDOOpY3agUDwWCVSy+RWt5tW5t/RCRXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yrxg82tWglVpM0LzDO19gBRT76KQ+r+VtAnKxAjxaGw=;
        b=ArqNK79q5+PQ9FhYWSDzcVt4+7716tTcJnsh7lEhih6hIQEmMv7ZQqxcINsLbVWOCF
         rTPsm1Pi/P0cKjXlBl7BABzjh53+gYt/dt/iNcNIdxNDe/NNhexFWN7YRZ1ayIB/Vn6m
         0o3mDqbfadOM8XOSpFbQD+8ws3LMAqomkla2T7yPQNdH1yc3tEAJ/ta5FfQaONGwlTRI
         no/G0W9cK03xekkTLCE/sc8GPF9Ao6CeNEH6rig5ICppCtxkcGzoYfcoEPTK6MVTyp32
         IxAhGQ7L8H/l53Bd/weMWELiyetmdMag81XIS9xLVZ6hXSFZjV7A1wFdB0R+7N7gAWlD
         lTVg==
X-Gm-Message-State: ABuFfohDACumJ4z+afcUhxIBsvpArQ9Wffu3t/YsXbowoV1QiiUN3p1e
        LSXTt2wuky8Zv3C3JVTuCkK58Q==
X-Google-Smtp-Source: ACcGV60tYDSsVxueUNUrEu7ICAtSzWhk018ow/vF8usOMRG78AX9/hf+xt8NurR8Hd9wvcO+EUwOSA==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10-v6mr14346658plx.209.1538441727304;
        Mon, 01 Oct 2018 17:55:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f29-v6sm28485128pff.29.2018.10.01.17.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:25 -0700 (PDT)
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
Subject: [PATCH security-next v4 30/32] capability: Initialize as LSM_ORDER_FIRST
Date:   Mon,  1 Oct 2018 17:55:03 -0700
Message-Id: <20181002005505.6112-31-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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
 security/security.c       | 9 ++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 62bc230826e0..36e7a716fdfe 100644
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
index dac379518e60..813dab3b5b97 100644
--- a/security/security.c
+++ b/security/security.c
@@ -62,6 +62,10 @@ static __initdata bool debug;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
+	/* LSM_ORDER_FIRST is always enabled. */
+	if (lsm->order == LSM_ORDER_FIRST)
+		return true;
+
 	if (WARN_ON(!lsm->enabled))
 		return false;
 
@@ -306,11 +310,6 @@ int __init security_init(void)
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

