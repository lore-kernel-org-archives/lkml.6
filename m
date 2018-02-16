Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162589AbeBPR5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:57:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161522AbeBPR5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:57:46 -0500
Date: Fri, 16 Feb 2018 11:57:44 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jason Baron <jbaron@akamai.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] extable: Make init_kernel_text() global
Message-ID: <20180216175744.2towvw7lja7dpkn7@treble>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
 <cabcf423-2214-f175-a3fc-a9756eabd247@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cabcf423-2214-f175-a3fc-a9756eabd247@akamai.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:55:54AM -0500, Jason Baron wrote:
> > +/* Disable any jump label entries in __init code */
> > +void __init jump_label_invalidate_init(void)
> > +{
> > +	struct jump_entry *iter_start = __start___jump_table;
> > +	struct jump_entry *iter_stop = __stop___jump_table;
> > +	struct jump_entry *iter;
> > +
> > +	for (iter = iter_start; iter < iter_stop; iter++)
> > +		if (iter->code >= (unsigned long)_sinittext &&
> > +		    iter->code < (unsigned long)_einittext)
> > +			iter->code = 0;
> > +}
> 
> Seems like this wants to use init_kernel_text() but i see its marked
> 'static', perhaps it can be moved to a header?

How about this patch on top?

---------

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] extable: Make init_kernel_text() global

Convert init_kernel_text() to a global function and use it in a few
places instead of manually comparing _sinittext and _einittext.

Note that kallsyms.h has a very similar function called
is_kernel_inittext(), but its end check is inclusive.  I'm not sure
whether that's intentional behavior, so I didn't touch it.

Suggested-by: Jason Baron <jbaron@akamai.com>
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
index 08a02ae54997..6cd43460cadc 100644
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
 
 	for (iter = iter_start; iter < iter_stop; iter++)
-		if (iter->code >= (unsigned long)_sinittext &&
-		    iter->code < (unsigned long)_einittext)
+		if (init_kernel_text(iter->code))
 			iter->code = 0;
 }
 
-- 
2.14.3
