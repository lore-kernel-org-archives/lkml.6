Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B009C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED4720841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dg5iAQJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED4720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJKHnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeJKHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so3442573pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3G6jZlpTaj7SjcMKQ9jlQ7SbDDXxzquRoJPLZTO5H4=;
        b=dg5iAQJMWFrX83s5d3vVRoxp4uxA1LkCL2Ls9eFz3EhPVAYgtJqdqCUBoW7kmM2qRP
         0RlmEaF6WL2y3vijfrmnitI7f2DhWhSIyfiiixNF/kNbwYcInJU/aa70mqHdKjCaODzh
         U3c5Lvqb/1mN/nmP5GseZ37xccQyI9FqL/G+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3G6jZlpTaj7SjcMKQ9jlQ7SbDDXxzquRoJPLZTO5H4=;
        b=glOlyQI8CI9VlWSjBNJwpV8KhGmjU9513MHWrrs7Mw5qwLiFyg0VYzKJ330VQ+vvGB
         FfDjl8wOrDXCOIQugT/BmGCaPcx6HQMMK96FVQa2vAAConHJaKnlGwX0ezrnrEpU61eo
         MJbSMRNFqeJuRnioOXtZ9pzegaHWjqbhSvh5q0PadD/QPF0/rwVu3mx41Wy29irn78Rl
         L09GGBsA6NEVJVtg8ttOyCc2KcCwMG3fl+kmpeio9uDfgYsDFKhqaBozOl4s0DUQPdeO
         Id3qfCw/dEoopVBLLdLlUgtpwfWVPPPt3BMeAvnwqDxH+4D8m6kJBfLVJklp3lshudZ0
         JVGg==
X-Gm-Message-State: ABuFfoiVnZs+YyDbEqKJybYV6qFVwryTb1GiP2486h+op+6R4laMgA44
        uSVxVqtcZMQpRvbEOFQqBnowEwQQkiU=
X-Google-Smtp-Source: ACcGV62IGmxCychjvc+FVpBPqxGWtVHKGNZVge9/GY5v7i7aAErhTB1fgphOUELGEsXhF3poGaP7mw==
X-Received: by 2002:a63:2643:: with SMTP id m64-v6mr31224545pgm.435.1539217150604;
        Wed, 10 Oct 2018 17:19:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p4-v6sm25604331pfg.188.2018.10.10.17.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:19:06 -0700 (PDT)
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
Subject: [PATCH security-next v5 16/30] LSM: Build ordered list of LSMs to initialize
Date:   Wed, 10 Oct 2018 17:18:32 -0700
Message-Id: <20181011001846.30964-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This constructs an ordered list of LSMs to initialize, using a hard-coded
list of only "integrity": minor LSMs continue to have direct hook calls,
and major LSMs continue to initialize separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 58 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index 8968c98e0a0e..9bb15d697287 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,6 +37,9 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -45,6 +48,9 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info **ordered_lsms;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -85,6 +91,34 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 	}
 }
 
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	ordered_lsms[last_lsm++] = lsm;
+	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
+		   is_enabled(lsm) ? "en" : "dis");
+}
+
 /* Is an LSM allowed to be initialized? */
 static bool __init lsm_allowed(struct lsm_info *lsm)
 {
@@ -121,18 +155,32 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-static void __init ordered_lsm_init(void)
+/* Populate ordered LSMs list from single LSM name. */
+static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
-			continue;
-
-		maybe_initialize_lsm(lsm);
+		if (strcmp(lsm->name, order) == 0)
+			append_ordered_lsm(lsm, origin);
 	}
 }
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info **lsm;
+
+	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
+				GFP_KERNEL);
+
+	ordered_lsm_parse("integrity", "builtin");
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		maybe_initialize_lsm(*lsm);
+
+	kfree(ordered_lsms);
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.17.1

