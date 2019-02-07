Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EB42175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBGLU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:20:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:28840 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfBGLU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:20:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 03:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,343,1544515200"; 
   d="scan'208";a="297933618"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2019 03:20:25 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] perf, bpf: Retain kernel executable code in memory to aid Intel PT tracing
Date:   Thu,  7 Feb 2019 13:19:01 +0200
Message-Id: <20190207111901.2399-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject to memory pressure and other limits, retain executable code, such
as JIT-compiled bpf, in memory instead of freeing it immediately it is no
longer needed for execution.

While perf is primarily aimed at statistical analysis, tools like Intel
PT can aim to provide a trace of exactly what happened. As such, corner
cases that can be overlooked statistically need to be addressed. For
example, there is a gap where JIT-compiled bpf can be freed from memory
before a tracer has a chance to read it out through the bpf syscall.
While that can be ignored statistically, it contributes to a death by
1000 cuts for tracers attempting to assemble exactly what happened. This is
a bit gratuitous given that retaining the executable code is relatively
simple, and the amount of memory involved relatively small. The retained
executable code is then available in memory images such as /proc/kcore.

This facility could perhaps be extended also to init sections.

Note that this patch is compile tested only and, at present, is missing
the ability to retain symbols.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/Kconfig.cpu       |   1 +
 include/linux/filter.h     |   4 +
 include/linux/xc_retain.h  |  49 ++++++++++
 init/Kconfig               |   6 ++
 kernel/Makefile            |   1 +
 kernel/bpf/core.c          |  44 ++++++++-
 kernel/xc_retain.c         | 183 +++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c |  62 +++++++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/xc_retain.h
 create mode 100644 kernel/xc_retain.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6adce15268bd..21dcd064c272 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -389,6 +389,7 @@ menuconfig PROCESSOR_SELECT
 config CPU_SUP_INTEL
 	default y
 	bool "Support Intel processors" if PROCESSOR_SELECT
+	select XC_RETAIN if PERF_EVENTS && BPF_JIT
 	---help---
 	  This enables detection, tunings and quirks for Intel processors
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index d531d4250bff..40b9f601e18f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -851,6 +851,10 @@ extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
+extern unsigned int bpf_jit_retain_min;
+extern unsigned int bpf_jit_retain_max;
+
+void bpf_jit_retain_update_sz(void);
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/include/linux/xc_retain.h b/include/linux/xc_retain.h
new file mode 100644
index 000000000000..e79dc138bab8
--- /dev/null
+++ b/include/linux/xc_retain.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Intel Corporation.
+ */
+#ifndef _LINUX_XC_RETAIN_H
+#define _LINUX_XC_RETAIN_H
+
+#include <linux/list.h>
+#include <linux/shrinker.h>
+#include <linux/spinlock.h>
+
+struct xc_retain_ops {
+	void (*free)(void *addr);
+};
+
+struct xc_retain {
+	struct list_head list;
+	struct list_head items;
+	const struct xc_retain_ops ops;
+	unsigned int min_pages;
+	unsigned int max_pages;
+	unsigned int current_pages;
+	unsigned int item_cnt;
+	spinlock_t lock;
+	struct shrinker shrinker;
+};
+
+#ifdef CONFIG_XC_RETAIN
+int xc_retain_register(struct xc_retain *xr);
+void xc_retain_binary(struct xc_retain *xr, void *addr, unsigned int pages);
+void xc_retain_set_min_pages(struct xc_retain *xr, unsigned int min_pages);
+void xc_retain_set_max_pages(struct xc_retain *xr, unsigned int max_pages);
+#else
+static inline int xc_retain_register(struct xc_retain *xr)
+{
+	return 0;
+}
+static inline void xc_retain_binary(struct xc_retain *xr, void *addr,
+				    unsigned int pages)
+{
+	xr->ops.free(addr);
+}
+static inline void xc_retain_set_max_pages(struct xc_retain *xr,
+					   unsigned int max_pages)
+{
+}
+#endif
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..954c288cabdc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1550,6 +1550,12 @@ config EMBEDDED
 	  an embedded system so certain expert options are available
 	  for configuration.
 
+config XC_RETAIN
+	bool
+	help
+	  Retain kernel executable code (e.g. jitted BPF) in memory after it
+	  would normally be freed.
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/kernel/Makefile b/kernel/Makefile
index 6aa7543bcdb2..5df40e2a934e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_XC_RETAIN) += xc_retain.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 19c49313c709..7fd235d235c2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -34,6 +34,7 @@
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
+#include <linux/xc_retain.h>
 
 #include <asm/unaligned.h>
 
@@ -480,6 +481,10 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
 int bpf_jit_harden   __read_mostly;
 int bpf_jit_kallsyms __read_mostly;
 long bpf_jit_limit   __read_mostly;
