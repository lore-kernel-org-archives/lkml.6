Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E3AECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BA0208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ofzqINPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BA0208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIPF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:59:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34044 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeIPF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:59:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so6037477pgv.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2a8mtVOqwOdVQK0JP99dIDkyrDFiG7OKha89K/kGZo=;
        b=ofzqINPOfpLuNLuL9A2VCBKjO5QtQrS9dGNUj0eZQvRxPSZZDiEcE4Ojf+uHoMbcCV
         3MyEwqG5pnTFTpymwuLZqkh8Y9xVY26R/4h42Jrvv/AIPxy6Q8YAV3cyQOjcP0dmPlzz
         hUdCUI0OQbfEigCM1dswQZJxlHle0Spr2CuZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2a8mtVOqwOdVQK0JP99dIDkyrDFiG7OKha89K/kGZo=;
        b=PPwX+pfgUhJq/thKSIy3yiVQ8Z9cLVpkhmdqFeKUnnw+FHGfI8hFyzpf62mwlK3Ha/
         AmSZEZWzFNhSqf5Qp/8DxRSd97wNGIu9gGTQAzaj0HSjuioZGKiLl+6GsvfDuMrR0ywg
         EI42O8gt7gOUghLcUGqDkQ9yauQzcAF+dJiUFNdYMHPYxeCeNJE5N+U/w1XK4s6i53vR
         IQn4l2Qwx+8RgjtArZ+pYmh3INmsKo1Snqoba13yRGsWkFZpq8ozy8cqCJYaGObUAqIv
         c62QpNOVSREws7FgR+PNKQheXj7VQi86YUup8zU8zI3Dkd7bhwS1hR5NSmIuunuqscu9
         zx0A==
X-Gm-Message-State: APzg51AM6k44dZ7QPWKNKvsjBb/KFnSveLiZ9mLamXHAA29LShV0X0h1
        xfk/+eaZd0yMaU19XCGqF4BcUg==
X-Google-Smtp-Source: ANB0VdYRnkvgbnKbIAgkQ1GPwRJC+dvqK3+qjofA9c3G6qrJjJ0pcpDh3mGVbtv1gJQztqOUFTU+QQ==
X-Received: by 2002:a62:7e93:: with SMTP id z141-v6mr19351317pfc.14.1537058330398;
        Sat, 15 Sep 2018 17:38:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l127-v6sm17374187pfc.55.2018.09.15.17.38.48
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
Subject: [PATCH 17/18] LSM: Provide init debugging
Date:   Sat, 15 Sep 2018 17:30:58 -0700
Message-Id: <20180916003059.1046-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with "lsm.debug" will report details on how LSM ordering
decisions are being made. Additionally changes tense of "Framework
initialized" to "... initializing" since it hadn't finished its
work yet.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 security/security.c                           | 30 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6d6bb9481193..c3e44a27c86a 100644
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
index f09a4bb3cb86..3b84b7eeb08c 100644
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
@@ -46,6 +48,13 @@ static const char *bootparam_lsms;
 static struct lsm_info **possible_lsms __initdata;
 static struct lsm_info *exclusive __initdata;
 
+static bool debug __initdata;
+#define init_debug(...)						\
+	do {							\
+		if (debug)					\
+			pr_info(__VA_ARGS__);			\
+	} while (0)
+
 /* Mark an LSM's enabled flag, if it exists. */
 static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
@@ -71,6 +80,7 @@ static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
 	if (possible_lsm(lsm)) {
+		init_debug("duplicate: %s\n", lsm->name);
 		return;
 	}
 
@@ -78,6 +88,7 @@ static void __init append_possible_lsm(struct lsm_info *lsm, const char *from)
 		return;
 
 	possible_lsms[last_lsm++] = lsm;
+	init_debug("%s possible: %s\n", from, lsm->name);
 }
 
 /* Default boot: populate possible LSMs list with builtin ordering. */
@@ -117,12 +128,18 @@ static void __init prepare_lsm_order_commandline(void)
 	next = sep;
 	/* Walk commandline list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (lsm->order == LSM_ORDER_MUTABLE &&
 			    !strcmp(lsm->name, name)) {
 				append_possible_lsm(lsm, "commandline");
+				found = true;
 			}
 		}
+
+		if (!found)
+			init_debug("ignoring: %s\n", name);
 	}
 	kfree(sep);
 
@@ -133,6 +150,7 @@ static void __init prepare_lsm_order_commandline(void)
 				continue;
 
 			set_enabled(lsm, false);
+			init_debug("disabled: %s\n", lsm->name);
 		}
 	}
 }
@@ -187,6 +205,7 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
 			exclusive = lsm;
+			init_debug("exclusive: %s\n", exclusive->name);
 		}
 		lsm->init();
 	}
@@ -211,12 +230,13 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
+	pr_info("Security Framework initializing\n");
+
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 	possible_lsms = kcalloc(LSM_COUNT + 1, sizeof(*possible_lsms),
 				GFP_KERNEL);
-	pr_info("Security Framework initialized\n");
 
 	prepare_lsm_order();
 	lsm_init();
@@ -233,6 +253,14 @@ static int __init choose_lsm(char *str)
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

