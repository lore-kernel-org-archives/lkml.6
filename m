Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB92FC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E7420835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ntlWzSce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJMDjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:39:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:37832 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:39:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 331501B7462;
        Fri, 12 Oct 2018 16:05:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id aXYxaqWbj82k; Fri, 12 Oct 2018 16:05:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 48F901B745F;
        Fri, 12 Oct 2018 16:05:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 48F901B745F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539374727;
        bh=BUy6aEpZFCnFPPJee/L7zXeKr/QtWs4AoTmH6FKVXnU=;
        h=From:To:Date:Message-Id;
        b=ntlWzSceS5dTl7HT+gBRA4AmABM2NtUYmova6fsrzaozTmwwKxJkjeKcHrtHktZPZ
         c/4xuIi9wPx6T0ZtlwSaPClkV3/mciZ4Nokj2W1hbR1slzITcOTec7xX+c0+fAv1Zb
         XtpVBTHsIAdf5VMIeiKmHCR9Md5gC34lt1HgKvGQ9r+OEwMn42byKk0DuCYqv7NFwY
         AGhMm94rae55iG6WQ2G87Upf9JGax4TxWDJm7iFJ/j6vU+6YnU04ImYAfUFl0N5UPH
         91nMav0Ce80BtOr78VMKqc8H+FD8FLJUWgpiR3kpTjelA0H8Ie2usL8tatlhWcSG6N
         iifhkAAKlLjtA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id B1sG69jGBHdD; Fri, 12 Oct 2018 16:05:27 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id D10661B7455;
        Fri, 12 Oct 2018 16:05:26 -0400 (EDT)
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
Subject: [PATCH for 4.19] tracepoint: Fix: out-of-bound tracepoint array iteration
Date:   Fri, 12 Oct 2018 16:05:23 -0400
Message-Id: <20181012200523.23731-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 46e0c9be206f ("kernel: tracepoints: add support for relative
references") changes the layout of the __tracepoint_ptrs section on
architectures supporting relative references. However, it does so
without turning struct tracepoint * const into const int * elsewhere in
the tracepoint code, which has the following side-effect:

tracepoint_module_{coming,going} invoke
tp_module_going_check_quiescent() with mod->tracepoints_ptrs
as first argument, and computes the end address of the array
for the second argument with:

  mod->tracepoints_ptrs + mod->num_tracepoints

However, because the type of mod->tracepoint_ptrs in module.h
has not been changed from pointer to int, it passes an end
pointer which is twice larger than the array, causing out-of-bound
array accesses.

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
 include/linux/module.h          |  2 +-
 include/linux/tracepoint-defs.h |  6 ++++++
 include/linux/tracepoint.h      | 36 +++++++++++++++++++++------------
 kernel/tracepoint.c             | 24 ++++++++--------------
 4 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..cdab2451d6be 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -430,7 +430,7 @@ struct module {
 
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

