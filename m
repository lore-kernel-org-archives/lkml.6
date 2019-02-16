Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE5C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E97222E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBPNKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 08:10:43 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33596 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfBPNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 08:10:43 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0034F72CCAE;
        Sat, 16 Feb 2019 16:10:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BE3FC7CC774; Sat, 16 Feb 2019 16:10:39 +0300 (MSK)
Date:   Sat, 16 Feb 2019 16:10:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] parisc: Fix ptrace syscall number modification
Message-ID: <20190216131039.GA18767@altlinux.org>
References: <20190216024623.GA11910@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216024623.GA11910@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 910cd32e552e ("parisc: Fix and enable seccomp filter support")
introduced a regression in ptrace-based syscall tampering: when tracer
changes syscall number to -1, the kernel fails to initialize %r28 with
-ENOSYS and subsequently fails to return the error code of the failed
syscall to userspace.

This erroneous behaviour could be observed with a simple strace syscall
fault injection command which is expected to print something like this:

$ strace -a0 -ewrite -einject=write:error=enospc echo hello
write(1, "hello\n", 6) = -1 ENOSPC (No space left on device) (INJECTED)
write(2, "echo: ", 6) = -1 ENOSPC (No space left on device) (INJECTED)
write(2, "write error", 11) = -1 ENOSPC (No space left on device) (INJECTED)
write(2, "\n", 1) = -1 ENOSPC (No space left on device) (INJECTED)
+++ exited with 1 +++

After commit 910cd32e552ea09caa89cdbe328e468979b030dd it loops printing
something like this instead:

write(1, "hello\n", 6../strace: Failed to tamper with process 12345: unexpectedly got no error (return value 0, error 0)
) = 0 (INJECTED)

This bug was found by strace test suite.

Fixes: 910cd32e552e ("parisc: Fix and enable seccomp filter support")
Cc: stable@vger.kernel.org # v4.5+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

 v2: Updated comments.
     Set gr[28] to -ENOSYS after tracehook_report_syscall_entry() invocation
     because setting of syscall return code by tracer on entering syscall
     shall not affect the syscall return code.

 N.B. I have no parisc box to test the patch.

 arch/parisc/kernel/ptrace.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 2582df1c529b..be4d6a279b12 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -308,15 +308,29 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs)) {
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		int rc = tracehook_report_syscall_entry(regs);
+
 		/*
-		 * Tracing decided this syscall should not happen or the
-		 * debugger stored an invalid system call number. Skip
-		 * the system call and the system call restart handling.
+		 * As tracesys_next does not set %r28 to -ENOSYS
+		 * when %r20 is set to -1, initialize it here.
 		 */
-		regs->gr[20] = -1UL;
-		goto out;
+		regs->gr[28] = -ENOSYS;
+
+		if (rc) {
+			/*
+			 * A nonzero return code from
+			 * tracehook_report_syscall_entry() tells us
+			 * to prevent the syscall execution.  Skip
+			 * the syscall call and the syscall restart handling.
+			 *
+			 * Note that the tracer may also just change
+			 * regs->gr[20] to an invalid syscall number,
+			 * that is handled by tracesys_next.
+			 */
+			regs->gr[20] = -1UL;
+			return -1;
+		}
 	}
 
 	/* Do the secure computing check after ptrace. */
-- 
ldv
