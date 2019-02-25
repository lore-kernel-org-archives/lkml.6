Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85367C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130536;
	bh=D968y1YLgbOi94eD7+TGPkReKx41EnApG/CgwHaAcmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YgQqro2iQLXGlD6fTLAIsBHepbdPwa/65IZ+YXIkLtkfnZapGddbuZUdQdSlhxvYp
	 wVnOmaEeCk13/IEha+LGDd+mZuMt+jHeKYj5DBK6rz4C/2lwewst+y/VWStzTGWjYV
	 y97L0a3kPzqVC+Hxd4RfMrdQyQjXkoPVlMDgkcCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbfBYVfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732992AbfBYVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C6321850;
        Mon, 25 Feb 2019 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130530;
        bh=D968y1YLgbOi94eD7+TGPkReKx41EnApG/CgwHaAcmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olxU+7le0yi4Z9hwh/fMm7k8DAJpAsX8GjYFyfayrbxE9L6xTiPJlXkMXfV7XNlVt
         40Tq049IR/VAZM5RYGugWvtuj0xlzJsmB4hhEhDO/lLj9tHHR5RHVjmMn77chIC7Ss
         M1bHTyNK2fnax1SH/8YID0MLsorNX/AaPjLgGrS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.20 151/183] parisc: Fix ptrace syscall number modification
Date:   Mon, 25 Feb 2019 22:12:04 +0100
Message-Id: <20190225195120.481697644@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry V. Levin <ldv@altlinux.org>

commit b7dc5a071ddf69c0350396b203cba32fe5bab510 upstream.

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
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/ptrace.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -308,15 +308,29 @@ long compat_arch_ptrace(struct task_stru
 
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
@@ -340,7 +354,6 @@ long do_syscall_trace_enter(struct pt_re
 			regs->gr[24] & 0xffffffff,
 			regs->gr[23] & 0xffffffff);
 
-out:
 	/*
 	 * Sign extend the syscall number to 64bit since it may have been
 	 * modified by a compat ptrace call


