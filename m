Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C301A20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C301A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbeGJWdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:33:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:41888 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732490AbeGJWc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:32:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 15:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="70305445"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2018 15:31:16 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v2 21/27] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date:   Tue, 10 Jul 2018 15:26:33 -0700
Message-Id: <20180710222639.8241-22-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710222639.8241-1-yu-cheng.yu@intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode indirect branch tracking support is done mostly by
GCC to insert ENDBR64/ENDBR32 instructions at branch targets.
The kernel provides CPUID enumeration, feature MSR setup and
the allocation of legacy bitmap.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig  | 12 ++++++++++++
 arch/x86/Makefile |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 768343768643..01de9743efe6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1945,6 +1945,18 @@ config X86_INTEL_SHADOW_STACK_USER
 
 	  If unsure, say y.
 
+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	select ARCH_HAS_PROGRAM_PROPERTIES
+	---help---
+	  Indirect Branch Tracking provides hardware protection against return-/jmp-
+	  oriented programing attacks.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index ad1314e5ef65..a7913de34866 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -164,6 +164,13 @@ ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
   endif
 endif
 
+# Check compiler ibt support
+ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+  ifeq ($(call cc-option-yn, -fcf-protection=branch), n)
+      $(error CONFIG_X86_INTEL_BRANCH_TRACKING_USER not supported by compiler)
+  endif
+endif
+
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
-- 
2.17.1

