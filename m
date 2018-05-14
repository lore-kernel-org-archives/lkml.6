Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeENOIX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:08:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54985 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932380AbeENOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:06:56 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 3/6] x86/stacktrace: remove STACKTRACE_DUMP_ONCE from __save_stack_trace_reliable
Date: Mon, 14 May 2018 16:06:50 +0200
Message-Id: <20180514140653.23678-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514140653.23678-1-jslaby@suse.cz>
References: <20180514140653.23678-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack unwinding can sometimes fail yet. Especially with the
generated debug info. So do not yell at users -- live patching (the only
user of this interface) will inform the user about the failure
gracefully.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 3a4602c2324f..e0169b128523 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -125,20 +125,16 @@ __save_stack_trace_reliable(struct stack_trace *trace,
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
 
 	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
 	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
-- 
2.16.3
