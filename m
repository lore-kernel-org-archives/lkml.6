Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D374C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6AD218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jIAUlBDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfAaTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:30:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfAaT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1930820pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9KbKFFE54asd6DE1G7u1hpP4nMD/Qk9TbntwHNFrl4=;
        b=jIAUlBDCeS298oL4oPUvkaqAouh42vXwjztsZWVh80C0I+p6jSMxQMBcqKSGShN/nQ
         ON6PeZBEONBFf8sV4Zg3v5lsoPm+VQBpTo4lGh6idqU0zyVRR39pFYIoTbjpLN1KUuPp
         2QTsmzkzrrvc+ldargc8IBGgwyF/TyYy0oWwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9KbKFFE54asd6DE1G7u1hpP4nMD/Qk9TbntwHNFrl4=;
        b=sQDgSyhA7mwbbeynoTtD21jtZUhp9lcqvyQm3QuzzlTFVJasJr0fpS4pFPtzw/4VXQ
         1VJYOzO2TNn59bYKmU6MQCsSCoqrNC51ljhLphVu9ua1hilD5TAC+bc8Sr+tnU87LzmA
         53vOd9ZXRHVi1n6S7haDsvaex0UjCgFC5K2P34/e1nc9Yiv6iGUJWaTbavhCo0r52BQj
         jdgpNy9j2z5rRs/f/qx1FZK9RZKfTqdHOGpJCbEed3ktR3+RXA21sxJoFXMRc7v3/dSJ
         FAz6w1hTINt7yPL1sN7TewpufyRwKZra+03/JQxCTb7YjQiICJEzlzZxpoanI35Ij3F6
         nW8Q==
X-Gm-Message-State: AJcUukdAnD3uW59/PjxTzmr6VMR9eKRulWMJ5S7BG6lQ8Y6qggmMH3sb
        HhdquCiHIZ1fvUPQXKm6Gx0lTA==
X-Google-Smtp-Source: ALg8bN6w5fA6ZKAxoZNtas49tJOQyUPprp48C/BHkh6QxaJRO1GK2BcCMQ8PJ4c0LV8ZS9kGo0tb3A==
X-Received: by 2002:a63:101:: with SMTP id 1mr32667438pgb.152.1548962932039;
        Thu, 31 Jan 2019 11:28:52 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:51 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Garnier <thgarnie@google.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jan Beulich <JBeulich@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: [PATCH v6 15/27] compiler: Option to default to hidden symbols
Date:   Thu, 31 Jan 2019 11:24:22 -0800
Message-Id: <20190131192533.34130-16-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to default visibility to hidden except for key
symbols. This option is disabled by default and will be used by x86_64
PIE support to remove errors between compilation units.

The default visibility is also enabled for external symbols that are
compared as they maybe equals (start/end of sections). In this case,
older versions of GCC will remove the comparison if the symbols are
hidden. This issue exists at least on gcc 4.9 and before.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/boot/boot.h                 |  2 +-
 arch/x86/include/asm/setup.h         |  2 +-
 arch/x86/kernel/cpu/microcode/core.c |  4 ++--
 drivers/base/firmware_loader/main.c  |  4 ++--
 include/asm-generic/sections.h       |  6 ++++++
 include/linux/compiler.h             |  7 +++++++
 init/Kconfig                         |  7 +++++++
 kernel/kallsyms.c                    | 16 ++++++++--------
 kernel/trace/trace.h                 |  4 ++--
 lib/dynamic_debug.c                  |  4 ++--
 10 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 32a09eb5c101..c4afcfecc817 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -193,7 +193,7 @@ static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 }
 
 /* Heap -- available for dynamic lists. */
-extern char _end[];
+extern char _end[] __default_visibility;
 extern char *HEAP;
 extern char *heap_end;
 #define RESET_HEAP() ((void *)( HEAP = _end ))
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ed8ec011a9fd..74f0a8d87986 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -71,7 +71,7 @@ static inline void x86_ce4100_early_setup(void) { }
  * This is set up by the setup-routine at boot-time
  */
 extern struct boot_params boot_params;
