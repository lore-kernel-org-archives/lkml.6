Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DBC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5521471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1/uG4P4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E5521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJBHfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56126 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJBHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:44 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so961005itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nN6g4PbGutmb0/T7yPnm6eCRi6kQ3RGQm5QiHIoyDE=;
        b=C1/uG4P4lFW9xwxw7M+GE7xFaDK0Es5Qf4u+4oGmAbkm04HpeIdXwa+FB7S+Kv61z8
         Y9fIzZ1SOUeyVrK7m74+9m+mnmOOCgAz3ZO3RXrQ/rdwYUnZLVMGDpfYtr5GeCgQ/anD
         CQyi64TGWagRnWPW+Gro5pFOVIDgyZ8NzQXOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nN6g4PbGutmb0/T7yPnm6eCRi6kQ3RGQm5QiHIoyDE=;
        b=F7Tw60nlRNWN2Wh4rIBFL7VNw6xZ/wPvyIYK0WDeA2VLxBfc8pbCf/fRQvT55QMC0D
         2BaRcicvhNrpiRJcWg8Jjj0UWY91ByjpxJkt6YtRlHxZbk0fmk0CzT1FvDfJbr+krPAf
         gVak8aGIN/SDxu/IH9ovhUsf0kChgTuOhfKV4JiFLeZaea93KII87PxoBHZ55J60zpcn
         6zh8xgvxlv4rZxUuUXcif4KcTTDFat+SKcXbKR6Ijq7e4hVPqv4nGHDJiH5s4gWzkgD2
         KGmBwn1i5qrD6G9t4kMJ27qYFICucC2Qz8tfa3xsBAwR7WkeDOQxyvRV6O1vT2nShRc/
         faIw==
X-Gm-Message-State: ABuFfohDJJCSU3T75OD6virmwzXpT1WHGM1+MvhGDzl3J/1PGrSS4xkI
        wbgcLneqweOLrTdlxzpPKSWTzA==
X-Google-Smtp-Source: ACcGV62s5p9uiL/K/99NeDG1Xp9iKKn1Hp6vc9a1oSnfKClbmfDEbYq7OF8DSg9ww2ysETgI3EiCKw==
X-Received: by 2002:a65:498b:: with SMTP id r11-v6mr12645840pgs.153.1538441715497;
        Mon, 01 Oct 2018 17:55:15 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b3-v6sm20582919pgm.74.2018.10.01.17.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:13 -0700 (PDT)
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
Subject: [PATCH security-next v4 08/32] LSM: Record LSM name in struct lsm_info
Date:   Mon,  1 Oct 2018 17:54:41 -0700
Message-Id: <20181002005505.6112-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 1 +
 security/apparmor/lsm.c    | 1 +
 security/integrity/iint.c  | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 security/tomoyo/tomoyo.c   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9c6b4198ff5a..ae159b02f3ab 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 struct lsm_info {
+	const char *name;	/* Required. */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c4863956c832..dca4b7dbf368 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1607,5 +1607,6 @@ static int __init apparmor_init(void)
 }
 
 DEFINE_LSM(apparmor) = {
+	.name = "apparmor",
 	.init = apparmor_init,
 };
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 94e8e1820748..1ea05da2323d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -176,6 +176,7 @@ static int __init integrity_iintcache_init(void)
 	return 0;
 }
 DEFINE_LSM(integrity) = {
+	.name = "integrity",
 	.init = integrity_iintcache_init,
 };
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ca2e89ddbd6..9651bccae270 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7203,6 +7203,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
+	.name = "selinux",
 	.init = selinux_init,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c62e26939a69..2fb56bcf1316 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4883,5 +4883,6 @@ static __init int smack_init(void)
  * all processes and objects when they are created.
  */
 DEFINE_LSM(smack) = {
+	.name = "smack",
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b2d833999910..1b5b5097efd7 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -551,5 +551,6 @@ static int __init tomoyo_init(void)
 }
 
 DEFINE_LSM(tomoyo) = {
+	.name = "tomoyo",
 	.init = tomoyo_init,
 };
-- 
2.17.1

