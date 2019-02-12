Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E959BC282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C242720863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBLAVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:21:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61446 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfBLAVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:21:47 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C0LeYu051397;
        Tue, 12 Feb 2019 09:21:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 12 Feb 2019 09:21:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C0Lexx051393;
        Tue, 12 Feb 2019 09:21:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1C0LeYB051392;
        Tue, 12 Feb 2019 09:21:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] LSM: Ignore =?ISO-2022-JP?B?InNlY3VyaXR5PSIgd2hlbiAibHNtPSIg?=
 =?ISO-2022-JP?B?aXMgc3BlY2lmaWVk?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Tue, 12 Feb 2019 09:21:40 +0900
References: <20190211225403.GA7769@beast>
In-Reply-To: <20190211225403.GA7769@beast>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:
> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> used on the command line, and report that it is happening.

To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.

---
 security/Kconfig    | 37 +++++++++++++++++++++++++++++++++++++
 security/security.c |  5 ++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 9555f49..6a40995 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -250,5 +250,42 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+choice
+	prompt "Default exclusive security module"
+	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
+	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
+	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
+	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
+	default DEFAULT_SECURITY_DAC
+
+	help
+	  The security module where only one of these modules should be enabled if
+	  neither the "security=" parameter nor the "lsm=" parameter is specified.
+
+	config DEFAULT_SECURITY_SELINUX
+		bool "SELinux" if SECURITY_SELINUX=y
+
+	config DEFAULT_SECURITY_SMACK
+		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+
+	config DEFAULT_SECURITY_TOMOYO
+		bool "TOMOYO" if SECURITY_TOMOYO=y
+
+	config DEFAULT_SECURITY_APPARMOR
+		bool "AppArmor" if SECURITY_APPARMOR=y
+
+	config DEFAULT_SECURITY_DAC
+		bool "Unix Discretionary Access Controls"
+
+endchoice
+
+config DEFAULT_SECURITY
+	string
+	default "selinux" if DEFAULT_SECURITY_SELINUX
+	default "smack" if DEFAULT_SECURITY_SMACK
+	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
+	default "apparmor" if DEFAULT_SECURITY_APPARMOR
+	default "" if DEFAULT_SECURITY_DAC
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index e6153ed..c44e3cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -294,8 +294,11 @@ static void __init ordered_lsm_init(void)
 			chosen_major_lsm = NULL;
 		}
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	} else
+	} else {
+		if (!chosen_major_lsm)
+			chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
+	}
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
-- 
1.8.3.1

