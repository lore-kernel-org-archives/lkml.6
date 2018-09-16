Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB3EECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2021477
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZLbiTN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE2021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIPF7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:59:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42143 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIPF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:59:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so5780445plq.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQRyrUWXnb8AuNAtpkPCS0fYxsM62KDeN7UFNaKV3mc=;
        b=XZLbiTN+JwKzW9hhUi0OTC36CiTE/PlRyC4WnQA1fZLI/YnMVHPIK50v5u5p1QHMfG
         ePxssnT0/wcSvDkqS5r1bHtQ0kpBdGLi7iAHq6h6TJ+bx0CjXkBD9LwpcchuZdiYglmt
         CaXmuC6JFbgnZY6vYjPAhTB3fmw+OdXltX7Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQRyrUWXnb8AuNAtpkPCS0fYxsM62KDeN7UFNaKV3mc=;
        b=WM+uJOhX2hWiUXJLxAOH30aIyr5v1pGFyuau9PDOU6Xj5f6wh6hEYxwMBzMU9QCRWk
         x+hv1sIi+Ao7KKpIcIN6A+kFDd4Kt9jqFvMQg9M8dkF+mKevhOfVYK9+4q/YX5gHvFnx
         IxsZ9Nsfy1BP1EsbQ7Jb9f4PwE66dKa7Cqquu42N0A4BjHoKz7oAJeOuEz/ribxcKYHx
         rTX67lM2h71FhGghsS1tLGZzKFaZTlbDItf+Lg8ddDF6qKlTpG47HayEBtjxLh0QDj0x
         B5xKVzbr5ZWsb0FcJI5IE/AqH0sMsEmzQVD/Uwg/JnR5qwNlxb4JKJAxLt0rStnjWq20
         x8aA==
X-Gm-Message-State: APzg51AMQoKkfB+qHS2T8Z7E4JCuV5Y2o3WhI1vuwUXXcTWrXxM3g1ty
        MQ+3lUf1e3v3OuHYmBeffaCtGQ==
X-Google-Smtp-Source: ANB0VdaRbmpI00JyLlOk81D7Vdq+FYb4F7SfgN1DYBYHFMtte7R134Av8PjYjIsg0x3C/nzY+RgoXA==
X-Received: by 2002:a17:902:7402:: with SMTP id g2-v6mr18388655pll.321.1537058332274;
        Sat, 15 Sep 2018 17:38:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a2-v6sm10913499pgc.68.2018.09.15.17.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:38:49 -0700 (PDT)
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
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
Date:   Sat, 15 Sep 2018 17:30:57 -0700
Message-Id: <20180916003059.1046-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for having a third type of LSM ("shared blob"), this implements
dynamic handling of LSM ordering. The visible change here is that the
"security=" boot commandline is now a comma-separated ordered list of
all LSMs, not just the single "exclusive" LSM. This means that the
"minor" LSMs can now be disabled at boot time by omitting them from the
commandline. Additionally LSM ordering becomes entirely mutable for LSMs
with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
first).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  13 +-
 security/security.c                           | 145 ++++++++++++++----
 2 files changed, 126 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..6d6bb9481193 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4027,11 +4027,14 @@
 			Note: increases power consumption, thus should only be
 			enabled if running jitter sensitive (HPC/RT) workloads.
 
-	security=	[SECURITY] Choose a security module to enable at boot.
-			If this boot parameter is not specified, only the first
-			security module asking for security registration will be
-			loaded. An invalid security module name will be treated
-			as if no module has been chosen.
+	security=	[SECURITY] An ordered comma-separated list of
+			security modules to attempt to enable at boot. If
+			this boot parameter is not specified, only the
+			security modules asking for initialization will be
+			enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
+			or invalid security modules will be ignored. The
+			capability module is always loaded first, without
+			regard to this parameter.
 
 	selinux=	[SELINUX] Disable or enable SELinux at boot time.
 			Format: { "0" | "1" }
diff --git a/security/security.c b/security/security.c
index 67532326a0ce..f09a4bb3cb86 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,17 +32,18 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
+static const char *bootparam_lsms;
 
