Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD1FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6217D206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W4XLD4PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6217D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJBHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:45:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39488 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJBHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:45:00 -0400
Received: by mail-io1-f68.google.com with SMTP id z16-v6so284584iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zecK+fw6L8v037inPgSN/m/4Zxn4FHGN1MbaVrC22C0=;
        b=W4XLD4PX28zRTlyMQwG4WluelnyiVxKarxOnbZJW1Hg0XwVkYB8X9PNbLDnIv1ZQZS
         PGRhgL0bEly4K1QxvqWo7VCdxoZ9Yl1lw/i3A1TqKCWrTDcsXCbHbvrVq0NyjqU/AbkA
         RXkZxkvfWFkgpS9VQTzR5GYGPp89k3p4QoRzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zecK+fw6L8v037inPgSN/m/4Zxn4FHGN1MbaVrC22C0=;
        b=KCm8SSHofrIln4qdHUJjmaf+MkDm/8yRAyQjYkWggNcu9B+CPx2YIJwG8dsigTXt6x
         bbmUElYC8D3z13ojpJpWAhVt/oQWohmgtF/TkTohOw+Zmj7zndfntqqrONECzU4iU7PE
         Whwq6SICefw+BSsP4NnQilSNOBlIm7JiOCM6XmkWV1ScPww3jpZEn3M79PvtYKMyyhLO
         YFWoU+sHpO423+NCGg7mWi1XBHOirFUHHm3W9WlDEqM0JupxQZE1ycUyCXJ0sNFG2XhC
         PZXDJXEGbfBniU4vjMeIE3VT/aDn3yCa6xn7SruozT6DfQyZnlAvw/Z3zKz0oa8Qk/5K
         hf2g==
X-Gm-Message-State: ABuFfojAcUv1yoDjgydc8O744IWCLO6GjXRRl0voZi0B3zjjUJ6XB9s0
        OZHUNHLH2iu/rnZ8CrW2PDUiBg==
X-Google-Smtp-Source: ACcGV60kxTP3I7VxZCr+tbEyh8BJQYWzHGqempdB2XI4Z4y+BPo8K449B8pZOOBCgPdNfsqn3uWyvg==
X-Received: by 2002:a62:9c4a:: with SMTP id f71-v6mr8631527pfe.135.1538442268325;
        Mon, 01 Oct 2018 18:04:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y19-v6sm27036514pff.14.2018.10.01.18.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 18:04:24 -0700 (PDT)
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
Subject: [PATCH security-next v4 27/32] LoadPin: Initialize as ordered LSM
Date:   Mon,  1 Oct 2018 17:55:00 -0700
Message-Id: <20181002005505.6112-28-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 -----
 security/Kconfig           | 2 +-
 security/loadpin/loadpin.c | 8 +++++++-
 security/security.c        | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b026ea93ff01..098ccf2caa0e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2091,10 +2091,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index c68520d97fd7..e59cb9296316 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -293,7 +293,7 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "integrity"
+	default "loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d8a68a6f6fef..dab42bfa1e4a 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,13 +184,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforcing ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin) = {
+	.name = "loadpin",
+	.init = loadpin_init,
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforcing, int, 0);
 MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index 6fafad44b85e..6957f5f50483 100644
--- a/security/security.c
+++ b/security/security.c
@@ -297,7 +297,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
-- 
2.17.1

