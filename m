Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D375EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrecM7tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8998F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbeITWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34357 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbeITWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so4594242plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V3gWF7rko5DL5iZJCCi6Kc67O4L0MbWrE1FLQotdnGU=;
        b=BrecM7tmXbNMsUhl0Mupx9lVNe2C1xFeTN5HxndpWFG10LXFE2t093zwwIFTEldMjU
         0B/JdxWJCPJF7nf71jJKwN7QYCxwBJUxgygh5eQFom/wYx3UkP0M4hpk2VdVGZf0k6EW
         2AaLPMYE1mizLaCJLG+W0bfPevqbuWTU05lfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V3gWF7rko5DL5iZJCCi6Kc67O4L0MbWrE1FLQotdnGU=;
        b=g1Sma/O9Y6sab6OCHLxvGxlHwwNENhPb7EjKpFRvdKImcPI6KaTX0cUksZlGt8a9Jk
         +hcUGNrZSfv4OviLXt09HVwQ2A7+vRtGFK9tUzXiZ15CR9uwfTF87OKVHwrDFIKjGAPP
         C/ThbgZ68t8VfG6uCltlDZBxKKCOkFSgY2I8JauxTisl36HeqA6uXN56ntT4NOQvjGGl
         TDW/+UV93uRA/HTxtzY0WUKlr3PQ7D8b2RyLiCHjGKkEQGnmnMLUvvSv79GLl4mXXa1E
         2LpAkCdX16Z2mhB3Cvc61l0wJ83Vq1d59kF72Lq05kawl3wCibOeBzrre350cgKg0znG
         SAqQ==
X-Gm-Message-State: APzg51A6v9dWHDxnhNgDetQjZ0Q4UKAA90ETUcU1aVVAGj5w6sRVQC29
        COwWdtHurg70n3zdSWOalIgyRw==
X-Google-Smtp-Source: ANB0VdaT5w+o1c5n0s5kLoyPzssRAmXN8DL5+YS5AWpbocANlJiupF6evitkfd4CBV5WESokBnW9Cw==
X-Received: by 2002:a17:902:4601:: with SMTP id o1-v6mr40579191pld.202.1537460634349;
        Thu, 20 Sep 2018 09:23:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t1-v6sm26569696pgp.32.2018.09.20.09.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
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
Subject: [PATCH security-next v2 09/26] LSM: Provide init debugging infrastructure
Date:   Thu, 20 Sep 2018 09:23:21 -0700
Message-Id: <20180920162338.21060-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with "lsm.debug" will report future details on how LSM ordering
decisions are being made.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt          |  2 ++
 security/security.c                            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..32d323ee9218 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2274,6 +2274,8 @@
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
+	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/security.c b/security/security.c
index e74f46fba591..ee49b921d750 100644
--- a/security/security.c
+++ b/security/security.c
@@ -12,6 +12,8 @@
  *	(at your option) any later version.
  */
 
+#define pr_fmt(fmt) "LSM: " fmt
+
 #include <linux/bpf.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
@@ -43,11 +45,19 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static bool debug __initdata;
+#define init_debug(...)						\
+	do {							\
+		if (debug)					\
+			pr_info(__VA_ARGS__);			\
+	} while (0)
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		init_debug("initializing %s\n", lsm->name);
 		lsm->init();
 	}
 }
@@ -91,6 +101,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Enable LSM order debugging. */
+static int __init enable_debug(char *str)
+{
+	debug = true;
+	return 1;
+}
+__setup("lsm.debug", enable_debug);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1

