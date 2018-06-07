Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u9gVKmBCGVtIewAAmS7hNA
	; Thu, 07 Jun 2018 14:34:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8AB2A608D4; Thu,  7 Jun 2018 14:34:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC6E8608D2;
	Thu,  7 Jun 2018 14:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC6E8608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeFGOeI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:34:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40331 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933937AbeFGOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zw-5k; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002uM-Dv; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Matt Turner" <mattst88@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.249903861@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 147/410] alpha: fix crash if pthread_create races
 with signal delivery
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 21ffceda1c8b3807615c40d440d7815e0c85d366 upstream.

On alpha, a process will crash if it attempts to start a thread and a
signal is delivered at the same time. The crash can be reproduced with
this program: https://cygwin.com/ml/cygwin/2014-11/msg00473.html

The reason for the crash is this:
* we call the clone syscall
* we go to the function copy_process
* copy process calls copy_thread_tls, it is a wrapper around copy_thread
* copy_thread sets the tls pointer: childti->pcb.unique = regs->r20
* copy_thread sets regs->r20 to zero
* we go back to copy_process
* copy process checks "if (signal_pending(current))" and returns
  -ERESTARTNOINTR
* the clone syscall is restarted, but this time, regs->r20 is zero, so
  the new thread is created with zero tls pointer
* the new thread crashes in start_thread when attempting to access tls

The comment in the code says that setting the register r20 is some
compatibility with OSF/1. But OSF/1 doesn't use the CLONE_SETTLS flag, so
we don't have to zero r20 if CLONE_SETTLS is set. This patch fixes the bug
by zeroing regs->r20 only if CLONE_SETTLS is not set.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/alpha/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -274,12 +274,13 @@ copy_thread(unsigned long clone_flags, u
 	   application calling fork.  */
 	if (clone_flags & CLONE_SETTLS)
 		childti->pcb.unique = regs->r20;
+	else
+		regs->r20 = 0;	/* OSF/1 has some strange fork() semantics.  */
 	childti->pcb.usp = usp ?: rdusp();
 	*childregs = *regs;
 	childregs->r0 = 0;
 	childregs->r19 = 0;
 	childregs->r20 = 1;	/* OSF/1 has some strange fork() semantics.  */
-	regs->r20 = 0;
 	stack = ((struct switch_stack *) regs) - 1;
 	*childstack = *stack;
 	childstack->r26 = (unsigned long) ret_from_fork;
