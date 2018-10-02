Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D42C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EA921471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMi+Iu9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EA921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJBHfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54551 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJBHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:47 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so968746ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BkVHY8L5VMquzw4EbJs5ZAxEkxvYW2nhxdXmAR5GSBo=;
        b=aMi+Iu9/VPcFPniGXBJcDUJYSpk0wtgR3n2VCgbFYNVCbvTD0eLwjXoMmbzadwen6I
         drTizrTK04r+VOchP38UyklzrPiVu2BtjY0o22p0VuPbQDLth4s28cVKvctC0qP4xB8h
         FGRnsaR1DbRocxwPBOLpgbJg/qDgtJVK9iivc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BkVHY8L5VMquzw4EbJs5ZAxEkxvYW2nhxdXmAR5GSBo=;
        b=H7PknlkSNRMS8K9YRlAQyvEnXc0fSaadDS+rhOAybLZ0ucP3tuIWXh4Hg6gA3AMXv7
         aexyo3BlGw2C6fZuCKuVp/xWUMAhR0aHaiYuKMQY+qW2v88zmrHNh2SP9VW50LekiXEK
         As+KTUilRz80TGlawq1o5gzXVAvd5Fja94WPPwkL2oCEDlpKN8UMBOpdYLxxNMuJxLUJ
         JuKkHhmEd4O5IMSReqxPHUKBy7wbx2GykgTPeN82fUmtCehd7ESNljC1oDUJGr/E7DwL
         rt3/RPJB4dhjUVWda8uqHbal0n0y/1QfS9Dnin1YdW9Ztyt9/6IttIr0KqPM9VQwjpnc
         +zDA==
X-Gm-Message-State: ABuFfoiEGnkQsJV4lF076dSFkvLKh3rU3kGrnd1Jl0KtiqAg9RXp/Gmf
        DxbKQAOWf8xP4TqHgkXXam7C6w==
X-Google-Smtp-Source: ACcGV60cvQbuRXcCrQBRhMB4s+ZySEpEQGyQmlQjHFpsbngRJu8uZxmQ+ceHChInmNcQ5jGtoe5kOg==
X-Received: by 2002:a63:2066:: with SMTP id r38-v6mr6932512pgm.289.1538441719054;
        Mon, 01 Oct 2018 17:55:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k71-v6sm18659062pge.44.2018.10.01.17.55.11
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
Subject: [PATCH security-next v4 07/32] LSM: Convert security_initcall() into DEFINE_LSM()
Date:   Mon,  1 Oct 2018 17:54:40 -0700
Message-Id: <20181002005505.6112-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using argument-based initializers, switch to defining the
contents of struct lsm_info on a per-LSM basis. This also drops
the final use of the now inaccurate "initcall" naming.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/apparmor/lsm.c    | 4 +++-
 security/integrity/iint.c  | 4 +++-
 security/selinux/hooks.c   | 4 +++-
 security/smack/smack_lsm.c | 4 +++-
 security/tomoyo/tomoyo.c   | 4 +++-
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d13059feca09..9c6b4198ff5a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2045,11 +2045,10 @@ struct lsm_info {
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
-#define security_initcall(lsm)						\
+#define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
-		__aligned(sizeof(unsigned long))			\
-		= { .init = lsm, }
+		__aligned(sizeof(unsigned long))
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..c4863956c832 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1606,4 +1606,6 @@ static int __init apparmor_init(void)
 	return error;
 }
 
-security_initcall(apparmor_init);
+DEFINE_LSM(apparmor) = {
+	.init = apparmor_init,
+};
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 70d21b566955..94e8e1820748 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -175,7 +175,9 @@ static int __init integrity_iintcache_init(void)
 			      0, SLAB_PANIC, init_once);
 	return 0;
 }
-security_initcall(integrity_iintcache_init);
+DEFINE_LSM(integrity) = {
+	.init = integrity_iintcache_init,
+};
 
 
 /*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..6ca2e89ddbd6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7202,7 +7202,9 @@ void selinux_complete_init(void)
 
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
-security_initcall(selinux_init);
+DEFINE_LSM(selinux) = {
+	.init = selinux_init,
+};
 
 #if defined(CONFIG_NETFILTER)
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30ad85d..c62e26939a69 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4882,4 +4882,6 @@ static __init int smack_init(void)
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
  */
-security_initcall(smack_init);
+DEFINE_LSM(smack) = {
+	.init = smack_init,
+};
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..b2d833999910 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,4 +550,6 @@ static int __init tomoyo_init(void)
 	return 0;
 }
 
-security_initcall(tomoyo_init);
+DEFINE_LSM(tomoyo) = {
+	.init = tomoyo_init,
+};
-- 
2.17.1

