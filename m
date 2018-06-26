Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819ACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B53625061
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQrVGqib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B53625061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeFZS26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:28:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41103 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeFZS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:28:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so18200320wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6EXfacxtBs2hWqAKIliQJWWXNn3sfRJsVjsG6USvlLk=;
        b=bQrVGqibSpzm0lqYZfOm5M3p2Ku6H+gTjwAeyMNzYNZM2wBegZD3H2nSkXaYFw3GzF
         RALNyXp+ukRiRhRzRiQ7UULLBWgsF352CMLsqolMnKbhtIO8zu0YOG250DacHndwhwof
         Wk4yk38W3fkpJN+GqJixfAxrbDiIKD8xFX9w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6EXfacxtBs2hWqAKIliQJWWXNn3sfRJsVjsG6USvlLk=;
        b=bcyyvdiyJ0S91lCrI6JO2Ta17/UhgChvyLto5On6ZFa/z4fEx2jZ7f0vhqXokXTaQB
         gOmuCbZxDf17hdKzPmloguvHBsZ2AxX/0QfuwstffxtEbfCJM0pdoR3+J+3JJX0bcwvX
         rmfnWXmNBgmCy5xggNDFp+iDuAupsqwFH+JXFjZncvwjgkwe5a5vgopCqG78V9+84x47
         kVOQEVwuuQP7FZ57pdsciEpX2neh4Q5LZRSZXK8dbMG5LRlgEDw2CySG/mHDX/TNfFnm
         faZXJl8oPraJQauai9VwSFwIgi6RMPxAw0R7TBbokOqjRFCY12hIZtkAqxkzedJNJysp
         VxAQ==
X-Gm-Message-State: APt69E3tBACKl/Q3e2SRmL9pDMT6EZ3E03+/qi8NXnLAmt6I4/O89jSJ
        7yVCAtJk0q6Ro2V9f4QyC4AHlXh48eE=
X-Google-Smtp-Source: AAOMgpcdlZwxBjFvJFjaP3l9oX6BkTYWNK80I+m9pAzcGYkx3IBdAjI4Sw64oXKLj7gFw9FOM2CqrA==
X-Received: by 2002:adf:fb43:: with SMTP id c3-v6mr2534500wrs.32.1530037731293;
        Tue, 26 Jun 2018 11:28:51 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:d037:e907:f0a2:a5ea])
        by smtp.gmail.com with ESMTPSA id s17-v6sm1707664wmc.34.2018.06.26.11.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:28:50 -0700 (PDT)
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
Subject: [PATCH v9 6/6] kernel: tracepoints: add support for relative references
Date:   Tue, 26 Jun 2018 20:28:01 +0200
Message-Id: <20180626182802.19932-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the need for relocating absolute references to tracepoint
structures at boot time when running relocatable kernels (which may
take a disproportionate amount of space), add the option to emit
these tables as relative references instead.

Cc: Ingo Molnar <mingo@redhat.com>
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
2.11.0

