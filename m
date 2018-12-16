Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB794C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEC82082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeLPR2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 12:28:31 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40148 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeLPR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 12:28:31 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6394C72CC59;
        Sun, 16 Dec 2018 20:28:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 50C20965035; Sun, 16 Dec 2018 20:28:28 +0300 (MSK)
Date:   Sun, 16 Dec 2018 20:28:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
Message-ID: <20181216172828.GA25359@altlinux.org>
References: <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210133655.GH11942@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke tracehook_report_syscall_entry once.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 714c3480c52d..8794d32c2d9e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3263,32 +3263,40 @@ static inline int do_seccomp(struct pt_regs *regs) { return 0; }
  */
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
+	u32 cached_flags;
+
 	user_exit();
 
-	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		/*
-		 * A nonzero return code from tracehook_report_syscall_entry()
-		 * tells us to prevent the syscall execution, but we are not
-		 * going to execute it anyway.
-		 *
-		 * Returning -1 will skip the syscall execution. We want to
-		 * avoid clobbering any register also, thus, not 'gotoing'
-		 * skip label.
-		 */
-		if (tracehook_report_syscall_entry(regs))
-			;
-		return -1;
-	}
+	cached_flags = READ_ONCE(current_thread_info()->flags) &
+		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
 
-	/*
-	 * The tracer may decide to abort the syscall, if so tracehook
-	 * will return !0. Note that the tracer may also just change
-	 * regs->gpr[0] to an invalid syscall number, that is handled
-	 * below on the exit path.
-	 */
-	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
-		goto skip;
+	if (cached_flags) {
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
-- 
ldv
