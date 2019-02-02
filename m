Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A6C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97153218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBBAHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:07:34 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:52402 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfBBAHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:07:34 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 06F444C0060;
        Sat,  2 Feb 2019 00:07:32 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:07:28 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH v2 1/4] static_call: add indirect call promotion
 (dynamic_call) infrastructure
To:     <namit@vmware.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Message-ID: <d9dd85ee-6fee-0efc-8fb6-aec956894ad6@solarflare.com>
Date:   Sat, 2 Feb 2019 00:07:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24400.005
X-TM-AS-Result: No-13.777400-4.000000-10
X-TMASE-MatchedRID: 20zepAPuWu6gVtmaxVWDUaVzYsvffdUxpPZLm8rbDqJjyv+d0Z0OxW9Z
        NQxuw2C3l4sRUz04dC43q+jxAiWaYPGgWlIacAz1M5vhCMb51Y8k9Lf/qe8xxwqiCYa6w8tvyJi
        VHsxfXPiSR/pPsumbzOGkC6UUQC9DdlYQPp9MBpLPmshbRFtLmOJ/6Zpnl1Dn8JGeRYYBDDp13e
        8TptaRwXUv5fXxlzM99gPoxs4Fl+DNwJnbTIxiVe7KTDtx8CggTJDl9FKHbrnxCQaCt6X8bipWM
        MWmA813mjLr5tFpiRe/v/ml9FIPSSbuZDjoMDHG+VmU9hhYfp15y+Nu7/EOOk+0uGVOF08QHOdj
        Zy3xfj2GUGnAFalyrtzwcvqyVpsQ42XoKl9uyfa8ZNzmhE6h3nUh2OMdFI0JQQ1XgvCe7sHgfDn
        XoidialaLt7XVMK8LoXeWnQhpGRp1tKCSzroCgZLB2j2kEEbAfrTt+hmA5bJFNyTs3OcE//yxAY
        AsYStxEhwoW7baUu/bOOxEG5SsnbmvMSppeWbNbuFuYBIpyuk4v0EQeJuGyIKwF4K/wIz9MCmLS
        FOvZt1awOZNKoxPB/9PJn4oaTOP0vxh6c85bkQ51NVfjWl7PfoLUyEI6+6gmJBe2bRXwlPY92Zl
        64JjIAJVch0IXRs49CYQMNqb0XpHq1tdpq05uaMVgdN9w+TCLAnNohUyMa0wEhHW5KVAz6dyK1r
        XVA/F14gnLq0QZ8cXIQarK0WBEHuHjdRpccGHA5rdNgLWPkJVyg4Yz2U7pKvM+zzl/BST3B2MKH
        XU15C62ReEaA1kVo7xQcJe4xZotzxYw6p+va6eAiCmPx4NwLTrdaH1ZWqCGtkvK5L7RXEXvQkGi
        3tjz/cUt5lc1lLgoGRyAacnhabKZZsXrNdslmp711B0NxrdhQXu2+Mz7MGNaZXw8ROqyH7cGd19
        dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.777400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24400.005
X-MDID: 1549066052-MuR3hUxCXces
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses runtime instrumentation of callees from an indirect call site to
 populate an indirect-call-wrapper branch tree.  Essentially we're doing
 indirect branch prediction in software because the hardware can't be
 trusted to get it right; this is sad.
Calls to these trampolines must take place within an RCU read-side
 critical section.  This is necessary because we use RCU synchronisation
 to ensure that no CPUs are running the fast path while we patch it;
 otherwise they could be between checking a static_call's func and
 actually calling it, and end up calling the wrong function.  The use
 of RCU as the synchronisation method means that dynamic_calls cannot be
 used for functions which call synchronize_rcu(), thus the mechanism has
 to be opt-in rather than being automatically applied to all indirect
 calls in the kernel.

