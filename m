Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA4ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD2208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anYDr9YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBD2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIPFwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so6014806pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nLcsl65zXuCwewU4XBNjy0s1JU3SYG9gCRtZLL604ME=;
        b=anYDr9YQ4Fa7NbHA7Q7jOy33HQQET52pJj6Qjgiy6nO2oXibz3UKxmVwFPjN1Kofm+
         Iir9FuGDLrUNaJ2m+927D3fTmIwo5dLSaxsbMcIe8ZbSd5TENB8H5dmXeHx7TpeyDGAJ
         wBp5ZaKk6H7eWIxm+5dF0ihSJpWaKzGP/WcGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nLcsl65zXuCwewU4XBNjy0s1JU3SYG9gCRtZLL604ME=;
        b=oQQZF0OH3ylRp9QDA+hH8pwohyqYBWMO9n6qF1ayMJVq8cTJB1L0wjTqKKw8M3r88I
         YiBDXBCYZJfv/4EfKR9xFmYfRDYrnZH8zvqtrI9A6aXCqfeVOQBv2ORkpEmB7biDtozP
         i/RjJw7ZyiZL7CKz8lYkLLQQo8qGT3Natogrm3TmEHK8l/IyqKROfzj2l5zs9FNrJEc7
         j267pCdSbUJN1CeCuc+SqR1lpFgoLGXm3D910sAfYuj+B4mZuC2caCugqY6eYs198THT
         JVYp9cBoaej4YhjedjAH2YIuljCEKY81u/GCFf/0PmJiSKGL5ATaGL/xDSSmzgxSd3wG
         MbvA==
X-Gm-Message-State: APzg51DFI6jphPLYyefrb1mVA85xUjYYS4F6iOQvweUzodQZHx+s8+jL
        Mh4c1je9xp+uRsD3kHCk/skaL9L6EXo=
X-Google-Smtp-Source: ANB0VdaijiiKbWYaCFSA7MnRBMzgIsZlDcg8Or9m78blsE1jLfqb7rXumOdTEtXJRC8znedpH75eCA==
X-Received: by 2002:a62:c699:: with SMTP id x25-v6mr19433799pfk.16.1537057872936;
        Sat, 15 Sep 2018 17:31:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h20-v6sm12346317pgg.3.2018.09.15.17.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
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
Subject: [PATCH 07/18] LSM: Add minor LSM initialization loop
Date:   Sat, 15 Sep 2018 17:30:48 -0700
Message-Id: <20180916003059.1046-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split initialization loop into two phases: "exclusive" LSMs and "minor"
LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 8 +++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f8e618e2bdd2..ec3419b9b16f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,7 +2039,13 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+enum lsm_type {
+	LSM_TYPE_EXCLUSIVE = 0,
+	LSM_TYPE_MINOR,
+};
+
 struct lsm_info {
+	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
 
diff --git a/security/security.c b/security/security.c
index 74ab98f82d34..da2a923f2609 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,12 +43,13 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
-static void __init major_lsm_init(void)
+static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		lsm->init();
+		if (lsm->type == type)
+			lsm->init();
 	}
 }
 
@@ -73,11 +74,12 @@ int __init security_init(void)
 	capability_add_hooks();
 	yama_add_hooks();
 	loadpin_add_hooks();
+	lsm_init(LSM_TYPE_MINOR);
 
 	/*
 	 * Load all the remaining security modules.
 	 */
-	major_lsm_init();
+	lsm_init(LSM_TYPE_EXCLUSIVE);
 
 	return 0;
 }
-- 
2.17.1

