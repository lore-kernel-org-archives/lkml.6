Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB99DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F35B2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GssHaghU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F35B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeJKHuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40860 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so3294907plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3Rn1Vu6J+MynTAWlzZFNM86DMwzLFNgXxOVSZrRq4M=;
        b=GssHaghULj0202mm4Q+TkXZyANOB8bpB7rB/hrLSoWtrvZuq77Z5/43fo3/ksejQoa
         XuACGmImRc0KpCdW+5aguZtdk9bwuHzuGnOBIwKxKZz4IwOTcGeelTBuDTlVyMlZCaYv
         twWS3zm/lq3q4ccZ8I5mpgucnHf6JSHBlR0/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3Rn1Vu6J+MynTAWlzZFNM86DMwzLFNgXxOVSZrRq4M=;
        b=VlVqmXsS8336xg+6tu/aSXZupTvVj3SMB17UxuxyvZMFdct/JByck46f0kfABHGbIB
         /ntnDlDHawUEj40vn0tZBTXjeIkPvrIRntNRxBsatHkz27Fm5AHgqu5SB1z/fI1GYdqL
         niBuAD4J2sUbCdPy3g12+5eSZmN3pH1AA5pLxFaHEM74vgCKwOHzvrO+lOwZ34B9Vq+f
         nL787AMGd5QWtyKvHR83OwW1NSZre2LHtgRqcJc2DNLwbrJvpkFcVA8uxmwAv/TS1NCt
         7cP2F0mjRHloQfG2xHcJ662npkN7wbVGxxWtTLpaYqyajB29koTrPahCpaWK0t/R6459
         xXtQ==
X-Gm-Message-State: ABuFfojUkEHSJ5OyZg1WH9mdW5osQAUvasxeosv1LlkxlTVu75hPx065
        jj3XawYZNkzhFsddkQH8JLWheg==
X-Google-Smtp-Source: ACcGV61cd4KP8MEFuD9gVVtS0zUppyIPOBNavb9Of99Bx8SiXjk0XuM4xsOCTRmUPQII0dgPM6pXqg==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr33939722pla.272.1539217546453;
        Wed, 10 Oct 2018 17:25:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d186-v6sm33693640pfg.173.2018.10.10.17.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:45 -0700 (PDT)
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
Subject: [PATCH security-next v5 18/30] LSM: Introduce "lsm=" for boottime LSM selection
Date:   Wed, 10 Oct 2018 17:18:34 -0700
Message-Id: <20181011001846.30964-19-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a way to explicitly choose LSM initialization order via the new
"lsm=" comma-separated list of LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 security/Kconfig                                |  3 ++-
 security/security.c                             | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 32d323ee9218..d6389ab66f49 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2276,6 +2276,10 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm=lsm1,...,lsmN
+			[SECURITY] Choose order of LSM initialization. This
+			overrides CONFIG_LSM.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index 005634f7c4bb..0aa82c1c928e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -281,7 +281,8 @@ config LSM
 	default "integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-	  Any LSMs left off this list will be ignored.
+	  Any LSMs left off this list will be ignored. This can be
+	  controlled at boot with the "lsm=" parameter.
 
 	  If unsure, leave this as the default.
 
diff --git a/security/security.c b/security/security.c
index 1c4889bce917..70cb2d0004e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_order;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -190,7 +191,10 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse(builtin_lsm_order, "builtin");
+	if (chosen_lsm_order)
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
@@ -252,6 +256,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.17.1

