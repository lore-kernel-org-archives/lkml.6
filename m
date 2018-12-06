Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001E620868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001E620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeLFWTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:19:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:39985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeLFWTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 14:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="99313300"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2018 14:19:28 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH v2 3/4] x86/traps: Attempt to fixup exceptions in vDSO before signaling
Date:   Thu,  6 Dec 2018 14:19:21 -0800
Message-Id: <20181206221922.31012-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206221922.31012-1-sean.j.christopherson@intel.com>
References: <20181206221922.31012-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call fixup_vdso_exception() in all trap flows that generate signals to
userspace immediately prior to generating any such signal.  If the
exception is fixed, return cleanly and do not generate a signal.

The goal of vDSO fixup is not to fixup all faults, nor is it to avoid
all signals, but rather to report faults directly to userspace when the
fault would otherwise directly result in a signal being sent to the
process.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kernel/traps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9b7c4ca8f0a7..f813481a85ff 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -223,6 +224,10 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = trapnr;
 
+	if (user_mode(regs) &&
+	    fixup_vdso_exception(regs, trapnr, error_code, 0))
+		return 0;
+
 	return -1;
 }
 
@@ -563,6 +568,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
 
+	if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
+		return;
+
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig(SIGSEGV, tsk);
@@ -791,6 +799,10 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 		goto exit;
 	}
 
+	if (user_mode(regs) &&
+	    fixup_vdso_exception(regs, X86_TRAP_DB, error_code, 0))
+		goto exit;
+
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
 		/*
 		 * Historical junk that used to handle SYSENTER single-stepping.
@@ -854,6 +866,9 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 	if (!si_code)
 		return;
 
+	if (fixup_vdso_exception(regs, trapnr, error_code, 0))
+		return;
+
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs), task);
 }
-- 
2.19.2

