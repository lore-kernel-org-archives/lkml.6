Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCOMfs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:35:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49186 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCOMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:44 -0400
Message-Id: <20180315123202.365696346@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:03 +0100
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
Subject: [PATCH 01/11] sched/wait: Introduce wait_var_event()
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-1.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a replacement for the wait_on_atomic_t() API provide the
wait_var_event() API.

The wait_var_event() API is based on the very same hashed-waitqueue
idea, but doesn't care about the type (atomic_t) or the specific
condition (atomic_read() == 0). IOW. it's much more widely
applicable/flexible.

It shares all the benefits/disadvantages of a hashed-waitqueue
approach with the existing wait_on_atomic_t/wait_on_bit() APIs.

The API is modeled after the existing wait_event() API, but instead of
taking a wait_queue_head, it takes an address. This addresses is
hashed to obtain a wait_queue_head from the bit_wait_table.

Similar to the wait_event() API, it takes a condition expression as
second argument and will wait until this expression becomes true.

The following are (mostly) identical replacements:

  wait_on_atomic_t(&my_atomic, atomic_t_wait, TASK_UNINTERRUPTIBLE);
  wake_up_atomic_t(&my_atomic);

  wait_var_event(&my_atomic, !atomic_read(&my_atomic));
  wake_up_var(&my_atomic);

The only difference is that wake_up_var() is an unconditional wakeup
and doesn't check the previously hard-coded (atomic_read() == 0)
condition here. This is of little concequence, since most callers are
already conditional on atomic_dec_and_test() and the ones that are
not, are trivial to make so.

Cc: David Howells <dhowells@redhat.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait_bit.h |   70 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/wait_bit.c  |   48 ++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -262,4 +262,74 @@ int wait_on_atomic_t(atomic_t *val, wait
 	return out_of_line_wait_on_atomic_t(val, action, mode);
 }
 
+extern void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int flags);
+extern void wake_up_var(void *var);
+extern wait_queue_head_t *__var_waitqueue(void *p);
+
+#define ___wait_var_event(var, condition, state, exclusive, ret, cmd)	\
+({									\
+	__label__ __out;						\
+	struct wait_queue_head *__wq_head = __var_waitqueue(var);	\
+	struct wait_bit_queue_entry __wbq_entry;			\
+	long __ret = ret; /* explicit shadow */				\
+									\
+	init_wait_var_entry(&__wbq_entry, var,				\
+			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
+	for (;;) {							\
+		long __int = prepare_to_wait_event(__wq_head,		\
+						   &__wbq_entry.wq_entry, \
+						   state);		\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret = __int;					\
+			goto __out;					\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+__out:	__ret;								\
+})
+
+#define __wait_var_event(var, condition)				\
+	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			  schedule())
+
+#define wait_var_event(var, condition)					\
+do {									\
+	might_sleep();							\
+	if (condition)							\
+		break;							\
+	__wait_var_event(var, condition);				\
+} while (0)
+
+#define __wait_var_event_killable(var, condition)			\
+	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
+			  schedule())
+
+#define wait_var_event_killable(var, condition)				\
+({									\
+	int __ret = 0;							\
+	might_sleep();							\
+	if (!(condition))						\
+		__ret = __wait_var_event_killable(var, condition);	\
+	__ret;								\
+})
+
+#define __wait_var_event_timeout(var, condition, timeout)		\
+	___wait_var_event(var, ___wait_cond_timeout(condition),		\
+			  TASK_UNINTERRUPTIBLE, 0, timeout,		\
+			  __ret = schedule_timeout(__ret))
+
+#define wait_var_event_timeout(var, condition, timeout)			\
+({									\
+	long __ret = timeout;						\
+	might_sleep();							\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __wait_var_event_timeout(var, condition, timeout); \
+	__ret;								\
+})
+
 #endif /* _LINUX_WAIT_BIT_H */
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -149,6 +149,54 @@ void wake_up_bit(void *word, int bit)
 }
 EXPORT_SYMBOL(wake_up_bit);
 
+wait_queue_head_t *__var_waitqueue(void *p)
+{
+	if (BITS_PER_LONG == 64) {
+		unsigned long q = (unsigned long)p;
+
+		return bit_waitqueue((void *)(q & ~1), q & 1);
+	}
+	return bit_waitqueue(p, 0);
+}
+EXPORT_SYMBOL(__var_waitqueue);
+
+static int
+var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
+		  int sync, void *arg)
+{
+	struct wait_bit_key *key = arg;
+	struct wait_bit_queue_entry *wbq_entry =
+		container_of(wq_entry, struct wait_bit_queue_entry, wq_entry);
+
+	if (wbq_entry->key.flags != key->flags ||
+	    wbq_entry->key.bit_nr != key->bit_nr)
+		return 0;
+
+	return autoremove_wake_function(wq_entry, mode, sync, key);
+}
+
+void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int flags)
+{
+	*wbq_entry = (struct wait_bit_queue_entry){
+		.key = {
+			.flags	= (var),
+			.bit_nr = -1,
+		},
+		.wq_entry = {
+			.private = current,
+			.func	 = var_wake_function,
+			.entry	 = LIST_HEAD_INIT(wbq_entry->wq_entry.entry),
+		},
+	};
+}
+EXPORT_SYMBOL(init_wait_var_entry);
+
+void wake_up_var(void *var)
+{
+	__wake_up_bit(__var_waitqueue(var), var, -1);
+}
+EXPORT_SYMBOL(wake_up_var);
+
 /*
  * Manipulate the atomic_t address to produce a better bit waitqueue table hash
  * index (we're keying off bit -1, but that would produce a horrible hash
