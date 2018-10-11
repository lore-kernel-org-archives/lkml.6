Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD943C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7321470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYp+0PFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE7321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJKHnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40440 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeJKHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so3288326plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nN6g4PbGutmb0/T7yPnm6eCRi6kQ3RGQm5QiHIoyDE=;
        b=JYp+0PFQzpPjqpzN/l8/VwCmRn3KZQxQgNYdk93VP1lEK+liUvTyFglEnayEycMuXL
         pErHVG7vmzakl0U1Lf8Hz54AwP3cVKMxIjRMT8+UAUvmLUGIPNF+UsPlonw0cmR1yhp4
         QzkzgtaNcjfeHiBGqyxOCGSCe8Wa8ccjoQS8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nN6g4PbGutmb0/T7yPnm6eCRi6kQ3RGQm5QiHIoyDE=;
        b=BppqDojoTtU7fZfJw0GaU36BEJl5iF8606me/6iRyiCTY/mRZJCylHZ/mjgqit/HHz
         hmx0jppxtC6QM8IL1vEgi7bT4p+ytOEi1pyE9S173Qkz4rpfePHErn3WkmI3hpyh1ctM
         qy8Vt23cRU3SEO2Mpz0R/758ZlRbypNW82aY/GyJpAVTgukAA91TGyHosNYmyC7n7B/D
         1t0tfERnjj1LZGVG8np9GxAwa8wkKxEDcNCW63iJmmkPUGLBPYC8J2ktqZmoopmIDCbX
         n4tIzmlMkwe8zgy+ZxQZ2lTsPGSCedrte+yc6D6o9wtDMdrKg7YC6JNIu4ThtkPVoKYv
         B0Ig==
X-Gm-Message-State: ABuFfojgNK7DIgDJn2lU4SDnNAHfXNNzl8Vb3UyGoag6kP9bPmgYmfiU
        DYXT+HzDBEvs4g2YgcE3r0F7Jw==
X-Google-Smtp-Source: ACcGV619747qShRQi5/OlLQAuc5h4/PU5fBaXlKirrvUnSTqpL5fZiblOOtUmiWoVYz5qFISotH+Ug==
X-Received: by 2002:a17:902:7802:: with SMTP id p2-v6mr150926pll.170.1539217139129;
        Wed, 10 Oct 2018 17:18:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o133-v6sm59590051pfg.86.2018.10.10.17.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:18:57 -0700 (PDT)
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
Subject: [PATCH security-next v5 08/30] LSM: Record LSM name in struct lsm_info
Date:   Wed, 10 Oct 2018 17:18:24 -0700
Message-Id: <20181011001846.30964-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
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

