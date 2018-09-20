Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8F621522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XCObcM6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8F621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbeITWIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42123 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeITWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so4578449plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5j7k7ZRHYVPORT2BHdhDUpe5J9v82EkRjqSlB3BsK9s=;
        b=XCObcM6hjXg8VsN8eA1ADrJSdO4WOrk6thvR8FFp3Gu801oMpPIJ4gBwVcNgVhdEpr
         dWHK7ZVGcOZ1Hp4VOd0tohzXgdQAcCHssfpZZTA4Dxn1o3zqgCmdUyAIrh9grL3zhZUw
         sxDQZE9oPaolhvoUXCjHUXKWbUprFDuPjB66Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5j7k7ZRHYVPORT2BHdhDUpe5J9v82EkRjqSlB3BsK9s=;
        b=RLPzn57VuyJGSVq8sD79dKdeIhLpcfytxKCGGXCkLI3+OIFRiysktilglRyenJqAUu
         nbUiunrjr0Za0Fa/lTC3Bu2A8nFLj/oPmNBFE0ikCylSepld5nhRgBi34Q9ye4hZgCxa
         OShC2Q39Q6DQgQCLkQApnm568/ZJ9LP7YJz24S0gSNc9488SeOvFwtuzFo1oVvZXutEk
         rb0fxQGQplbrKnAv193mOJUDx19Bs3aDjWroIUNz3OPsul09xwFE5nUJJHx48jUZjfyB
         oAj2QMmc8Pbr2GqRghRUWqINBTuXrOXeGFFqNpDfyY5O4AKLAEDgYm92A4AGRdsjJqno
         zFgA==
X-Gm-Message-State: APzg51AtBKWK/krRim0A9mLyDtffjKA6oI/y36+i2rsGIUDZbRvMLn36
        X5WDLwwPuiztoBnA8vVcHdoVxQ==
X-Google-Smtp-Source: ANB0VdZMS+aPJK5qEezkzYYAI7ytvxieZB/iuSGTAyYtxT6mbIQxO8D6+DAaWrdB5u0Gkm0RZ4Y+AQ==
X-Received: by 2002:a17:902:292b:: with SMTP id g40-v6mr39778298plb.223.1537460630516;
        Thu, 20 Sep 2018 09:23:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z63-v6sm28316768pgd.69.2018.09.20.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
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
Subject: [PATCH security-next v2 07/26] LSM: Convert security_initcall() into DEFINE_LSM()
Date:   Thu, 20 Sep 2018 09:23:19 -0700
Message-Id: <20180920162338.21060-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using argument-based initializers, switch to defining the
contents of struct lsm_info on a per-LSM basis. This also drops
the final use of the now inaccurate "initcall" naming.

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

