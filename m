Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeENOG5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54969 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeENOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:06:56 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 1/6] x86/stacktrace: do not unwind after user regs
Date: Mon, 14 May 2018 16:06:48 +0200
Message-Id: <20180514140653.23678-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh pointed out, that there is no way a frame can be after user regs.
So remove the last unwind and the check.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 093f2ea5dd56..8948b7d9c064 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -113,15 +113,6 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 			if (!user_mode(regs))
 				return -EINVAL;
 
-			/*
-			 * The last frame contains the user mode syscall
-			 * pt_regs.  Skip it and finish the unwind.
-			 */
-			unwind_next_frame(&state);
-			if (!unwind_done(&state)) {
-				STACKTRACE_DUMP_ONCE(task);
-				return -EINVAL;
-			}
 			break;
 		}
 
-- 
2.16.3
