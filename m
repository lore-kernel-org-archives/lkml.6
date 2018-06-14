Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1357C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D75C208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiu8n/PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75C208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966172AbeFNONF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966150AbeFNOM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9954B208DB;
        Thu, 14 Jun 2018 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985576;
        bh=onS7lc/CPsi3TFRUgMWJBfWgWRU2x+B+yJ0/90shOzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiu8n/PS5P+WKioYTJ71E7DOcIrdR8HFVtdfJiLnp7TuJbxtitOHDi4p7KMZzbS2Y
         SOldroNKlolX3f6v2hNooVQBP/UYh3tHZYZe5OK0meBrpURZme7isAAkH5QXpVrIrL
         DqfpLuSx4/DfHqjNii4O4MIZXTi2SpllG/hryht0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 01/24] x86/fpu: Fix early FPU command-line parsing
Date:   Thu, 14 Jun 2018 16:04:56 +0200
Message-Id: <20180614132724.543910879@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yu-cheng yu <yu-cheng.yu@intel.com>

commit 4f81cbafcce2c603db7865e9d0e461f7947d77d4 upstream.

The function fpu__init_system() is executed before
parse_early_param(). This causes wrong FPU configuration. This
patch fixes this issue by parsing boot_command_line in the
beginning of fpu__init_system().

With all four patches in this series, each parameter disables
features as the following:

eagerfpu=off: eagerfpu, avx, avx2, avx512, mpx
no387: fpu
nofxsr: fxsr, fxsropt, xmm
noxsave: xsave, xsaveopt, xsaves, xsavec, avx, avx2, avx512,
mpx, xgetbv1 noxsaveopt: xsaveopt
noxsaves: xsaves

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Ravi V. Shankar <ravi.v.shankar@intel.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: yu-cheng yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/1452119094-7252-2-git-send-email-yu-cheng.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/init.c |  109 +++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 71 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -3,8 +3,11 @@
  */
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
+#include <asm/setup.h>
+#include <asm/cmdline.h>
 
 #include <linux/sched.h>
+#include <linux/init.h>
 
 /*
  * Initialize the TS bit in CR0 according to the style of context-switches
@@ -262,18 +265,6 @@ static void __init fpu__init_system_xsta
  */
 static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
 
-static int __init eager_fpu_setup(char *s)
-{
-	if (!strcmp(s, "on"))
-		eagerfpu = ENABLE;
-	else if (!strcmp(s, "off"))
-		eagerfpu = DISABLE;
-	else if (!strcmp(s, "auto"))
-		eagerfpu = AUTO;
-	return 1;
-}
-__setup("eagerfpu=", eager_fpu_setup);
-
 /*
  * Pick the FPU context switching strategy:
  */
@@ -308,11 +299,46 @@ static void __init fpu__init_system_ctx_
 }
 
 /*
+ * We parse fpu parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init fpu__init_parse_early_param(void)
+{
+	/*
+	 * No need to check "eagerfpu=auto" again, since it is the
+	 * initial default.
+	 */
+	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off"))
+		eagerfpu = DISABLE;
+	else if (cmdline_find_option_bool(boot_command_line, "eagerfpu=on"))
+		eagerfpu = ENABLE;
+
+	if (cmdline_find_option_bool(boot_command_line, "no387"))
+		setup_clear_cpu_cap(X86_FEATURE_FPU);
+
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
+		setup_clear_cpu_cap(X86_FEATURE_FXSR);
+		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
+		setup_clear_cpu_cap(X86_FEATURE_XMM);
+	}
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
+		fpu__xstate_clear_all_cpu_caps();
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
+}
+
+/*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
+	fpu__init_parse_early_param();
 	fpu__init_system_early_generic(c);
 
 	/*
@@ -336,62 +362,3 @@ void __init fpu__init_system(struct cpui
 
 	fpu__init_system_ctx_switch();
 }
-
-/*
- * Boot parameter to turn off FPU support and fall back to math-emu:
- */
-static int __init no_387(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_FPU);
-	return 1;
-}
-__setup("no387", no_387);
-
-/*
- * Disable all xstate CPU features:
- */
-static int __init x86_noxsave_setup(char *s)
-{
-	if (strlen(s))
-		return 0;
-
-	fpu__xstate_clear_all_cpu_caps();
-
-	return 1;
-}
-__setup("noxsave", x86_noxsave_setup);
-
-/*
- * Disable the XSAVEOPT instruction specifically:
- */
-static int __init x86_noxsaveopt_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
-
-	return 1;
-}
-__setup("noxsaveopt", x86_noxsaveopt_setup);
-
-/*
- * Disable the XSAVES instruction:
- */
-static int __init x86_noxsaves_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_XSAVES);
-
-	return 1;
-}
-__setup("noxsaves", x86_noxsaves_setup);
-
-/*
- * Disable FX save/restore and SSE support:
- */
-static int __init x86_nofxsr_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_FXSR);
-	setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
-	setup_clear_cpu_cap(X86_FEATURE_XMM);
-
-	return 1;
-}
-__setup("nofxsr", x86_nofxsr_setup);


