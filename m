Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E098C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A242083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="egozONIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A242083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGDIlK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:41:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36457 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933741AbeGDIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:38:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so3468270eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sNQ200Dbn8i5rABOHA2COrJbJeN/1Dd7TOxo9J6iksY=;
        b=egozONIvLTNRF14bkHiz1LxWn3ZE/RmJ9/KQP6mYSoT+Ck+jy5MGj1XCYoSQL34Yuz
         rD+btanjtPcwVK+bbMJRJvZpW1gFOruSWbwSuvLqcF8PnQ5dpsyYhO5mGNA7NSxuVjk6
         iZXERhQaBbe3acJH1sm1UlXrI4aOg9dEpF7DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sNQ200Dbn8i5rABOHA2COrJbJeN/1Dd7TOxo9J6iksY=;
        b=kCME4ClF5x+IdUylL6BhOnQCmKWiDOqp90ruwWIfEozEpDw5eGwt0/W9FHFyCyqym2
         3jepYPZsbb5k8qLJp7S8nXhyO7TqZmnwNUtRCNbMX2g+Ak3mK0qbd+W5fe+s3q3wHXlH
         ZckZpe8y75iL4jSj97SqpSQ9ewzCX3nCWDo76sLGk+gFhrRmM5MPMxbGqNAtyhUh0+Jn
         sBOV76jS05CAsKutCu/HILSSmewVM4MmJXUYoF7yZdpEq8ym1D3gYW521PLPh2qt2c8t
         zDFbg/ylE7+WFOWdGcW6tG8myoEKXK7yyh9U+pUHCqGkD/zT1lPPuvuhZIB09ceOOmmp
         7Kxg==
X-Gm-Message-State: APt69E0u9xP2qPg0P6Ts0zgkZOoQ2fykLem2ZevYoICKkyOqxXwan9Wk
        9QtQMbYJADMTL7Dm/35dks8+19tHD8U=
X-Google-Smtp-Source: AAOMgpfxM4J/6kHyeRaZRp75XdGuzsV36E6Sp3TNDoC7mTeOGvKwNwEnWLxMEDxxj8+XqxQdSr0msQ==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr1734704edj.62.1530693535996;
        Wed, 04 Jul 2018 01:38:55 -0700 (PDT)
Received: from ards-mac-mini.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1821740edj.55.2018.07.04.01.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:38:55 -0700 (PDT)
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
Subject: [PATCH v10 6/6] kernel: tracepoints: add support for relative references
Date:   Wed,  4 Jul 2018 10:36:51 +0200
Message-Id: <20180704083651.24360-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the need for relocating absolute references to tracepoint
structures at boot time when running relocatable kernels (which may
take a disproportionate amount of space), add the option to emit
these tables as relative references instead.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/tracepoint.h | 19 ++++++--
 kernel/tracepoint.c        | 49 +++++++++++---------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 19a690b559ca..b130e40d82cb 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -225,6 +225,19 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __TRACEPOINT_ENTRY(name)					\
+	asm("	.section \"__tracepoints_ptrs\", \"a\"		\n"	\
+	    "	.balign 4					\n"	\
+	    "	.long 	__tracepoint_" #name " - .		\n"	\
+	    "	.previous					\n")
+#else
+#define __TRACEPOINT_ENTRY(name)					 \
+	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
+	__attribute__((section("__tracepoints_ptrs"))) =		 \
+		&__tracepoint_##name
+#endif
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
@@ -234,11 +247,9 @@ extern void syscall_unregfunc(void);
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"))) =			 \
+	__attribute__((section("__tracepoints"), used)) =		 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name;
+	__TRACEPOINT_ENTRY(name);
 
 #define DEFINE_TRACE(name)						\
 	DEFINE_TRACE_FN(name, NULL, NULL);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6dc6356c3327..451c8f5e8345 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -325,6 +325,27 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
 
+static void for_each_tracepoint_range(struct tracepoint * const *begin,
+		struct tracepoint * const *end,
+		void (*fct)(struct tracepoint *tp, void *priv),
+		void *priv)
+{
+	if (!begin)
+		return;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)) {
+		const int *iter;
+
+		for (iter = (const int *)begin; iter < (const int *)end; iter++)
+			fct(offset_to_ptr(iter), priv);
+	} else {
+		struct tracepoint * const *iter;
+
+		for (iter = begin; iter < end; iter++)
+			fct(*iter, priv);
+	}
+}
+
 #ifdef CONFIG_MODULES
 bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -389,15 +410,9 @@ EXPORT_SYMBOL_GPL(unregister_tracepoint_module_notifier);
  * Ensure the tracer unregistered the module's probes before the module
  * teardown is performed. Prevents leaks of probe and data pointers.
  */
-static void tp_module_going_check_quiescent(struct tracepoint * const *begin,
-		struct tracepoint * const *end)
+static void tp_module_going_check_quiescent(struct tracepoint *tp, void *priv)
 {
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		WARN_ON_ONCE((*iter)->funcs);
+	WARN_ON_ONCE(tp->funcs);
 }
 
 static int tracepoint_module_coming(struct module *mod)
@@ -448,8 +463,9 @@ static void tracepoint_module_going(struct module *mod)
 			 * Called the going notifier before checking for
 			 * quiescence.
 			 */
-			tp_module_going_check_quiescent(mod->tracepoints_ptrs,
-				mod->tracepoints_ptrs + mod->num_tracepoints);
+			for_each_tracepoint_range(mod->tracepoints_ptrs,
+				mod->tracepoints_ptrs + mod->num_tracepoints,
+				tp_module_going_check_quiescent, NULL);
 			break;
 		}
 	}
@@ -501,19 +517,6 @@ static __init int init_tracepoints(void)
 __initcall(init_tracepoints);
 #endif /* CONFIG_MODULES */
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
-		void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv)
-{
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		fct(*iter, priv);
-}
-
 /**
  * for_each_kernel_tracepoint - iteration on all kernel tracepoints
  * @fct: callback
-- 
2.17.1

