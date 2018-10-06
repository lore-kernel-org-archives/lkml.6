Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D9DC00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEB52147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEB52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeJFI6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeJFI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:58:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7D021473;
        Sat,  6 Oct 2018 01:57:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1g8bqK-0006AY-Nl; Fri, 05 Oct 2018 21:57:20 -0400
Message-Id: <20181006015720.634688468@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 05 Oct 2018 21:51:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
References: <20181006015110.653946300@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0001-jump_function-Addition-of-new-feature-jump_function.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h |   4 +
 include/linux/jump_function.h     |  93 ++++++++
 kernel/Makefile                   |   2 +-
 kernel/jump_function.c            | 368 ++++++++++++++++++++++++++++++
 4 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/jump_function.h
 create mode 100644 kernel/jump_function.c

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..0e205069ff36 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -257,6 +257,10 @@
 	__start___jump_table = .;					\
 	KEEP(*(__jump_table))                                           \
 	__stop___jump_table = .;					\
+	. = ALIGN(8);                                                   \
+	__start___dynfunc_table = .;					\
+	KEEP(*(__dynfunc_table))					\
+	__stop___dynfunc_table = .;					\
 	. = ALIGN(8);							\
 	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
diff --git a/include/linux/jump_function.h b/include/linux/jump_function.h
new file mode 100644
index 000000000000..8c6b0bab5f10
--- /dev/null
+++ b/include/linux/jump_function.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_JUMP_FUNCTION_H
+#define _LINUX_JUMP_FUNCTION_H
+
+
+//// This all should be in arch/x86/include/asm
+
+typedef long dynfunc_t;
+
+struct dynfunc_struct;
+
+#define arch_dynfunc_trampoline(name, def)	\
+	asm volatile (				\
+	".globl dynfunc_" #name "; \n\t"	\
+	"dynfunc_" #name ": \n\t"		\
+	"jmp " #def " \n\t"			\
+	".balign 8 \n \t"			\
+	: : : "memory" )
+
+int arch_assign_dynamic_function(const struct dynfunc_struct *dynfunc, void *func);
+
+//////////////// The below should be in include/linux
+
+#ifndef PARAMS
+#define PARAMS(x...) x
+#endif
+
+#ifndef ARGS
+#define ARGS(x...) x
+#endif
+
+struct dynfunc_struct {
+	const void		*dynfunc;
+	void			*func;
+};
+
+int assign_dynamic_function(const struct dynfunc_struct *dynfunc, void *func);
+
+/*
+ * DECLARE_DYNAMIC_FUNCTION - Declaration to create a dynamic function call
+ * @name: The name of the function call to create
+ * @proto: The proto-type of the function (up to 4 args)
+ * @args: The arguments used by @proto
+ *
+ * This macro creates the function that can by used to create a dynamic
+ * function call later. It also creates the function to modify what is
+ * called:
+ *
+ *   dynfunc_[name](args);
+ *
+ * This is placed in the code where the dynamic function should be called
+ * from.
+ *
+ *   assign_dynamic_function_[name](func);
+ *
+ * This is used to make the dynfunc_[name]() call a different function.
+ * It will then call (func) instead.
+ *
+ * This must be added in a header for users of the above two functions.
+ */
+#define DECLARE_DYNAMIC_FUNCTION(name, proto, args)			\
+	extern struct dynfunc_struct ___dyn_func__##name;		\
+	static inline int assign_dynamic_function_##name(int(*func)(proto)) { \
+		return assign_dynamic_function(&___dyn_func__##name, func); \
+	}								\
+	extern int dynfunc_##name(proto)
+
+/*
+ * DEFINE_DYNAMIC_FUNCTION - Define the dynamic function and default
+ * @name: The name of the function call to create
+ * @def: The default function to call
+ * @proto: The proto-type of the function (up to 4 args)
+ *
+ * Must be placed in a C file.
+ *
+ * This sets up the dynamic function that other places may call
+ * dynfunc_[name]().
+ *
+ * It defines the default function that the dynamic function will start
+ * out calling at boot up.
+ */
+#define DEFINE_DYNAMIC_FUNCTION(name, def, proto)			\
+	static void __used __dyn_func_trampoline_##name(void)		\
+	{								\
+		arch_dynfunc_trampoline(name, def);			\
+		unreachable();						\
+	}								\
+	struct dynfunc_struct ___dyn_func__##name __used = {		\
+		.dynfunc	= (void *)dynfunc_##name,		\
+		.func		= def,					\
+	}
+
+#endif	/*  _LINUX_JUMP_FUNCTION_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 7a63d567fdb5..c647c7f15318 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o
+	    async.o range.o smpboot.o ucount.o jump_function.o
 
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/jump_function.c b/kernel/jump_function.c
new file mode 100644
index 000000000000..f3decae1bb84
--- /dev/null
+++ b/kernel/jump_function.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dynamic function support
+ *
+ * Copyright (C) 2018 VMware inc, Steven Rostedt <rostedt@goodmis.org>
+ *
+ */
+
+#include <linux/jump_function.h>
+#include <linux/memory.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/sort.h>
+#include <linux/err.h>
+
+#include <asm/sections.h>
+#include <asm/text-patching.h>
+
+#include <linux/uaccess.h>
+
+static DEFINE_MUTEX(dynfunc_mutex);
+
+
+////// The below should be in arch/x86/kernel
+
+#define CALL_SIZE 5
+
+union call_code_union {
+	unsigned char code[CALL_SIZE];
+	struct {
+		unsigned char e9;
+		int offset;
+	} __attribute__((packed));
+};
+
+int arch_assign_dynamic_function(const struct dynfunc_struct *dynfunc,
+				void *func)
+{
+	unsigned long dfunc = (unsigned long)dynfunc->dynfunc;
+	union call_code_union code;
+
+	/* Debug to see what we are replacing (remove this) */
+	probe_kernel_read(code.code, (void *)dfunc, CALL_SIZE);
+#if 0
+	printk("old code = %02x %02x %02x %02x %02x %pS (%lx)\n",
+		code.code[0], code.code[1], code.code[2], code.code[3], code.code[4],
+	       (void *)(code.offset + dfunc + CALL_SIZE),
+	       code.offset + dfunc + CALL_SIZE);
+#endif
+
+	code.e9 = 0xe9;
+	code.offset = (int)((unsigned long)func - (dfunc + CALL_SIZE));
+
+#if 0
+	/* Debug to see what we are updating to (remove this) */
+	printk("adding func %pS to %pS (%lx) %02x %02x %02x %02x %02x\n",
+	       func, (void *)dfunc, (unsigned long)dfunc,
+		code.code[0], code.code[1], code.code[2], code.code[3], code.code[4]);
+#endif
+
+	mutex_lock(&text_mutex);
+	text_poke_bp((void *)dfunc, code.code, CALL_SIZE, func);
+	mutex_unlock(&text_mutex);
+
+	return 0;
+}
+
+////////////// The below can be in kernel/jump_function.c
+
+int assign_dynamic_function(const struct dynfunc_struct *dynfunc, void *func)
+{
+	int ret;
+
+	mutex_lock(&dynfunc_mutex);
+	ret = arch_assign_dynamic_function(dynfunc, func);
+	mutex_unlock(&dynfunc_mutex);
+
+	return ret;
+}
+
+///////// The below is for testing. Can be added in sample code.
+
+#include <linux/debugfs.h>
+
+/*
+ * The below creates a directory in debugfs called "jump_funcs" and
+ * five files within that directory:
+ *
+ * func0, func1, func2, func3, func4.
+ *
+ * Each of those files trigger a dynamic function, with the number
+ * of arguments that match the number in the file name. The
+ * arguments are an "int", "long", "void *" and "char *" (for the defined
+ * arguments of the dynmaic functions). The values used are:
+ * "1", "2", "0xdeadbeef" and "random string".
+ *
+ * Reading the file causes a dynamic function to be called. The
+ * functions assigned to the dynamic functions just prints its own
+ * function name, followed by the parameters passed to it.
+ *
+ * Each dynamic function has 3 functions that can be assigned to it.
+ * By echoing a "0" through "2" will change the function that is
+ * assigned. By doing another read of that file, it should show that
+ * the dynamic function has been updated.
+ */
+DECLARE_DYNAMIC_FUNCTION(myfunc0, PARAMS(void), ARGS());
+DECLARE_DYNAMIC_FUNCTION(myfunc1, PARAMS(int a), ARGS(a));
+DECLARE_DYNAMIC_FUNCTION(myfunc2, PARAMS(int a, long b), ARGS(a, b));
+DECLARE_DYNAMIC_FUNCTION(myfunc3, PARAMS(int a, long b, void *c),
+			 ARGS(a, b, c));
+DECLARE_DYNAMIC_FUNCTION(myfunc4, PARAMS(int a, long b, void *c, char *d),
+			 ARGS(a, b, c, d));
+
+static int myfunc0_default(void)
+{
+	printk("%s\n", __func__);
+	return 0;
+}
+
+static int myfunc1_default(int a)
+{
+	printk("%s %d\n", __func__, a);
+	return 0;
+}
+
+static int myfunc2_default(int a, long b)
+{
+	printk("%s %d %ld\n", __func__, a, b);
+	return 0;
+}
+
+static int myfunc3_default(int a, long b, void *c)
+{
+	printk("%s %d %ld %p\n", __func__, a, b, c);
+	return 0;
+}
+
+static int myfunc4_default(int a, long b, void *c, char *d)
+{
+	printk("%s %d %ld %p %s\n", __func__, a, b, c, d);
+	return 0;
+}
+
+DEFINE_DYNAMIC_FUNCTION(myfunc0, myfunc0_default, PARAMS(void));
+DEFINE_DYNAMIC_FUNCTION(myfunc1, myfunc1_default, PARAMS(int a));
+DEFINE_DYNAMIC_FUNCTION(myfunc2, myfunc2_default, PARAMS(int a, long b));
+DEFINE_DYNAMIC_FUNCTION(myfunc3, myfunc3_default, PARAMS(int a, long b, void *c));
+DEFINE_DYNAMIC_FUNCTION(myfunc4, myfunc4_default,
+			PARAMS(int a, long b, void *c, char *d));
+
+static int myfunc0_test1(void)
+{
+	printk("%s\n", __func__);
+	return 1;
+}
+
+static int myfunc1_test1(int a)
+{
+	printk("%s %d\n", __func__, a);
+	return 1;
+}
+
+static int myfunc2_test1(int a, long b)
+{
+	printk("%s %d %ld\n", __func__, a, b);
+	return 1;
+}
+
+static int myfunc3_test1(int a, long b, void *c)
+{
+	printk("%s %d %ld %p\n", __func__, a, b, c);
+	return 1;
+}
+
+static int myfunc4_test1(int a, long b, void *c, char *d)
+{
+	printk("%s %d %ld %p %s\n", __func__, a, b, c, d);
+	return 1;
+}
+
+static int myfunc0_test2(void)
+{
+	printk("%s\n", __func__);
+	return 2;
+}
+
+static int myfunc1_test2(int a)
+{
+	printk("%s %d\n", __func__, a);
+	return 2;
+}
+
+static int myfunc2_test2(int a, long b)
+{
+	printk("%s %d %ld\n", __func__, a, b);
+	return 2;
+}
+
+static int myfunc3_test2(int a, long b, void *c)
+{
+	printk("%s %d %ld %px\n", __func__, a, b, c);
+	return 2;
+}
+
+static int myfunc4_test2(int a, long b, void *c, char *d)
+{
+	printk("%s %d %ld %px %s\n", __func__, a, b, c, d);
+	return 2;
+}
+
+static int open_generic(struct inode *inode, struct file *filp)
+{
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t
+jump_func_write(struct file *filp, const char __user *ubuf,
+	       size_t cnt, loff_t *ppos)
+{
+	long type = (long)filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case 0:
+		switch(val) {
+		case 0:
+			assign_dynamic_function_myfunc0(myfunc0_default);
+			break;
+		case 1:
+			assign_dynamic_function_myfunc0(myfunc0_test1);
+			break;
+		case 2:
+			assign_dynamic_function_myfunc0(myfunc0_test2);
+			break;
+		}
+		break;
+	case 1:
+		switch(val) {
+		case 0:
+			assign_dynamic_function_myfunc1(myfunc1_default);
+			break;
+		case 1:
+			assign_dynamic_function_myfunc1(myfunc1_test1);
+			break;
+		case 2:
+			assign_dynamic_function_myfunc1(myfunc1_test2);
+			break;
+		}
+		break;
+	case 2:
+		switch(val) {
+		case 0:
+			assign_dynamic_function_myfunc2(myfunc2_default);
+			break;
+		case 1:
+			assign_dynamic_function_myfunc2(myfunc2_test1);
+			break;
+		case 2:
+			assign_dynamic_function_myfunc2(myfunc2_test2);
+			break;
+		}
+		break;
+	case 3:
+		switch(val) {
+		case 0:
+			assign_dynamic_function_myfunc3(myfunc3_default);
+			break;
+		case 1:
+			assign_dynamic_function_myfunc3(myfunc3_test1);
+			break;
+		case 2:
+			assign_dynamic_function_myfunc3(myfunc3_test2);
+			break;
+		}
+		break;
+	case 4:
+		switch(val) {
+		case 0:
+			assign_dynamic_function_myfunc4(myfunc4_default);
+			break;
+		case 1:
+			assign_dynamic_function_myfunc4(myfunc4_test1);
+			break;
+		case 2:
+			assign_dynamic_function_myfunc4(myfunc4_test2);
+			break;
+		}
+		break;
+	}
+	return cnt;
+}
+
+static ssize_t
+jump_func_read(struct file *filp, char __user *ubuf,
+	       size_t count, loff_t *ppos)
+{
+	long type = (long)filp->private_data;
+	int a = 1;
+	long b = 2;
+	void *c = (void *)0xdeadbeef;
+	char *d = "random string";
+	long ret;
+
+	switch (type) {
+	case 0:
+		ret = dynfunc_myfunc0();
+		printk("ret=%ld\n", ret);
+		break;
+	case 1:
+		ret = dynfunc_myfunc1(a);
+		printk("ret=%ld\n", ret);
+		break;
+	case 2:
+		ret = dynfunc_myfunc2(a, b);
+		printk("ret=%ld\n", ret);
+		break;
+	case 3:
+		ret = dynfunc_myfunc3(a, b, c);
+		printk("ret=%ld\n", ret);
+		break;
+	case 4:
+		ret = dynfunc_myfunc4(a, b, c, d);
+		printk("ret=%ld\n", ret);
+		break;
+	}
+
+	*ppos += count;
+	return 0;
+}
+
+static const struct file_operations jump_func_ops = {
+	.open			= open_generic,
+	.write			= jump_func_write,
+	.read			= jump_func_read,
+};
+
+
+static __init int setup_test(void)
+{
+	struct dentry *top = debugfs_create_dir("jump_funcs", NULL);
+
+	if (!top)
+		return -ENOMEM;
+
+	debugfs_create_file("func0", 0666, top, (void *)0,
+			    &jump_func_ops);
+
+	debugfs_create_file("func1", 0666, top, (void *)1,
+			    &jump_func_ops);
+
+	debugfs_create_file("func2", 0666, top, (void *)2,
+			    &jump_func_ops);
+
+	debugfs_create_file("func3", 0666, top, (void *)3,
+			    &jump_func_ops);
+
+	debugfs_create_file("func4", 0666, top, (void *)4,
+			    &jump_func_ops);
+
+	return 0;
+}
+__initcall(setup_test);
-- 
2.19.0


