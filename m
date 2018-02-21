Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeBUKuH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:50:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBUKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:50:05 -0500
Date: Wed, 21 Feb 2018 02:49:28 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-d414f443c2baf24e104d903ae4bc07d0c401c6d0@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, jpoimboe@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, jbaron@akamai.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de
Reply-To: hpa@zytor.com, jpoimboe@redhat.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        jbaron@akamai.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        bp@suse.de
In-Reply-To: <4335d02be8d45ca7d265d2f174251d0b7ee6c5fd.1519051220.git.jpoimboe@redhat.com>
References: <4335d02be8d45ca7d265d2f174251d0b7ee6c5fd.1519051220.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] extable: Make init_kernel_text() global
Git-Commit-ID: d414f443c2baf24e104d903ae4bc07d0c401c6d0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d414f443c2baf24e104d903ae4bc07d0c401c6d0
Gitweb:     https://git.kernel.org/tip/d414f443c2baf24e104d903ae4bc07d0c401c6d0
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 20 Feb 2018 11:37:53 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:11:39 +0100

extable: Make init_kernel_text() global

Convert init_kernel_text() to a global function and use it in a few
places instead of manually comparing _sinittext and _einittext.

Note that kallsyms.h has a very similar function called
is_kernel_inittext(), but its end check is inclusive.  I'm not sure
whether that's intentional behavior, so I didn't touch it.

Suggested-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/4335d02be8d45ca7d265d2f174251d0b7ee6c5fd.1519051220.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 3 +--
 include/linux/kernel.h       | 1 +
 kernel/extable.c             | 2 +-
 kernel/jump_label.c          | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 1f9188f..feb28fe 100644
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
index ce51455..3fd2915 100644
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
index a17fdb6..6a5b61e 100644
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
index b2f0b47..52a0a7a 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,7 +16,6 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
-#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -429,8 +428,7 @@ void __init jump_label_invalidate_init(void)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (iter->code >= (unsigned long)_sinittext &&
-		    iter->code < (unsigned long)_einittext)
+		if (init_kernel_text(iter->code))
 			iter->code = 0;
 	}
 }
