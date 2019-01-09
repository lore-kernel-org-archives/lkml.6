Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C0CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71112206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfAIXAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:00:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfAIXAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:00:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D0A5C023D;
        Wed,  9 Jan 2019 23:00:01 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47F341001F57;
        Wed,  9 Jan 2019 22:59:59 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 4/6] static_call: Add inline static call infrastructure
Date:   Wed,  9 Jan 2019 16:59:39 -0600
Message-Id: <c70ea8c00b93dadcb97b9d83659cf204121372d6.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 09 Jan 2019 23:00:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add infrastructure for an arch-specific CONFIG_HAVE_STATIC_CALL_INLINE
option, which is a faster version of CONFIG_HAVE_STATIC_CALL.  At
runtime, the static call sites are patched directly, rather than using
the out-of-line trampolines.

Compared to out-of-line static calls, the performance benefits are more
modest, but still measurable.  Steven Rostedt did some tracepoint
measurements:

  https://lkml.kernel.org/r/20181126155405.72b4f718@gandalf.local.home

This code is heavily inspired by the jump label code (aka "static
jumps"), as some of the concepts are very similar.

For more details, see the comments in include/linux/static_call.h.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                      |   4 +
 include/linux/module.h            |  10 +
 include/linux/static_call.h       |  63 +++++-
 include/linux/static_call_types.h |   9 +
 kernel/Makefile                   |   1 +
 kernel/module.c                   |   5 +
 kernel/static_call.c              | 316 ++++++++++++++++++++++++++++++
 7 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 kernel/static_call.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 7e469a693da3..173f2f564ef9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -888,6 +888,10 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 config HAVE_STATIC_CALL
 	bool
 
+config HAVE_STATIC_CALL_INLINE
+	bool
+	depends on HAVE_STATIC_CALL
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/module.h b/include/linux/module.h
index 9a21fe3509af..7af718767ba3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -21,6 +21,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/static_call_types.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -454,6 +455,10 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	int num_static_call_sites;
+	struct static_call_site *static_call_sites;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
@@ -693,6 +698,11 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module_init(unsigned long addr, const struct module *mod)
+{
+	return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 9e85c479cd11..b641ce40af1d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -47,6 +47,12 @@
  *    Each static_call() site calls into a trampoline associated with the key.
  *    The trampoline has a direct branch to the default function.  Updates to a
  *    key will modify the trampoline's branch destination.
+ *
+ *    If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
+ *    themselves will be patched at runtime to call the functions directly,
+ *    rather than calling through the trampoline.  This requires objtool or a
+ *    compiler plugin to detect all the static_call() sites and annotate them
+ *    in the .static_call_sites section.
  */
 
 #include <linux/types.h>
@@ -64,7 +70,62 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func);
 	extern typeof(func) STATIC_CALL_TRAMP(key)
 
 
-#if defined(CONFIG_HAVE_STATIC_CALL)
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+struct static_call_key {
+	void *func, *tramp;
+	/*
+	 * List of modules (including vmlinux) and their call sites associated
+	 * with this key.
+	 */
+	struct list_head site_mods;
+};
+
+struct static_call_mod {
+	struct list_head list;
+	struct module *mod; /* for vmlinux, mod == NULL */
+	struct static_call_site *sites;
+};
+
+extern void __static_call_update(struct static_call_key *key, void *func);
+extern int static_call_mod_init(struct module *mod);
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+		.tramp = STATIC_CALL_TRAMP(key),			\
+		.site_mods = LIST_HEAD_INIT(key.site_mods),		\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(key, _func)
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so objtool can reference it when it generates the
+ * static_call_site structs.
+ */
+#define static_call(key, args...)					\
+({									\
+	__ADDRESSABLE(key);						\
+	STATIC_CALL_TRAMP(key)(args);					\
+})
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key)						\
+	EXPORT_SYMBOL(key);						\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
+
+#define EXPORT_STATIC_CALL_GPL(key)					\
+	EXPORT_SYMBOL_GPL(key);						\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
+
+
+#elif defined(CONFIG_HAVE_STATIC_CALL)
 
 struct static_call_key {
 	void *func, *tramp;
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 0baaf3f02476..09b0a1db7a51 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -10,4 +10,13 @@
 #define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
 #define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
 
+/*
+ * The static call site table needs to be created by external tooling (objtool
+ * or a compiler plugin).
+ */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 6aa7543bcdb2..8e1c6ca0f6e7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..c09e3a868d4c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3130,6 +3130,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->ei_funcs = section_objs(info, "_error_injection_whitelist",
 					    sizeof(*mod->ei_funcs),
 					    &mod->num_ei_funcs);
+#endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	mod->static_call_sites = section_objs(info, ".static_call_sites",
+					      sizeof(*mod->static_call_sites),
+					      &mod->num_static_call_sites);
 #endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
