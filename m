Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeERGsO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:32955 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbeERGrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:47:16 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 3/6] x86/stacktrace: clarify the reliable success paths
Date: Fri, 18 May 2018 08:47:10 +0200
Message-Id: <20180518064713.26440-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518064713.26440-1-jslaby@suse.cz>
References: <20180518064713.26440-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make clear which path is for user tasks and for kthreads and idle
tasks. This will allow easier plug-in of the ORC unwinder in the next
patches.

Note that we added a check for unwind error to the top of the loop, so
that an error is returned also for user tasks (the 'goto success' would
skip the check after the loop otherwise).

[v3] check for unwind_error in the loop

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index f9dacf6d4667..6acf1d5ca832 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -89,21 +89,24 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 	struct pt_regs *regs;
 	unsigned long addr;
 
-	for (unwind_start(&state, task, NULL, NULL); !unwind_done(&state);
+	for (unwind_start(&state, task, NULL, NULL);
+	     !unwind_done(&state) && !unwind_error(&state);
 	     unwind_next_frame(&state)) {
 
 		regs = unwind_get_entry_regs(&state, NULL);
 		if (regs) {
+			/* Success path for user tasks */
+			if (user_mode(regs))
+				goto success;
+
 			/*
 			 * Kernel mode registers on the stack indicate an
 			 * in-kernel interrupt or exception (e.g., preemption
 			 * or a page fault), which can make frame pointers
 			 * unreliable.
 			 */
-			if (!user_mode(regs))
-				return -EINVAL;
 
-			break;
+			return -EINVAL;
 		}
 
 		addr = unwind_get_return_address(&state);
@@ -124,6 +127,11 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 	if (unwind_error(&state))
 		return -EINVAL;
 
+	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
+	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
+		return -EINVAL;
+
+success:
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 
-- 
2.16.3
