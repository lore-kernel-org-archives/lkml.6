Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A6820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A6820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeH3SsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:48:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:38430 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeH3SqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="67186683"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2018 07:43:40 -0700
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
Subject: [RFC PATCH v3 07/24] x86/cet/shstk: Add Kconfig option for user-mode shadow stack
Date:   Thu, 30 Aug 2018 07:38:47 -0700
Message-Id: <20180830143904.3168-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830143904.3168-1-yu-cheng.yu@intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Kconfig option X86_INTEL_SHADOW_STACK_USER.

An application has shadow stack protection when all the following are
true:

  (1) The kernel has X86_INTEL_SHADOW_STACK_USER enabled,
  (2) The running processor supports the shadow stack,
  (3) The application is built with shadow stack enabled tools & libs
      and, and at runtime, all dependent shared libs can support shadow
      stack.

If this kernel config option is enabled, but (2) or (3) above is not
true, the application runs without the shadow stack protection.
Existing legacy applications will continue to work without the shadow
stack protection.

The user-mode shadow stack protection is only implemented for the
64-bit kernel.  Thirty-two bit applications are supported under the
compatibility mode.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig  | 24 ++++++++++++++++++++++++
 arch/x86/Makefile |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5ff296bc5d1..017b3ba70807 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1913,6 +1913,30 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config X86_INTEL_CET
+	def_bool n
+
+config ARCH_HAS_SHSTK
+	def_bool n
+
+config X86_INTEL_SHADOW_STACK_USER
+	prompt "Intel Shadow Stack for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	select ARCH_HAS_SHSTK
+	---help---
+	  Shadow stack provides hardware protection against program stack
+	  corruption.  Only when all the following are true will an application
+	  have the shadow stack protection: the kernel supports it (i.e. this
+	  feature is enabled), the application is compiled and linked with
+	  shadow stack enabled, and the processor supports this feature.
+	  When the kernel has this configuration enabled, existing non shadow
+	  stack applications will continue to work, but without shadow stack
+	  protection.
+
+	  If unsure, say y.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94859241bc3e..00927853e409 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -152,6 +152,13 @@ ifdef CONFIG_X86_X32
 endif
 export CONFIG_X86_X32_ABI
 
+# Check assembler shadow stack suppot
+ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+  ifeq ($(call as-instr, saveprevssp, y),)
+      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
+  endif
+endif
+
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
-- 
2.17.1

