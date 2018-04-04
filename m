Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDDQTH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeDDQTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:19:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AF52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 12:19:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] lockdep: Do not record irq state in
 debug_check_no_locks_freed()
Message-ID: <20180404121904.6713fb9d@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

While debugging where things were going wrong with mapping
enabling/disabling interrupts with the lockdep state and actual real
enabling and disabling interrupts, I had to silent the irq
disabling/enabling in debug_check_no_locks_freed() because it was
always showing up as it was called before the splat was.

Use raw_local_irq_save/restore() for debug_check_no_locks_freed() as it
hides useful information about where interrupts were used incorrectly
last.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83f1969..8c145dc1315b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4407,7 +4407,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 	if (unlikely(!debug_locks))
 		return;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
 
@@ -4418,7 +4418,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 		print_freed_lock_bug(curr, mem_from, mem_from + mem_len, hlock);
 		break;
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
