Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0674CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8212147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahZIpUG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8212147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbeITWN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:13:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37321 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387809AbeITWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:13:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so4624991pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyWMd8rVkpihbr4KDxBE72JP3/jiqTkQ3QerKHyyizk=;
        b=ahZIpUG0/YIgUgOjo2yfsN1C80IDhpbgbwdaDUX61WMGT+3KWeBpvoiYiDREs2lCB7
         vy3usl9Y7vVuitETM7OnvmrNczgIUxmTaQB16iac/kJQDTOotMAHtNJL1+ZMqof1qm+V
         vwls64q1Ri/gH1PS899TUpkFzQl7igHNAH52Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyWMd8rVkpihbr4KDxBE72JP3/jiqTkQ3QerKHyyizk=;
        b=phUOxYSpNPyUgjOtjWsKDKNiaWioEBnLyThOQhwHHADbD3D7iisOLH5ij0KqS9cXkb
         QgFP+alyWFrppXKqB9XDJGuSb8L9zQ4IB6jO1ernpvUiqWfcW7Wux08z/FJLjpkRmnME
         bp6YfOUt756o3e15pfsMShjqpqVmesgxrhwKehekor2+bQaH40+uGqOB5foTOMx8ODrI
         9ZoFsyqRbbsgRdkHlWp0EQ1DMaNquYb8DwrLErOsIHU4OwtDXzDgvsZtX56WKpz3HUaF
         7UEFHRJ6cOY2n75xkP1rCLE7VMjFwNb0b+3AK5jMxn9PqQLt37dlOa6pGfA/uTQLfWAp
         7J2A==
X-Gm-Message-State: APzg51BYzHC1hMnejFryW3XJ3Q2axS4zrgUd23Wc+GBKWs/DELa3HJm/
        Vc7OBkFtKi2DESd4GTudPP4WiA==
X-Google-Smtp-Source: ANB0VdZ14ZTqQILaXGfUP/yxYN9+PpRuGmnHIGOnUHeHHhHXizJkJwmbGM1ugqpl5799EmDkXhQ4PA==
X-Received: by 2002:a63:3dc6:: with SMTP id k189-v6mr37518264pga.191.1537460980226;
        Thu, 20 Sep 2018 09:29:40 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k64-v6sm36455796pfg.141.2018.09.20.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:29:39 -0700 (PDT)
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
Subject: [PATCH security-next v2 25/26] LSM: Separate idea of "major" LSM from "exclusive" LSM
Date:   Thu, 20 Sep 2018 09:23:37 -0700
Message-Id: <20180920162338.21060-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to both support old "security=" Legacy Major LSM selection, and
handling real exclusivity, this creates LSM_FLAG_EXCLUSIVE and updates
the selection logic to handle them.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    |  2 +-
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8e843eaacffb..7d9c94d31279 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	(1 << 0)
+#define LSM_FLAG_EXCLUSIVE	(2 << 0)
 
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5399c2f03536..d68bc931d388 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1601,7 +1601,7 @@ static int __init apparmor_init(void)
 }
 
 DEFINE_LSM(apparmor)
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 END_LSM;
diff --git a/security/security.c b/security/security.c
index a40e938db1b0..f076fdc6b451 100644
--- a/security/security.c
+++ b/security/security.c
@@ -49,6 +49,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static bool debug __initdata;
 #define init_debug(...)						\
@@ -181,6 +182,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (lsm->enabled && !*lsm->enabled)
 		return false;
 
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
 	return true;
 }
 
@@ -196,6 +203,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		int ret;
 
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive: %s\n", lsm->name);
+		}
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 409a9252aeb6..5461d54fcd99 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7193,7 +7193,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux)
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
 	.init = selinux_init,
 END_LSM;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e79fad43a8e3..e46c1ea8cf84 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4880,6 +4880,6 @@ static __init int smack_init(void)
  * all processes and objects when they are created.
  */
 DEFINE_LSM(smack)
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = smack_init,
 END_LSM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 39bb994ebe09..cc39eb8df61a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -549,6 +549,6 @@ static int __init tomoyo_init(void)
 }
 
 DEFINE_LSM(tomoyo)
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 END_LSM;
-- 
2.17.1

