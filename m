Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E556E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E556E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLGSwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:52:30 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:60126 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLGSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:52:30 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D266B72CC59;
        Fri,  7 Dec 2018 21:52:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C6A817CEACC; Fri,  7 Dec 2018 21:52:26 +0300 (MSK)
Date:   Fri, 7 Dec 2018 21:52:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181207185226.GB31278@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207155605.GB28964@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elvira Khabirova <lineprinter@altlinux.org>

Arch code should use tracehook_*() helpers, as documented
in include/linux/tracehook.h,
ptrace_report_syscall() is not expected to be used outside that file.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
Please make either v5 or v6 edition of this fix, or any similar fix,
into v4.20.

v6: reverted to a fixed version of v4, compile- and run-tested with strace
v5: reverted to a simple approach, compile- and run-tested
v4: rewritten to call tracehook_report_syscall_entry() once, compile-tested
v3: add a descriptive comment
v2: explicitly ignore tracehook_report_syscall_entry() return code
 arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..fcfdc1229f08 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3263,27 +3263,43 @@ static inline int do_seccomp(struct pt_regs *regs) { return 0; }
  */
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
+	struct thread_info *ti;
+	u32 cached_flags;
+
 	user_exit();
 
-	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
-		/*
-		 * Returning -1 will skip the syscall execution. We want to
-		 * avoid clobbering any register also, thus, not 'gotoing'
-		 * skip label.
-		 */
-		return -1;
-	}
+	ti = current_thread_info();
+	cached_flags = READ_ONCE(ti->flags) &
+		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE |
+			_TIF_SYSCALL_TRACEPOINT);
 
-	/*
-	 * The tracer may decide to abort the syscall, if so tracehook
-	 * will return !0. Note that the tracer may also just change
-	 * regs->gpr[0] to an invalid syscall number, that is handled
-	 * below on the exit path.
-	 */
-	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
-		goto skip;
+	if (cached_flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
+		int rc = tracehook_report_syscall_entry(regs);
+
+		if (unlikely(cached_flags & _TIF_SYSCALL_EMU)) {
+			/*
+			 * A nonzero return code from
+			 * tracehook_report_syscall_entry() tells us
+			 * to prevent the syscall execution, but
+			 * we are not going to execute it anyway.
+			 *
+			 * Returning -1 will skip the syscall execution.
+			 * We want to avoid clobbering any register also,
+			 * thus, not 'gotoing' skip label.
+			 */
+			return -1;
+		}
+
+		if (rc) {
+			/*
+			 * The tracer decided to abort the syscall.
+			 * Note that the tracer may also just change
+			 * regs->gpr[0] to an invalid syscall number,
+			 * that is handled below on the exit path.
+			 */
+			goto skip;
+		}
+	}
 
 	/* Run seccomp after ptrace; allow it to set gpr[3]. */
 	if (do_seccomp(regs))
@@ -3293,7 +3309,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	if (regs->gpr[0] >= NR_syscalls)
 		goto skip;
 
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+	if (unlikely(cached_flags & _TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->gpr[0]);
 
 #ifdef CONFIG_PPC64
-- 
ldv