+/* Ordered list of possible LSMs to initialize. */
+static struct lsm_info **possible_lsms __initdata;
 static struct lsm_info *exclusive __initdata;
 
 /* Mark an LSM's enabled flag, if it exists. */
@@ -52,6 +53,108 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 		*lsm->enabled = enabled;
 }
 
+/* Is an LSM already listed in the possible LSMs list? */
+static bool __init possible_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = possible_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of possible LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (possible_lsm(lsm)) {
+		return;
+	}
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	possible_lsms[last_lsm++] = lsm;
+}
+
+/* Default boot: populate possible LSMs list with builtin ordering. */
+static void __init prepare_lsm_order_builtin(void)
+{
+	struct lsm_info *lsm;
+
+	/* All minor LSMs should go next. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_MINOR &&
+		    lsm->order == LSM_ORDER_MUTABLE)
+			append_possible_lsm(lsm, "builtin minor");
+	}
+
+	/* Then the CONFIG_DEFAULT_SECURITY exclusive LSM. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE &&
+		    !strcmp(CONFIG_DEFAULT_SECURITY, lsm->name))
+			append_possible_lsm(lsm, "builtin default");
+	}
+
+	/* Then other exclusive LSMs, in case above is disabled. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE &&
+		    strcmp(CONFIG_DEFAULT_SECURITY, lsm->name))
+			append_possible_lsm(lsm, "builtin extra");
+	}
+}
+
+/* "security=" boot: populate possible LSMs list from boot commandline. */
+static void __init prepare_lsm_order_commandline(void)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(bootparam_lsms, GFP_KERNEL);
+	next = sep;
+	/* Walk commandline list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    !strcmp(lsm->name, name)) {
+				append_possible_lsm(lsm, "commandline");
+			}
+		}
+	}
+	kfree(sep);
+
+	/* Mark any LSMs missing from commandline as explicitly disabled. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_MUTABLE) {
+			if (possible_lsm(lsm))
+				continue;
+
+			set_enabled(lsm, false);
+		}
+	}
+}
+
+/* Populate possible LSMs list from build order or commandline order. */
+static void __init prepare_lsm_order(void)
+{
+	struct lsm_info *lsm;
+
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_possible_lsm(lsm, "first");
+	}
+
+	/* If no commandline order defined, use builtin order. */
+	if (!bootparam_lsms)
+		prepare_lsm_order_builtin();
+	else
+		prepare_lsm_order_commandline();
+}
+
 /* Is an LSM allowed to be enabled? */
 static bool __init lsm_enabled(struct lsm_info *lsm)
 {
@@ -69,10 +172,6 @@ static bool __init lsm_enabled(struct lsm_info *lsm)
 	if (exclusive)
 		return false;
 
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -93,17 +192,13 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 	}
 }
 
-static void __init lsm_init(enum lsm_type type)
+/* Initialize all possible LSMs in order, if they are enabled. */
+static void __init lsm_init(void)
 {
-	struct lsm_info *lsm;
-	enum lsm_order order;
+	struct lsm_info **lsm;
 
-	for (order = LSM_ORDER_FIRST; order < LSM_ORDER_MAX; order++) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (lsm->type == type && lsm->order == order)
-				maybe_enable_lsm(lsm);
-		}
-	}
+	for (lsm = possible_lsms; *lsm; lsm++)
+		maybe_enable_lsm(*lsm);
 }
 
 /**
@@ -119,25 +214,21 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
+	possible_lsms = kcalloc(LSM_COUNT + 1, sizeof(*possible_lsms),
+				GFP_KERNEL);
 	pr_info("Security Framework initialized\n");
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	lsm_init(LSM_TYPE_MINOR);
-
-	/*
-	 * Load all the remaining security modules.
-	 */
-	lsm_init(LSM_TYPE_EXCLUSIVE);
+	prepare_lsm_order();
+	lsm_init();
 
+	kfree(possible_lsms);
 	return 0;
 }
 
 /* Save user chosen LSM */
 static int __init choose_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	bootparam_lsms = str;
 	return 1;
 }
 __setup("security=", choose_lsm);
-- 
2.17.1

