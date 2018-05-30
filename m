Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeE3LJP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:09:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60767 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752694AbeE3LHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Matt Turner" <mattst88@gmail.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.713218982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 057/153] alpha: fix crash if pthread_create races with
 signal delivery
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Remove the settls variable, which was done upstream in commit 25906730ec01
   "alpha: reorganize copy_process(), prepare to saner fork_idle()"]
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -279,7 +279,7 @@ copy_thread(unsigned long clone_flags, u
 	struct thread_info *childti = task_thread_info(p);
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
-	unsigned long stack_offset, settls;
+	unsigned long stack_offset;
 
 	stack_offset = PAGE_SIZE - sizeof(struct pt_regs);
 	if (!(regs->ps & 8))
@@ -288,11 +288,9 @@ copy_thread(unsigned long clone_flags, u
 	  (stack_offset + PAGE_SIZE + task_stack_page(p));
 		
 	*childregs = *regs;
-	settls = regs->r20;
 	childregs->r0 = 0;
 	childregs->r19 = 0;
 	childregs->r20 = 1;	/* OSF/1 has some strange fork() semantics.  */
-	regs->r20 = 0;
 	stack = ((struct switch_stack *) regs) - 1;
 	childstack = ((struct switch_stack *) childregs) - 1;
 	*childstack = *stack;
@@ -302,16 +300,16 @@ copy_thread(unsigned long clone_flags, u
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
 	/* Set a new TLS for the child thread?  Peek back into the
-	   syscall arguments that we saved on syscall entry.  Oops,
-	   except we'd have clobbered it with the parent/child set
-	   of r20.  Read the saved copy.  */
+	   syscall arguments that we saved on syscall entry. */
 	/* Note: if CLONE_SETTLS is not set, then we must inherit the
 	   value from the parent, which will have been set by the block
 	   copy in dup_task_struct.  This is non-intuitive, but is
 	   required for proper operation in the case of a threaded
 	   application calling fork.  */
 	if (clone_flags & CLONE_SETTLS)
-		childti->pcb.unique = settls;
+		childti->pcb.unique = regs->r20;
+	else
+		regs->r20 = 0;	/* OSF/1 has some strange fork() semantics.  */
 
 	return 0;
 }
