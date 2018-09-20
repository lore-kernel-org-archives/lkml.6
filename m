Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F9D2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+GIwIYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F9D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbeITWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46314 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbeITWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so4597933pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBGZ2JAq52GVO7DMel4vdKBb6P5PB4Nfw1MCI4/fUVo=;
        b=Y+GIwIYy1i7nEwQqJoICogiY+6igMki3L7ZSogo14PNlABRQEWW34ENWdENkTFLofS
         VhQA+q4UDjAGnttTPca83jRHMhW/Gu5ldBqLc+69eTE+JfGKI1AG2zUBJ54LLLFP/a3c
         h05HMkTWAnnhgCgfOpjEbBN/gOjdl7ZB/G+Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iBGZ2JAq52GVO7DMel4vdKBb6P5PB4Nfw1MCI4/fUVo=;
        b=Ux3Kxpdu/0EXsVmYq7ihiXmRRS4Vt+kX6N3CBjLWcF+TgiBEkuJC4OXqP/QiO811dG
         rZtuCtfwkbsr2bUTkH1yCU2KRiSEh3yD9pwlCXSvA4FVyv81pOqlSGsaD/gJJUKM32tf
         FzoLHwoTJz8f4wkxGGf6FOvHulyAMZoLoru94FJ2jdpCRrjJTvLBwycxif80XKm5E8k+
         QwRgaW1leLttoZrcxJTD7ssSL2M2YVjRZq4K7LUiDQbRJra8ukJuYO97iZhjwaPCLsfX
         C/QUzysvywvmBa9S0mIwp+BgVznjhcCluOEr9OagVXjBYjBLYTL1NR0tZk6CJ2pGa2ld
         U+ag==
X-Gm-Message-State: APzg51Ct0gjXG9/JBgEoM5SK/7hQW1RKDFr6RCX6JJER7Tyw8Lok2YgG
        VcYBBMvktSQfrFCkmPCzP6XLdQ==
X-Google-Smtp-Source: ANB0VdZvPEYthdJSOrAqvxPARMZrpWIfjJvEAEpojcDbp8zFuDwP3KnBJnX8gt0DwiFHtCoAvxq55A==
X-Received: by 2002:a65:5a81:: with SMTP id c1-v6mr37761175pgt.120.1537460640540;
        Thu, 20 Sep 2018 09:24:00 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v186-v6sm30118436pgd.25.2018.09.20.09.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:23:55 -0700 (PDT)
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
Subject: [PATCH security-next v2 19/26] LSM: Introduce CONFIG_LSM_ORDER
Date:   Thu, 20 Sep 2018 09:23:31 -0700
Message-Id: <20180920162338.21060-20-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a way to declare LSM initialization order via Kconfig.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 11 +++++++++++
 security/security.c | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..de8202886c1d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,16 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM_ORDER
+	string "Default initialization order of builtin LSMs"
+	default "integrity"
+	help
+	  A comma-separated list of LSMs, in initialization order.
+	  Any LSMs left off this list will be link-order initialized
+	  after any listed LSMs. Any LSMs listed here but not built in
+	  the kernel will be ignored.
+
+	  If unsure, leave this as the default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 2541a512a0f7..063ee2466e58 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,8 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_major_lsm;
 
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
+
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
 
@@ -108,14 +110,44 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
 }
 
-/* Populate ordered LSMs list from hard-coded list of LSMs. */
+/* Populate ordered LSMs list from given string. */
+static void __init parse_lsm_order(const char *order, const char *origin)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			    strcmp(lsm->name, name) == 0) {
+				append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
+
+		if (!found)
+			init_debug("%s ignored: %s\n", origin, name);
+	}
+	kfree(sep);
+}
+
+/* Populate ordered LSMs list from builtin list of LSMs. */
 static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* Parse order from builtin list. */
+	parse_lsm_order(builtin_lsm_order, "builtin");
+
+	/* Add any missing LSMs, in link order. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (strcmp(lsm->name, "integrity") == 0)
-			append_ordered_lsm(lsm, "builtin");
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			append_ordered_lsm(lsm, "link-time");
 	}
 }
 
-- 
2.17.1

