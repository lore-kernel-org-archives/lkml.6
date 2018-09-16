Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F616ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D59208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCZYnAHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D59208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeIPFww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39218 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbeIPFwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so5927560pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkRtHeHTFBnAc/sv4IK8rqFQ9+Szak4hW2PMgxRCo6c=;
        b=MCZYnAHZCfAfy2e+wYykDRQND5+7AhMr94F3SmaLMhlWbPXth2yNb1FpiFGzs3LyLt
         YtDqU4a1dYHCwtz78vDOeg4rd8fCh9W8E31aAqmUFItuxx09UsfZIm49KKyqxwNFWVoD
         DoPuItoMWmNL0FwMkQnAFx8CF3fCx/CLDbzOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkRtHeHTFBnAc/sv4IK8rqFQ9+Szak4hW2PMgxRCo6c=;
        b=hwnrUv7Pw9fCW/9g0V6xbas8m885uUWCJfFs61kdVv2vitSxDryhmiF0QUN3TEXMTG
         p7eBzJhHA4TLrPQ6mdpnkgaj0LcFcyz9QH/bplbHS4lDXoIoYCoWRKKPjJVR1DYbe1As
         zvuTEoPBwvqRNmYdQwSsXDwH4PZM/QOU4k6PDZVCXOhe/qirQlFj6PKNJrr8uSgdBPMt
         O/evzbaUzpuafohWYcQAmNVwpyE0j4WH49Rp18BtPbnwIOuzZUgFWfNkvA80hOiDsT8z
         dKoVuxk/Yl4/8xnY1ySB0vjmWwnO3mCgz5InOu1BWG3DqIHJGVbC4xE2bRKC+C3G0sHQ
         iEzQ==
X-Gm-Message-State: APzg51BzIdxpOQRVFZhFYSnkCU3lEj52NCuPLqE7YCKnRQ1c2Fn3w1Uc
        L403A5E70fFKD/ky4NWSwu7Oew==
X-Google-Smtp-Source: ANB0VdaIkx6Stype9deRlghvpX02gJfWtwbzQk5UDnxD3I9SIL9vVYIqLDEI23WufUrhTeWZqUBPjA==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr19128516pff.211.1537057873828;
        Sat, 15 Sep 2018 17:31:13 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f4-v6sm20045424pfj.46.2018.09.15.17.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
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
Subject: [PATCH 10/18] LSM: Plumb visibility into optional "enabled" state
Date:   Sat, 15 Sep 2018 17:30:51 -0700
Message-Id: <20180916003059.1046-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This must be an "int" to include
handling cases where "enabled" is exposed via sysctl which has no "bool"
type (i.e. LoadPin's use).

LoadPin's "enabled" tracking will be added later when it is marked as
LSM_TYPE_MINOR.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a7833193e9e9..8a3a6cd26f03 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2046,6 +2046,7 @@ enum lsm_type {
 
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
+	int *enabled;		/* Optional: NULL means enabled. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7fa7b4464cf4..6cd630b34c3b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1607,5 +1607,6 @@ static int __init apparmor_init(void)
 }
 
 DEFINE_LSM(apparmor)
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 END_LSM;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 469a90806bc6..78b5afc188f3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7203,6 +7203,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux)
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 END_LSM;
 
-- 
2.17.1