Enabled by new CONFIG_DYNAMIC_CALLS, which defaults to off (and depends
 on a static_call implementation being available).

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 include/linux/dynamic_call.h | 300 +++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig                 |  11 ++
 kernel/Makefile              |   1 +
 kernel/dynamic_call.c        | 131 +++++++++++++++++++
 4 files changed, 443 insertions(+)
 create mode 100644 include/linux/dynamic_call.h
 create mode 100644 kernel/dynamic_call.c

diff --git a/include/linux/dynamic_call.h b/include/linux/dynamic_call.h
new file mode 100644
index 000000000000..2e84543c0c8b
--- /dev/null
+++ b/include/linux/dynamic_call.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DYNAMIC_CALL_H
+#define _LINUX_DYNAMIC_CALL_H
+
+/*
+ * Dynamic call (optpoline) support
+ *
+ * Dynamic calls use code patching and runtime learning to promote indirect
+ * calls into direct calls using the static_call machinery.  They give the
+ * flexibility of function pointers, but with improved performance.  This is
+ * especially important for cases where retpolines would otherwise be used, as
+ * retpolines can significantly impact performance.
+ * The two callees learned to be most common will be made through static_calls,
+ * while for any other callee the trampoline will fall back to an indirect call
+ * (or a retpoline, if those are enabled).
+ * Patching of newly learned callees into the fast-path relies on RCU to ensure
+ * the fast-path is not in use on any CPU; thus the calls must be made under
+ * the RCU read lock.
+ *
+ *
+ * A dynamic call table must be defined in file scope with
+ *	DYNAMIC_CALL_$NR(ret, name, type1, ..., type$NR);
+ * where $NR is from 1 to 4, ret is the return type of the function and type1
+ * through type$NR are the argument types.  Then, calls can be made through a
+ * matching function pointer 'func' with
+ *	x = dynamic_name(func, arg1, ..., arg$NR);
+ * which will behave equivalently to
+ *	(*func)(arg1, ..., arg$NR);
+ * except hopefully with higher performance.  It is allowed for multiple
+ * callsites to use the same dynamic call table, in which case they will share
+ * statistics for learning.  This will perform well as long as the callsites
+ * typically have the same set of common callees.
+ *
+ * Usage example:
+ *
+ *	struct foo {
+ *		int x;
+ *		int (*f)(int);
+ *	}
+ *	DYNAMIC_CALL_1(int, handle_foo, int);
+ *
+ *	int handle_foo(struct foo *f)
+ *	{
+ *		return dynamic_handle_foo(f->f, f->x);
+ *	}
+ *
+ * This should behave the same as if the function body were changed to:
+ *		return (f->f)(f->x);
+ * but potentially with improved performance.
+ */
+
+#define DEFINE_DYNAMIC_CALL_1(_ret, _name, _type1)			       \
+_ret dynamic_##_name(_ret (*func)(_type1), _type1 arg1);
+
+#define DEFINE_DYNAMIC_CALL_2(_ret, _name, _type1, _name2, _type2)	       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2), _type1 arg1, _type2 arg2);
+
+#define DEFINE_DYNAMIC_CALL_3(_ret, _name, _type1, _type2, _type3)	       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3), _type1 arg1,	       \
+		     _type2 arg2, _type3 arg3);
+
+#define DEFINE_DYNAMIC_CALL_4(_ret, _name, _type1, _type2, _type3, _type4)     \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3, _type4), _type1 arg1,\
+		     _type2 arg2, _type3 arg3, _type4 arg4);
+
+#ifdef CONFIG_DYNAMIC_CALLS
+
+#include <linux/jump_label.h>
+#include <linux/mutex.h>
+#include <linux/percpu.h>
+#include <linux/static_call.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+/* Number of callees from the slowpath to track on each CPU */
+#define DYNAMIC_CALL_CANDIDATES	4
+/*
+ * Number of fast-path callees; to change this, much of the macrology below
+ * must also be changed.
+ */
+#define DYNAMIC_CALL_BRANCHES	2
+struct dynamic_call_candidate {
+	void *func;
+	unsigned long hit_count;
+};
+struct dynamic_call_percpu {
+	struct dynamic_call_candidate candidates[DYNAMIC_CALL_CANDIDATES];
+	unsigned long hit_count[DYNAMIC_CALL_BRANCHES];
+	unsigned long miss_count;
+};
+struct dynamic_call {
+	struct work_struct update_work;
+	struct static_key_false *skip_stats;
+	struct static_key_true *skip_fast;
+	struct static_call_key *key[DYNAMIC_CALL_BRANCHES];
+	struct __percpu dynamic_call_percpu *percpu;
+	struct mutex update_lock;
+};
+
+void dynamic_call_update(struct work_struct *work);
+
+
+#define __DYNAMIC_CALL_BITS(_ret, _name, ...)				       \
+static _ret dummy_##_name(__VA_ARGS__)					       \
+{									       \
+	BUG();								       \
+}									       \
+DEFINE_STATIC_KEY_TRUE(_name##_skip_fast);				       \
+DEFINE_STATIC_KEY_FALSE(_name##_skip_stats);				       \
+DEFINE_STATIC_CALL(dynamic_##_name##_1, dummy_##_name);			       \
+DEFINE_STATIC_CALL(dynamic_##_name##_2, dummy_##_name);			       \
+DEFINE_PER_CPU(struct dynamic_call_percpu, _name##_dc_pc);		       \
+									       \
+static struct dynamic_call _name##_dc = {				       \
+	.update_work = __WORK_INITIALIZER(_name##_dc.update_work,	       \
+					  dynamic_call_update),		       \
+	.skip_stats = &_name##_skip_stats,				       \
+	.skip_fast = &_name##_skip_fast,				       \
+	.key = {&dynamic_##_name##_1, &dynamic_##_name##_2},		       \
+	.percpu = &_name##_dc_pc,					       \
+	.update_lock = __MUTEX_INITIALIZER(_name##_dc.update_lock),	       \
+};
+
+#define __DYNAMIC_CALL_STATS(_name)					       \
+	if (static_branch_unlikely(&_name##_skip_stats))		       \
+		goto skip_stats;					       \
+	for (i = 0; i < DYNAMIC_CALL_CANDIDATES; i++)			       \
+		if (func == thiscpu->candidates[i].func) {		       \
+			thiscpu->candidates[i].hit_count++;		       \
+			break;						       \
+		}							       \
+	if (i == DYNAMIC_CALL_CANDIDATES) /* no match */		       \
+		for (i = 0; i < DYNAMIC_CALL_CANDIDATES; i++)		       \
+			if (!thiscpu->candidates[i].func) {		       \
+				thiscpu->candidates[i].func = func;	       \
+				thiscpu->candidates[i].hit_count = 1;	       \
+				break;					       \
+			}						       \
+	if (i == DYNAMIC_CALL_CANDIDATES) /* no space */		       \
+		thiscpu->miss_count++;					       \
+									       \
+	for (i = 0; i < DYNAMIC_CALL_CANDIDATES; i++)			       \
+		total_count += thiscpu->candidates[i].hit_count;	       \
+	if (total_count > 1000) /* Arbitrary threshold */		       \
+		schedule_work(&_name##_dc.update_work);			       \
+	else if (thiscpu->miss_count > 1000) {				       \
+		/* Many misses, few hits: let's roll the dice again for a      \
+		 * fresh set of candidates.				       \
+		 */							       \
+		memset(thiscpu->candidates, 0, sizeof(thiscpu->candidates));   \
+		thiscpu->miss_count = 0;				       \
+	}								       \
+skip_stats:
+
+
+#define DYNAMIC_CALL_1(_ret, _name, _type1)				       \
+__DYNAMIC_CALL_BITS(_ret, _name, _type1 arg1)				       \
+									       \
+_ret dynamic_##_name(_ret (*func)(_type1), _type1 arg1)			       \
+{									       \
+	struct dynamic_call_percpu *thiscpu = this_cpu_ptr(_name##_dc.percpu); \
+	unsigned long total_count = 0;					       \
+	int i;								       \
+									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	if (static_branch_unlikely(&_name##_skip_fast))			       \
+		goto skip_fast;						       \
+	if (func == dynamic_##_name##_1.func) {				       \
+		thiscpu->hit_count[0]++;				       \
+		return static_call(dynamic_##_name##_1, arg1);		       \
+	}								       \
+	if (func == dynamic_##_name##_2.func) {				       \
+		thiscpu->hit_count[1]++;				       \
+		return static_call(dynamic_##_name##_2, arg1);		       \
+	}								       \
+									       \
+skip_fast:								       \
+	__DYNAMIC_CALL_STATS(_name)					       \
+	return func(arg1);						       \
+}
+
+#define DYNAMIC_CALL_2(_ret, _name, _type1, _type2)			       \
+__DYNAMIC_CALL_BITS(_ret, _name, _type1 arg1, _type2 arg2)		       \
+									       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2), _type1 arg1,	_type2 arg2)   \
+{									       \
+	struct dynamic_call_percpu *thiscpu = this_cpu_ptr(_name##_dc.percpu); \
+	unsigned long total_count = 0;					       \
+	int i;								       \
+									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	if (static_branch_unlikely(&_name##_skip_fast))			       \
+		goto skip_fast;						       \
+	if (func == dynamic_##_name##_1.func) {				       \
+		thiscpu->hit_count[0]++;				       \
+		return static_call(dynamic_##_name##_1, arg1, arg2);	       \
+	}								       \
+	if (func == dynamic_##_name##_2.func) {				       \
+		thiscpu->hit_count[1]++;				       \
+		return static_call(dynamic_##_name##_2, arg1, arg2);	       \
+	}								       \
+									       \
+skip_fast:								       \
+	__DYNAMIC_CALL_STATS(_name)					       \
+	return func(arg1, arg2);					       \
+}
+
+#define DYNAMIC_CALL_3(_ret, _name, _type1, _type2, _type3)		       \
+__DYNAMIC_CALL_BITS(_ret, _name, _type1 arg1, _type2 arg2, _type3 arg3)        \
+									       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3), _type1 arg1,	       \
+		     _type2 arg2, _type3 arg3)				       \
+{									       \
+	struct dynamic_call_percpu *thiscpu = this_cpu_ptr(_name##_dc.percpu); \
+	unsigned long total_count = 0;					       \
+	int i;								       \
+									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	if (static_branch_unlikely(&_name##_skip_fast))			       \
+		goto skip_fast;						       \
+	if (func == dynamic_##_name##_1.func) {				       \
+		thiscpu->hit_count[0]++;				       \
+		return static_call(dynamic_##_name##_1, arg1, arg2, arg3);  \
+	}								       \
+	if (func == dynamic_##_name##_2.func) {				       \
+		thiscpu->hit_count[1]++;				       \
+		return static_call(dynamic_##_name##_2, arg1, arg2, arg3);  \
+	}								       \
+									       \
+skip_fast:								       \
+	__DYNAMIC_CALL_STATS(_name)					       \
+	return func(arg1, arg2, arg3);					       \
+}
+
+#define DYNAMIC_CALL_4(_ret, _name, _type1, _type2, _type3, _type4)	       \
+__DYNAMIC_CALL_BITS(_ret, _name, _type1 arg1, _type2 arg2, _type3 arg3,	       \
+		    _type4 arg4)					       \
+									       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3, _type4), _type1 arg1,\
+		     _type2 arg2, _type3 arg3, _type4 arg4)		       \
+{									       \
+	struct dynamic_call_percpu *thiscpu = this_cpu_ptr(_name##_dc.percpu); \
+	unsigned long total_count = 0;					       \
+	int i;								       \
+									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	if (static_branch_unlikely(&_name##_skip_fast))			       \
+		goto skip_fast;						       \
+	if (func == dynamic_##_name##_1.func) {				       \
+		thiscpu->hit_count[0]++;				       \
+		return static_call(dynamic_##_name##_1, arg1, arg2, arg3, arg4);\
+	}								       \
+	if (func == dynamic_##_name##_2.func) {				       \
+		thiscpu->hit_count[1]++;				       \
+		return static_call(dynamic_##_name##_2, arg1, arg2, arg3, arg4);\
+	}								       \
+									       \
+skip_fast:								       \
+	__DYNAMIC_CALL_STATS(_name)					       \
+	return func(arg1, arg2, arg3, arg4);				       \
+}
+
+#else /* !CONFIG_DYNAMIC_CALLS */
+
+/* Implement as simple indirect calls */
+
+#define DYNAMIC_CALL_1(_ret, _name, _type1)				       \
+_ret dynamic_##_name(_ret (*func)(_type1), _type1 arg1)			       \
+{									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	return func(arg1);						       \
+}									       \
+
+#define DYNAMIC_CALL_2(_ret, _name, _type1, _name2, _type2)		       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2), _type1 arg1, _type2 arg2)   \
+{									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	return func(arg1, arg2);					       \
+}									       \
+
+#define DYNAMIC_CALL_3(_ret, _name, _type1, _type2, _type3)		       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3), _type1 arg1,	       \
+		     _type2 arg2, _type3 arg3)				       \
+{									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	return func(arg1, arg2, arg3);					       \
+}									       \
+
+#define DYNAMIC_CALL_4(_ret, _name, _type1, _type2, _type3, _type4)	       \
+_ret dynamic_##_name(_ret (*func)(_type1, _type2, _type3, _type4), _type1 arg1,\
+		     _type2 arg2, _type3 arg3, _type4 arg4)		       \
+{									       \
+	WARN_ON_ONCE(!rcu_read_lock_held());					       \
+	return func(arg1, arg2, arg3, arg4);				       \
+}									       \
+
+
+#endif /* CONFIG_DYNAMIC_CALLS */
+
+#endif /* _LINUX_DYNAMIC_CALL_H */
diff --git a/init/Kconfig b/init/Kconfig
index 513fa544a134..11133c141c21 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1779,6 +1779,17 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config DYNAMIC_CALLS
+	bool "Dynamic call optimisation (EXPERIMENTAL)"
+	depends on HAVE_STATIC_CALL
+	help
+	  Say Y here to accelerate selected indirect calls with optpolines,
+	  using runtime learning to populate the optpoline call tables.  This
+	  should improve performance, particularly when retpolines are enabled,
+	  but increases the size of the kernel .text, and on some workloads may
+	  cause the kernel to spend a significant amount of time updating the
+	  call tables.
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Makefile b/kernel/Makefile
index 8e1c6ca0f6e7..e6c32ac7e519 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
+obj-$(CONFIG_DYNAMIC_CALLS) += dynamic_call.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 
diff --git a/kernel/dynamic_call.c b/kernel/dynamic_call.c
new file mode 100644
index 000000000000..4ba2e5cdded3
--- /dev/null
+++ b/kernel/dynamic_call.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dynamic_call.h>
+#include <linux/printk.h>
+
+static void dynamic_call_add_cand(struct dynamic_call_candidate *top,
+				 size_t ncands,
+				 struct dynamic_call_candidate next)
+{
+	struct dynamic_call_candidate old;
+	int i;
+
+	for (i = 0; i < ncands; i++) {
+		if (next.hit_count > top[i].hit_count) {
+			/* Swap next with top[i], so that the old top[i] can
+			 * shunt along all lower scores
+			 */
+			old = top[i];
+			top[i] = next;
+			next = old;
+		}
+	}
+}
+
+static void dynamic_call_count_hits(struct dynamic_call_candidate *top,
+				   size_t ncands, struct dynamic_call *dc,
+				   int i)
+{
+	struct dynamic_call_candidate next;
+	struct dynamic_call_percpu *percpu;
+	int cpu;
+
+	next.func = dc->key[i]->func;
+	next.hit_count = 0;
+	for_each_online_cpu(cpu) {
+		percpu = per_cpu_ptr(dc->percpu, cpu);
+		next.hit_count += percpu->hit_count[i];
+		percpu->hit_count[i] = 0;
+	}
+
+	dynamic_call_add_cand(top, ncands, next);
+}
+
+void dynamic_call_update(struct work_struct *work)
+{
+	struct dynamic_call *dc = container_of(work, struct dynamic_call,
+					       update_work);
+	struct dynamic_call_candidate top[4], next, *cands, *cands2;
+	struct dynamic_call_percpu *percpu, *percpu2;
+	int cpu, i, cpu2, j;
+
+	memset(top, 0, sizeof(top));
+
+	pr_debug("dynamic_call_update called for %ps\n", dc);
+	mutex_lock(&dc->update_lock);
+	/* We don't stop the other CPUs adding to their counts while this is
+	 * going on; but it doesn't really matter because this is a heuristic
+	 * anyway so we don't care about perfect accuracy.
+	 */
+	/* First count up the hits on the existing static branches */
+	for (i = 0; i < DYNAMIC_CALL_BRANCHES; i++)
+		dynamic_call_count_hits(top, ARRAY_SIZE(top), dc, i);
+	/* Next count up the callees seen in the fallback path */
+	/* Switch off stats collection in the slowpath first */
+	static_branch_enable(dc->skip_stats);
+	synchronize_rcu();
+	for_each_online_cpu(cpu) {
+		percpu = per_cpu_ptr(dc->percpu, cpu);
+		cands = percpu->candidates;
+		for (i = 0; i < DYNAMIC_CALL_CANDIDATES; i++) {
+			next = cands[i];
+			if (next.func == NULL)
+				continue;
+			next.hit_count = 0;
+			for_each_online_cpu(cpu2) {
+				percpu2 = per_cpu_ptr(dc->percpu, cpu2);
+				cands2 = percpu2->candidates;
+				for (j = 0; j < DYNAMIC_CALL_CANDIDATES; j++) {
+					if (cands2[j].func == next.func) {
+						cands2[j].func = NULL;
+						next.hit_count += cands2[j].hit_count;
+						cands2[j].hit_count = 0;
+						break;
+					}
+				}
+			}
+			dynamic_call_add_cand(top, ARRAY_SIZE(top), next);
+		}
+	}
+	/* Record our results (for debugging) */
+	for (i = 0; i < ARRAY_SIZE(top); i++) {
+		if (i < DYNAMIC_CALL_BRANCHES)
+			pr_debug("%ps: selected [%d] %pf, score %lu\n",
+				 dc, i, top[i].func, top[i].hit_count);
+		else
+			pr_debug("%ps: runnerup [%d] %pf, score %lu\n",
+				 dc, i, top[i].func, top[i].hit_count);
+	}
+	/* It's possible that we could have picked up multiple pushes of the
+	 * workitem, so someone already collected most of the count.  In that
+	 * case, don't make a decision based on only a small number of calls.
+	 */
+	if (top[0].hit_count > 250) {
+		/* Divert callers away from the fast path */
+		static_branch_enable(dc->skip_fast);
+		/* Wait for existing fast path callers to finish */
+		synchronize_rcu();
+		/* Patch the chosen callees into the fast path */
+		for(i = 0; i < DYNAMIC_CALL_BRANCHES; i++) {
+			__static_call_update(dc->key[i], top[i].func);
+			/* Clear the hit-counts, they were for the old funcs */
+			for_each_online_cpu(cpu)
+				per_cpu_ptr(dc->percpu, cpu)->hit_count[i] = 0;
+		}
+		/* Ensure the new fast path is seen before we direct anyone
+		 * into it.  This probably isn't necessary (the binary-patching
+		 * framework probably takes care of it) but let's be paranoid.
+		 */
+		wmb();
+		/* Switch callers back onto the fast path */
+		static_branch_disable(dc->skip_fast);
+	} else {
+		pr_debug("%ps: too few hits, not patching\n", dc);
+	}
+
+	/* Finally, re-enable stats gathering in the fallback path. */
+	static_branch_disable(dc->skip_stats);
+
+	mutex_unlock(&dc->update_lock);
+	pr_debug("dynamic_call_update (%ps) finished\n", dc);
+}

