Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D7C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E0257CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E0257CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965905AbeGAR4T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:56:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030280AbeGAQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF3B8AA6;
        Sun,  1 Jul 2018 16:31:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 050/157] arm64: Fix syscall restarting around signal suppressed by tracer
Date:   Sun,  1 Jul 2018 18:22:02 +0200
Message-Id: <20180701160855.155799663@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Martin <Dave.Martin@arm.com>

commit 0fe42512b2f03f9e5a20b9f55ef1013a68b4cd48 upstream.

Commit 17c2895 ("arm64: Abstract syscallno manipulation") abstracts
out the pt_regs.syscallno value for a syscall cancelled by a tracer
as NO_SYSCALL, and provides helpers to set and check for this
condition.  However, the way this was implemented has the
unintended side-effect of disabling part of the syscall restart
logic.

This comes about because the second in_syscall() check in
do_signal() re-evaluates the "in a syscall" condition based on the
updated pt_regs instead of the original pt_regs.  forget_syscall()
is explicitly called prior to the second check in order to prevent
restart logic in the ret_to_user path being spuriously triggered,
which means that the second in_syscall() check always yields false.

This triggers a failure in
tools/testing/selftests/seccomp/seccomp_bpf.c, when using ptrace to
suppress a signal that interrups a nanosleep() syscall.

Misbehaviour of this type is only expected in the case where a
tracer suppresses a signal and the target process is either being
single-stepped or the interrupted syscall attempts to restart via
-ERESTARTBLOCK.

This patch restores the old behaviour by performing the
in_syscall() check only once at the start of the function.

Fixes: 17c289586009 ("arm64: Abstract syscallno manipulation")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/signal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -676,11 +676,12 @@ static void do_signal(struct pt_regs *re
 	unsigned long continue_addr = 0, restart_addr = 0;
 	int retval = 0;
 	struct ksignal ksig;
+	bool syscall = in_syscall(regs);
 
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
-	if (in_syscall(regs)) {
+	if (syscall) {
 		continue_addr = regs->pc;
 		restart_addr = continue_addr - (compat_thumb_mode(regs) ? 2 : 4);
 		retval = regs->regs[0];
@@ -732,7 +733,7 @@ static void do_signal(struct pt_regs *re
 	 * Handle restarting a different system call. As above, if a debugger
 	 * has chosen to restart at a different PC, ignore the restart.
 	 */
-	if (in_syscall(regs) && regs->pc == restart_addr) {
+	if (syscall && regs->pc == restart_addr) {
 		if (retval == -ERESTART_RESTARTBLOCK)
 			setup_restart_syscall(regs);
 		user_rewind_single_step(current);


