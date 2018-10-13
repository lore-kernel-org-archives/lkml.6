Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C78C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953BB2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MC64G/94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953BB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJNCtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 22:49:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:57920 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeJNCtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 22:49:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3C9E71A8764;
        Sat, 13 Oct 2018 15:11:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id wr-I9Eog8i12; Sat, 13 Oct 2018 15:11:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 82C071A8761;
        Sat, 13 Oct 2018 15:11:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 82C071A8761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539457863;
        bh=bZUIu67iIW4tgrLX8WuuK0zDJaXnb8YHfZIV/ojcrKE=;
        h=From:To:Date:Message-Id;
        b=MC64G/94VKwjlTnN1tMA3cJOONNHmUSM/vVrgJEVbGBHNWbhqF0S9KAolkwtovEEG
         aEq4HvkJAaqaVHpEIihlHpchLJvowY8G95zDqtIWSPuSwD2X73ZJreJyiMSIUeuKiZ
         B6X78Udc89jJmts0ip/qDbkKZGH1HaqwXrTuKXIJMF8k1rE29TXpHzWFmwXoiuiFBu
         YRIWnl3W7rGs6FMB1IzYHeOGhRti2Z8yRnB+1/aYXDKlSbe0NwnTDN/2ZxckmW79t+
         wR/D7/emTB9VFs0bOBUC1SVBxDH7Wqxf/hosWdJjKM5z45vxETI/lMxbNLDYQhQEtj
         TlAVwA4G4gjvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LurGCVSyzjZy; Sat, 13 Oct 2018 15:11:03 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 074B81A875B;
        Sat, 13 Oct 2018 15:11:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <james.morris@microsoft.com>,
        James Morris <jmorris@namei.org>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nico@linaro.org>,
        Paul Mackerras <paulus@samba.org>,
        Petr Mladek <pmladek@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH for 4.19] tracepoint: Fix: tracepoint array element size mismatch
Date:   Sat, 13 Oct 2018 15:10:50 -0400
Message-Id: <20181013191050.22389-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 46e0c9be206f ("kernel: tracepoints: add support for relative
references") changes the layout of the __tracepoint_ptrs section on
architectures supporting relative references. However, it does so
without turning struct tracepoint * const into const int elsewhere in
the tracepoint code, which has the following side-effect:

Setting mod->num_tracepoints is done in by module.c:

    mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
                                         sizeof(*mod->tracepoints_ptrs),
                                         &mod->num_tracepoints);

Basically, since sizeof(*mod->tracepoints_ptrs) is a pointer size
(rather than sizeof(int)), num_tracepoints is erroneously set to half the
size it should be on 64-bit arch. So a module with an odd number of
tracepoints misses the last tracepoint due to effect of integer
division.

So in the module going notifier:

        for_each_tracepoint_range(mod->tracepoints_ptrs,
                mod->tracepoints_ptrs + mod->num_tracepoints,
                tp_module_going_check_quiescent, NULL);

the expression (mod->tracepoints_ptrs + mod->num_tracepoints) actually
evaluates to something within the bounds of the array, but miss the
last tracepoint if the number of tracepoints is odd on 64-bit arch.

Fix this by introducing a new typedef: tracepoint_ptr_t, which
is either "const int" on architectures that have PREL32 relocations,
or "struct tracepoint * const" on architectures that does not have
this feature.

Also provide a new tracepoint_ptr_defer() static inline to
encapsulate deferencing this type rather than duplicate code and
ugly idefs within the for_each_tracepoint_range() implementation.

This issue appears in 4.19-rc kernels, and should ideally be fixed
before the end of the rc cycle.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Link: http://lkml.kernel.org/r/20180704083651.24360-7-ard.biesheuvel@linaro.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morris <james.morris@microsoft.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h          |  3 ++-
 include/linux/tracepoint-defs.h |  6 ++++++
 include/linux/tracepoint.h      | 36 +++++++++++++++++++++------------
 kernel/tracepoint.c             | 24 ++++++++--------------
 4 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..e19ae08c7fb8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/rbtree_latch.h>
 #include <linux/error-injection.h>
+#include <linux/tracepoint-defs.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -430,7 +431,7 @@ struct module {
 
 #ifdef CONFIG_TRACEPOINTS
 	unsigned int num_tracepoints;
-	struct tracepoint * const *tracepoints_ptrs;
+	tracepoint_ptr_t *tracepoints_ptrs;
 #endif
 #ifdef HAVE_JUMP_LABEL
 	struct jump_entry *jump_entries;
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 22c5a46e9693..49ba9cde7e4b 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -35,6 +35,12 @@ struct tracepoint {
 	struct tracepoint_func __rcu *funcs;
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+typedef const int tracepoint_ptr_t;
+#else
+typedef struct tracepoint * const tracepoint_ptr_t;
+#endif
+
 struct bpf_raw_event_map {
 	struct tracepoint	*tp;
 	void			*bpf_func;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 041f7e56a289..538ba1a58f5b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -99,6 +99,29 @@ extern void syscall_unregfunc(void);
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
+{
+	return offset_to_ptr(p);
+}
+
+#define __TRACEPOINT_ENTRY(name)					\
+	asm("	.section \"__tracepoints_ptrs\", \"a\"		\n"	\
+	    "	.balign 4					\n"	\
+	    "	.long 	__tracepoint_" #name " - .		\n"	\
+	    "	.previous					\n")
+#else
+static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
+{
+	return *p;
+}
+
+#define __TRACEPOINT_ENTRY(name)					 \
+	static tracepoint_ptr_t __tracepoint_ptr_##name __used		 \
+	__attribute__((section("__tracepoints_ptrs"))) =		 \
+		&__tracepoint_##name
+#endif
+
 #endif /* _LINUX_TRACEPOINT_H */
 
 /*
@@ -253,19 +276,6 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define __TRACEPOINT_ENTRY(name)					\
-	asm("	.section \"__tracepoints_ptrs\", \"a\"		\n"	\
-	    "	.balign 4					\n"	\
-	    "	.long 	__tracepoint_" #name " - .		\n"	\
-	    "	.previous					\n")
-#else
-#define __TRACEPOINT_ENTRY(name)					 \
-	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name
-#endif
-
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index bf2c06ef9afc..a3be42304485 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -28,8 +28,8 @@
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
 
-extern struct tracepoint * const __start___tracepoints_ptrs[];
-extern struct tracepoint * const __stop___tracepoints_ptrs[];
+extern tracepoint_ptr_t __start___tracepoints_ptrs[];
+extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
 DEFINE_SRCU(tracepoint_srcu);
 EXPORT_SYMBOL_GPL(tracepoint_srcu);
@@ -371,25 +371,17 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
+static void for_each_tracepoint_range(
+		tracepoint_ptr_t *begin, tracepoint_ptr_t *end,
 		void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv)
 {
+	tracepoint_ptr_t *iter;
+
 	if (!begin)
 		return;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)) {
-		const int *iter;
-
-		for (iter = (const int *)begin; iter < (const int *)end; iter++)
-			fct(offset_to_ptr(iter), priv);
-	} else {
-		struct tracepoint * const *iter;
-
-		for (iter = begin; iter < end; iter++)
-			fct(*iter, priv);
-	}
+	for (iter = begin; iter < end; iter++)
+		fct(tracepoint_ptr_deref(iter), priv);
 }
 
 #ifdef CONFIG_MODULES
-- 
2.17.1

