Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1F2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oargnQD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF1F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJKHub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:50:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeJKHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:50:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so3456686pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nEDfuECvIoCXFIzMh9Dj+6TlJ4peBjPjA1wDbBbnVw=;
        b=oargnQD59MjHdASA/jZzqoYS/AuSEnLTP9i33/bcO4GerJX7MNwfBorPpxSGkmy8dk
         SnlpmRUWdTySLIhGr/p5wxbZlEBIlVWGlvn+XgDoi7kOGBh3BjnJqSZBCORTZB+Ei4I+
         5GJchYdIkG9d29+fzpDbdZuxOILSOHhtP4u3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5nEDfuECvIoCXFIzMh9Dj+6TlJ4peBjPjA1wDbBbnVw=;
        b=lPje7pu1jZdZtokV4nRK3aKAZdyLsysDswkHU5PRUMdD6J53wTQT+QEG+rlkQSgBLb
         fW6vmeNLBlBXBRuaZoJri3W+9O/JxequcjJYfERAKOiGZNlx5lARKq2Nhp49Rjdc3NCL
         04XPkek4TR4XT51mSQUp5mplV1Gd6S5RgIOSYk/Amrq0oc3Y8fL8JQaffjYsS2rpusLG
         nwBsb1FazldA57b1h0NQLrV9BFFzq+KAhDN9Y45sPJB1820ta8J+KCGyqYVqzHen/HWu
         C68PEFaYZkfFanp06NIDHyvQROvxS6R8XI9heOub9kq71NQuOyJLd00Tk6QcpLrN2cA+
         9HCQ==
X-Gm-Message-State: ABuFfoj+5jBYn7dr0tWe/T8CvzKiZ3ydpS8HnWykvG60ARxQoLoPt5eo
        NrEIM+q8Vx/25ZrOH68lDbCP1g==
X-Google-Smtp-Source: ACcGV60psu5w1GB0+hcdsn8NLGqumxgi1GedY++WWis/Q829xrZiGZPmIT5ghc7tMJClonWd/JWD6g==
X-Received: by 2002:a62:3541:: with SMTP id c62-v6mr36860753pfa.45.1539217553729;
        Wed, 10 Oct 2018 17:25:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w127-v6sm32878924pfd.112.2018.10.10.17.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:25:50 -0700 (PDT)
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
Subject: [PATCH security-next v5 23/30] apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
Date:   Wed, 10 Oct 2018 17:18:39 -0700
Message-Id: <20181011001846.30964-24-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_APPARMOR_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=apparmor", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/Kconfig | 16 ----------------
 security/apparmor/lsm.c   |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ebf63461a79c..9eaf1dec2e61 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,7 +1303,7 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static int apparmor_enabled __lsm_ro_after_init = 1;
 module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
-- 
2.17.1

