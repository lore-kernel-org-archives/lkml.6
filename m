Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD30AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A982147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeXHPMHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A982147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbeITWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:14:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbeITWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:14:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so4617350pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AcW3F/O+fl3XT2ZLqa+o+qWhOJ9ucCkwfwLeB76MZXo=;
        b=JeXHPMHHyCZQH9VNVaKgHvagSKYLdbtUuEpEDnIu9WRq5VXUF6pIMIe1YC2FAQfcTL
         H4AK2mucZZCXLHunN5rEIvVtDZk7RuEFq8nc1Gej5ylMVwlVuCjC7TnXaKo5EJnIyVgW
         VrYjM81q5d5lamF2qVadA9rR6IUB780UKq86M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AcW3F/O+fl3XT2ZLqa+o+qWhOJ9ucCkwfwLeB76MZXo=;
        b=W/TOWYOFw/JyM1CPqcayV09YC9xt8GHNnnd7JOi14OeLrEdABw0iywGryWvZfcMQd/
         xjTe1LHmGI6vnkk2iMls2+xZnC8c5V3Vily7GRdxPcdMPT6uW+X2Q634tg381v6BAsKI
         1nkloIR7OxxVWVG0dqxw1aNSw/Lb7AAa4gHNr/6ZQReIt3X+n6F1lePkBvd+rsMZhkzv
         5rk9D5vKOU67v8ALChevKzZ19vOBrnSUDu4zRRlpNe9PgT5xVO/olbUMKQ41cF/naX7q
         NJaIkXQxDVbcod7OyflF/+bm7VOkzzewk7wEMDyGk1i7Tx0+5EBdtnKz0xQmSt4LU72x
         Qp7w==
X-Gm-Message-State: APzg51BpTiQVmjR8JPdcicWHqzInIjKaMzuPfJszcfy53aqSFm3Ms1gJ
        jRNLL1mNv8emlv4IMrcsCmDBRA==
X-Google-Smtp-Source: ANB0VdZuFqaJsFSrEv52yNE+G9Q1sPwlwtBHGpcBceWc32tzAKdCVk5l6Zi07Zs3eHaZVH1ifS0aXg==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr42279294pfi.66.1537460982880;
        Thu, 20 Sep 2018 09:29:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s70-v6sm7430271pgc.16.2018.09.20.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:29:39 -0700 (PDT)
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
Subject: [PATCH security-next v2 16/26] LSM: Prepare for reorganizing "security=" logic
Date:   Thu, 20 Sep 2018 09:23:28 -0700
Message-Id: <20180920162338.21060-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index 72d1ef2fc4cc..5cacbcefbc32 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,16 +34,12 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_major_lsm;
 
 static bool debug __initdata;
 #define init_debug(...)						\
@@ -90,7 +86,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -154,6 +150,9 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
@@ -173,12 +172,12 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
-static int __init choose_lsm(char *str)
+static int __init choose_major_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	chosen_major_lsm = str;
 	return 1;
 }
-__setup("security=", choose_lsm);
+__setup("security=", choose_major_lsm);
 
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
-- 
2.17.1

