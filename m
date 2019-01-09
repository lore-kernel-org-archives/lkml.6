Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0768A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAIXAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfAIW75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:59:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA61D73A71;
        Wed,  9 Jan 2019 22:59:56 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139DB1001F57;
        Wed,  9 Jan 2019 22:59:53 +0000 (UTC)
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
Subject: [PATCH v3 2/6] static_call: Add basic static call infrastructure
Date:   Wed,  9 Jan 2019 16:59:37 -0600
Message-Id: <a01f733889ebf4bc447507ab8041a60378eaa89f.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 22:59:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static calls are a replacement for global function pointers.  They use
code patching to allow direct calls to be used instead of indirect
calls.  They give the flexibility of function pointers, but with
improved performance.  This is especially important for cases where
retpolines would otherwise be used, as retpolines can significantly
impact performance.

The concept and code are an extension of previous work done by Ard
Biesheuvel and Steven Rostedt:

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
  https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

There are two implementations, depending on arch support:

1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
2) basic function pointers

For more details, see the comments in include/linux/static_call.h.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                      |   3 +
 include/linux/static_call.h       | 135 ++++++++++++++++++++++++++++++
 include/linux/static_call_types.h |  13 +++
 3 files changed, 151 insertions(+)
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..7e469a693da3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -885,6 +885,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config HAVE_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
new file mode 100644
index 000000000000..9e85c479cd11
--- /dev/null
+++ b/include/linux/static_call.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STATIC_CALL_H
+#define _LINUX_STATIC_CALL_H
+
+/*
+ * Static call support
+ *
+ * Static calls use code patching to hard-code function pointers into direct
+ * branch instructions.  They give the flexibility of function pointers, but
+ * with improved performance.  This is especially important for cases where
+ * retpolines would otherwise be used, as retpolines can significantly impact
+ * performance.
+ *
+ *
+ * API overview:
+ *
+ *   DECLARE_STATIC_CALL(key, func);
+ *   DEFINE_STATIC_CALL(key, func);
+ *   static_call(key, args...);
+ *   static_call_update(key, func);
+ *
+ *
+ * Usage example:
+ *
+ *   # Start with the following functions (with identical prototypes):
+ *   int func_a(int arg1, int arg2);
+ *   int func_b(int arg1, int arg2);
+ *
+ *   # Define a 'my_key' reference, associated with func_a() by default
+ *   DEFINE_STATIC_CALL(my_key, func_a);
+ *
+ *   # Call func_a()
+ *   static_call(my_key, arg1, arg2);
+ *
+ *   # Update 'my_key' to point to func_b()
+ *   static_call_update(my_key, func_b);
+ *
+ *   # Call func_b()
+ *   static_call(my_key, arg1, arg2);
+ *
+ *
+ * Implementation details:
+ *
+ *    This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
+ *    Otherwise basic indirect calls are used (with function pointers).
+ *
+ *    Each static_call() site calls into a trampoline associated with the key.
+ *    The trampoline has a direct branch to the default function.  Updates to a
+ *    key will modify the trampoline's branch destination.
+ */
+
+#include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/static_call_types.h>
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+#include <asm/static_call.h>
+extern void arch_static_call_transform(void *site, void *tramp, void *func);
+#endif
+
+
+#define DECLARE_STATIC_CALL(key, func)					\
+	extern struct static_call_key key;				\
+	extern typeof(func) STATIC_CALL_TRAMP(key)
+
+
+#if defined(CONFIG_HAVE_STATIC_CALL)
+
+struct static_call_key {
+	void *func, *tramp;
+};
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+		.tramp = STATIC_CALL_TRAMP(key),			\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(key, _func)
+
+#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
+
+static inline void __static_call_update(struct static_call_key *key, void *func)
+{
+	cpus_read_lock();
+	WRITE_ONCE(key->func, func);
+	arch_static_call_transform(NULL, key->tramp, func);
+	cpus_read_unlock();
+}
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key)						\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
+
+#define EXPORT_STATIC_CALL_GPL(key)					\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
+
+
+#else /* Generic implementation */
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+	}
+
+#define static_call(key, args...)					\
+	((typeof(STATIC_CALL_TRAMP(key))*)(key.func))(args)
+
+static inline void __static_call_update(struct static_call_key *key, void *func)
+{
+	WRITE_ONCE(key->func, func);
+}
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key) EXPORT_SYMBOL(key)
+#define EXPORT_STATIC_CALL_GPL(key) EXPORT_SYMBOL_GPL(key)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
new file mode 100644
index 000000000000..0baaf3f02476
--- /dev/null
+++ b/include/linux/static_call_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
+#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
+
+#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
+#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
+
+#endif /* _STATIC_CALL_TYPES_H */
-- 
2.17.2

