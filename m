Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeCCOrp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 09:47:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44238 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeCCOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 09:47:43 -0500
X-Google-Smtp-Source: AG47ELtXVj9yw+Vb9TG0FnTuv1AHiO+79mpx7T31N7EtfMQu0bsbf2nm/vHRR6i8aRNxwJGHbmcoFg==
Date: Sat, 3 Mar 2018 23:47:39 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20180303144739.GA516@tigerII.localdomain>
References: <20180302160732.12691fbc@canb.auug.org.au>
 <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Tejun

On (03/02/18 16:54), Petr Mladek wrote:
[..]
> > (Though it is not immediately obvious why.)
> 
> It is a mistery to me. The error appears when I move any of
> dump_stack_print_info() or show_regs_print_info() function
> definitions from kernel/printk/printk.c to lib/dump_stack.c.
> All the other changes seems unrelated.
> 
> The thing is that we basically do not touch dump_stack() definition
> by that patch.

Apparently dump_stack_print_info() was in lib/dump_stack.c a long
time ago, but it was deliberately moved to printk.c, when kernel gained
a "generic" (dummy) dump_stack() fallback. Some archs, like blackfin,
define their own dump_stack() symbol and make it global via EXPORT_SYMBOL.

In case of blackfin that arch-specific dump_stack() symbol invokes a
global dump_stack_print_info(). If we move dump_stack_print_info() back
to lib/dump_stack.c then we link both with arch/blackfin/dumpstack.o
and lib/dump_stack.o, which results in multiple definitions error.
If we move dump_stack_print_info() out on libdump_stack.o, then we
never link with lib/dump_stack.o

... so what are we going to do with that.

a) we can drop the patch and cherry pick only the kexec part

b) we can try to mark dummy lib/dump_stack() as __weak
   EXPORT_SYMBOL and remove EXPORT_SYMBOL from arch-specific
   definitions.

   So we will end up with EXPORT_SYMBOL dump_stack() and archs
   may re-define it. If some arch will accidentally mark its
   own dump_stack() as EXPORT_SYMBOL then there should be a
   linkage warning - a symbol is exported twice.


Something like below.

Opinions? Will this work?


========= 8< =========

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] dump_stack: mark dummy dump_stack() as weak

---
 arch/blackfin/kernel/dumpstack.c | 1 -
 arch/nds32/kernel/traps.c        | 2 --
 lib/dump_stack.c                 | 4 ++--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/blackfin/kernel/dumpstack.c b/arch/blackfin/kernel/dumpstack.c
index 3c992c1f8ef2..61af017130cd 100644
--- a/arch/blackfin/kernel/dumpstack.c
+++ b/arch/blackfin/kernel/dumpstack.c
@@ -174,4 +174,3 @@ void dump_stack(void)
 	show_stack(current, &stack);
 	trace_buffer_restore(tflags);
 }
-EXPORT_SYMBOL(dump_stack);
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8828b4aeb72b..455bb0787367 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -166,8 +166,6 @@ void dump_stack(void)
 	__dump(NULL, base_reg);
 }
 
-EXPORT_SYMBOL(dump_stack);
-
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
 	unsigned long *base_reg;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..9cf4465dbffa 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -85,7 +85,7 @@ static void __dump_stack(void)
 #ifdef CONFIG_SMP
 static atomic_t dump_lock = ATOMIC_INIT(-1);
 
-asmlinkage __visible void dump_stack(void)
+asmlinkage __weak __visible void dump_stack(void)
 {
 	unsigned long flags;
 	int was_locked;
@@ -118,7 +118,7 @@ asmlinkage __visible void dump_stack(void)
 	local_irq_restore(flags);
 }
 #else
-asmlinkage __visible void dump_stack(void)
+asmlinkage __weak __visible void dump_stack(void)
 {
 	__dump_stack();
 }
-- 
2.16.2
