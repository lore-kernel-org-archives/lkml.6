Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeCOMhI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:37:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeCOMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:43 -0400
Message-Id: <20180315123202.839601268@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 10/11] sched/wait: Remove wait_on_atomic_t()
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-10.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users left, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait_bit.h |   27 ------------
 kernel/sched/wait_bit.c  |  101 -----------------------------------------------
 2 files changed, 128 deletions(-)

--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -10,7 +10,6 @@
 struct wait_bit_key {
 	void			*flags;
 	int			bit_nr;
-#define WAIT_ATOMIC_T_BIT_NR	-1
 	unsigned long		timeout;
 };
 
@@ -22,21 +21,15 @@ struct wait_bit_queue_entry {
 #define __WAIT_BIT_KEY_INITIALIZER(word, bit)					\
 	{ .flags = word, .bit_nr = bit, }
 
-#define __WAIT_ATOMIC_T_KEY_INITIALIZER(p)					\
-	{ .flags = p, .bit_nr = WAIT_ATOMIC_T_BIT_NR, }
-
 typedef int wait_bit_action_f(struct wait_bit_key *key, int mode);
-typedef int wait_atomic_t_action_f(atomic_t *counter, unsigned int mode);
 
 void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit);
 int __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 int __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 void wake_up_bit(void *word, int bit);
-void wake_up_atomic_t(atomic_t *p);
 int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
 int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
 int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
-int out_of_line_wait_on_atomic_t(atomic_t *p, wait_atomic_t_action_f action, unsigned int mode);
 struct wait_queue_head *bit_waitqueue(void *word, int bit);
 extern void __init wait_bit_init(void);
 
@@ -57,7 +50,6 @@ extern int bit_wait(struct wait_bit_key
 extern int bit_wait_io(struct wait_bit_key *key, int mode);
 extern int bit_wait_timeout(struct wait_bit_key *key, int mode);
 extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
-extern int atomic_t_wait(atomic_t *counter, unsigned int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
@@ -243,25 +235,6 @@ wait_on_bit_lock_action(unsigned long *w
 	return out_of_line_wait_on_bit_lock(word, bit, action, mode);
 }
 
-/**
- * wait_on_atomic_t - Wait for an atomic_t to become 0
- * @val: The atomic value being waited on, a kernel virtual address
- * @action: the function used to sleep, which may take special actions
- * @mode: the task state to sleep in
- *
- * Wait for an atomic_t to become 0.  We abuse the bit-wait waitqueue table for
- * the purpose of getting a waitqueue, but we set the key to a bit number
- * outside of the target 'word'.
- */
-static inline
-int wait_on_atomic_t(atomic_t *val, wait_atomic_t_action_f action, unsigned mode)
-{
-	might_sleep();
-	if (atomic_read(val) == 0)
-		return 0;
-	return out_of_line_wait_on_atomic_t(val, action, mode);
-}
-
 extern void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int flags);
 extern void wake_up_var(void *var);
 extern wait_queue_head_t *__var_waitqueue(void *p);
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -197,107 +197,6 @@ void wake_up_var(void *var)
 }
 EXPORT_SYMBOL(wake_up_var);
 
-/*
- * Manipulate the atomic_t address to produce a better bit waitqueue table hash
- * index (we're keying off bit -1, but that would produce a horrible hash
- * value).
- */
-static inline wait_queue_head_t *atomic_t_waitqueue(atomic_t *p)
-{
-	if (BITS_PER_LONG == 64) {
-		unsigned long q = (unsigned long)p;
-
-		return bit_waitqueue((void *)(q & ~1), q & 1);
-	}
-	return bit_waitqueue(p, 0);
-}
-
-static int wake_atomic_t_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync,
-				  void *arg)
-{
-	struct wait_bit_key *key = arg;
-	struct wait_bit_queue_entry *wait_bit = container_of(wq_entry, struct wait_bit_queue_entry, wq_entry);
-	atomic_t *val = key->flags;
-
-	if (wait_bit->key.flags != key->flags ||
-	    wait_bit->key.bit_nr != key->bit_nr ||
-	    atomic_read(val) != 0)
-		return 0;
-
-	return autoremove_wake_function(wq_entry, mode, sync, key);
-}
-
-/*
- * To allow interruptible waiting and asynchronous (i.e. nonblocking) waiting,
- * the actions of __wait_on_atomic_t() are permitted return codes.  Nonzero
- * return codes halt waiting and return.
- */
-static __sched
-int __wait_on_atomic_t(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry,
-		       wait_atomic_t_action_f action, unsigned int mode)
-{
-	atomic_t *val;
-	int ret = 0;
-
-	do {
-		prepare_to_wait(wq_head, &wbq_entry->wq_entry, mode);
-		val = wbq_entry->key.flags;
-		if (atomic_read(val) == 0)
-			break;
-		ret = (*action)(val, mode);
-	} while (!ret && atomic_read(val) != 0);
-	finish_wait(wq_head, &wbq_entry->wq_entry);
-
-	return ret;
-}
-
-#define DEFINE_WAIT_ATOMIC_T(name, p)					\
-	struct wait_bit_queue_entry name = {				\
-		.key = __WAIT_ATOMIC_T_KEY_INITIALIZER(p),		\
-		.wq_entry = {						\
-			.private	= current,			\
-			.func		= wake_atomic_t_function,	\
-			.entry		=				\
-				LIST_HEAD_INIT((name).wq_entry.entry),	\
-		},							\
-	}
-
-__sched int out_of_line_wait_on_atomic_t(atomic_t *p,
-					 wait_atomic_t_action_f action,
-					 unsigned int mode)
-{
-	struct wait_queue_head *wq_head = atomic_t_waitqueue(p);
-	DEFINE_WAIT_ATOMIC_T(wq_entry, p);
-
-	return __wait_on_atomic_t(wq_head, &wq_entry, action, mode);
-}
-EXPORT_SYMBOL(out_of_line_wait_on_atomic_t);
-
-__sched int atomic_t_wait(atomic_t *counter, unsigned int mode)
-{
-	schedule();
-	if (signal_pending_state(mode, current))
-		return -EINTR;
-
-	return 0;
-}
-EXPORT_SYMBOL(atomic_t_wait);
-
-/**
- * wake_up_atomic_t - Wake up a waiter on a atomic_t
- * @p: The atomic_t being waited on, a kernel virtual address
- *
- * Wake up anyone waiting for the atomic_t to go to zero.
- *
- * Abuse the bit-waker function and its waitqueue hash table set (the atomic_t
- * check is done by the waiter's wake function, not the by the waker itself).
- */
-void wake_up_atomic_t(atomic_t *p)
-{
-	__wake_up_bit(atomic_t_waitqueue(p), p, WAIT_ATOMIC_T_BIT_NR);
-}
-EXPORT_SYMBOL(wake_up_atomic_t);
-
 __sched int bit_wait(struct wait_bit_key *word, int mode)
 {
 	schedule();
