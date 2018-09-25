Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCBA2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rb1e51Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCBA2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeIYGaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:30:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36233 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeIYGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:30:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so10127455pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFbalDbpQVU7OjIRnEIJaOE4IoeEsoACg+mJq3logWg=;
        b=Rb1e51WfosNEyxho7niYo0jwgJozShnawgN0RvO94pmSSasn3ejlf9zF4xjlXWH+MO
         vAB+tb8PWXeSsckb73K6klVcoIg12gBRKyhNcH9TtfXRerFF28YW66ZYCE5/uOaeVB+R
         UqiWF71G8MavAmfFWHbsH00ci8WC5tgkle7yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rFbalDbpQVU7OjIRnEIJaOE4IoeEsoACg+mJq3logWg=;
        b=LPjQEHKnmysjpK38sS2ykjdXWHtK3CCO8jE2P7mUEjsqvMY2m1nEJrcZC5Ur40TEoO
         HbBMJLds4H+UN2ZLco8TZl3ZaG8sOJfdcwh1mGBMhLbubgyXalpyISvSIA0wunUgwh1/
         SmwvweyC2FibKmkWXCObLzdDvk55+K2OTD7BKBXg0Q6c2m0SvjsW8wBU4ZBN9HGD8TrC
         9kcAvTqb5j/JtsFrpnGWSbOHGX7vbAo0t+GT1Ye9r92bP1Le6qvgtA148Wgf2jmCbkHl
         aKCeS0IehrLCE/6KX9AEnV7qyV+2npkaJwJLPlvX8ySIqjouApzHsaMTKBkhrSOFWc1g
         /CDw==
X-Gm-Message-State: ABuFfojjU5NlbZ6AYcKzaXxxXZH/2ft8ysYByd0bWPxILi2nFwINp5bN
        eaU1mYW6ZP7lOJsDz7myHdmyxQ==
X-Google-Smtp-Source: ACcGV60ICBAe/yeo6RFqvOeHMxrBoCezDuR3lZYuExK++14x98wfiinzSx1BGg33GwSYslDVoPhbmg==
X-Received: by 2002:a63:68c7:: with SMTP id d190-v6mr915939pgc.135.1537835118165;
        Mon, 24 Sep 2018 17:25:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 3-v6sm683001pfq.10.2018.09.24.17.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:25:16 -0700 (PDT)
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
Subject: [PATCH security-next v3 17/29] LSM: Introduce CONFIG_LSM_ENABLE
Date:   Mon, 24 Sep 2018 17:18:20 -0700
Message-Id: <20180925001832.18322-18-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To provide a set of default-enabled LSMs at boot, this introduces the
new CONFIG_LSM_ENABLE. A value of "all" means all builtin LSMs are
enabled by default. Any unlisted LSMs will be implicitly disabled
(excepting those with LSM-specific CONFIGs for enabling/disabling).

The behavior of the LSM-specific CONFIGs for SELinux are AppArmor
unchanged: the default-enabled state for those LSMs remains controlled
through their LSM-specific "enable" CONFIGs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 2 +-
 security/Kconfig          | 8 ++++++++
 security/security.c       | 4 +++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95798f212dbf..ab23f1bc6d77 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
 	int (*init)(void);
 };
 
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..71306b046270 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,13 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM_ENABLE
+	string "LSMs to enable at boot time"
+	default "all"
+	help
+	  A comma-separate list of LSMs to enable by default at boot. The
+	  default is "all", to enable all LSM modules at boot. Any LSMs
+	  not listed here will be disabled by default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index a8107d54b3d3..7ecb9879a863 100644
--- a/security/security.c
+++ b/security/security.c
@@ -45,6 +45,8 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
+
 static bool debug __initdata;
 #define init_debug(...)						\
 	do {							\
@@ -182,7 +184,7 @@ static void __init parse_lsm_enable(const char *str,
 static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
-	parse_lsm_enable("all", default_enabled, true);
+	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
 }
 
 /**
-- 
2.17.1

