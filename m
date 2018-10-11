Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A909C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8720870
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFVYQeBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A8720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJKHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35919 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJKHuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so3457589pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDq8QXTvGfDQo8enk7I/8dLpEbR7SYI/PHjZNIdtOls=;
        b=TFVYQeBD3isOYarr6fwcaguoEF1VqoyVIGS/Jy4VnBSn2ch8BFXlv3ocNYM/+XaNvU
         4drzTWDWTFNWge+b+2BbGWlF2i90wvl1/SNzzKJXnrlqQpUF1WVonESt1NOKpO8aKjU2
         UMTwYPv58C17E6wKQXqWMp1wLhBLl6zFy1YMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDq8QXTvGfDQo8enk7I/8dLpEbR7SYI/PHjZNIdtOls=;
        b=BBiKG3Mc4lCaj6N1EqrVqM7mR/BOB7ZZcaNbo9X/GK/buNpeSeHYfy84LGkCauwmv8
         /d/cLSWT1HLMDtjOcjxAiWDiBOSQYdBkSlHNW1DjEB9mG4pll2o9s/KFF8+Hldy0tFEC
         EBy6RJ46zWJcfZdywoo2fogK2G0tXAZbj3nV8uqv8O9tbKiTGS/zWbTm9c2RLCErsv8u
         /jVaOE5GsZSYBUJZtdPAa+67kp5MnVcMOA/SpSU+9LqDSE0ZGM3Tvgh87Dz3KCRvmMhW
         T2ZshgV8gfKIHA6t7f5M2UqaXsL5ZAwByr7/XYfbzJ9R24CgxxRKvSqBClrO1hzIrj0o
         KQTg==
X-Gm-Message-State: ABuFfoigDBMwyiNl3TkFkgTPtDTYvmqo023XXTLTOrEgNEkOJjAQtHwE
        b+achsD/4haR6Mj00SKm2sk1eg==
X-Google-Smtp-Source: ACcGV63wJGPcUqiX1haS0R+LeYhgztWmc+PLTeJMbugNUBpVwZbLBngSTPX4KjH9F5Jbs3eX5FrsHg==
X-Received: by 2002:a62:5e02:: with SMTP id s2-v6mr25795217pfb.146.1539217558491;
        Wed, 10 Oct 2018 17:25:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 187-v6sm43659859pfu.129.2018.10.10.17.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:57 -0700 (PDT)
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
Subject: [PATCH security-next v5 20/30] LSM: Prepare for reorganizing "security=" logic
Date:   Wed, 10 Oct 2018 17:18:36 -0700
Message-Id: <20181011001846.30964-21-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index f3777ed4ca80..1b1ee823457c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,9 +34,6 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -45,9 +42,8 @@ static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 static __initdata const char *chosen_lsm_order;
+static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -138,7 +134,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -195,6 +191,9 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+
 	if (chosen_lsm_order)
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
 	else
@@ -257,12 +256,12 @@ int __init security_init(void)
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
 
 /* Explicitly choose LSM initialization order. */
 static int __init choose_lsm_order(char *str)
-- 
2.17.1

