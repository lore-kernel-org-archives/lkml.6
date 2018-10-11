Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9154620644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cws5cD8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9154620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJKHu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39379 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJKHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so3293396plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXmX6NWqSt00W/pJqFjPQo5O3fzHwsapi11+f9ycNnY=;
        b=cws5cD8Uerjr3MHzRcnYnlT5+eBQqFBGojNGuzv077jH86oBWEdNpl23x4IdPMZlTp
         A6ebBufTnmglmqUmC/kB9s1M6Hu5fMFoZ69kZWKv6HcGYu7FIXM8MIulumWsAVpfrCWg
         +5+mE7eMuFZnCg1bLyBbI5xRzVDm0O23F4o6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXmX6NWqSt00W/pJqFjPQo5O3fzHwsapi11+f9ycNnY=;
        b=JNDSdWZGrCBovtv2m0zfLe2rCKCBo6R9t12Lq4DCvKoj8HSJddTMZMLb47zorpnkBn
         TqgLVja63UgsRZKlCdu4Wb7LUXURl2CkS3+OH8IhWR3XrKRJL12ZhS5Aou2LABkDas1/
         VU3TTVXNQwaT671TBQ1KiiV/8BtiFKr7udDf737eS7JyddK0XVtY/K0aKGv5Ggggv7fz
         Rs39fQ4KM7jopH9AL1JCYSWrnyVW2m+dSkhcOBlUOUaL95qUNKYGiDGt4L1B4D99txsx
         z4PP2lzWDZ620IoxLCkdvezZB1gWRMV9BFztKKyxA56BsSPV3MJy9X8Wp1fO9GtsRVV3
         r2fA==
X-Gm-Message-State: ABuFfog0pq9iORXfCYqdixmwHHSGN68beR1AQIOEEOvrLfemmQYEz2Sp
        DR158MIha73NeMF7NXLvY8I/zw==
X-Google-Smtp-Source: ACcGV62jhBnYWxcO5h7stRmixxdBMTEDtpjlyNYVISANT7qe+10BZJpGKCGnvCYg18nHuaZ/lFlcZw==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr34065840plp.14.1539217549396;
        Wed, 10 Oct 2018 17:25:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v84-v6sm36583257pfk.12.2018.10.10.17.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:45 -0700 (PDT)
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
Subject: [PATCH security-next v5 24/30] selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
Date:   Wed, 10 Oct 2018 17:18:40 -0700
Message-Id: <20181011001846.30964-25-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_SELINUX_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=selinux", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/Kconfig | 15 ---------------
 security/selinux/hooks.c |  5 +----
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..55f032f1fc2d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -22,21 +22,6 @@ config SECURITY_SELINUX_BOOTPARAM
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_SELINUX_BOOTPARAM_VALUE
-	int "NSA SELinux boot parameter default value"
-	depends on SECURITY_SELINUX_BOOTPARAM
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'selinux', which allows SELinux to be disabled at boot.  If this
-	  option is set to 0 (zero), the SELinux kernel parameter will
-	  default to 0, disabling SELinux at bootup.  If this option is
-	  set to 1 (one), the SELinux kernel parameter will default to 1,
-	  enabling SELinux at bootup.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f8d7bb88197..14c120842ab4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,9 +120,8 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
+int selinux_enabled __lsm_ro_after_init = 1;
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
 static int __init selinux_enabled_setup(char *str)
 {
 	unsigned long enabled;
@@ -131,8 +130,6 @@ static int __init selinux_enabled_setup(char *str)
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
 #endif
 
 static unsigned int selinux_checkreqprot_boot =
-- 
2.17.1

