Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF637C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B1820C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lh2KYIUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B1820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJBHpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35170 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeJBHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:02 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so295941iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9HNh3Q4VSJQ5w/3yyHsrKc9aYEok0he5oMNhPVupBp4=;
        b=Lh2KYIUDEd873+dDWgH/cRt/83/GRJbzYnB+K7WwzMFcXv9oqBIRx1erTG1iww0Qcs
         TdP6+oIvl5oYuf4q6zNuKng8aGp03W6hekBu71VCaPIpvOdQZwy9HZN9cz9LvUICACRs
         baq7BtEIffeKPzNXwFBAjzEO5c+UoDEbP9KTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9HNh3Q4VSJQ5w/3yyHsrKc9aYEok0he5oMNhPVupBp4=;
        b=H85PFeCQ+q3D/MXcfHv1zYrKvzVvgYliSAVEoGiBWDlJ51Ns/mDNNTmc0RuoGSBJqb
         HWFEAO//Mc+It8CBAtEU0NzXOkEtWAEQO5WwB1pffh70eFugUWuDdIk1o9hJP/rzJSYr
         hkzbixwSHFZrUKb77xJwTxDEPkzQC/GtMmVS7fWnOjYMFHipRp4ULkxUcdoar0prQ7I6
         cyR3eVzUqv3emE3WCzac0jAzZZ3z0xM6LD7BmGxo1QA4W6Xa+GK9tuJJ9B46u1VL53Jd
         kr+b+LhW8k3wFxAlLFI+0Gp6N/LRP5IgnxFWHIb8nLh69ejMvYOJF9XEEU/tXDyv0LiF
         5jog==
X-Gm-Message-State: ABuFfogBL8x+iX7Zqq3V8VJS7BKcVX4/9pSGxvLFr+75OCpz3JY+FLLz
        n20LwwkY2fUkHQxYW+eqlNn6cQ==
X-Google-Smtp-Source: ACcGV61p+6jux778ZBLbYvLQR8FnTRc24YhLc4vSgLatG/TNAzLVvla8MMwQU8ljRvMGsZAFhu2JBw==
X-Received: by 2002:a17:902:f01:: with SMTP id 1-v6mr14341449ply.8.1538442271325;
        Mon, 01 Oct 2018 18:04:31 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h132-v6sm22420511pfc.100.2018.10.01.18.04.27
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
Subject: [PATCH security-next v4 22/32] apparmor: Remove boot parameter
Date:   Mon,  1 Oct 2018 17:54:55 -0700
Message-Id: <20181002005505.6112-23-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
"lsm.enable=...", this removes the LSM-specific enabling logic from
AppArmor, though it leaves the existing userspace API visibility into
/sys/module/apparmor/parameters/enabled.

Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 security/apparmor/Kconfig                       | 16 ----------------
 security/apparmor/lsm.c                         |  7 ++-----
 3 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f646cfab5613..cf963febebb0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4054,13 +4054,6 @@
 			If enabled at boot time, /selinux/disable can be used
 			later to disable prior to initial policy load.
 
-	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
-			Format: { "0" | "1" }
-			See security/apparmor/Kconfig help text
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index bc56b058dc75..4cd96a66ed6f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,15 +1303,12 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static int apparmor_enabled __lsm_ro_after_init;
 module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
-	unsigned long enabled;
-	int error = kstrtoul(str, 0, &enabled);
-	if (!error)
-		apparmor_enabled = enabled ? 1 : 0;
+	pr_err("Boot param 'apparmor=' ignored. Use 'lsm.disable=apparmor'\n");
 	return 1;
 }
 
-- 
2.17.1

