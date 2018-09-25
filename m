Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E09C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289B21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gD7CP7/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeIYGXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbeIYGXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so2107666pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lGcBNu5wBxL18dEuz7PbQ+NY4GN1WXf9BVTSBp/Amas=;
        b=gD7CP7/qxk4zPAjD8lFjJqp5b3bRZEjBAjCCo4wJYbzZ6jajFoJ9+qC5PoG+RKYceb
         bIAUblel0hC5pn560KFzsTLgfvfxc97fW9EflATBw03g+ltasoXope1QyuX7aQseRlBN
         AbojF7Y7heVyyZVkkCenzPK4jse/5tgi48jks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lGcBNu5wBxL18dEuz7PbQ+NY4GN1WXf9BVTSBp/Amas=;
        b=pooXpE2v1GwULerYsrKRT+MR7nVLBd6IzruJ7N3jc9hRH3DwSk4CB0r4TOXjX6sHCA
         wKhmbscYOHD+mC3NOBHl5oNdl0eMaPOdL5oeul2Wu36cn0Pt+VErtxIyy8yBMvNPQwZV
         gBqOVCxuTw5Cmm5SM+nhoM8g7axlPm6rEqaLzdmbHswbB/kv+yVl631G8jD692y01Wqm
         kmtaFba32wUTZ5ZeWbuirxWYx6wm4KNrLrFrW2W+bJOceo7bkxBvbiIesv4D9dL2N2P5
         kiKukBLtH7KSBcm3Ar6vuOpvirLQnHWSXi6mHWdLvZufbavsJWju8qW/toR+1ekluiXR
         giBQ==
X-Gm-Message-State: ABuFfohnl9hBBoNUmZrm2EEp5Pb3lJUZ30GM7sURf7Dv9fnM3gGQKgXW
        ELEs2i6wHpbGG05VO/w1Rx2pRg==
X-Google-Smtp-Source: ACcGV63JzhUOEzLu1scPJiJRgCBlyCBoCC4xIcRXHPWWjBaN8jFqMnbq6Enj9Rr4zHwuY/7uKXDxMg==
X-Received: by 2002:a62:384c:: with SMTP id f73-v6mr1008359pfa.242.1537834731566;
        Mon, 24 Sep 2018 17:18:51 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r19-v6sm495971pgo.43.2018.09.24.17.18.42
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
Subject: [PATCH security-next v3 14/29] LSM: Plumb visibility into optional "enabled" state
Date:   Mon, 24 Sep 2018 17:18:17 -0700
Message-Id: <20180925001832.18322-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This should be an "int" to include
handling any future cases where "enabled" is exposed via sysctl which
has no "bool" type.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5056f7374b3d..2a41e8e6f6e5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
 	unsigned long flags;	/* Optional: flags describing LSM */
+	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4c5f63e9aeba..d03133a267f2 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1608,5 +1608,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor)
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 END_LSM;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 615cf6498c0f..3f999ed98cfd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7204,6 +7204,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux)
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 END_LSM;
 
-- 
2.17.1