diff --git a/kernel/static_call.c b/kernel/static_call.c
new file mode 100644
index 000000000000..b9fdf6fab4d1
--- /dev/null
+++ b/kernel/static_call.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/processor.h>
+#include <asm/sections.h>
+
+extern struct static_call_site __start_static_call_sites[],
+			       __stop_static_call_sites[];
+
+static bool static_call_initialized;
+
+#define STATIC_CALL_INIT 1UL
+
+/* mutex to protect key modules/sites */
+static DEFINE_MUTEX(static_call_mutex);
+
+static void static_call_lock(void)
+{
+	mutex_lock(&static_call_mutex);
+}
+
+static void static_call_unlock(void)
+{
+	mutex_unlock(&static_call_mutex);
+}
+
+static inline void *static_call_addr(struct static_call_site *site)
+{
+	return (void *)((long)site->addr + (long)&site->addr);
+}
+
+
+static inline struct static_call_key *static_call_key(const struct static_call_site *site)
+{
+	return (struct static_call_key *)
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+}
+
+/* These assume the key is word-aligned. */
+static inline bool static_call_is_init(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+}
+
+static inline void static_call_set_init(struct static_call_site *site)
+{
+	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+		    (long)&site->key;
+}
+
+static int static_call_site_cmp(const void *_a, const void *_b)
+{
+	const struct static_call_site *a = _a;
+	const struct static_call_site *b = _b;
+	const struct static_call_key *key_a = static_call_key(a);
+	const struct static_call_key *key_b = static_call_key(b);
+
+	if (key_a < key_b)
+		return -1;
+
+	if (key_a > key_b)
+		return 1;
+
+	return 0;
+}
+
+static void static_call_site_swap(void *_a, void *_b, int size)
+{
+	long delta = (unsigned long)_a - (unsigned long)_b;
+	struct static_call_site *a = _a;
+	struct static_call_site *b = _b;
+	struct static_call_site tmp = *a;
+
+	a->addr = b->addr  - delta;
+	a->key  = b->key   - delta;
+
+	b->addr = tmp.addr + delta;
+	b->key  = tmp.key  + delta;
+}
+
+static inline void static_call_sort_entries(struct static_call_site *start,
+					    struct static_call_site *stop)
+{
+	sort(start, stop - start, sizeof(struct static_call_site),
+	     static_call_site_cmp, static_call_site_swap);
+}
+
+void __static_call_update(struct static_call_key *key, void *func)
+{
+	struct static_call_mod *site_mod;
+	struct static_call_site *site, *stop;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	if (key->func == func)
+		goto done;
+
+	key->func = func;
+
+	/*
+	 * If called before init, leave the call sites unpatched for now.
+	 * In the meantime they'll continue to call the temporary trampoline.
+	 */
+	if (!static_call_initialized)
+		goto done;
+
+	list_for_each_entry(site_mod, &key->site_mods, list) {
+		if (!site_mod->sites) {
+			/*
+			 * This can happen if the static call key is defined in
+			 * a module which doesn't use it.
+			 */
+			continue;
+		}
+
+		stop = __stop_static_call_sites;
+
+#ifdef CONFIG_MODULES
+		if (site_mod->mod) {
+			stop = site_mod->mod->static_call_sites +
+			       site_mod->mod->num_static_call_sites;
+		}
+#endif
+
+		for (site = site_mod->sites;
+		     site < stop && static_call_key(site) == key; site++) {
+			void *site_addr = static_call_addr(site);
+			struct module *mod = site_mod->mod;
+
+			if (static_call_is_init(site)) {
+				/*
+				 * Don't write to call sites which were in
+				 * initmem and have since been freed.
+				 */
+				if (!mod && system_state >= SYSTEM_RUNNING)
+					continue;
+				if (mod && !within_module_init((unsigned long)site_addr, mod))
+					continue;
+			}
+
+			if (!kernel_text_address((unsigned long)site_addr)) {
+				WARN_ONCE(1, "can't patch static call site at %pS",
+					  site_addr);
+				continue;
+			}
+
+			arch_static_call_transform(site_addr, key->tramp, func);
+		}
+	}
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+
+#ifdef CONFIG_MODULES
+
+static int static_call_add_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	if (start == stop)
+		return 0;
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		void *site_addr = static_call_addr(site);
+
+		if (within_module_init((unsigned long)site_addr, mod))
+			static_call_set_init(site);
+
+		key = static_call_key(site);
+		if (key != prev_key) {
+			prev_key = key;
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod)
+				return -ENOMEM;
+
+			site_mod->mod = mod;
+			site_mod->sites = site;
+			list_add_tail(&site_mod->list, &key->site_mods);
+		}
+
+		arch_static_call_transform(site_addr, key->tramp, key->func);
+	}
+
+	return 0;
+}
+
+static void static_call_del_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	for (site = start; site < stop; site++) {
+		key = static_call_key(site);
+		if (key == prev_key)
+			continue;
+		prev_key = key;
+
+		list_for_each_entry(site_mod, &key->site_mods, list) {
+			if (site_mod->mod == mod) {
+				list_del(&site_mod->list);
+				kfree(site_mod);
+				break;
+			}
+		}
+	}
+}
+
+static int static_call_module_notify(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		module_disable_ro(mod);
+		ret = static_call_add_module(mod);
+		module_enable_ro(mod, false);
+		if (ret) {
+			WARN(1, "Failed to allocate memory for static calls");
+			static_call_del_module(mod);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		static_call_del_module(mod);
+		break;
+	}
+
+	static_call_unlock();
+	cpus_read_unlock();
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block static_call_module_nb = {
+	.notifier_call = static_call_module_notify,
+};
+
+#endif /* CONFIG_MODULES */
+
+static void __init static_call_init(void)
+{
+	struct static_call_site *start = __start_static_call_sites;
+	struct static_call_site *stop  = __stop_static_call_sites;
+	struct static_call_site *site;
+
+	if (start == stop) {
+		pr_warn("WARNING: empty static call table\n");
+		return;
+	}
+
+	cpus_read_lock();
+	static_call_lock();
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		struct static_call_key *key = static_call_key(site);
+		void *site_addr = static_call_addr(site);
+
+		if (init_section_contains(site_addr, 1))
+			static_call_set_init(site);
+
+		if (list_empty(&key->site_mods)) {
+			struct static_call_mod *site_mod;
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod) {
+				WARN(1, "Failed to allocate memory for static calls");
+				goto done;
+			}
+
+			site_mod->sites = site;
+			list_add_tail(&site_mod->list, &key->site_mods);
+		}
+
+		arch_static_call_transform(site_addr, key->tramp, key->func);
+	}
+
+	static_call_initialized = true;
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+
+#ifdef CONFIG_MODULES
+	if (static_call_initialized)
+		register_module_notifier(&static_call_module_nb);
+#endif
+}
+early_initcall(static_call_init);
-- 
2.17.2

