Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA44C46464
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB42075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odSYJl5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DB42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJKHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39382 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJKHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so3293489plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i7+WY/jHpzJT6ht0Y+8g3kVgLzl4v3M2OeZZNdpdTfs=;
        b=odSYJl5MVP6b7FO/sh3vvTt0HGfbPxDgszmGZ7afN533sijcINFI5wqsUkHVLRqy5v
         qPCya2I+EUl/w+8ITFfZzhNyyYdO87wueoQ7sLrA2GG1YhgfD15tKk74AKpGSvNOCvXR
         loWdLuY7a+TrOiO9ebUBqA2BRlMGgt8AEX9sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i7+WY/jHpzJT6ht0Y+8g3kVgLzl4v3M2OeZZNdpdTfs=;
        b=rAC2ZiCtKVYWqsUIFEfmCoAr3x0vw+REQVp8kb95oMULmFvJqbC8MnTCP6kYA+qLdb
         q8iHUVKXZ9PKeWnUREJRDuLbkTh+3d+Zru+GgKHppfoHLvpJJFtkqtlGafabsntbMASY
         DOMGrq3QmfW06RW1tV5fnQ8Rij24DbPhXA3q4OTJ8DNcERw9Q0xqva+Lq7vbpTCIbzOW
         pbRmghZ0ZNw4Jt87SNjJzJG+cJigMjCelltT2I8fMdp9nZfS0paEgEo2HV3lVPiNChVp
         DdWRwumGb7/0ZKWQgQqXjZVp6Dm274IvXn33U3tQxEvdfK276M0qV+NxoarqY8lYngw5
         l51Q==
X-Gm-Message-State: ABuFfohuiyaon3Uj/WgPnsMQPEWtjzO+EhzeFXncH7dzhFLPHX8To8hh
        hwuFFPH+1FZuiqdTpsjJsNuipQ==
X-Google-Smtp-Source: ACcGV60dUTyw3VCQSwMlueigJGcG9Tv+uK5nOIioeNv9gG8dH2JcJ28IFaQE7rn6vhF6uMUkh6aWvQ==
X-Received: by 2002:a17:902:b198:: with SMTP id s24-v6mr33605985plr.70.1539217555602;
        Wed, 10 Oct 2018 17:25:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v189-v6sm36233331pfb.54.2018.10.10.17.25.47
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
Subject: [PATCH security-next v5 22/30] LSM: Separate idea of "major" LSM from "exclusive" LSM
Date:   Wed, 10 Oct 2018 17:18:38 -0700
Message-Id: <20181011001846.30964-23-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to both support old "security=" Legacy Major LSM selection, and
handling real exclusivity, this creates LSM_FLAG_EXCLUSIVE and updates
the selection logic to handle them.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    |  2 +-
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b6b05d351eb4..e88c725a43b8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
 struct lsm_info {
 	const char *name;	/* Required. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index bc56b058dc75..ebf63461a79c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1602,7 +1602,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/security.c b/security/security.c
index 2c754968f98b..65f1fa733e4b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -49,6 +49,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)						\
@@ -129,6 +130,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
 	return true;
 }
 
@@ -144,6 +151,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		int ret;
 
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive chosen: %s\n", lsm->name);
+		}
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 71a10fedecb3..0f8d7bb88197 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7194,7 +7194,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f243044d5a55..92e4baa342f8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4881,6 +4881,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a46f6bc1e97c..daff7d7897ad 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,6 +550,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 };
-- 
2.17.1

