Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeERGrR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:47:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:32947 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:47:15 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 2/6] x86/stacktrace: remove STACKTRACE_DUMP_ONCE
Date: Fri, 18 May 2018 08:47:09 +0200
Message-Id: <20180518064713.26440-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518064713.26440-1-jslaby@suse.cz>
References: <20180518064713.26440-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack unwinding can sometimes fail yet. Especially with the
generated debug info. So do not yell at users -- live patching (the only
user of this interface) will inform the user about the failure
gracefully.

And given this was the only user of the macro, remove the macro proper
too.

[v3] remove also the macro

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 8948b7d9c064..f9dacf6d4667 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -81,16 +81,6 @@ EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 
-#define STACKTRACE_DUMP_ONCE(task) ({				\
-	static bool __section(.data.unlikely) __dumped;		\
-								\
-	if (!__dumped) {					\
-		__dumped = true;				\
-		WARN_ON(1);					\
-		show_stack(task, NULL);				\
-	}							\
-})
-
 static int __always_inline
 __save_stack_trace_reliable(struct stack_trace *trace,
 			    struct task_struct *task)
@@ -123,20 +113,16 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 		 * generated code which __kernel_text_address() doesn't know
 		 * about.
 		 */
-		if (!addr) {
-			STACKTRACE_DUMP_ONCE(task);
+		if (!addr)
 			return -EINVAL;
-		}
 
 		if (save_stack_address(trace, addr, false))
 			return -EINVAL;
 	}
 
 	/* Check for stack corruption */
-	if (unwind_error(&state)) {
-		STACKTRACE_DUMP_ONCE(task);
+	if (unwind_error(&state))
 		return -EINVAL;
-	}
 
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
-- 
2.16.3
