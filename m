Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D38C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B22A2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgpSJneX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B22A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeGDIlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:41:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34112 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933594AbeGDIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:38:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id d3-v6so3477576edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p91lF12qdUvsqqUYIEbuayY71r/VOTp9g79ZDtfXMw4=;
        b=kgpSJneXTy3GRlY2BU7xjQ+bRlydSilw80tXvVnEVaWwXQI+TFsnpzI0JyI9LBD98Q
         rEe3fOpCQYrHoDDfnTTwLOsvJB+d5nPG7lPNq1tpVD10Ef1cKgEVU2W9i5hCEpwSqoVB
         64fmJQGBVdEfTVY8Fnpgs1HzzqFjctVDmUD3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p91lF12qdUvsqqUYIEbuayY71r/VOTp9g79ZDtfXMw4=;
        b=V5pBjITg5x3CH0l4XGej9azb3lm0IYi9ssLYPbN5z90gVacEypdY2hwt2bO84wNCSC
         zVfG3kfmpC/15heqznExPw4Tv0PIFydarq4sivMAluOqRYA5hvW0iMoH4sbaS9lTUWW9
         Uuu5MdAyYuyCORDY1SxY0PP01GtqPyB8SDZndDsOL0kMsapL7Sbng03UOj/uK3VOjtwu
         dfWLWj9QmhoWpGOnJhayeNjJJD0rMeSNONDA+5xSbV6Z5PsjpaTvjPjHuzYh2XAD/t6a
         tfNp0RTQvBkwIbO8czg9Ll282RB+VTUMf18jap6QFX35gq+9taRh6GpvOETn+ft02QQz
         jTqg==
X-Gm-Message-State: APt69E1dS+YrgX09dHd1NG2BBSHCgwpnhVxo+DU84pOnhH7ZUAq9HIjB
        qIvUgohZJ1ToIoApjydxmRJmQFrYcSY=
X-Google-Smtp-Source: AAOMgpduul+1FenusY9vghRHvunQiKuFX/pLUFdKnHI1uUKwWBDRUB4amdIh/96zNKgr58Hk8NT9jw==
X-Received: by 2002:a50:f4d2:: with SMTP id v18-v6mr1758005edm.162.1530693532907;
        Wed, 04 Jul 2018 01:38:52 -0700 (PDT)
Received: from ards-mac-mini.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1821740edj.55.2018.07.04.01.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:38:52 -0700 (PDT)
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
Subject: [PATCH v10 4/6] init: allow initcall tables to be emitted using relative references
Date:   Wed,  4 Jul 2018 10:36:49 +0200
Message-Id: <20180704083651.24360-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Acked-by: James Morris <james.morris@microsoft.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Ingo Molnar <mingo@kernel.org>
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
2.17.1

