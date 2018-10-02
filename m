Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93EAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98E0206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWMa/tn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98E0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJBHp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52636 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJBHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:00 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so1016237itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVOoGnQVVxtCQukk9qvIxsFMi2TMOCjgfBDPf6jS5YQ=;
        b=oWMa/tn1rXNvp56NZzs7vYF4yF3oxT5MHoSS9c41PHjSgCp2ZUK64Iy0T9L3kshGCo
         dpda/TnhyAjx43PVZ71axdb0UYPuvx3fIb80UKBkJwKcB1R3Lrz4r9+JSk4GFQ6BFA65
         iCrps6usAwk6JEQL2Ap9vDKiNcqUyIn6NhLt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVOoGnQVVxtCQukk9qvIxsFMi2TMOCjgfBDPf6jS5YQ=;
        b=aAbVeliLNXsNByP5Ko4v8EAs3j0jjGzspuPGQvGeDtGb/pyIZG7Tz9rz+QZPpoJO21
         vcca9D6xbIii6FqrOdwpAAC6LkklQDO0WCnVBF3KmwFZEDjhdTKF9ZaNoTQOsUXc6pe6
         r4Mu1a4yuSTUoAWsN8eX9luC9lS/ZtNRSLqPoxlI+JguEH5Rvvbj/Pc+3uFZr82OnkR9
         kVKSBfTO7nagEi1WqTsl/B9itUw/oDLDyL/gaWWU7DAQF5/p8aRJbojNJ1cMAI+4W2y+
         /jB6Q3MFk7EOGM9MG4xxkP86fJRLTlLS46+o4e/O2Gt5uyQKv3/9unOKRYJDnEA2Uas3
         nE0Q==
X-Gm-Message-State: ABuFfoinphdKqw8//qSN8m4BGM4Z8Ps23l6G6Ef6MEvTkav+Vgy/6Mj6
        zZj8F90K195yHz2xSPdNERPxow==
X-Google-Smtp-Source: ACcGV61gAfz3eq5nRwKSITgdokwgKGzhbAXBNqps58mayyW8EoJld4tsLx4//UvTSWttaRRr6tefNw==
X-Received: by 2002:a63:a902:: with SMTP id u2-v6mr12305606pge.207.1538442269214;
        Mon, 01 Oct 2018 18:04:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2793786pfe.6.2018.10.01.18.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 18:04:24 -0700 (PDT)
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
Subject: [PATCH security-next v4 17/32] LSM: Introduce CONFIG_LSM_ENABLE
Date:   Mon,  1 Oct 2018 17:54:50 -0700
Message-Id: <20181002005505.6112-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To provide a set of default-enabled LSMs at boot, this introduces the
new CONFIG_LSM_ENABLE. A value of "all" means all builtin LSMs are
enabled by default. Any unlisted LSMs will be implicitly disabled
(excepting those with LSM-specific CONFIGs for enabling/disabling).

The behavior of the LSM-specific CONFIGs for SELinux are AppArmor
unchanged: the default-enabled state for those LSMs remains controlled
through their LSM-specific "enable" CONFIGs.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 +-
 security/Kconfig          | 8 ++++++++
 security/security.c       | 4 +++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9ecb623fb39d..fd85637a1931 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..ac23feba584d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,13 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM_ENABLE
+	string "LSMs to enable at boot time"
+	default "all"
+	help
+	  A comma-separated list of LSMs to enable by default at boot. The
+	  default is "all", to enable all LSM modules at boot. Any LSMs
+	  not listed here will be disabled by default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 9459b4ee4fd9..35601000176b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -45,6 +45,8 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -182,7 +184,7 @@ static void __init parse_lsm_enable(const char *str,
 static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
-	parse_lsm_enable("all", default_enabled, true);
+	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
 }
 
 /**
-- 
2.17.1

