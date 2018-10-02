Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70627C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42420C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7Tdip1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B42420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJBHpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40071 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeJBHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:03 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so280244iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/qQzlLdHC3pOVrMYLSbt8GYIcGt6njlsLirLySrxEA=;
        b=Y7Tdip1y9DwjAKK6x8Y+GHfJCWkEXS3Aw7euEhxbEiDtK6KfdYnw6gwb5IT16cRlOR
         ISlTHU748v3IdC/VJdzbHQA5J6rxccFfp3yCZ3J/6w9GJXQ+hCK5ws2b0T6qoXssy4wc
         EjM77V+6IofPdUj3X/Gebf/zpXt/ZCfP0VSY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W/qQzlLdHC3pOVrMYLSbt8GYIcGt6njlsLirLySrxEA=;
        b=oJM+9Kt8qHr/kXE9kUgqysxRkfvBLeNyWELh19sLMWZC4UhAsZGAslknhAbkjT6Byf
         nUazSvvrRpVRS47rj9/YnCls9i80lM/QqxjPbEAiMTCuSOCXHFzZ+i39MqqFP++31OJv
         bLq2x+BQemNOukrxGNBJpDzpdq2reN/bEAbUlQTwLdTJEAMDFqmablfP8GQmV1OaP7dc
         vvy//AUdWyGvVYcasb61VAmuuCSEaCsRRv/ARnYsd88UuxfIdYcDndko8Sty7HvV4j+O
         Gw8stHCjSCY5j04gV7fIvXm3OCsL7Ry4l5+Powwzw5haFesLE+qgcz+SqLMcXfAllQ02
         jhFQ==
X-Gm-Message-State: ABuFfogNQGcS6Gr9PCHzgSioFE+AVkxGsCvIyyqU1Cl/ywXROlz+5PeS
        rmQtubiYDmnyb0zDnTsQiiMlIg==
X-Google-Smtp-Source: ACcGV63Cykas03Y9txiaHpl+hTXVURFzAvX/91GaddzbP8yzCAh5DVaH6ZWfP7OiVOI6H7XcoIdJ1w==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14-v6mr8773333plz.61.1538442272202;
        Mon, 01 Oct 2018 18:04:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h77-v6sm18554060pfh.13.2018.10.01.18.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 18:04:29 -0700 (PDT)
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
Subject: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date:   Mon,  1 Oct 2018 17:54:56 -0700
Message-Id: <20181002005505.6112-24-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
"lsm.enable=...", this removes the LSM-specific enabling logic from
SELinux.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ------
 security/selinux/Kconfig                      | 29 -------------------
 security/selinux/hooks.c                      | 15 +---------
 3 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf963febebb0..0d10ab3d020e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4045,15 +4045,6 @@
 			loaded. An invalid security module name will be treated
 			as if no module has been chosen.
 
-	selinux=	[SELINUX] Disable or enable SELinux at boot time.
-			Format: { "0" | "1" }
-			See security/selinux/Kconfig help text.
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-			If enabled at boot time, /selinux/disable can be used
-			later to disable prior to initial policy load.
-
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..86936528a0bb 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -8,35 +8,6 @@ config SECURITY_SELINUX
 	  You will also need a policy configuration and a labeled filesystem.
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_SELINUX_BOOTPARAM
-	bool "NSA SELinux boot parameter"
-	depends on SECURITY_SELINUX
-	default n
-	help
-	  This option adds a kernel parameter 'selinux', which allows SELinux
-	  to be disabled at boot.  If this option is selected, SELinux
-	  functionality can be disabled with selinux=0 on the kernel
-	  command line.  The purpose of this option is to allow a single
-	  kernel image to be distributed with SELinux built in, but not
-	  necessarily enabled.
-
-	  If you are unsure how to answer this question, answer N.
-
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
index 71a10fedecb3..8f5eea097612 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,20 +120,7 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
-#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
-static int __init selinux_enabled_setup(char *str)
-{
-	unsigned long enabled;
-	if (!kstrtoul(str, 0, &enabled))
-		selinux_enabled = enabled ? 1 : 0;
-	return 1;
-}
-__setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
-#endif
+int selinux_enabled __lsm_ro_after_init;
 
 static unsigned int selinux_checkreqprot_boot =
 	CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
-- 
2.17.1

