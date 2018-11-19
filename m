Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950CE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLPB/Jvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeKTJLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbeKTJLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:41 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45052148E;
        Mon, 19 Nov 2018 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667547;
        bh=Z/QmCvuEDR0yIFKfuIsoKI7xQ7oBVS02ijKpwVL9eqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iLPB/Jvqapnf5A4a0F6wQe0m4s1OaLC++EM+5zFFfgNi0z69ze9/yHqnIXVTO/bwK
         AeEZt0110XnXR59XV73z3PgJeXmUf0u+GPmkKMyNahn63kFPMIDsERikoZ5uWQgCWx
         vLQ0DjdxuqzAjfh3jzhbfztfI8Z25k+54zKYzt8U=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 07/13] x86/fault: Make error_code sanitization more robust
Date:   Mon, 19 Nov 2018 14:45:31 -0800
Message-Id: <b31159bd55bd0c4fa061a20dfd6c429c094bebaa.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code in a page fault on a kernel address indicates
whether that address is mapped, which should not be revealed in a signal.
The normal code path for a page fault on a kernel address sanitizes the bit,
but the paths for vsyscall emulation and SIGBUS do not.  Both are
harmless, but for subtle reasons.  SIGBUS is never sent for a kernel
address, and vsyscall emulation will never fault on a kernel address
per se because it will fail an access_ok() check instead.

Make the code more robust by adding a helper that sets the relevant
fields and sanitizing the error code in the helper.  This also
cleans up the code -- we had three copies of roughly the same thing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index bd89b6f83aa2..fac931d89c23 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -631,6 +631,24 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
+static void set_signal_archinfo(unsigned long address,
+				unsigned long error_code)
+{
+	struct task_struct *tsk = current;
+
+	/*
+	 * To avoid leaking information about the kernel page
+	 * table layout, pretend that user-mode accesses to
+	 * kernel addresses are always protection faults.
+	 */
+	if (address >= TASK_SIZE_MAX)
+		error_code |= X86_PF_PROT;
+
+	tsk->thread.trap_nr = X86_TRAP_PF;
+	tsk->thread.error_code = error_code | X86_PF_USER;
+	tsk->thread.cr2 = address;
+}
+
 static noinline void
 no_context(struct pt_regs *regs, unsigned long error_code,
 	   unsigned long address, int signal, int si_code)
@@ -656,9 +674,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * faulting through the emulate_vsyscall() logic.
 		 */
 		if (current->thread.sig_on_uaccess_err && signal) {
-			tsk->thread.trap_nr = X86_TRAP_PF;
-			tsk->thread.error_code = error_code | X86_PF_USER;
-			tsk->thread.cr2 = address;
+			set_signal_archinfo(address, error_code);
 
 			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_fault(signal, si_code, (void __user *)address,
@@ -821,9 +837,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (likely(show_unhandled_signals))
 			show_signal_msg(regs, error_code, address, tsk);
 
-		tsk->thread.cr2		= address;
-		tsk->thread.error_code	= error_code;
-		tsk->thread.trap_nr	= X86_TRAP_PF;
+		set_signal_archinfo(address, error_code);
 
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, pkey);
@@ -937,9 +951,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-	tsk->thread.cr2		= address;
-	tsk->thread.error_code	= error_code;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
+	set_signal_archinfo(address, error_code);
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
-- 
2.17.2

