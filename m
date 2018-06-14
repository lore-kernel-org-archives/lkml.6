Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A143DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10120864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYLGHh7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966363AbeFNOOP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966343AbeFNOOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:14:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA4D208E5;
        Thu, 14 Jun 2018 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985641;
        bh=3MHN5oDqdvsmB4O+vp5oHRFmu2PyT2ElPDEJ1Z9Q6ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYLGHh7wgRn2BPG2ouLqnuRK9YlEiCGCALkE7KuyMajcZVVvKrYx/70bsCnCxkVBj
         JvUql8CeuXO833rky2xFyjbuqboMg7ktN857txIKFXfXO9U0b6VBR9g4IAB3sjyEB4
         pPOjK7+TNkEA1qSAtsAaaberqCn8Nw+aFAB64iKQ=
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
Subject: [PATCH 4.4 04/24] x86/fpu: Disable MPX when eagerfpu is off
Date:   Thu, 14 Jun 2018 16:04:59 +0200
Message-Id: <20180614132724.657637907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yu-cheng yu <yu-cheng.yu@intel.com>

commit a5fe93a549c54838063d2952dd9643b0b18aa67f upstream.

This issue is a fallout from the command-line parsing move.

When "eagerfpu=off" is given as a command-line input, the kernel
should disable MPX support. The decision for turning off MPX was
made in fpu__init_system_ctx_switch(), which is after the
selection of the XSAVE format. This patch fixes it by getting
that decision done earlier in fpu__init_system_xstate().

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
Link: http://lkml.kernel.org/r/1452119094-7252-4-git-send-email-yu-cheng.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/internal.h |    1 
 arch/x86/kernel/fpu/init.c          |   56 ++++++++++++++++++++++++++++--------
 arch/x86/kernel/fpu/xstate.c        |    3 -
 3 files changed, 46 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -42,6 +42,7 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
+extern u64 fpu__get_supported_xfeatures_mask(void);
 
 /*
  * Debugging facility:
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -266,7 +266,45 @@ static void __init fpu__init_system_xsta
 static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
 
 /*
+ * Find supported xfeatures based on cpu features and command-line input.
+ * This must be called after fpu__init_parse_early_param() is called and
+ * xfeatures_mask is enumerated.
+ */
+u64 __init fpu__get_supported_xfeatures_mask(void)
+{
+	/* Support all xfeatures known to us */
+	if (eagerfpu != DISABLE)
+		return XCNTXT_MASK;
+
+	/* Warning of xfeatures being disabled for no eagerfpu mode */
+	if (xfeatures_mask & XFEATURE_MASK_EAGER) {
+		pr_err("x86/fpu: eagerfpu switching disabled, disabling the following xstate features: 0x%llx.\n",
+			xfeatures_mask & XFEATURE_MASK_EAGER);
+	}
+
+	/* Return a mask that masks out all features requiring eagerfpu mode */
+	return ~XFEATURE_MASK_EAGER;
+}
+
+/*
+ * Disable features dependent on eagerfpu.
+ */
+static void __init fpu__clear_eager_fpu_features(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_MPX);
+}
+
+/*
  * Pick the FPU context switching strategy:
+ *
+ * When eagerfpu is AUTO or ENABLE, we ensure it is ENABLE if either of
+ * the following is true:
+ *
+ * (1) the cpu has xsaveopt, as it has the optimization and doing eager
+ *     FPU switching has a relatively low cost compared to a plain xsave;
+ * (2) the cpu has xsave features (e.g. MPX) that depend on eager FPU
+ *     switching. Should the kernel boot with noxsaveopt, we support MPX
+ *     with eager FPU switching at a higher cost.
  */
 static void __init fpu__init_system_ctx_switch(void)
 {
@@ -278,19 +316,11 @@ static void __init fpu__init_system_ctx_
 	WARN_ON_FPU(current->thread.fpu.fpstate_active);
 	current_thread_info()->status = 0;
 
-	/* Auto enable eagerfpu for xsaveopt */
 	if (boot_cpu_has(X86_FEATURE_XSAVEOPT) && eagerfpu != DISABLE)
 		eagerfpu = ENABLE;
 
-	if (xfeatures_mask & XFEATURE_MASK_EAGER) {
-		if (eagerfpu == DISABLE) {
-			pr_err("x86/fpu: eagerfpu switching disabled, disabling the following xstate features: 0x%llx.\n",
-			       xfeatures_mask & XFEATURE_MASK_EAGER);
-			xfeatures_mask &= ~XFEATURE_MASK_EAGER;
-		} else {
-			eagerfpu = ENABLE;
-		}
-	}
+	if (xfeatures_mask & XFEATURE_MASK_EAGER)
+		eagerfpu = ENABLE;
 
 	if (eagerfpu == ENABLE)
 		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
@@ -308,10 +338,12 @@ static void __init fpu__init_parse_early
 	 * No need to check "eagerfpu=auto" again, since it is the
 	 * initial default.
 	 */
-	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off"))
+	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off")) {
 		eagerfpu = DISABLE;
-	else if (cmdline_find_option_bool(boot_command_line, "eagerfpu=on"))
+		fpu__clear_eager_fpu_features();
+	} else if (cmdline_find_option_bool(boot_command_line, "eagerfpu=on")) {
 		eagerfpu = ENABLE;
+	}
 
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
 		setup_clear_cpu_cap(X86_FEATURE_FPU);
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -632,8 +632,7 @@ void __init fpu__init_system_xstate(void
 		BUG();
 	}
 
-	/* Support only the state known to the OS: */
-	xfeatures_mask = xfeatures_mask & XCNTXT_MASK;
+	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();


