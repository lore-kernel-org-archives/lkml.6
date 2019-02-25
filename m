Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FCBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C985720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129965;
	bh=rKFSH2QolR2zpUpUr/7RhH3ednBoGtVW7INDd+u+34o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cEG1HBXxnB3EV0WdLfSFwKqI4GzY8As9eLrkXmf5hRbMo6Z/Bg5a3UZpGztN0RUrI
	 N3tK7jkL6ShnM3uMHcm9SKrYOGfK4yLQK2m8Ffp7pWbZPCtZeN9u4gRtN2JF3drqNG
	 XE6B0KELJxptnMf5qsQZoNcFPSrXyjk/CdJxff1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfBYV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731132AbfBYV0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5249213A2;
        Mon, 25 Feb 2019 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129960;
        bh=rKFSH2QolR2zpUpUr/7RhH3ednBoGtVW7INDd+u+34o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbXyM8QRizL3NWw2spgO+RMqYY3G2g2bqucflcjP+bfkY3s1VoBXN+WMeGdqnBPl+
         AuJLT6HcwnrKd2L8QD82HpEEsx/Sh9+4+USdQ6bSX+Gu/6TEQa0xGpriV8ZOL+jagB
         AefUI2eX51zNc538Rj4UL1+H3KZlDBHVKvVyfhSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 122/152] parisc: Fix ptrace syscall number modification
Date:   Mon, 25 Feb 2019 22:11:54 +0100
Message-Id: <20190225195051.515861581@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