-extern char _text[];
+extern char _text[] __default_visibility;
 
 static inline bool kaslr_enabled(void)
 {
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 97f9ada9ceda..04ca89e65f79 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -149,8 +149,8 @@ static bool __init check_loader_disabled_bsp(void)
 	return *res;
 }
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+extern struct builtin_fw __start_builtin_fw[] __default_visibility;
+extern struct builtin_fw __end_builtin_fw[] __default_visibility;
 
 bool get_builtin_firmware(struct cpio_data *cd, const char *name)
 {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 8e9213b36e31..f04096161a52 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -94,8 +94,8 @@ static struct firmware_cache fw_cache;
 
 #ifdef CONFIG_FW_LOADER
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+extern struct builtin_fw __start_builtin_fw[] __default_visibility;
+extern struct builtin_fw __end_builtin_fw[] __default_visibility;
 
 static void fw_copy_to_prealloc_buf(struct firmware *fw,
 				    void *buf, size_t size)
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d79abca81a52..94f072f3a48d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -32,6 +32,9 @@
  *	__softirqentry_text_start, __softirqentry_text_end
  *	__start_opd, __end_opd
  */
+#ifdef CONFIG_DEFAULT_HIDDEN_SYMS
+#pragma GCC visibility push(default)
+#endif
 extern char _text[], _stext[], _etext[];
 extern char _data[], _sdata[], _edata[];
 extern char __bss_start[], __bss_stop[];
@@ -49,6 +52,9 @@ extern char __start_once[], __end_once[];
 
 /* Start and end of .ctors section - used for constructor calls. */
 extern char __ctors_start[], __ctors_end[];
+#ifdef CONFIG_DEFAULT_HIDDEN_SYMS
+#pragma GCC visibility pop
+#endif
 
 /* Start and end of .opd section - used for function descriptors. */
 extern char __start_opd[], __end_opd[];
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 87692fdae97a..5c0723604a52 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -287,6 +287,13 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
+#ifdef CONFIG_DEFAULT_HIDDEN_SYMS
+#pragma GCC visibility push(hidden)
+#define __default_visibility  __attribute__((visibility ("default")))
+#else
+#define __default_visibility
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
diff --git a/init/Kconfig b/init/Kconfig
index bb383615823a..116e0de4817f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1848,6 +1848,13 @@ config CMDLINE_OVERRIDE
 
 endif
 
+#
+# Default to hidden visibility for all symbols.
+# Useful for Position Independent Code to reduce global references.
+#
+config DEFAULT_HIDDEN_SYMS
+	bool
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 14934afa9e68..547affc40b68 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -29,24 +29,24 @@
  * These will be re-linked against their real values
  * during the second link stage.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[] __weak __default_visibility;
+extern const int kallsyms_offsets[] __weak __default_visibility;
+extern const u8 kallsyms_names[] __weak __default_visibility;
 
 /*
  * Tell the compiler that the count isn't in the small data section if the arch
  * has one (eg: FRV).
  */
 extern const unsigned int kallsyms_num_syms
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".rodata"))) __default_visibility;
 
 extern const unsigned long kallsyms_relative_base
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".rodata"))) __default_visibility;
 
-extern const u8 kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const u8 kallsyms_token_table[] __weak __default_visibility;
+extern const u16 kallsyms_token_index[] __weak __default_visibility;
 
-extern const unsigned int kallsyms_markers[] __weak;
+extern const unsigned int kallsyms_markers[] __weak __default_visibility;
 
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..5246977a2db7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1809,8 +1809,8 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
 				      int enable, int soft_disable);
 extern int tracing_alloc_snapshot(void);
 
-extern const char *__start___trace_bprintk_fmt[];
-extern const char *__stop___trace_bprintk_fmt[];
+extern const char *__start___trace_bprintk_fmt[] __default_visibility;
+extern const char *__stop___trace_bprintk_fmt[] __default_visibility;
 
 extern const char *__start___tracepoint_str[];
 extern const char *__stop___tracepoint_str[];
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dbf2b457e47e..05482e65ae7d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,8 +37,8 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
-extern struct _ddebug __start___verbose[];
-extern struct _ddebug __stop___verbose[];
+extern struct _ddebug __start___verbose[] __default_visibility;
+extern struct _ddebug __stop___verbose[] __default_visibility;
 
 struct ddebug_table {
 	struct list_head link;
-- 
2.20.1.495.gaa96b0ce6b-goog

