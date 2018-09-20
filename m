Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E81C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D62147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WERGcZTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D62147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeITWIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41493 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeITWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so4671941pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W20mZjeWpWBoIrHvkqaSs3YTVsX8vIOCX/b5Cc7nYmw=;
        b=WERGcZTXyWf1nCFDOGSIpB8hfmOa0bbhhWFO2wRdBXSGkMEuA/iH4Li0TnT5n4KAgi
         TmNXvJgFJYHXo/oxLaZjFlO4CXpCNNWpJtjQ9VEL1b3Y5YqGx62bs8C+cfdYNpccdFXY
         2AnukDQH6UzWvYzA9UtUhyZRTGXFTVRNvrMGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W20mZjeWpWBoIrHvkqaSs3YTVsX8vIOCX/b5Cc7nYmw=;
        b=mZcZmiNT7OrrUnqreKjWVxRL7qi/MHotp2G2zunFQxTt46IL5L4LokwkLkzqotZJvO
         72ijg4vuBKblve4altPbYyS7i9QZGaHUb1XtHhdVxG25t8KKPXOuHeKdGINzz0r/JD0C
         x4nxtSONMuRkxMJRe05drKx7KmWJBHOodhgwTB0XLh1jDrnvszIexU6yGEhNK3TjhS8q
         o4h4yLN/VVulmq2ks/B/mSzazt/FwDYL3Xaww6b4WcQnhO5VnxcHPMZZxIyOBH9R31JA
         SMdM/tPTHjEvid2YH/C5vNQQvYhYZAJVqIsvgc0o4m58nnnpPgGFPgC1PpAO5batKAkq
         47uQ==
X-Gm-Message-State: APzg51D8Y3aHyk+Xv/wZUvEYIwlgLeEj/5fXLrMMVD2NmRYLoxqUoLJ3
        x8GP2PeymWGWcz7e0XCO2rtT+A==
X-Google-Smtp-Source: ANB0Vdam9Mht/W82Wqzk3Qpmf8tdCdeW+fgC75kjNmiMi3CZZzjND6JyoY2+QCXQpiJ+G8RFEPhLNQ==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr37536231pgf.12.1537460639359;
        Thu, 20 Sep 2018 09:23:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u17-v6sm53738170pfa.176.2018.09.20.09.23.50
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
Subject: [PATCH security-next v2 15/26] LSM: Introduce lsm.enable= and lsm.disable=
Date:   Thu, 20 Sep 2018 09:23:27 -0700
Message-Id: <20180920162338.21060-16-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has identical functionality to the existing per-LSM enable handling,
but provides a centralized place to perform it. If multiple instances
of a parameter (either with the custom LSM-specific parameter or the
"lsm.{enable,disable}" parameter) for a specific LSM are on the boot
command line, the last one takes precedent.

Disabling an LSM means it will not be considered when performing
initializations. Enabling an LSM means either undoing a previous disabling
or a undoing a default-disabled CONFIG setting.

For example: "lsm.disable=apparmor apparmor.enabled=1" will leave
AppArmor enabled. "selinux.enabled=0 lsm.enable=selinux" will leave
SELinux enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 85533d4e534a..72d1ef2fc4cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -53,10 +53,29 @@ static bool debug __initdata;
 	} while (0)
 
 /* Mark an LSM's enabled flag, if it exists. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
 static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
-	if (lsm->enabled)
+	if (!lsm->enabled) {
+		/*
+		 * If the LSM hasn't configured an enable flag, we
+		 * can use a hard-coded setting for storing the
+		 * state ourselves.
+		 */
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
 		*lsm->enabled = enabled;
+	}
 }
 
 /* Is an LSM allowed to be enabled? */
@@ -169,6 +188,32 @@ static int __init enable_debug(char *str)
 }
 __setup("lsm.debug", enable_debug);
 
+/* Explicitly enable an LSM */
+static int __init enable_lsm(char *str)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (strcmp(str, lsm->name) == 0)
+			set_enabled(lsm, true);
+	}
+	return 1;
+}
+__setup("lsm.enable=", enable_lsm);
+
+/* Explicitly disable an LSM */
+static int __init disable_lsm(char *str)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (strcmp(str, lsm->name) == 0)
+			set_enabled(lsm, false);
+	}
+	return 1;
+}
+__setup("lsm.disable=", disable_lsm);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1

