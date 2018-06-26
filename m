Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94252C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D0926F03
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK5muTqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0926F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeFZS3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:29:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47067 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeFZS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:28:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id l14-v6so13143353wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e3jnCZ1uFoNVuf5Qep6Bc6KNPlh/C1aJMc4q0hY5MUE=;
        b=LK5muTqU9KKzjP5cU+TC57wGqc+oEWRwIa/cBtdPV5ZGnhL8/xAvrfA/txCA+lbIMl
         z48mNDc5Sq5oiaKoviBG2gsH1ySZhDXd183Ff1qsFJauPtQzxEtCJbEobv2nYIUlWL+w
         d1YddENHiJLOVApc+XEX7k0swJFIVgx/2HjyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e3jnCZ1uFoNVuf5Qep6Bc6KNPlh/C1aJMc4q0hY5MUE=;
        b=NDfyE8sU1AxXf+CC05P8xMU2pZ4GOEitF1lXyQiR8JeEv1craiDMMbjoJtnIrfF/LH
         F0NvOHrkVn9pqRvm49ON0z16XAWIWFSKKgbcs65N0/anWbkPKPLtT9XE6h8tqetDPiFA
         zgspRUMOxaBolOW25kNZgT95rY6Xb8mtw+1RKWwZ6PTG0sC3uverw1AEZ8/kJzyqd9cj
         Cb8lSC9Ghh96lgMlBTEGlVmvqIfpAly1GH3SPoY2u91kZohbdVVkWa+vc5YqJkRO5Umi
         WJ8A1rqxeF15M1VZ2IMB5qXv7g859uESwLkxl7KP3dE81rIu60P6BBMi2J3FZrSzzwMg
         +qgA==
X-Gm-Message-State: APt69E04dNc0CZs/Ofj6jNqTKsv/b7hhnbQc/6s1bibB1ushgHzwL2AO
        MWz/AonDKPeVuVztWoLqwwpFtpKtaJM=
X-Google-Smtp-Source: AAOMgpfqwElJUbJs96p73Db0XS4yKnwD/mCpg/MD+iL8AWoWjrxLnHPEmJob7MCgOJKm0Y6cJYOe7A==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr2481260wrj.109.1530037727883;
        Tue, 26 Jun 2018 11:28:47 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:d037:e907:f0a2:a5ea])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1707664wmc.34.2018.06.26.11.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:28:47 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v9 4/6] init: allow initcall tables to be emitted using relative references
Date:   Tue, 26 Jun 2018 20:27:59 +0200
Message-Id: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/init.h   | 44 +++++++++++++++-----
 init/main.c            | 32 +++++++-------
 kernel/printk/printk.c | 16 +++----
 security/security.c    | 17 ++++----
 4 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index bc27cf03c41e..2538d176dd1f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -116,8 +116,24 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_t __security_initcall_start[], __security_initcall_end[];
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+typedef int initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return offset_to_ptr(entry);
+}
+#else
+typedef initcall_t initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return *entry;
+}
+#endif
+
+extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
+extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -167,9 +183,20 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
-#define __define_initcall(fn, id) \
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)			\
+	__ADDRESSABLE(fn)					\
+	asm(".section	\"" #__sec ".init\", \"a\"	\n"	\
+	"__initcall_" #fn #id ":			\n"	\
+	    ".long	" #fn " - .			\n"	\
+	    ".previous					\n");
+#else
+#define ___define_initcall(fn, id, __sec) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn;
+		__attribute__((__section__(#__sec ".init"))) = fn;
+#endif
+
+#define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
  * Early initcalls run before initializing SMP.
@@ -208,13 +235,8 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.con_initcall.init) = fn
-
-#define security_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.security_initcall.init) = fn
+#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..e59a01f163d6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -901,18 +901,18 @@ int __init_or_module do_one_initcall(initcall_t fn)
 }
 
 
-extern initcall_t __initcall_start[];
-extern initcall_t __initcall0_start[];
-extern initcall_t __initcall1_start[];
-extern initcall_t __initcall2_start[];
-extern initcall_t __initcall3_start[];
-extern initcall_t __initcall4_start[];
-extern initcall_t __initcall5_start[];
-extern initcall_t __initcall6_start[];
-extern initcall_t __initcall7_start[];
-extern initcall_t __initcall_end[];
-
-static initcall_t *initcall_levels[] __initdata = {
+extern initcall_entry_t __initcall_start[];
+extern initcall_entry_t __initcall0_start[];
+extern initcall_entry_t __initcall1_start[];
+extern initcall_entry_t __initcall2_start[];
+extern initcall_entry_t __initcall3_start[];
+extern initcall_entry_t __initcall4_start[];
+extern initcall_entry_t __initcall5_start[];
+extern initcall_entry_t __initcall6_start[];
+extern initcall_entry_t __initcall7_start[];
+extern initcall_entry_t __initcall_end[];
+
+static initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
 	__initcall2_start,
@@ -938,7 +938,7 @@ static char *initcall_level_names[] __initdata = {
 
 static void __init do_initcall_level(int level)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
@@ -949,7 +949,7 @@ static void __init do_initcall_level(int level)
 
 	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -980,11 +980,11 @@ static void __init do_basic_setup(void)
 
 static void __init do_pre_smp_initcalls(void)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..688a27b0888c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2772,7 +2772,8 @@ EXPORT_SYMBOL(unregister_console);
 void __init console_init(void)
 {
 	int ret;
-	initcall_t *call;
+	initcall_t call;
+	initcall_entry_t *ce;
 
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
@@ -2781,13 +2782,14 @@ void __init console_init(void)
 	 * set up the console device so that later boot sequences can
 	 * inform about problems etc..
 	 */
-	call = __con_initcall_start;
+	ce = __con_initcall_start;
 	trace_initcall_level("console");
-	while (call < __con_initcall_end) {
-		trace_initcall_start((*call));
-		ret = (*call)();
-		trace_initcall_finish((*call), ret);
-		call++;
+	while (ce < __con_initcall_end) {
+		call = initcall_from_entry(ce);
+		trace_initcall_start(call);
+		ret = call();
+		trace_initcall_finish(call, ret);
+		ce++;
 	}
 }
 
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..1e7b1486d82a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -48,14 +48,17 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 static void __init do_security_initcalls(void)
 {
 	int ret;
-	initcall_t *call;
-	call = __security_initcall_start;
+	initcall_t call;
+	initcall_entry_t *ce;
+
+	ce = __security_initcall_start;
 	trace_initcall_level("security");
-	while (call < __security_initcall_end) {
-		trace_initcall_start((*call));
-		ret = (*call) ();
-		trace_initcall_finish((*call), ret);
-		call++;
+	while (ce < __security_initcall_end) {
+		call = initcall_from_entry(ce);
+		trace_initcall_start(call);
+		ret = call();
+		trace_initcall_finish(call, ret);
+		ce++;
 	}
 }
 
-- 
2.11.0

