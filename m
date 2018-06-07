Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fsWtMdRIGVumSgAAmS7hNA
	; Thu, 07 Jun 2018 15:01:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0419B607E7; Thu,  7 Jun 2018 15:01:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62F78601C3;
	Thu,  7 Jun 2018 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62F78601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbeFGPBw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:01:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41411 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964837AbeFGPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:49 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zx-KI; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035s-Tl; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Laura Abbott" <labbott@redhat.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "James Morse" <james.morse@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.973768993@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 265/410] arm64: remove __die()'s stack dump
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit c5bc503cbeee8586395aa541d2b53c69c3dd6930 upstream.

Our __die() implementation tries to dump the stack memory, in addition
to a backtrace, which is problematic.

For contemporary 16K stacks, this can be a lot of data, which can take a
long time to dump, and can push other useful context out of the kernel's
printk ringbuffer (and/or a user's scrollback buffer on an attached
console).

Additionally, the code implicitly assumes that the SP is on the task's
stack, and tries to dump everything between the SP and the highest task
stack address. When the SP points at an IRQ stack (or is corrupted),
this makes the kernel attempt to dump vast amounts of VA space. With
vmap'd stacks, this may result in erroneous accesses to peripherals.

This patch removes the memory dump, leaving us to rely on the backtrace,
and other means of dumping stack memory such as kdump.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -206,8 +206,6 @@ static int __die(const char *str, int er
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
