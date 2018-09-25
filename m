Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6573ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531292098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpz2sKAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531292098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeIYGXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44088 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbeIYGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9904978pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdPLBrV86brfh6UmS043o/g5aoVc6H7x7cEeohypzFE=;
        b=bpz2sKAilWIIzusgyQATBx+ty90qv45CNB1P4sbc6019yMyILdQx1mrvJE8CFqekoh
         zCaz7Ng3B3KCQcDkpLC7tZrKP5wcQ+ON+JDkMpnXqnZ8fIpO6D+dvBwI1VudM1zOzejX
         AYRChWUJXtfaki4TVYGJc5RfPgj1ZDOfb1vBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdPLBrV86brfh6UmS043o/g5aoVc6H7x7cEeohypzFE=;
        b=VE4TAu/nTKCgjXivZl9QlojZNEEAzgaxlDijrcEORq9rJ35LC+GvFwrq3to4VM9ZrS
         fXH+Beo+y8/U1MorAalfzfk0J9C0suVqR+iKx4c+/IFSubqclEzlGUt4b63wdwPJr/42
         FxXEWg1l8wlfNijckt7xEFwns44Cu3/wb8xiyHCyP5pLLCyTsb/u2p9xyM8WiLeBykq7
         lsHRF/ianlDBDkz9m1l/id+EhkQXHiBwnkIMtfU9nYtbktXfsco0PYJmUGfsZxtMqHS3
         O0B0oWnXZHFEN5XACsEIoMPs4xslpVXeHn06li4jPO2MdgMPvxEjbPDlMn5anDzZx/Yz
         CRZg==
X-Gm-Message-State: ABuFfoju1UNiWg559laJQQEXdvBwl7A8NOHr0MMekRVv5ydXYop9OFdt
        mmJBV/RUBlHyjuUyd8WoDMuOKg==
X-Google-Smtp-Source: ACcGV6060sXsy7bzJlo0awXtW/tWu5u15XmLS1sYG37rkA6kfoV61gD++is9N27LjTcOQdLJivS6zA==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr993116plq.156.1537834738027;
        Mon, 24 Sep 2018 17:18:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g21-v6sm704862pfe.41.2018.09.24.17.18.48
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
Subject: [PATCH security-next v3 28/29] LSM: Separate idea of "major" LSM from "exclusive" LSM
Date:   Mon, 24 Sep 2018 17:18:31 -0700
Message-Id: <20180925001832.18322-29-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
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
index 950042fb2385..0f5d44d0a9cc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
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
index ade74b90b73c..5a3e19f1fe48 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,6 +52,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static bool debug __initdata;
 #define init_debug(...)						\
@@ -204,6 +205,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
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
 
@@ -219,6 +226,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
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

