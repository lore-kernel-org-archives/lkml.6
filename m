Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D491FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28FF20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28FF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLCDS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:18:27 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52920 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeLCDS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:18:26 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1509972CA65;
        Mon,  3 Dec 2018 06:18:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 0C7467CCEA3; Mon,  3 Dec 2018 06:18:23 +0300 (MSK)
Date:   Mon, 3 Dec 2018 06:18:23 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181203031823.GE11573@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efbe166y.fsf@concordia.ellerman.id.au>
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
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v4: rewritten to call tracehook_report_syscall_entry() once, compile-tested
v3: add a descriptive comment
v2: explicitly ignore tracehook_report_syscall_entry() return code

 arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..59c8c9a3d7ea 100644
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
+	cached_flags =
+		READ_ONCE(ti->flags) &
+		(TIF_SYSCALL_EMU | TIF_SYSCALL_TRACE | TIF_SYSCALL_TRACEPOINT);
 
-	/*
-	 * The tracer may decide to abort the syscall, if so tracehook
-	 * will return !0. Note that the tracer may also just change
-	 * regs->gpr[0] to an invalid syscall number, that is handled
-	 * below on the exit path.
-	 */
-	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
-		goto skip;
+	if (cached_flags & (TIF_SYSCALL_EMU | TIF_SYSCALL_TRACE)) {
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
+	if (unlikely(cached_flags & TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->gpr[0]);
 
 #ifdef CONFIG_PPC64
-- 
ldv
