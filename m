Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeBSBRv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:17:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752040AbeBSBRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:17:49 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 3/3] extable: Make init_kernel_text() global
Date: Sun, 18 Feb 2018 19:17:21 -0600
Message-Id: <3a495f6dae559f4895198639f7bd3cc553cb31f1.1519002843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1519002843.git.jpoimboe@redhat.com>
References: <cover.1519002843.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert init_kernel_text() to a global function and use it in a few
places instead of manually comparing _sinittext and _einittext.

Note that kallsyms.h has a very similar function called
is_kernel_inittext(), but its end check is inclusive.  I'm not sure
whether that's intentional behavior, so I didn't touch it.

Suggested-by: Jason Baron <jbaron@akamai.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 3 +--
 include/linux/kernel.h       | 1 +
 kernel/extable.c             | 2 +-
 kernel/jump_label.c          | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 1f9188f5357c..feb28fee6cea 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -5,7 +5,6 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
-#include <asm/sections.h>
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
@@ -148,7 +147,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	}
 
 	/* vmlinux .init slow lookup: */
-	if (ip >= (unsigned long)_sinittext && ip < (unsigned long)_einittext)
+	if (init_kernel_text(ip))
 		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
 				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..3fd291503576 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -472,6 +472,7 @@ extern bool parse_option_str(const char *str, const char *option);
 extern char *next_arg(char *args, char **param, char **val);
 
 extern int core_kernel_text(unsigned long addr);
+extern int init_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
diff --git a/kernel/extable.c b/kernel/extable.c
index a17fdb63dc3e..6a5b61ebc66c 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -64,7 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 	return e;
 }
 
-static inline int init_kernel_text(unsigned long addr)
+int init_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext &&
 	    addr < (unsigned long)_einittext)
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 250e7e6540cc..6c6abb71dea3 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,7 +16,6 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
-#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -645,8 +644,7 @@ void __init jump_label_invalidate_init(void)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (iter->code >= (unsigned long)_sinittext &&
-		    iter->code < (unsigned long)_einittext)
+		if (init_kernel_text(iter->code))
 			iter->code = 0;
 	}
 }
-- 
2.14.3
