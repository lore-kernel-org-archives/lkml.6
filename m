Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA620C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SzKobk9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EA620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJBHpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41316 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeJBHpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:08 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so275708iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pq4ACjGaPlM3h3UYEHG6fyOCzAt325XuBayF3KFtHqs=;
        b=SzKobk9CWHgW0EjDQXpy5PM5QZ3lzRGlKyIOumCKOBfw36q+fvtBUq+NVX6EB408KK
         jkNAXDs5T/9+DbK8+FTehptO3P/TR2yTBQPWOeqyFtrVUk6ud/QmbGt56BDUGrSthTps
         kj5B3jrPoUo8KtnNxt02PY2FOyHzKtnaUUAR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pq4ACjGaPlM3h3UYEHG6fyOCzAt325XuBayF3KFtHqs=;
        b=Oq9NkzAnV05TGAbcg7kUfvbuxOJ8YEo7kVKyWKcV9wwFZDg0qyGWX6w7gT0dWyjz3C
         JZ90O+7K1nytHruc7f/kmJNu3WTwxFw4Mp+nWuYHEPw8aIspVDVa577Fvn1nezlhNYR1
         ebhnz6Sclgv9VDKe/sCsLDwKm2coyKVfN5l4XeoDqVHR7ld93qVJEuy6k3rDMZG/17NQ
         93xKz7chkCjiuBc2U4GzYoaYiR7IlLQXOzq87dDSaR444/xcS00PGtCwI0dURzg5MZyd
         /c6NsUNUaR6WENEa+GRSaf55LTtZ0M6IAiDsGB9Budc2DbBkLDxJUYNH+Q11RRHfFQhW
         vrmw==
X-Gm-Message-State: ABuFfogsX2pnrvGTqkHfDTSlviBHfEk1KtrcBtGjEC9pQVyQq8KScJ9B
        Mi2utLVuRpZhqLcoFnKTVPt3J/ktMds=
X-Google-Smtp-Source: ACcGV60csJm88HLa23FTU1Xhybq/VG+zyuJY0dZP11rGjItd9KnUQxv91OPn5PDDSYFWZIaE040tvQ==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr13963277pfj.152.1538442276863;
        Mon, 01 Oct 2018 18:04:36 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n79-v6sm28498659pfk.19.2018.10.01.18.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 18:04:35 -0700 (PDT)
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
Subject: [PATCH security-next v4 25/32] LSM: Introduce CONFIG_LSM_ORDER
Date:   Mon,  1 Oct 2018 17:54:58 -0700
Message-Id: <20181002005505.6112-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a way to declare LSM initialization order via Kconfig.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/Kconfig    | 16 ++++++++++++++++
 security/security.c | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 1e57619fd561..c68520d97fd7 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -286,5 +286,21 @@ config LSM_ENABLE
 	  changed with the "lsm.enable=" and "lsm.disable=" boot
 	  parameters.
 
+	  Note that any enabled exclusive LSM modules will be initialized
+	  based on LSM ordering, automatically disabling any following
+	  exclusive LSMs. See CONFIG_LSM_ORDER for more details on
+	  changing LSM initialization order.
+
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
index 8706b42b4d44..0510bb8e0af0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ static __initdata const char *chosen_lsm_disable;
 static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
@@ -122,14 +123,47 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   is_enabled(lsm) ? "en" : "dis");
 }
 
-/* Populate ordered LSMs list from hard-coded list of LSMs. */
+/* Populate ordered LSMs list from given string. */
+static void __init parse_lsm_order(const char *order, const char *origin)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	if (!order)
+		return;
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

