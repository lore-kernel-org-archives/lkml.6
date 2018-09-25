Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E5AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301632098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pc+q2RRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301632098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeIYGYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:24:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39084 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeIYGXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85-v6so7044598pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5l74R9wyjkir+Dl1KfDtlUqJXEi99o1nRx2MTGeLAA=;
        b=Pc+q2RRyvzsoZBouIG80xzpFm9EsGeO0tXH6j1/diIYrgBIbKZyvtDViuG9FxKDXtb
         i1n/PqHYqFeMMikJATe+MEztj7ZWbYCteKV5QPaeR98UGRYs4Zvod/03NjQ4KE4b1ugf
         JzOq4kpyJauKk2D8askDI5VN8m3R+bF8GVX9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5l74R9wyjkir+Dl1KfDtlUqJXEi99o1nRx2MTGeLAA=;
        b=THgc4CWjZYYroft/YmjgtHQS5nvpLMt0gkGE5UQ8oc1j5vTbKW9yP/nlsGCO6NNW1i
         mla4B22mk4/gUALt7nZzhdpxOV0IkX4eY4dSMCjzHEdj8tWa9N3E7zzaPj+r4ukNWBSL
         KGyNKp/SL4N4Rj+QkDe4kYANL9dsYhhde4V5XJ6BtjFYh4G7It2fi5qa5935XrTrk4yJ
         6+lA4d4Chvk8JanH+xHCS+xvIoRH+dyzHfP+idT+2ObLkbJuj6qrd7kX+fMH/5ABylXe
         DZmtYqqiWuK4VXvOmKBMshX7u7j5q4u6yBx5Rz/vCzgvWSseBSmUPoPIAmOjrUXiDWAA
         JHoA==
X-Gm-Message-State: ABuFfohjhOHYhgZsNnF/vcU7DV68xm0PHxZDqeCb1jZzzX09nTKpaw54
        c6z79D5HiuZbG4QS9F1hVBc+PA==
X-Google-Smtp-Source: ACcGV61YOtyaJj2609MU4UnUf90BOclgZko4bqt+Ci7APPeVZ7gzO9IsnE17FTypeJudSy2XHtQPAA==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr891384pgp.65.1537834736257;
        Mon, 24 Sep 2018 17:18:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k3-v6sm903756pfk.60.2018.09.24.17.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:48 -0700 (PDT)
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
Subject: [PATCH security-next v3 29/29] LSM: Add all exclusive LSMs to ordered initialization
Date:   Mon, 24 Sep 2018 17:18:32 -0700
Message-Id: <20180925001832.18322-30-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes CONFIG_DEFAULT_SECURITY in favor of the explicit build-time
ordering offered by CONFIG_LSM_ORDER, and adds all the exclusive LSMs to
the ordered LSM initialization. The old meaning of CONFIG_DEFAULT_SECURITY
is now captured by which exclusive LSM is listed first in the LSM order.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 43 ++++---------------------------------------
 security/security.c | 23 +----------------------
 2 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index e37de9a44747..efa4826c3d99 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,43 +239,6 @@ source security/yama/Kconfig
 
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
 config LSM_ENABLE
 	string "LSMs to enable at boot time"
 	default "all"
@@ -293,12 +256,14 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "yama,loadpin,integrity"
+	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
 	  after any listed LSMs. Any LSMs listed here but not built in
-	  the kernel will be ignored.
+	  the kernel will be ignored. If the boot parameter
+	  "lsm.order=" is used, it will override this order, with any
+	  unlisted LSMs falling back to the order of this config, etc.
 
 	  If unsure, leave this as the default.
 
diff --git a/security/security.c b/security/security.c
index 5a3e19f1fe48..fedc26fb8554 100644
--- a/security/security.c
+++ b/security/security.c
@@ -154,7 +154,6 @@ static void __init parse_lsm_order(const char *order, const char *origin)
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (lsm->order == LSM_ORDER_MUTABLE &&
-			    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
 			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
@@ -186,8 +185,7 @@ static void __init prepare_lsm_order(void)
 
 	/* Add any missing LSMs, in link order. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_MUTABLE &&
-		    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		if (lsm->order == LSM_ORDER_MUTABLE)
 			append_ordered_lsm(lsm, "link-time");
 	}
 
@@ -245,18 +243,6 @@ static void __init ordered_lsm_init(void)
 		maybe_initialize_lsm(*lsm);
 }
 
-static void __init major_lsm_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-			continue;
-
-		maybe_initialize_lsm(lsm);
-	}
-}
-
 static void __init parse_lsm_enable(const char *str,
 				    void (*set)(struct lsm_info *, bool),
 				    bool enabled)
@@ -290,8 +276,6 @@ static void __init prepare_lsm_enable(void)
 	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
 
 	/* Process "security=", if given. */
-	if (!chosen_major_lsm)
-		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 	if (chosen_major_lsm) {
 		struct lsm_info *lsm;
 
@@ -334,11 +318,6 @@ int __init security_init(void)
 	prepare_lsm_order();
 	ordered_lsm_init();
 
-	/*
-	 * Load all the remaining security modules.
-	 */
-	major_lsm_init();
-
 	kfree(ordered_lsms);
 	return 0;
 }
-- 
2.17.1

