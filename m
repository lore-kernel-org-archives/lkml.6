Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADEBC46462
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99D52075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C22U1ev7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99D52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJKHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42909 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJKHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so3291602plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+n1UZ9G4yKJazZzNuVd8n+cXsOtWyTYvX517I36L/Q=;
        b=C22U1ev7xMSh2fiuwFIgKlasVKjOebDH2/kjkOXR4Qlp3KSQpkuuXEc1PAY9HaRMQO
         ug18C/EBi1AUvtl/plUm8tEedGuWWgu482TP87Qd/GZxHirzV1KnVMjpbTNMbLjeF5jS
         mEC1pdMHYqeUOhmHk2VYKdHCCl2C+YuT4Hlng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+n1UZ9G4yKJazZzNuVd8n+cXsOtWyTYvX517I36L/Q=;
        b=YJGapZ6SghGUWH47Zktke4jo6q4GxCvFsOwmcvCG8GZlTEusKSJ1EoLMQa6hzBgjcB
         QXj2RGC+4Lh9qh7gH5QNpiiPPwzIC0emtlwVJB6WsTl+tmMZFNECfxzo3bowqPjZWHhj
         McZ/laZgLNEdBliDs6VjA39DK0oRDFADpm4/VDyiR3y4luAfI2+zPu4RYESA30g//uiI
         wNJrFD9Eno5/NGT8TgH42F7MEOc91GYE8PgtFtkov8xSKc2b32y5sjqjwjeHaq9jid8g
         OpPzq2AfhBJRemaziD5f48UsVD3LGniCQHoLVIFX0yxR+VNaR8jLPSRIHZq7pGch/E4n
         H4OQ==
X-Gm-Message-State: ABuFfohHgW4qkCp3ntT7sLV4SIOQucYecs/IneP/VGf1BqWLfF6fa5ks
        Rbrh/DtCwoqe+ZQuxcc2dPxVIg==
X-Google-Smtp-Source: ACcGV60BxUJWXHpb/8AKwu+qTuIQMX4gWtf94uTcDCr5C32Sc2Yre0PBW5Vr7EhpfkL09/9AoWx4zA==
X-Received: by 2002:a17:902:104:: with SMTP id 4-v6mr8503458plb.189.1539217552801;
        Wed, 10 Oct 2018 17:25:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b10-v6sm35720727pfe.148.2018.10.10.17.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
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
Subject: [PATCH security-next v5 25/30] LSM: Add all exclusive LSMs to ordered initialization
Date:   Wed, 10 Oct 2018 17:18:41 -0700
Message-Id: <20181011001846.30964-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes CONFIG_DEFAULT_SECURITY in favor of the explicit ordering
offered by CONFIG_LSM and adds all the exclusive LSMs to the ordered
LSM initialization. The old meaning of CONFIG_DEFAULT_SECURITY is now
captured by which exclusive LSM is listed first in the LSM order. All
LSMs not added to the ordered list are explicitly disabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 39 +--------------------------------------
 security/security.c | 35 ++++++++++-------------------------
 2 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 0aa82c1c928e..2f8dc1f59cae 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,46 +239,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
-choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_DAC
-
-	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
-		bool "SELinux" if SECURITY_SELINUX=y
-
-	config DEFAULT_SECURITY_SMACK
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
-
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
-		bool "AppArmor" if SECURITY_APPARMOR=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
-
-endchoice
-
-config DEFAULT_SECURITY
-	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "" if DEFAULT_SECURITY_DAC
-
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "integrity"
+	default "integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/security.c b/security/security.c
index 65f1fa733e4b..4f52bd06705f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -175,8 +175,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
-			    strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
@@ -185,6 +184,15 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (!found)
 			init_debug("%s ignored: %s\n", origin, name);
 	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s disabled: %s\n", origin, lsm->name);
+	}
+
 	kfree(sep);
 }
 
@@ -196,8 +204,6 @@ static void __init ordered_lsm_init(void)
 				GFP_KERNEL);
 
 	/* Process "security=", if given. */
-	if (!chosen_major_lsm)
-		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
 
@@ -229,22 +235,6 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
-static void __init major_lsm_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-			continue;
-
-		/* Enable this LSM, if it is not already set. */
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-
-		maybe_initialize_lsm(lsm);
-	}
-}
-
 /**
  * security_init - initializes the security framework
  *
@@ -271,11 +261,6 @@ int __init security_init(void)
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-	/*
-	 * Load all the remaining security modules.
-	 */
-	major_lsm_init();
-
 	return 0;
 }
 
-- 
2.17.1