+#define BPF_JIT_RETAIN_MIN 0
+#define BPF_JIT_RETAIN_MAX 16
+unsigned int bpf_jit_retain_min __read_mostly = BPF_JIT_RETAIN_MIN;
+unsigned int bpf_jit_retain_max __read_mostly = BPF_JIT_RETAIN_MAX;
 
 static __always_inline void
 bpf_get_prog_addr_region(const struct bpf_prog *prog,
@@ -795,6 +800,43 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 	bpf_jit_uncharge_modmem(pages);
 }
 
+#ifdef CONFIG_XC_RETAIN
+static struct xc_retain bpf_jit_retain = {
+	.min_pages = BPF_JIT_RETAIN_MIN,
+	.max_pages = BPF_JIT_RETAIN_MAX,
+	.ops = {
+		.free = module_memfree,
+	},
+};
+
+void bpf_jit_retain_update_sz(void)
+{
+	xc_retain_set_min_pages(&bpf_jit_retain, bpf_jit_retain_min);
+	xc_retain_set_max_pages(&bpf_jit_retain, bpf_jit_retain_max);
+}
+
+static int __init bpf_jit_retain_init(void)
+{
+	return xc_retain_register(&bpf_jit_retain);
+}
+subsys_initcall(bpf_jit_retain_init);
+
+static void bpf_jit_binary_retain(struct bpf_prog *fp,
+				  struct bpf_binary_header *hdr)
+{
+	u32 pages = hdr->pages;
+
+	xc_retain_binary(&bpf_jit_retain, hdr, pages);
+	bpf_jit_uncharge_modmem(pages);
+}
+#else
+static void bpf_jit_binary_retain(struct bpf_prog *fp,
+				  struct bpf_binary_header *hdr)
+{
+	return bpf_jit_binary_free(hdr);
+}
+#endif
+
 /* This symbol is only overridden by archs that have different
  * requirements than the usual eBPF JITs, f.e. when they only
  * implement cBPF JIT, do not set images read-only, etc.
@@ -805,7 +847,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
 
 		bpf_jit_binary_unlock_ro(hdr);
-		bpf_jit_binary_free(hdr);
+		bpf_jit_binary_retain(fp, hdr);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
diff --git a/kernel/xc_retain.c b/kernel/xc_retain.c
new file mode 100644
index 000000000000..fcf987d443f2
--- /dev/null
+++ b/kernel/xc_retain.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Intel Corporation.
+ */
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/shrinker.h>
+#include <linux/xc_retain.h>
+
+struct xc_retain_item {
+	struct list_head list;
+	void *addr;
+	unsigned int pages;
+};
+
+#define XC_RETAIN_MAX_ITEMS 1024
+
+static struct xc_retain_item *xc_retain_item_alloc(void *addr,
+						   unsigned int pages)
+{
+	struct xc_retain_item *item;
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (item) {
+		INIT_LIST_HEAD(&item->list);
+		item->addr = addr;
+		item->pages = pages;
+	}
+
+	return item;
+}
+
+static void xc_retain_item_free(struct xc_retain *xr,
+				struct xc_retain_item *item)
+{
+	xr->ops.free(item->addr);
+	kfree(item);
+}
+
+static void xc_retain_item_add(struct xc_retain *xr,
+			       struct xc_retain_item *item)
+{
+	list_add_tail(&item->list, &xr->items);
+	xr->current_pages += item->pages;
+	xr->item_cnt += 1;
+}
+
+static void xc_retain_item_remove(struct xc_retain *xr,
+				  struct xc_retain_item *item)
+{
+	list_del(&item->list);
+	xr->current_pages -= item->pages;
+	xr->item_cnt -= 1;
+}
+
+static inline bool xc_retain_size_ok(struct xc_retain *xr)
+{
+	return xr->current_pages <= xr->max_pages &&
+	       xr->item_cnt <= XC_RETAIN_MAX_ITEMS;
+}
+
+static void xc_retain_resize(struct xc_retain *xr, struct list_head *to_free)
+{
+	struct xc_retain_item *item, *next;
+
+	if (xc_retain_size_ok(xr))
+		return;
+
+	list_for_each_entry_safe(item, next, &xr->items, list) {
+		xc_retain_item_remove(xr, item);
+		list_add_tail(&item->list, to_free);
+		if (xc_retain_size_ok(xr))
+			break;
+	}
+}
+
+static void xc_retain_items_free(struct xc_retain *xr,
+				 struct list_head *to_free)
+{
+	struct xc_retain_item *item, *next;
+
+	list_for_each_entry_safe(item, next, to_free, list)
+		xc_retain_item_free(xr, item);
+}
+
+void xc_retain_binary(struct xc_retain *xr, void *addr, unsigned int pages)
+{
+	struct xc_retain_item *item;
+	LIST_HEAD(to_free);
+
+	if (pages > xr->max_pages)
+		goto out_not_cached;
+
+	item = xc_retain_item_alloc(addr, pages);
+	if (!item)
+		goto out_not_cached;
+
+	spin_lock(&xr->lock);
+	xc_retain_item_add(xr, item);
+	xc_retain_resize(xr, &to_free);
+	spin_unlock(&xr->lock);
+
+	xc_retain_items_free(xr, &to_free);
+
+	return;
+
+out_not_cached:
+	xr->ops.free(addr);
+}
+
+void xc_retain_set_min_pages(struct xc_retain *xr, unsigned int min_pages)
+{
+	spin_lock(&xr->lock);
+	xr->min_pages = min_pages;
+	spin_unlock(&xr->lock);
+}
+
+void xc_retain_set_max_pages(struct xc_retain *xr, unsigned int max_pages)
+{
+	LIST_HEAD(to_free);
+
+	spin_lock(&xr->lock);
+	xr->max_pages = max_pages;
+	xc_retain_resize(xr, &to_free);
+	spin_unlock(&xr->lock);
+
+	xc_retain_items_free(xr, &to_free);
+}
+
+static unsigned long xc_retain_shrink_count(struct shrinker *shrinker,
+					    struct shrink_control *sc)
+{
+	struct xc_retain *xr = container_of(shrinker, struct xc_retain, shrinker);
+	struct xc_retain_item *item;
+	unsigned long nr = 0;
+
+	spin_lock(&xr->lock);
+	list_for_each_entry(item, &xr->items, list) {
+		if (xr->current_pages - item->pages < xr->min_pages)
+			break;
+		nr += 1;
+	}
+	spin_unlock(&xr->lock);
+
+	return nr ?: SHRINK_EMPTY;
+}
+
+static unsigned long xc_retain_shrink_scan(struct shrinker *shrinker,
+					   struct shrink_control *sc)
+{
+	struct xc_retain *xr = container_of(shrinker, struct xc_retain, shrinker);
+	struct xc_retain_item *item;
+	unsigned long freed;
+	LIST_HEAD(to_free);
+
+	spin_lock(&xr->lock);
+	for (freed = 0; sc->nr_to_scan && xr->item_cnt; freed++, sc->nr_to_scan--) {
+		item = list_first_entry(&xr->items, struct xc_retain_item, list);
+		if (xr->current_pages - item->pages < xr->min_pages)
+			break;
+		xc_retain_item_remove(xr, item);
+		list_add_tail(&item->list, &to_free);
+	}
+	spin_unlock(&xr->lock);
+
+	xc_retain_items_free(xr, &to_free);
+
+	return freed;
+}
+
+int xc_retain_register(struct xc_retain *xr)
+{
+	INIT_LIST_HEAD(&xr->list);
+	INIT_LIST_HEAD(&xr->items);
+
+	spin_lock_init(&xr->lock);
+
+	xr->shrinker.count_objects = xc_retain_shrink_count;
+	xr->shrinker.scan_objects = xc_retain_shrink_scan;
+
+	return register_shrinker(&xr->shrinker);
+}
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index d67ec17f2cc8..144d440dd9cd 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -28,6 +28,7 @@ static int two __maybe_unused = 2;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
+static int int_max __maybe_unused = INT_MAX;
 static long long_one __maybe_unused = 1;
 static long long_max __maybe_unused = LONG_MAX;
 
