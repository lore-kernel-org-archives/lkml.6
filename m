Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EFEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB2220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l/A2+cib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB2220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeIYGaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45558 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIYGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so2244853pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0/WPo99XAf06GH3nkcVhpC3IX4g7QPK+MCrVXTlZy4=;
        b=l/A2+cibrEfz7/yZEb4l5SyjQtkMpfWilXj0S0KhfH7psuUr+D8C5fgnyqoZxpLoLU
         ptaUqnRFfIvmNXOUUZFN+PIahQNlrTriix08jtczB6us5/dDd5DQIt4BjHISq1NsTyEH
         zrc93oH9OdNxmi6zydOWdSnZjCCoZ9X+OQAFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0/WPo99XAf06GH3nkcVhpC3IX4g7QPK+MCrVXTlZy4=;
        b=DlE1xy7+vPkGAIr2FHFc/hHCKc7KfReAkR8Q5FQU2bW0UtlqMIWG/eesauzTP3zUyf
         M+8RzsCufi3rWRgE6bEp5Hpecx84bq7sZiAvp3lJQwbgiyRGe9T45b7o4PgPVkssu3eC
         DUBoAEG/WU3jGkqIdvIOqa929MH71du7Jm9mBVIsbXk6L1MIJuXDcWqMqZwn8OUrjGny
         RbZ/8/7C1NPDS7HjAC8e05kKd9QdDDUvZ7CLPB0P9uhADz7aQAgmo+QOLIF6KRBRZnUW
         2OH7zfnI6ZY7H94Y1+06ScbxQMQ+BgYVS60JBivoX03gcqbogpOJo5RJg1j1L29xsqmC
         d/0A==
X-Gm-Message-State: ABuFfoi7VusPZ8ZoyJuiAfzlfoAcjWCXDaVc/jiY8BRd2IAXwb/KkljN
        ZCiHZusGctH3LuzZun5O2M5opA==
X-Google-Smtp-Source: ACcGV60AjhFfXXFGP+3F6NZZm8H4asXFHmRSD99uzdbECeeJ+nXSyCQoStdobAYuJqYJmJ0tSJdUXA==
X-Received: by 2002:a63:115f:: with SMTP id 31-v6mr933261pgr.53.1537835120797;
        Mon, 24 Sep 2018 17:25:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id i185-v6sm536664pfe.140.2018.09.24.17.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:16 -0700 (PDT)
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
Subject: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
Date:   Mon, 24 Sep 2018 17:18:21 -0700
Message-Id: <20180925001832.18322-19-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
which each can contain a comma-separated list of LSMs to enable or
disable, respectively. The string "all" matches all LSMs.

This has very similar functionality to the existing per-LSM enable
handling ("apparmor.enabled=...", etc), but provides a centralized
place to perform the changes. These parameters take precedent over any
LSM-specific boot parameters.

Disabling an LSM means it will not be considered when performing
initializations. Enabling an LSM means either undoing a previous
LSM-specific boot parameter disabling or a undoing a default-disabled
CONFIG setting.

For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
result in SELinux being enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
 security/Kconfig                              |  4 +++-
 security/security.c                           | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 32d323ee9218..67c90985d2b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2276,6 +2276,18 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm.disable=lsm1,...,lsmN
+			[SECURITY] Comma-separated list of LSMs to disable
+			at boot time. This overrides "lsm.enable=",
+			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
+			parameters.
+
+	lsm.enable=lsm1,...,lsmN
+			[SECURITY] Comma-separated list of LSMs to enable
+			at boot time. This overrides any omissions from
+			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
+			boot parameters.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index 71306b046270..1a82a006cc62 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -282,7 +282,9 @@ config LSM_ENABLE
 	help
 	  A comma-separate list of LSMs to enable by default at boot. The
 	  default is "all", to enable all LSM modules at boot. Any LSMs
-	  not listed here will be disabled by default.
+	  not listed here will be disabled by default. This can be
+	  changed with the "lsm.enable=" and "lsm.disable=" boot
+	  parameters.
 
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 7ecb9879a863..456a3f73bc36 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,8 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_enable;
+static __initdata const char *chosen_lsm_disable;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
 
@@ -185,6 +187,10 @@ static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
 	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
+
+	/* Process "lsm.enable=" and "lsm.disable=", if given. */
+	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
+	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
 }
 
 /**
@@ -240,6 +246,22 @@ static int __init enable_debug(char *str)
 }
 __setup("lsm.debug", enable_debug);
 
+/* Explicitly enable a list of LSMs. */
+static int __init enable_lsm(char *str)
+{
+	chosen_lsm_enable = str;
+	return 1;
+}
+__setup("lsm.enable=", enable_lsm);
+
+/* Explicitly disable a list of LSMs. */
+static int __init disable_lsm(char *str)
+{
+	chosen_lsm_disable = str;
+	return 1;
+}
+__setup("lsm.disable=", disable_lsm);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1

