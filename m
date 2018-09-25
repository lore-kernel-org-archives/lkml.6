Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA37C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2405820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mbq8PKJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2405820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeIYGaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeIYGaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so5318602pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OmKzimyohhf+zr/naGxorwDbJPy1b1KsUqv0GqD4+8g=;
        b=Mbq8PKJrbJf8ZmYeZ3v1vr3hrS7QR/UloEPJJy62xaaRSqyhqR35KPqeOStWYSIm4b
         90LegfQCpHdGAbEJxGXndnXOslYWoGmHB87W3qyr+Sfh0tq9/T7OZuG9OpWFQ/E58/qX
         6WsNIfQuyi+8VRbo9Ipi8NY/jRyj5fne5lrHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OmKzimyohhf+zr/naGxorwDbJPy1b1KsUqv0GqD4+8g=;
        b=RzPkpyYhlIhDVYWMB++cy+svGULnkmzs9nVk6zyFUhvtGqOELHxxypuSB04CkX0QiY
         b09t+pTJnRvchGsaaZa25J+clqlGeoRhGjuFPdYoEwvGLGKs0A0AYMEeBN4TRCdfTIhi
         UQF/tVcrA1ygEXFaK5lHfxiCn03qLynFfhPD8DskMNWo3adQb1m1m8bV6VOJYv+P2s6u
         apEavlUihUBPfrZfvABdoKuoR8rTlukXw6qECQHPR2OJ7KGPH0CA8LG01tN9TAbPz5Dn
         cEIAOyF7a4/UD/Tdj/BWlE/jPHANbsWYAcMaJuJMapaGGuxKrt2t2q2Dyr58gUeDvqyU
         2ZWg==
X-Gm-Message-State: ABuFfoihuDtg6RaPAkUMDk2pMg7K6LEf4csWEwGZkNXllkC4EKsV+zn5
        +BnMaaHNq4swcFneTnoEf6JgnQ==
X-Google-Smtp-Source: ACcGV60lZ0y5vkt0p1Pzl8z+uGPW4Sd3O8rQySRUYFSGxVZ7Mp1TS+0Z9TBRZ3Y2AG9ErbIpgrATow==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr963990pgf.12.1537835123026;
        Mon, 24 Sep 2018 17:25:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p75-v6sm631227pfi.22.2018.09.24.17.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:20 -0700 (PDT)
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
Subject: [PATCH security-next v3 22/29] LSM: Introduce CONFIG_LSM_ORDER
Date:   Mon, 24 Sep 2018 17:18:25 -0700
Message-Id: <20180925001832.18322-23-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a way to declare LSM initialization order via Kconfig.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 16 ++++++++++++++++
 security/security.c | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 1a82a006cc62..7ec86dbdb6b8 100644
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
index ef1ced0a3a50..e38df0314f5e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ static __initdata const char *chosen_lsm_disable;
 static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
@@ -130,14 +131,47 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
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