@@ -302,6 +303,47 @@ proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+# ifdef CONFIG_XC_RETAIN
+#define BPF_JIT_CACHE_LIMIT_SHIFT 4
+static int proc_bpf_jit_retain_sz(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos, bool is_max)
+{
+	int ret, val = *(int *)table->data;
+	struct ctl_table tmp = *table;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	tmp.data = &val;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		if (is_max ||
+		    val <= (totalram_pages() >> BPF_JIT_CACHE_LIMIT_SHIFT)) {
+			*(int *)table->data = val;
+			bpf_jit_retain_update_sz();
+		} else {
+			ret = -EINVAL;
+		}
+	}
+	return ret;
+}
+
+static int proc_bpf_jit_retain_min(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	return proc_bpf_jit_retain_sz(table, write, buffer, lenp, ppos, false);
+}
+
+static int proc_bpf_jit_retain_max(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	return proc_bpf_jit_retain_sz(table, write, buffer, lenp, ppos, true);
+}
+# endif
 #endif
 
 static struct ctl_table net_core_table[] = {
@@ -417,6 +459,26 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= &long_one,
 		.extra2		= &long_max,
 	},
+# ifdef CONFIG_XC_RETAIN
+	{
+		.procname	= "bpf_jit_retain_min",
+		.data		= &bpf_jit_retain_min,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_bpf_jit_retain_min,
+		.extra1		= &zero,
+		.extra2		= &int_max,
+	},
+	{
+		.procname	= "bpf_jit_retain_max",
+		.data		= &bpf_jit_retain_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_bpf_jit_retain_max,
+		.extra1		= &zero,
+		.extra2		= &int_max,
+	},
+# endif
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
-- 
2.17.1

