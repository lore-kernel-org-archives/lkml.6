Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892920C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlLCbrje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJBHpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55519 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJBHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:06 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so995386itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhboxPriZT52eGToQVEpgNPg17ea2OIRYF06FRnxbvc=;
        b=WlLCbrjeGA86NysbR871Ng18mT+zoovqQwuyvXD4J/5kvPFVdsI/P114q7pGJGEKaD
         mG8uO9Z+HQxxk5gkcFJyAK7S+kEbcW728lAA1Wkq9sDY7Lu6muzpjMyX51si31BEW2Dd
         3UC1wMk+nXtWTGZXOGaIyBHPgd6Uw1JhViBYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uhboxPriZT52eGToQVEpgNPg17ea2OIRYF06FRnxbvc=;
        b=fpPZKdXSHHPch/h4r70pDyL36dcXBXRh8NE+Kj9r5lgaA+ffDkInfFxUgEiqkojozU
         jo8E6CZubelWZDBwbkHLfl16RjvopLhEa0Y6p/l9c9QY69w86ovZdyG6KLCo+6wiJGp4
         LrjhDNIF716BGfLnXSM+72IszZ0gn367gTAgnBosFwYhZ3bJC0uBag6GwP3OJPATyzIv
         9Bvzjl5ui2VYP0HjGEYVJMZ9pANqTe2laGWApUFWz6IRggGzTMwXs65PiUrTNATbF+hM
         7GTsrQY0SR1zePhiUwU42B88qudgzvfwvEsOBIpNAp5aW90xyoAqODobGc5mR8rdSF3P
         RaUg==
X-Gm-Message-State: ABuFfoimALoLroZI5VPJE6kg4j4OhpAvldH6dxUdt0jozKfVdVg2ffOf
        sTERoW6cbuEEntOIvSCPBg7fuA==
X-Google-Smtp-Source: ACcGV60BdIhUIj8Dkw4LzSPjJ8N6E37NLhPrR/W5lmoJ9tp85nNOwNUXMd6+qkcmXRIK18j6syRenw==
X-Received: by 2002:a63:8e43:: with SMTP id k64-v6mr12227313pge.75.1538442274810;
        Mon, 01 Oct 2018 18:04:34 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r73-v6sm10100416pfk.157.2018.10.01.18.04.27
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
Subject: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM enabling logic
Date:   Mon,  1 Oct 2018 17:54:54 -0700
Message-Id: <20181002005505.6112-22-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch, default "enable" behavior was unchanged: SELinux
and AppArmor were controlled separately from the centralized control
defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
logic to give all control over to the central logic.

Instead of allowing SELinux and AppArmor to override the central LSM
enabling logic, by having separate CONFIG and boot parameters, this
forces all "enable" variables to disabled, then enables any listed in
the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
any listed in "lsm.disable=...".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++--
 include/linux/lsm_hooks.h                     |  2 +-
 security/security.c                           | 32 +++++++------------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 67c90985d2b8..f646cfab5613 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2279,14 +2279,12 @@
 	lsm.disable=lsm1,...,lsmN
 			[SECURITY] Comma-separated list of LSMs to disable
 			at boot time. This overrides "lsm.enable=",
-			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
-			parameters.
+			CONFIG_LSM_ENABLE.
 
 	lsm.enable=lsm1,...,lsmN
 			[SECURITY] Comma-separated list of LSMs to enable
 			at boot time. This overrides any omissions from
-			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
-			boot parameters.
+			CONFIG_LSM_ENABLE.
 
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fd85637a1931..b026ea93ff01 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
+	int *enabled;		/* Optional: set based on CONFIG_LSM_ENABLE */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index d7132c181ea6..40b9f508b856 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,27 +63,19 @@ static bool __init is_enabled(struct lsm_info *lsm)
 /* Mark an LSM's enabled flag, if it exists. */
 static int lsm_enabled_true __initdata = 1;
 static int lsm_enabled_false __initdata = 0;
-
-static void __init default_enabled(struct lsm_info *lsm, bool enabled)
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
-	/* If storage location already set, skip this one. */
-	if (lsm->enabled)
-		return;
-
 	/*
 	 * When an LSM hasn't configured an enable variable, we can use
 	 * a hard-coded location for storing the default enabled state.
 	 */
-	if (enabled)
-		lsm->enabled = &lsm_enabled_true;
-	else
-		lsm->enabled = &lsm_enabled_false;
-}
-
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
-{
-	if (WARN_ON(!lsm->enabled))
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
 		return;
+	}
 
 	if (lsm->enabled == &lsm_enabled_true) {
 		if (!enabled)
@@ -149,7 +141,6 @@ static void __init major_lsm_init(void)
 }
 
 static void __init parse_lsm_enable(const char *str,
-				    void (*set)(struct lsm_info *, bool),
 				    bool enabled)
 {
 	char *sep, *name, *next;
@@ -165,7 +156,7 @@ static void __init parse_lsm_enable(const char *str,
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (strcmp(name, "all") == 0 ||
 			    strcmp(name, lsm->name) == 0)
-				set(lsm, enabled);
+				set_enabled(lsm, enabled);
 		}
 	}
 	kfree(sep);
@@ -174,11 +165,12 @@ static void __init parse_lsm_enable(const char *str,
 static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
-	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
+	parse_lsm_enable("all", false);
+	parse_lsm_enable(builtin_lsm_enable, true);
 
 	/* Process "lsm.enable=" and "lsm.disable=", if given. */
-	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
-	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
+	parse_lsm_enable(chosen_lsm_enable, true);
+	parse_lsm_enable(chosen_lsm_disable, false);
 
 	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
-- 
2.17.1

