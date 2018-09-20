Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D79C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED732147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cA2l9yp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED732147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeITWNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:13:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbeITWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:13:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so4609873pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1R3OyL5qZwtVctuoKGY5KtAiw4R0ChLxsIprVubIdKY=;
        b=cA2l9yp59kBSM66Ek4dMpVBzmjS7OG6j+25ylPsFYwXzqkxEtpMvK6SDkZX3dOIcIu
         mrm1eg624plsw7/ZZKLEZnBJbvTnhPCkZQYgZLEKEgHngwO8enaDtRK5tTaC1emHaP5x
         YcwoB9yIPKsJV2Tg/RHhGh/a4OEeQ/q3PVUl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1R3OyL5qZwtVctuoKGY5KtAiw4R0ChLxsIprVubIdKY=;
        b=a6EMGg5rFmEsc3Jh1SeoB3q5C37I3n+i/cI8z9QORroyUyl+3S2W2+99jb0qsjIOXp
         /kXBd6lfv+vebzR8t/bk5FnNsDsJnPPDiUzKKfhCcsv0ehyS0lvyX/mxtCdDFB3DBLWx
         SGueRkni81Fzb5r//soJPHjp0JbxQa6T9rxbKamQa4GWf8+fx9Dct4T1YPGC0UpiL+Nz
         yLKh4lgGlFcC/k+rN4M78dIQkFGLQHmh4pd12J7J3dfGO1PtueziTYPuGogpmxzPMDIr
         kVGOuXBS8SnwKdsrcij97DDj6j9d/exRzjo/M2lXTRySSz1EmrrOHMRyIErNBvTiobuR
         OSzw==
X-Gm-Message-State: APzg51CpO4dRfB87GVBJ1VOsOFbGrPkMulIniYdqFCNz7UWzTOTv6uHX
        DoVi4KlA3PQb2nw9QNwcHq2Uzw==
X-Google-Smtp-Source: ANB0VdaCGJFsG0abGS3ayfdSrynwn6t5dkQ3yO8PdUO2g3QQMkoeUCg4ag80XRiM4VXRM9lKq9+dNg==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr38007537pgq.174.1537460975559;
        Thu, 20 Sep 2018 09:29:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 77-v6sm30867694pga.40.2018.09.20.09.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:29:34 -0700 (PDT)
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
Subject: [PATCH security-next v2 24/26] capability: Mark as LSM_ORDER_FIRST
Date:   Thu, 20 Sep 2018 09:23:36 -0700
Message-Id: <20180920162338.21060-25-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts capabilities to use the new LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 8 +++++++-
 security/security.c       | 5 -----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bf29851baf47..8e843eaacffb 100644
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
index d649e7dea4c4..a40e938db1b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -259,11 +259,6 @@ int __init security_init(void)
 		}
 	}
 
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

