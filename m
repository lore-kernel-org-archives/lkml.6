Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7487CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFBA21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hkOjT+tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFBA21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeIYGXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeIYGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85-v6so7044382pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V3gWF7rko5DL5iZJCCi6Kc67O4L0MbWrE1FLQotdnGU=;
        b=hkOjT+tkFnNlRszSXPE//GHlDYA0w4AK8opuzxqqgNSPnb4aEo6bx3OTwffySrpN4W
         jIb9d1mocCjbaiWHTR+rZjDkXeKO0vUU+VHXyYFomeC2mkGsAuU6YmkwUm26MIDQ6jZJ
         gsOo7QwkxDatM8nWhoWjLBhDOoJ+Kh5j0QS1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V3gWF7rko5DL5iZJCCi6Kc67O4L0MbWrE1FLQotdnGU=;
        b=d0IAM5pIYr8WBFd5w6hYdnkcrJUnK+ih0gSPeT1bpYTwrESrsI6IiXLi5wyrjx7n7B
         WRB8viIwMN0RJdnUFLMfuKF7OqeHayKHCPuZz7jCGoshh9MVAboNHxEdZZ4cnfQI6T4I
         84hlPcvvWj8BeliE7nTo51qa6mAU6TQJW58lBfI+6/5OouT4ps2Qe8+yKNcaX95A8E9l
         29q3hNZNSaNd8RuWb0GgVqNmAti4OFE2w/T7kPiBFrbPNneNP+GrAJnem0XXfJl1Khrh
         tEtuecnR0OKbG+fX5wqofCttsVZ1qfWEUoFmmLy9dLhH33a/OHZ5x3/UEgNb2oihljA/
         KvGA==
X-Gm-Message-State: ABuFfoi4zt4uHUgjK1QjkX6iX9qhq2pmNTUmXe1K0SRgQVTEtUsPfeCh
        FRsbGr7LsIje9RvEVhke5pIHhA==
X-Google-Smtp-Source: ACcGV60qe4zTewbildyI7dwKMAKAlT5Ht4YTAsfkNCS7qLzGRoOJBbDOROzO5coNkv/AJZkjpEC9Kw==
X-Received: by 2002:a17:902:44:: with SMTP id 62-v6mr955985pla.181.1537834727371;
        Mon, 24 Sep 2018 17:18:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v83-v6sm612154pfa.103.2018.09.24.17.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:42 -0700 (PDT)
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
Subject: [PATCH security-next v3 09/29] LSM: Provide init debugging infrastructure
Date:   Mon, 24 Sep 2018 17:18:12 -0700
Message-Id: <20180925001832.18322-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
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

