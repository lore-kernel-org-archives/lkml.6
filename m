Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDDSGe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeDDSGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:06:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A15020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 14:06:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] lockdep: Do not record irq state within lockdep code
Message-ID: <20180404140630.3f4f4c7a@gandalf.local.home>
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

Use raw_local_irq_save/restore() for not only debug_check_no_locks_freed()
but for all internal lockdep functions, as they hide useful information
about where interrupts were used incorrectly last.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83f1969..113d825b28cf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1261,11 +1261,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
@@ -1288,11 +1288,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
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
 
