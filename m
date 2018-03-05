Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeCEFiP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:38:15 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33630 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbeCEFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:38:12 -0500
X-Google-Smtp-Source: AG47ELtbw7QrK2kLinjZ0LltMz0+pzixb8AVz1ojBnmEeDwzZtHHAYE8mtdiRJ+7wzvXYCKUPXaA3g==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Date: Mon,  5 Mar 2018 14:37:42 +0900
Message-Id: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to move dump_stack related functions out of printk C
code and consolidate them in lib/dump_stack file. The reason why
dump_stack_print_info()/etc ended up in printk.c was a "generic"
(dummy) lib dump_stack() function, which archs can override.
For example, blackfin and nds32, define their own EXPORT_SYMBOL
dump_stack() functions.

In case of blackfin that arch-specific dump_stack() symbol invokes
a global dump_stack_print_info() function. So we can't easily move
dump_stack_print_info() to lib/dump_stack, because this way we will
link with lib/dump_stack.o file, which will bring in a generic
dump_stack() symbol with it, causing a multiple definitions error:
  - one dump_stack() from arch/blackfin/dumpstack
  - the other one from lib/dump_stack

Convert generic dump_stack() into a weak symbol. So we will be
able link with lib/dump_stack and at the same time archs will
be able to override dump_stack(). It also opens up a way for us
to move dump_stack_set_arch_desc(), dump_stack_print_info() and
show_regs_print_info() to lib/dump_stack.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
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
index c5edbedd364d..02a8ad163760 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -25,7 +25,7 @@ static void __dump_stack(void)
 #ifdef CONFIG_SMP
 static atomic_t dump_lock = ATOMIC_INIT(-1);
 
-asmlinkage __visible void dump_stack(void)
+asmlinkage __weak __visible void dump_stack(void)
 {
 	unsigned long flags;
 	int was_locked;
@@ -58,7 +58,7 @@ asmlinkage __visible void dump_stack(void)
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
