Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F35214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ca8HuJEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F35214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeIYGZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:25:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42593 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeIYGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so10108004pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6EfxT0zcae6A5rzLbELC2IqQ09YDT4L0Am/o9GdvmCQ=;
        b=ca8HuJEN8GvhdrrGWOJGHlywVNTjjXI23kAJOqur2gPvgJq4UX3WPgibnW/GvLJ6LX
         sBljd7tWuue+7KP85zge+rgxoKYQ7HtIsfSzJedqK/WdiGbpKo6YLJJRwGLnz8V5oDlO
         LNqPGr1y0SSZvAPde8tK7oZ9JRyQ2MKjS1bt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6EfxT0zcae6A5rzLbELC2IqQ09YDT4L0Am/o9GdvmCQ=;
        b=BqXSQcdHbNjVnJQg9+2NjxG8FuS6zObj9rzqAO0m4B9OzbNxo31Qt3HAMPQnXBDkhs
         f44lGrZxl4Qy7xkhGmtvi77lHOrwiCc2hGSncUkarvbPesw1WLAMBVVo5HFENiDX6U+E
         XFc+YXTl35P/UVqL7IC36WjJZ6fAZ5DKqb636ugknV6qQSvBrbfQ8860xjjj3/JY9Kzs
         Yy4B1+z/0n1fUBzinM6pN6JCuz4GxWllyj8edlE4oRuuM7srZfIrYA+1rZ1dNkB+Hcrn
         60gQz6TF73ZkkE9UymBY6iU2uCV4umdAB/juBDN2wtkbllKnjEyYylfbn/cPLhD+SlX6
         haeg==
X-Gm-Message-State: ABuFfojX0PB4+FVih7vX9L3WNAU8ubf9CFdV1BvipIam5aUxn3FXzy1H
        sCCc5JSFnyT0sCC4Qv6wyWpcWg==
X-Google-Smtp-Source: ACcGV61sgt2d0oFLTpcaL284CJN9GYkgWTcz9hrEiYPZ5KRo/A/eEWo/lu+MeTxLrEIDpJQw98EHPQ==
X-Received: by 2002:a63:700e:: with SMTP id l14-v6mr860909pgc.359.1537834726429;
        Mon, 24 Sep 2018 17:18:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a75-v6sm540713pfa.124.2018.09.24.17.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 07/29] LSM: Convert security_initcall() into DEFINE_LSM()
Date:   Mon, 24 Sep 2018 17:18:10 -0700
Message-Id: <20180925001832.18322-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using argument-based initializers, switch to defining the
contents of struct lsm_info on a per-LSM basis. This also drops
the final use of the now inaccurate "initcall" naming.

Cc: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  | 6 ++++--
 security/apparmor/lsm.c    | 4 +++-
 security/integrity/iint.c  | 4 +++-
 security/selinux/hooks.c   | 4 +++-
 security/smack/smack_lsm.c | 4 +++-
 security/tomoyo/tomoyo.c   | 4 +++-
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ad04761e5587..02ec717189f9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2045,11 +2045,13 @@ struct lsm_info {
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
-#define security_initcall(lsm)						\
+#define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
-		= { .init = lsm, }
+		= {							\
+
+#define END_LSM	  }
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..7fa7b4464cf4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1606,4 +1606,6 @@ static int __init apparmor_init(void)
 	return error;
 }
 
-security_initcall(apparmor_init);
+DEFINE_LSM(apparmor)
+	.init = apparmor_init,
+END_LSM;
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 70d21b566955..20e60df929a3 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -175,7 +175,9 @@ static int __init integrity_iintcache_init(void)
 			      0, SLAB_PANIC, init_once);
 	return 0;
 }
-security_initcall(integrity_iintcache_init);
+DEFINE_LSM(integrity)
+	.init = integrity_iintcache_init,
+END_LSM;
 
 
 /*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..469a90806bc6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7202,7 +7202,9 @@ void selinux_complete_init(void)
 
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
-security_initcall(selinux_init);
+DEFINE_LSM(selinux)
+	.init = selinux_init,
+END_LSM;
 
 #if defined(CONFIG_NETFILTER)
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30ad85d..1e1ace718e75 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4882,4 +4882,6 @@ static __init int smack_init(void)
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
  */
-security_initcall(smack_init);
+DEFINE_LSM(smack)
+	.init = smack_init,
+END_LSM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..a280d4eab456 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,4 +550,6 @@ static int __init tomoyo_init(void)
 	return 0;
 }
 
-security_initcall(tomoyo_init);
+DEFINE_LSM(tomoyo)
+	.init = tomoyo_init,
+END_LSM;
-- 
2.17.1

