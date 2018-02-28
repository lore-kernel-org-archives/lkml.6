Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeB1O2i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:28:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1O2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:28:37 -0500
Date: Wed, 28 Feb 2018 06:28:13 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-04860d48a8aba5b21ae5ba1f86b0d4e3bc628fff@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, bp@suse.de, tglx@linutronix.de
In-Reply-To: <20180226134926.23069-1-bp@alien8.de>
References: <20180226134926.23069-1-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Show unadorned pointers
Git-Commit-ID: 04860d48a8aba5b21ae5ba1f86b0d4e3bc628fff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  04860d48a8aba5b21ae5ba1f86b0d4e3bc628fff
Gitweb:     https://git.kernel.org/tip/04860d48a8aba5b21ae5ba1f86b0d4e3bc628fff
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 26 Feb 2018 14:49:26 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:25:44 +0100

locking/lockdep: Show unadorned pointers

Show unadorned pointers in lockdep reports - lockdep is a debugging
facility and hashing pointers there doesn't make a whole lotta sense.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20180226134926.23069-1-bp@alien8.de

---
 kernel/locking/lockdep.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83f1969..12a2805dd64a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -557,7 +557,7 @@ static void print_lock(struct held_lock *hlock)
 	}
 
 	print_lock_name(lock_classes + class_idx - 1);
-	printk(KERN_CONT ", at: [<%p>] %pS\n",
+	printk(KERN_CONT ", at: [<%px>] %pS\n",
 		(void *)hlock->acquire_ip, (void *)hlock->acquire_ip);
 }
 
@@ -808,7 +808,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
-		printk("\nnew class %p: %s", class->key, class->name);
+		printk("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
@@ -1407,7 +1407,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	}
 	printk("%*s }\n", depth, "");
 
-	printk("%*s ... key      at: [<%p>] %pS\n",
+	printk("%*s ... key      at: [<%px>] %pS\n",
 		depth, "", class->key, class->key);
 }
 
@@ -2340,7 +2340,7 @@ cache_hit:
 
 		if (very_verbose(class)) {
 			printk("\nhash chain already cached, key: "
-					"%016Lx tail class: [%p] %s\n",
+					"%016Lx tail class: [%px] %s\n",
 					(unsigned long long)chain_key,
 					class->key, class->name);
 		}
@@ -2349,7 +2349,7 @@ cache_hit:
 	}
 
 	if (very_verbose(class)) {
-		printk("\nnew hash chain, key: %016Lx tail class: [%p] %s\n",
+		printk("\nnew hash chain, key: %016Lx tail class: [%px] %s\n",
 			(unsigned long long)chain_key, class->key, class->name);
 	}
 
@@ -2676,16 +2676,16 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 void print_irqtrace_events(struct task_struct *curr)
 {
 	printk("irq event stamp: %u\n", curr->irq_events);
-	printk("hardirqs last  enabled at (%u): [<%p>] %pS\n",
+	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		curr->hardirq_enable_event, (void *)curr->hardirq_enable_ip,
 		(void *)curr->hardirq_enable_ip);
-	printk("hardirqs last disabled at (%u): [<%p>] %pS\n",
+	printk("hardirqs last disabled at (%u): [<%px>] %pS\n",
 		curr->hardirq_disable_event, (void *)curr->hardirq_disable_ip,
 		(void *)curr->hardirq_disable_ip);
-	printk("softirqs last  enabled at (%u): [<%p>] %pS\n",
+	printk("softirqs last  enabled at (%u): [<%px>] %pS\n",
 		curr->softirq_enable_event, (void *)curr->softirq_enable_ip,
 		(void *)curr->softirq_enable_ip);
-	printk("softirqs last disabled at (%u): [<%p>] %pS\n",
+	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
 		curr->softirq_disable_event, (void *)curr->softirq_disable_ip,
 		(void *)curr->softirq_disable_ip);
 }
@@ -3207,7 +3207,7 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 	 * Sanity check, the lock-class key must be persistent:
 	 */
 	if (!static_obj(key)) {
-		printk("BUG: key %p not in .data!\n", key);
+		printk("BUG: key %px not in .data!\n", key);
 		/*
 		 * What it says above ^^^^^, I suggest you read it.
 		 */
@@ -3322,7 +3322,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	atomic_inc((atomic_t *)&class->ops);
 	if (very_verbose(class)) {
-		printk("\nacquire class [%p] %s", class->key, class->name);
+		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
@@ -4376,7 +4376,7 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	pr_warn("WARNING: held lock freed!\n");
 	print_kernel_ident();
 	pr_warn("-------------------------\n");
-	pr_warn("%s/%d is freeing memory %p-%p, with a lock still held there!\n",
+	pr_warn("%s/%d is freeing memory %px-%px, with a lock still held there!\n",
 		curr->comm, task_pid_nr(curr), mem_from, mem_to-1);
 	print_lock(hlock);
 	lockdep_print_held_locks(curr);
