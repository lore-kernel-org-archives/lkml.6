Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbeENOHB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:07:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeENOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:06:57 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 4/6] x86/stacktrace: do not fail for ORC with regs on stack
Date: Mon, 14 May 2018 16:06:51 +0200
Message-Id: <20180514140653.23678-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514140653.23678-1-jslaby@suse.cz>
References: <20180514140653.23678-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_stack_trace_reliable now returns "non reliable" when there are
kernel pt_regs on stack. This means an interrupt or exception happened
somewhere down the route. It is a problem for the frame pointer
unwinder, because the frame might not have been set up yet when the irq
happened, so the unwinder might fail to unwind from the interrupted
function.

With ORC, this is not a problem, as ORC has out-of-band data. We can
find ORC data even for the IP in the interrupted function and always
unwind one level up reliably.

So lift the check to apply only when CONFIG_FRAME_POINTER is enabled.

[v2]
- rewrite the code in favor of Josh's suggestions

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index e0169b128523..32983bf642d1 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -115,7 +115,8 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 			 * unreliable.
 			 */
 
-			return -EINVAL;
+			if (IS_ENABLED(CONFIG_FRAME_POINTER))
+				return -EINVAL;
 		}
 
 		addr = unwind_get_return_address(&state);
-- 
2.16.3
