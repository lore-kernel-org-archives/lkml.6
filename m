Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeDXM4i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:56:38 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:38491 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757877AbeDXM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:56:19 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Huacai Chen <chenhc@lemote.com>, <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, <oprofile-list@lists.sf.net>
Subject: [RFC PATCH] MIPS: Oprofile: Drop support
Date: Tue, 24 Apr 2018 13:55:54 +0100
Message-ID: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524574550-637140-30405-118854-1
X-BESS-VER: 2018.5-r1804232011
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192327
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core oprofile code in drivers/oprofile/ has not seeen significant
maintenance other than fixes to changes in other parts of the tree for
the last 5 years at least. It looks as through the perf tool has
more or less superceeded it's functionality.
Additionally the MIPS architecture support has bitrotted to an extent
meaning it is not currently functional.
For example the current Kconfig rule disallows HW_PERF from being
enabled in a kernel supporting OPROFILE, but attempting to use oprofile
on such a kernel results in:

$ op-check-perfevents -v
  perf_event_open syscall returned No such file or directory

Due to missing perf support....

If this dependency is removed such that oprofile can be started, very
quickly an oops is triggered which appears to be a result of the
oprofile buffer having not been set up correctly:

$ operf: Profiler started
[   96.950415] CPU 1 Unable to handle kernel paging request at virtual address 00000008, epc == 804fcb14, ra == 809b6424
[   96.962266] Oops[#1]:
[   96.964821] CPU: 1 PID: 145 Comm: operf Not tainted 4.16.0+ #235
[   96.971516] $ 0   : 00000000 809b6500 d179d1bb ffffffff
[   96.977367] $ 4   : 00000000 0000000c 00000001 8efab000
[   96.983215] $ 8   : 80e00000 0000007f 002887fc ffffffff
[   96.989062] $12   : 8f495de4 00000000 8131c400 80e01000
[   96.994916] $16   : 8f495dfc 80d10000 00000000 8efab000
[   97.000781] $20   : 00000000 80cf8aa0 8f495ef8 80d70000
[   97.006630] $24   : 00000000 00000000
[   97.012477] $28   : 8e936000 8f495d68 00000001 809b6424
[   97.018329] Hi    : 00210c94
[   97.021551] Lo    : 4a54aef0
[   97.024810] epc   : 804fcb14 ring_buffer_lock_reserve+0x38/0x6fc
[   97.031526] ra    : 809b6424 op_cpu_buffer_write_reserve+0x3c/0x78
[   97.038417] Status: 1100fc02    KERNEL EXL
[   97.042820] Cause : 04808008 (ExcCode 02)
[   97.047286] BadVA : 00000008
[   97.050503] PrId  : 0001a120 (MIPS interAptiv (multi))
[   97.056225] Modules linked in:
[   97.059667] Process operf (pid: 145, threadinfo=e9a0abb0, task=3ddccdc2, tls=77fcd490)
[   97.068484] Stack : 80e00000 8132d400 00000001 8efab000 8132d400 80d10000 80d0de64 00000001
[   97.077836]         ffff3973 8047763c 8293d343 80d70000 8f495d98 d179d1bb 00000001 8f495dfc
[   97.087190]         00000001 00000001 8efab000 00000000 80cf8aa0 8f495ef8 80d70000 809b6424
[   97.096542]         8293e5d2 00000016 8293d343 80d70000 804c9c38 0000000b 80d10000 809b6500
[   97.105897]         81329ae8 8e937a90 8293e5d2 00000016 8293d343 81329ae8 81329ae8 804b4cf4
[   97.115251]         ...
[   97.117992] Call Trace:
[   97.120743] [<804fcb14>] ring_buffer_lock_reserve+0x38/0x6fc
[   97.127080] [<809b6424>] op_cpu_buffer_write_reserve+0x3c/0x78
[   97.133604] [<809b6500>] op_add_code+0x80/0x114
[   97.138675] [<809b6610>] log_sample+0x7c/0xf0
[   97.143545] [<809b6928>] oprofile_add_sample+0x90/0xd4
[   97.149292] [<809ba2f0>] mipsxx_perfcount_handler+0x408/0x474
[   97.155728] [<80492c4c>] __handle_irq_event_percpu+0xbc/0x288
[   97.162141] [<80492e58>] handle_irq_event_percpu+0x40/0x98
[   97.168276] [<80498700>] handle_percpu_irq+0x98/0xc8
[   97.173833] [<8049204c>] generic_handle_irq+0x38/0x48
[   97.179504] [<807da298>] gic_handle_local_int+0xb0/0x108
[   97.185438] [<807da498>] gic_irq_dispatch+0x20/0x30
[   97.190887] [<8049204c>] generic_handle_irq+0x38/0x48
[   97.196539] [<80b7e098>] do_IRQ+0x28/0x34
[   97.201024] [<807d8ef0>] plat_irq_dispatch+0xf0/0x11c
[   97.206677] [<804060a8>] except_vec_vi_end+0xb8/0xc4
[   97.212227] [<80b7dc2c>] _raw_spin_unlock_irq+0x28/0x34
[   97.218067] [<80544428>] __add_to_page_cache_locked.part.44+0xe4/0x218
[   97.225353] [<80544930>] add_to_page_cache_lru+0x88/0x1bc
[   97.231419] [<805563e0>] read_cache_pages+0x9c/0x1bc
[   97.236981] [<806d4b38>] nfs_readpages+0x124/0x234
[   97.242344] [<805566e8>] __do_page_cache_readahead+0x1e8/0x344
[   97.248877] [<80556e70>] page_cache_sync_readahead+0x68/0x74
[   97.255199] [<80547354>] generic_file_read_iter+0x340/0xd50
[   97.261449] [<806c5a9c>] nfs_file_read+0x84/0x120
[   97.266726] [<805a8d28>] __vfs_read+0x144/0x198
[   97.271801] [<805a8e34>] vfs_read+0xb8/0x144
[   97.276589] [<805a8ee8>] kernel_read+0x28/0x3c
[   97.281585] [<805b00f4>] prepare_binprm+0x18c/0x1c4
[   97.287042] [<805b21c8>] do_execveat_common+0x3fc/0x6d8
[   97.292878] [<805b24dc>] do_execve+0x38/0x44
[   97.297669] [<80415a58>] syscall_common+0x34/0x58
[   97.302924] Code: afb0003c  8e22d4e0  afa20034 <8c820008> 14400170
24030020  8f82000c  26460010  00a09825

Since it appears that MIPS oprofile support is currently broken, core
oprofile is not getting many updates and not as many architectures
implement support for it compared to perf, remove the MIPS support.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

This is meant as an RFC to determine if people are still using oprofile.
If they are, then let's get it fixed such that it works correctly and
perhaps make the oprofile support more closely tie in with perf, sharing
the code as much as possible. If not, the effort to do this would be
rather wasted and perhaps we're better drawing a line under the support
here. Thoughts?
Thanks,
Matt

---
 arch/mips/Kconfig                                |   3 +-
 arch/mips/Makefile                               |   1 -
 arch/mips/configs/fuloong2e_defconfig            |   1 -
 arch/mips/configs/ip32_defconfig                 |   1 -
 arch/mips/configs/lemote2f_defconfig             |   1 -
 arch/mips/configs/mtx1_defconfig                 |   1 -
 arch/mips/include/asm/mach-loongson64/loongson.h |   3 -
 arch/mips/oprofile/Makefile                      |  18 -
 arch/mips/oprofile/backtrace.c                   | 177 ---------
 arch/mips/oprofile/common.c                      | 147 -------
 arch/mips/oprofile/op_impl.h                     |  41 --
 arch/mips/oprofile/op_model_loongson2.c          | 161 --------
 arch/mips/oprofile/op_model_loongson3.c          | 213 -----------
 arch/mips/oprofile/op_model_mipsxx.c             | 466 -----------------------
 14 files changed, 1 insertion(+), 1233 deletions(-)
 delete mode 100644 arch/mips/oprofile/Makefile
 delete mode 100644 arch/mips/oprofile/backtrace.c
 delete mode 100644 arch/mips/oprofile/common.c
 delete mode 100644 arch/mips/oprofile/op_impl.h
 delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
 delete mode 100644 arch/mips/oprofile/op_model_loongson3.c
 delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95da23ce..3c92cdd91b46 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -59,7 +59,6 @@ config MIPS
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
@@ -2637,7 +2636,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !OPROFILE && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
+	depends on PERF_EVENTS && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5e9fce076ab6..b7affd468442 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -325,7 +325,6 @@ libs-y			+= arch/mips/math-emu/
 core-y += arch/mips/
 
 drivers-$(CONFIG_MIPS_CRC_SUPPORT) += arch/mips/crypto/
-drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
 
 # suspend and hibernation support
 drivers-$(CONFIG_PM)	+= arch/mips/power/
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 499f51498ecb..db219b02d8ce 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -21,7 +21,6 @@ CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index ebff297328ae..fc61ff7e1e4b 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -12,7 +12,6 @@ CONFIG_RELAY=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 02be95c1b712..a543bb753e3f 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -22,7 +22,6 @@ CONFIG_RD_LZMA=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index c3d0d0a6e044..aca5fd1485d4 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -13,7 +13,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index d0ae5d55413b..c5fb51fa914f 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -74,9 +74,6 @@ extern int mach_i8259_irq(void);
 #include <linux/interrupt.h>
 static inline void do_perfcnt_IRQ(void)
 {
-#if IS_ENABLED(CONFIG_OPROFILE)
-	do_IRQ(LOONGSON2_PERFCNT_IRQ);
-#endif
 }
 
 #define LOONGSON_FLASH_BASE	0x1c000000
diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
deleted file mode 100644
index 011cf9f891e7..000000000000
--- a/arch/mips/oprofile/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y				:= $(DRIVER_OBJS) common.o backtrace.o
-
-oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
-oprofile-$(CONFIG_CPU_LOONGSON3)	+= op_model_loongson3.o
diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
deleted file mode 100644
index 806fb798091f..000000000000
--- a/arch/mips/oprofile/backtrace.c
+++ /dev/null
@@ -1,177 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/oprofile.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/uaccess.h>
-#include <asm/ptrace.h>
-#include <asm/stacktrace.h>
-#include <linux/stacktrace.h>
-#include <linux/kernel.h>
-#include <asm/sections.h>
-#include <asm/inst.h>
-
-struct stackframe {
-	unsigned long sp;
-	unsigned long pc;
-	unsigned long ra;
-};
-
-static inline int get_mem(unsigned long addr, unsigned long *result)
-{
-	unsigned long *address = (unsigned long *) addr;
-	if (!access_ok(VERIFY_READ, address, sizeof(unsigned long)))
-		return -1;
-	if (__copy_from_user_inatomic(result, address, sizeof(unsigned long)))
-		return -3;
-	return 0;
-}
-
-/*
- * These two instruction helpers were taken from process.c
- */
-static inline int is_ra_save_ins(union mips_instruction *ip)
-{
-	/* sw / sd $ra, offset($sp) */
-	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op)
-		&& ip->i_format.rs == 29 && ip->i_format.rt == 31;
-}
-
-static inline int is_sp_move_ins(union mips_instruction *ip)
-{
-	/* addiu/daddiu sp,sp,-imm */
-	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
-		return 0;
-	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
-		return 1;
-	return 0;
-}
-
-/*
- * Looks for specific instructions that mark the end of a function.
- * This usually means we ran into the code area of the previous function.
- */
-static inline int is_end_of_function_marker(union mips_instruction *ip)
-{
-	/* jr ra */
-	if (ip->r_format.func == jr_op && ip->r_format.rs == 31)
-		return 1;
-	/* lui gp */
-	if (ip->i_format.opcode == lui_op && ip->i_format.rt == 28)
-		return 1;
-	return 0;
-}
-
-/*
- * TODO for userspace stack unwinding:
- * - handle cases where the stack is adjusted inside a function
- *     (generally doesn't happen)
- * - find optimal value for max_instr_check
- * - try to find a better way to handle leaf functions
- */
-
-static inline int unwind_user_frame(struct stackframe *old_frame,
-				    const unsigned int max_instr_check)
-{
-	struct stackframe new_frame = *old_frame;
-	off_t ra_offset = 0;
-	size_t stack_size = 0;
-	unsigned long addr;
-
-	if (old_frame->pc == 0 || old_frame->sp == 0 || old_frame->ra == 0)
-		return -9;
-
-	for (addr = new_frame.pc; (addr + max_instr_check > new_frame.pc)
-		&& (!ra_offset || !stack_size); --addr) {
-		union mips_instruction ip;
-
-		if (get_mem(addr, (unsigned long *) &ip))
-			return -11;
-
-		if (is_sp_move_ins(&ip)) {
-			int stack_adjustment = ip.i_format.simmediate;
-			if (stack_adjustment > 0)
-				/* This marks the end of the previous function,
-				   which means we overran. */
-				break;
-			stack_size = (unsigned long) stack_adjustment;
-		} else if (is_ra_save_ins(&ip)) {
-			int ra_slot = ip.i_format.simmediate;
-			if (ra_slot < 0)
-				/* This shouldn't happen. */
-				break;
-			ra_offset = ra_slot;
-		} else if (is_end_of_function_marker(&ip))
-			break;
-	}
-
-	if (!ra_offset || !stack_size)
-		goto done;
-
-	if (ra_offset) {
-		new_frame.ra = old_frame->sp + ra_offset;
-		if (get_mem(new_frame.ra, &(new_frame.ra)))
-			return -13;
-	}
-
-	if (stack_size) {
-		new_frame.sp = old_frame->sp + stack_size;
-		if (get_mem(new_frame.sp, &(new_frame.sp)))
-			return -14;
-	}
-
-	if (new_frame.sp > old_frame->sp)
-		return -2;
-
-done:
-	new_frame.pc = old_frame->ra;
-	*old_frame = new_frame;
-
-	return 0;
-}
-
-static inline void do_user_backtrace(unsigned long low_addr,
-				     struct stackframe *frame,
-				     unsigned int depth)
-{
-	const unsigned int max_instr_check = 512;
-	const unsigned long high_addr = low_addr + THREAD_SIZE;
-
-	while (depth-- && !unwind_user_frame(frame, max_instr_check)) {
-		oprofile_add_trace(frame->ra);
-		if (frame->sp < low_addr || frame->sp > high_addr)
-			break;
-	}
-}
-
-#ifndef CONFIG_KALLSYMS
-static inline void do_kernel_backtrace(unsigned long low_addr,
-				       struct stackframe *frame,
-				       unsigned int depth) { }
-#else
-static inline void do_kernel_backtrace(unsigned long low_addr,
-				       struct stackframe *frame,
-				       unsigned int depth)
-{
-	while (depth-- && frame->pc) {
-		frame->pc = unwind_stack_by_address(low_addr,
-						    &(frame->sp),
-						    frame->pc,
-						    &(frame->ra));
-		oprofile_add_trace(frame->ra);
-	}
-}
-#endif
-
-void notrace op_mips_backtrace(struct pt_regs *const regs, unsigned int depth)
-{
-	struct stackframe frame = { .sp = regs->regs[29],
-				    .pc = regs->cp0_epc,
-				    .ra = regs->regs[31] };
-	const int userspace = user_mode(regs);
-	const unsigned long low_addr = ALIGN(frame.sp, THREAD_SIZE);
-
-	if (userspace)
-		do_user_backtrace(low_addr, &frame, depth);
-	else
-		do_kernel_backtrace(low_addr, &frame, depth);
-}
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
deleted file mode 100644
index 2f33992f6dff..000000000000
--- a/arch/mips/oprofile/common.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004, 2005 Ralf Baechle
- * Copyright (C) 2005 MIPS Technologies, Inc.
- */
-#include <linux/compiler.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/oprofile.h>
-#include <linux/smp.h>
-#include <asm/cpu-info.h>
-#include <asm/cpu-type.h>
-
-#include "op_impl.h"
-
-extern struct op_mips_model op_model_mipsxx_ops __weak;
-extern struct op_mips_model op_model_loongson2_ops __weak;
-extern struct op_mips_model op_model_loongson3_ops __weak;
-
-static struct op_mips_model *model;
-
-static struct op_counter_config ctr[20];
-
-static int op_mips_setup(void)
-{
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr);
-
-	/* Configure the registers on all cpus.	 */
-	on_each_cpu(model->cpu_setup, NULL, 1);
-
-	return 0;
-}
-
-static int op_mips_create_files(struct dentry *root)
-{
-	int i;
-
-	for (i = 0; i < model->num_counters; ++i) {
-		struct dentry *dir;
-		char buf[4];
-
-		snprintf(buf, sizeof buf, "%d", i);
-		dir = oprofilefs_mkdir(root, buf);
-
-		oprofilefs_create_ulong(dir, "enabled", &ctr[i].enabled);
-		oprofilefs_create_ulong(dir, "event", &ctr[i].event);
-		oprofilefs_create_ulong(dir, "count", &ctr[i].count);
-		oprofilefs_create_ulong(dir, "kernel", &ctr[i].kernel);
-		oprofilefs_create_ulong(dir, "user", &ctr[i].user);
-		oprofilefs_create_ulong(dir, "exl", &ctr[i].exl);
-		/* Dummy.  */
-		oprofilefs_create_ulong(dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	return 0;
-}
-
-static int op_mips_start(void)
-{
-	on_each_cpu(model->cpu_start, NULL, 1);
-
-	return 0;
-}
-
-static void op_mips_stop(void)
-{
-	/* Disable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_stop, NULL, 1);
-}
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	struct op_mips_model *lmodel = NULL;
-	int res;
-
-	switch (boot_cpu_type()) {
-	case CPU_5KC:
-	case CPU_M14KC:
-	case CPU_M14KEC:
-	case CPU_20KC:
-	case CPU_24K:
-	case CPU_25KF:
-	case CPU_34K:
-	case CPU_1004K:
-	case CPU_74K:
-	case CPU_1074K:
-	case CPU_INTERAPTIV:
-	case CPU_PROAPTIV:
-	case CPU_P5600:
-	case CPU_I6400:
-	case CPU_M5150:
-	case CPU_LOONGSON1:
-	case CPU_SB1:
-	case CPU_SB1A:
-	case CPU_R10000:
-	case CPU_R12000:
-	case CPU_R14000:
-	case CPU_R16000:
-	case CPU_XLR:
-		lmodel = &op_model_mipsxx_ops;
-		break;
-
-	case CPU_LOONGSON2:
-		lmodel = &op_model_loongson2_ops;
-		break;
-	case CPU_LOONGSON3:
-		lmodel = &op_model_loongson3_ops;
-		break;
-	};
-
-	/*
-	 * Always set the backtrace. This allows unsupported CPU types to still
-	 * use timer-based oprofile.
-	 */
-	ops->backtrace = op_mips_backtrace;
-
-	if (!lmodel)
-		return -ENODEV;
-
-	res = lmodel->init();
-	if (res)
-		return res;
-
-	model = lmodel;
-
-	ops->create_files	= op_mips_create_files;
-	ops->setup		= op_mips_setup;
-	//ops->shutdown		= op_mips_shutdown;
-	ops->start		= op_mips_start;
-	ops->stop		= op_mips_stop;
-	ops->cpu_type		= lmodel->cpu_type;
-
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
-
-	return 0;
-}
-
-void oprofile_arch_exit(void)
-{
-	if (model)
-		model->exit();
-}
diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
deleted file mode 100644
index a4e758a39af4..000000000000
--- a/arch/mips/oprofile/op_impl.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_impl.h
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#ifndef OP_IMPL_H
-#define OP_IMPL_H 1
-
-extern int (*perf_irq)(void);
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-	unsigned long count;
-	/* Dummies because I am too lazy to hack the userspace tools.  */
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long exl;
-	unsigned long unit_mask;
-};
-
-/* Per-architecture configure and hooks.  */
-struct op_mips_model {
-	void (*reg_setup) (struct op_counter_config *);
-	void (*cpu_setup) (void *dummy);
-	int (*init)(void);
-	void (*exit)(void);
-	void (*cpu_start)(void *args);
-	void (*cpu_stop)(void *args);
-	char *cpu_type;
-	unsigned char num_counters;
-};
-
-void op_mips_backtrace(struct pt_regs * const regs, unsigned int depth);
-
-#endif
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
deleted file mode 100644
index b249ec0bebb2..000000000000
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * Loongson2 performance counter driver for oprofile
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Yanhua <yanh@lemote.com>
- * Author: Wu Zhangjin <wuzhangjin@gmail.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/oprofile.h>
-#include <linux/interrupt.h>
-
-#include <loongson.h>			/* LOONGSON2_PERFCNT_IRQ */
-#include "op_impl.h"
-
-#define LOONGSON2_CPU_TYPE	"mips/loongson2"
-
-#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL	<< 31)
-
-#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
-#define LOONGSON2_PERFCTRL_KERNEL		(1UL	<<  1)
-#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL	<<  2)
-#define LOONGSON2_PERFCTRL_USER			(1UL	<<  3)
-#define LOONGSON2_PERFCTRL_ENABLE		(1UL	<<  4)
-#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
-	(((event) & 0x0f) << ((idx) ? 9 : 5))
-
-#define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
-#define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
-#define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
-#define write_c0_perfcnt(val) __write_64bit_c0_register($25, 0, val)
-
-static struct loongson2_register_config {
-	unsigned int ctrl;
-	unsigned long long reset_counter1;
-	unsigned long long reset_counter2;
-	int cnt1_enabled, cnt2_enabled;
-} reg;
-
-static char *oprofid = "LoongsonPerf";
-static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
-
-static void reset_counters(void *arg)
-{
-	write_c0_perfctrl(0);
-	write_c0_perfcnt(0);
-}
-
-static void loongson2_reg_setup(struct op_counter_config *cfg)
-{
-	unsigned int ctrl = 0;
-
-	reg.reset_counter1 = 0;
-	reg.reset_counter2 = 0;
-
-	/*
-	 * Compute the performance counter ctrl word.
-	 * For now, count kernel and user mode.
-	 */
-	if (cfg[0].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EVENT(0, cfg[0].event);
-		reg.reset_counter1 = 0x80000000ULL - cfg[0].count;
-	}
-
-	if (cfg[1].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EVENT(1, cfg[1].event);
-		reg.reset_counter2 = 0x80000000ULL - cfg[1].count;
-	}
-
-	if (cfg[0].enabled || cfg[1].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EXL | LOONGSON2_PERFCTRL_ENABLE;
-		if (cfg[0].kernel || cfg[1].kernel)
-			ctrl |= LOONGSON2_PERFCTRL_KERNEL;
-		if (cfg[0].user || cfg[1].user)
-			ctrl |= LOONGSON2_PERFCTRL_USER;
-	}
-
-	reg.ctrl = ctrl;
-
-	reg.cnt1_enabled = cfg[0].enabled;
-	reg.cnt2_enabled = cfg[1].enabled;
-}
-
-static void loongson2_cpu_setup(void *args)
-{
-	write_c0_perfcnt((reg.reset_counter2 << 32) | reg.reset_counter1);
-}
-
-static void loongson2_cpu_start(void *args)
-{
-	/* Start all counters on current CPU */
-	if (reg.cnt1_enabled || reg.cnt2_enabled)
-		write_c0_perfctrl(reg.ctrl);
-}
-
-static void loongson2_cpu_stop(void *args)
-{
-	/* Stop all counters on current CPU */
-	write_c0_perfctrl(0);
-	memset(&reg, 0, sizeof(reg));
-}
-
-static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
-{
-	uint64_t counter, counter1, counter2;
-	struct pt_regs *regs = get_irq_regs();
-	int enabled;
-
-	/* Check whether the irq belongs to me */
-	enabled = read_c0_perfctrl() & LOONGSON2_PERFCTRL_ENABLE;
-	if (!enabled)
-		return IRQ_NONE;
-	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
-	if (!enabled)
-		return IRQ_NONE;
-
-	counter = read_c0_perfcnt();
-	counter1 = counter & 0xffffffff;
-	counter2 = counter >> 32;
-
-	if (counter1 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt1_enabled)
-			oprofile_add_sample(regs, 0);
-		counter1 = reg.reset_counter1;
-	}
-	if (counter2 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt2_enabled)
-			oprofile_add_sample(regs, 1);
-		counter2 = reg.reset_counter2;
-	}
-
-	write_c0_perfcnt((counter2 << 32) | counter1);
-
-	return IRQ_HANDLED;
-}
-
-static int __init loongson2_init(void)
-{
-	return request_irq(LOONGSON2_PERFCNT_IRQ, loongson2_perfcount_handler,
-			   IRQF_SHARED, "Perfcounter", oprofid);
-}
-
-static void loongson2_exit(void)
-{
-	reset_counters(NULL);
-	free_irq(LOONGSON2_PERFCNT_IRQ, oprofid);
-}
-
-struct op_mips_model op_model_loongson2_ops = {
-	.reg_setup = loongson2_reg_setup,
-	.cpu_setup = loongson2_cpu_setup,
-	.init = loongson2_init,
-	.exit = loongson2_exit,
-	.cpu_start = loongson2_cpu_start,
-	.cpu_stop = loongson2_cpu_stop,
-	.cpu_type = LOONGSON2_CPU_TYPE,
-	.num_counters = 2
-};
diff --git a/arch/mips/oprofile/op_model_loongson3.c b/arch/mips/oprofile/op_model_loongson3.c
deleted file mode 100644
index 436b1fc99f2c..000000000000
--- a/arch/mips/oprofile/op_model_loongson3.c
+++ /dev/null
@@ -1,213 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- */
-#include <linux/init.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/proc_fs.h>
-#include <linux/oprofile.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/uaccess.h>
-#include <irq.h>
-#include <loongson.h>
-#include "op_impl.h"
-
-#define LOONGSON3_PERFCNT_OVERFLOW	(1ULL << 63)
-
-#define LOONGSON3_PERFCTRL_EXL		(1UL << 0)
-#define LOONGSON3_PERFCTRL_KERNEL	(1UL << 1)
-#define LOONGSON3_PERFCTRL_SUPERVISOR	(1UL << 2)
-#define LOONGSON3_PERFCTRL_USER		(1UL << 3)
-#define LOONGSON3_PERFCTRL_ENABLE	(1UL << 4)
-#define LOONGSON3_PERFCTRL_W		(1UL << 30)
-#define LOONGSON3_PERFCTRL_M		(1UL << 31)
-#define LOONGSON3_PERFCTRL_EVENT(idx, event) \
-	(((event) & (idx ? 0x0f : 0x3f)) << 5)
-
-/* Loongson-3 PerfCount performance counter1 register */
-#define read_c0_perflo1() __read_64bit_c0_register($25, 0)
-#define write_c0_perflo1(val) __write_64bit_c0_register($25, 0, val)
-#define read_c0_perfhi1() __read_64bit_c0_register($25, 1)
-#define write_c0_perfhi1(val) __write_64bit_c0_register($25, 1, val)
-
-/* Loongson-3 PerfCount performance counter2 register */
-#define read_c0_perflo2() __read_64bit_c0_register($25, 2)
-#define write_c0_perflo2(val) __write_64bit_c0_register($25, 2, val)
-#define read_c0_perfhi2() __read_64bit_c0_register($25, 3)
-#define write_c0_perfhi2(val) __write_64bit_c0_register($25, 3, val)
-
-static int (*save_perf_irq)(void);
-
-static struct loongson3_register_config {
-	unsigned int control1;
-	unsigned int control2;
-	unsigned long long reset_counter1;
-	unsigned long long reset_counter2;
-	int ctr1_enable, ctr2_enable;
-} reg;
-
-static void reset_counters(void *arg)
-{
-	write_c0_perfhi1(0);
-	write_c0_perfhi2(0);
-	write_c0_perflo1(0xc0000000);
-	write_c0_perflo2(0x40000000);
-}
-
-/* Compute all of the registers in preparation for enabling profiling. */
-static void loongson3_reg_setup(struct op_counter_config *ctr)
-{
-	unsigned int control1 = 0;
-	unsigned int control2 = 0;
-
-	reg.reset_counter1 = 0;
-	reg.reset_counter2 = 0;
-	/* Compute the performance counter control word. */
-	/* For now count kernel and user mode */
-	if (ctr[0].enabled) {
-		control1 |= LOONGSON3_PERFCTRL_EVENT(0, ctr[0].event) |
-					LOONGSON3_PERFCTRL_ENABLE;
-		if (ctr[0].kernel)
-			control1 |= LOONGSON3_PERFCTRL_KERNEL;
-		if (ctr[0].user)
-			control1 |= LOONGSON3_PERFCTRL_USER;
-		reg.reset_counter1 = 0x8000000000000000ULL - ctr[0].count;
-	}
-
-	if (ctr[1].enabled) {
-		control2 |= LOONGSON3_PERFCTRL_EVENT(1, ctr[1].event) |
-					LOONGSON3_PERFCTRL_ENABLE;
-		if (ctr[1].kernel)
-			control2 |= LOONGSON3_PERFCTRL_KERNEL;
-		if (ctr[1].user)
-			control2 |= LOONGSON3_PERFCTRL_USER;
-		reg.reset_counter2 = 0x8000000000000000ULL - ctr[1].count;
-	}
-
-	if (ctr[0].enabled)
-		control1 |= LOONGSON3_PERFCTRL_EXL;
-	if (ctr[1].enabled)
-		control2 |= LOONGSON3_PERFCTRL_EXL;
-
-	reg.control1 = control1;
-	reg.control2 = control2;
-	reg.ctr1_enable = ctr[0].enabled;
-	reg.ctr2_enable = ctr[1].enabled;
-}
-
-/* Program all of the registers in preparation for enabling profiling. */
-static void loongson3_cpu_setup(void *args)
-{
-	uint64_t perfcount1, perfcount2;
-
-	perfcount1 = reg.reset_counter1;
-	perfcount2 = reg.reset_counter2;
-	write_c0_perfhi1(perfcount1);
-	write_c0_perfhi2(perfcount2);
-}
-
-static void loongson3_cpu_start(void *args)
-{
-	/* Start all counters on current CPU */
-	reg.control1 |= (LOONGSON3_PERFCTRL_W|LOONGSON3_PERFCTRL_M);
-	reg.control2 |= (LOONGSON3_PERFCTRL_W|LOONGSON3_PERFCTRL_M);
-
-	if (reg.ctr1_enable)
-		write_c0_perflo1(reg.control1);
-	if (reg.ctr2_enable)
-		write_c0_perflo2(reg.control2);
-}
-
-static void loongson3_cpu_stop(void *args)
-{
-	/* Stop all counters on current CPU */
-	write_c0_perflo1(0xc0000000);
-	write_c0_perflo2(0x40000000);
-	memset(&reg, 0, sizeof(reg));
-}
-
-static int loongson3_perfcount_handler(void)
-{
-	unsigned long flags;
-	uint64_t counter1, counter2;
-	uint32_t cause, handled = IRQ_NONE;
-	struct pt_regs *regs = get_irq_regs();
-
-	cause = read_c0_cause();
-	if (!(cause & CAUSEF_PCI))
-		return handled;
-
-	counter1 = read_c0_perfhi1();
-	counter2 = read_c0_perfhi2();
-
-	local_irq_save(flags);
-
-	if (counter1 & LOONGSON3_PERFCNT_OVERFLOW) {
-		if (reg.ctr1_enable)
-			oprofile_add_sample(regs, 0);
-		counter1 = reg.reset_counter1;
-	}
-	if (counter2 & LOONGSON3_PERFCNT_OVERFLOW) {
-		if (reg.ctr2_enable)
-			oprofile_add_sample(regs, 1);
-		counter2 = reg.reset_counter2;
-	}
-
-	local_irq_restore(flags);
-
-	write_c0_perfhi1(counter1);
-	write_c0_perfhi2(counter2);
-
-	if (!(cause & CAUSEF_TI))
-		handled = IRQ_HANDLED;
-
-	return handled;
-}
-
-static int loongson3_starting_cpu(unsigned int cpu)
-{
-	write_c0_perflo1(reg.control1);
-	write_c0_perflo2(reg.control2);
-	return 0;
-}
-
-static int loongson3_dying_cpu(unsigned int cpu)
-{
-	write_c0_perflo1(0xc0000000);
-	write_c0_perflo2(0x40000000);
-	return 0;
-}
-
-static int __init loongson3_init(void)
-{
-	on_each_cpu(reset_counters, NULL, 1);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
-				  "mips/oprofile/loongson3:starting",
-				  loongson3_starting_cpu, loongson3_dying_cpu);
-	save_perf_irq = perf_irq;
-	perf_irq = loongson3_perfcount_handler;
-
-	return 0;
-}
-
-static void loongson3_exit(void)
-{
-	on_each_cpu(reset_counters, NULL, 1);
-	cpuhp_remove_state_nocalls(CPUHP_AP_MIPS_OP_LOONGSON3_STARTING);
-	perf_irq = save_perf_irq;
-}
-
-struct op_mips_model op_model_loongson3_ops = {
-	.reg_setup	= loongson3_reg_setup,
-	.cpu_setup	= loongson3_cpu_setup,
-	.init		= loongson3_init,
-	.exit		= loongson3_exit,
-	.cpu_start	= loongson3_cpu_start,
-	.cpu_stop	= loongson3_cpu_stop,
-	.cpu_type	= "mips/loongson3",
-	.num_counters	= 2
-};
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
deleted file mode 100644
index c3e4c18ef8d4..000000000000
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ /dev/null
@@ -1,466 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004, 05, 06 by Ralf Baechle
- * Copyright (C) 2005 by MIPS Technologies, Inc.
- */
-#include <linux/cpumask.h>
-#include <linux/oprofile.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-#include <asm/irq_regs.h>
-#include <asm/time.h>
-
-#include "op_impl.h"
-
-#define M_PERFCTL_EVENT(event)		(((event) << MIPS_PERFCTRL_EVENT_S) & \
-					 MIPS_PERFCTRL_EVENT)
-#define M_PERFCTL_VPEID(vpe)		((vpe)	  << MIPS_PERFCTRL_VPEID_S)
-
-#define M_COUNTER_OVERFLOW		(1UL	  << 31)
-
-static int (*save_perf_irq)(void);
-static int perfcount_irq;
-
-/*
- * XLR has only one set of counters per core. Designate the
- * first hardware thread in the core for setup and init.
- * Skip CPUs with non-zero hardware thread id (4 hwt per core)
- */
-#if defined(CONFIG_CPU_XLR) && defined(CONFIG_SMP)
-#define oprofile_skip_cpu(c)	((cpu_logical_map(c) & 0x3) != 0)
-#else
-#define oprofile_skip_cpu(c)	0
-#endif
-
-#ifdef CONFIG_MIPS_MT_SMP
-static int cpu_has_mipsmt_pertccounters;
-#define WHAT		(MIPS_PERFCTRL_MT_EN_VPE | \
-			 M_PERFCTL_VPEID(cpu_vpe_id(&current_cpu_data)))
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_vpe_id(&current_cpu_data))
-
-/*
- * The number of bits to shift to convert between counters per core and
- * counters per VPE.  There is no reasonable interface atm to obtain the
- * number of VPEs used by Linux and in the 34K this number is fixed to two
- * anyways so we hardcore a few things here for the moment.  The way it's
- * done here will ensure that oprofile VSMP kernel will run right on a lesser
- * core like a 24K also or with maxcpus=1.
- */
-static inline unsigned int vpe_shift(void)
-{
-	if (num_possible_cpus() > 1)
-		return 1;
-
-	return 0;
-}
-
-#else
-
-#define WHAT		0
-#define vpe_id()	0
-
-static inline unsigned int vpe_shift(void)
-{
-	return 0;
-}
-
-#endif
-
-static inline unsigned int counters_total_to_per_cpu(unsigned int counters)
-{
-	return counters >> vpe_shift();
-}
-
-static inline unsigned int counters_per_cpu_to_total(unsigned int counters)
-{
-	return counters << vpe_shift();
-}
-
-#define __define_perf_accessors(r, n, np)				\
-									\
-static inline unsigned int r_c0_ ## r ## n(void)			\
-{									\
-	unsigned int cpu = vpe_id();					\
-									\
-	switch (cpu) {							\
-	case 0:								\
-		return read_c0_ ## r ## n();				\
-	case 1:								\
-		return read_c0_ ## r ## np();				\
-	default:							\
-		BUG();							\
-	}								\
-	return 0;							\
-}									\
-									\
-static inline void w_c0_ ## r ## n(unsigned int value)			\
-{									\
-	unsigned int cpu = vpe_id();					\
-									\
-	switch (cpu) {							\
-	case 0:								\
-		write_c0_ ## r ## n(value);				\
-		return;							\
-	case 1:								\
-		write_c0_ ## r ## np(value);				\
-		return;							\
-	default:							\
-		BUG();							\
-	}								\
-	return;								\
-}									\
-
-__define_perf_accessors(perfcntr, 0, 2)
-__define_perf_accessors(perfcntr, 1, 3)
-__define_perf_accessors(perfcntr, 2, 0)
-__define_perf_accessors(perfcntr, 3, 1)
-
-__define_perf_accessors(perfctrl, 0, 2)
-__define_perf_accessors(perfctrl, 1, 3)
-__define_perf_accessors(perfctrl, 2, 0)
-__define_perf_accessors(perfctrl, 3, 1)
-
-struct op_mips_model op_model_mipsxx_ops;
-
-static struct mipsxx_register_config {
-	unsigned int control[4];
-	unsigned int counter[4];
-} reg;
-
-/* Compute all of the registers in preparation for enabling profiling.	*/
-
-static void mipsxx_reg_setup(struct op_counter_config *ctr)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-	int i;
-
-	/* Compute the performance counter control word.  */
-	for (i = 0; i < counters; i++) {
-		reg.control[i] = 0;
-		reg.counter[i] = 0;
-
-		if (!ctr[i].enabled)
-			continue;
-
-		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
-				 MIPS_PERFCTRL_IE;
-		if (ctr[i].kernel)
-			reg.control[i] |= MIPS_PERFCTRL_K;
-		if (ctr[i].user)
-			reg.control[i] |= MIPS_PERFCTRL_U;
-		if (ctr[i].exl)
-			reg.control[i] |= MIPS_PERFCTRL_EXL;
-		if (boot_cpu_type() == CPU_XLR)
-			reg.control[i] |= XLR_PERFCTRL_ALLTHREADS;
-		reg.counter[i] = 0x80000000 - ctr[i].count;
-	}
-}
-
-/* Program all of the registers in preparation for enabling profiling.	*/
-
-static void mipsxx_cpu_setup(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	if (oprofile_skip_cpu(smp_processor_id()))
-		return;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-		w_c0_perfcntr3(reg.counter[3]);
-	case 3:
-		w_c0_perfctrl2(0);
-		w_c0_perfcntr2(reg.counter[2]);
-	case 2:
-		w_c0_perfctrl1(0);
-		w_c0_perfcntr1(reg.counter[1]);
-	case 1:
-		w_c0_perfctrl0(0);
-		w_c0_perfcntr0(reg.counter[0]);
-	}
-}
-
-/* Start all counters on current CPU */
-static void mipsxx_cpu_start(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	if (oprofile_skip_cpu(smp_processor_id()))
-		return;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(WHAT | reg.control[3]);
-	case 3:
-		w_c0_perfctrl2(WHAT | reg.control[2]);
-	case 2:
-		w_c0_perfctrl1(WHAT | reg.control[1]);
-	case 1:
-		w_c0_perfctrl0(WHAT | reg.control[0]);
-	}
-}
-
-/* Stop all counters on current CPU */
-static void mipsxx_cpu_stop(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	if (oprofile_skip_cpu(smp_processor_id()))
-		return;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-	case 3:
-		w_c0_perfctrl2(0);
-	case 2:
-		w_c0_perfctrl1(0);
-	case 1:
-		w_c0_perfctrl0(0);
-	}
-}
-
-static int mipsxx_perfcount_handler(void)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-	unsigned int control;
-	unsigned int counter;
-	int handled = IRQ_NONE;
-
-	if (cpu_has_mips_r2 && !(read_c0_cause() & CAUSEF_PCI))
-		return handled;
-
-	switch (counters) {
-#define HANDLE_COUNTER(n)						\
-	case n + 1:							\
-		control = r_c0_perfctrl ## n();				\
-		counter = r_c0_perfcntr ## n();				\
-		if ((control & MIPS_PERFCTRL_IE) &&			\
-		    (counter & M_COUNTER_OVERFLOW)) {			\
-			oprofile_add_sample(get_irq_regs(), n);		\
-			w_c0_perfcntr ## n(reg.counter[n]);		\
-			handled = IRQ_HANDLED;				\
-		}
-	HANDLE_COUNTER(3)
-	HANDLE_COUNTER(2)
-	HANDLE_COUNTER(1)
-	HANDLE_COUNTER(0)
-	}
-
-	return handled;
-}
-
-static inline int __n_counters(void)
-{
-	if (!cpu_has_perf)
-		return 0;
-	if (!(read_c0_perfctrl0() & MIPS_PERFCTRL_M))
-		return 1;
-	if (!(read_c0_perfctrl1() & MIPS_PERFCTRL_M))
-		return 2;
-	if (!(read_c0_perfctrl2() & MIPS_PERFCTRL_M))
-		return 3;
-
-	return 4;
-}
-
-static inline int n_counters(void)
-{
-	int counters;
-
-	switch (current_cpu_type()) {
-	case CPU_R10000:
-		counters = 2;
-		break;
-
-	case CPU_R12000:
-	case CPU_R14000:
-	case CPU_R16000:
-		counters = 4;
-		break;
-
-	default:
-		counters = __n_counters();
-	}
-
-	return counters;
-}
-
-static void reset_counters(void *arg)
-{
-	int counters = (int)(long)arg;
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-		w_c0_perfcntr3(0);
-	case 3:
-		w_c0_perfctrl2(0);
-		w_c0_perfcntr2(0);
-	case 2:
-		w_c0_perfctrl1(0);
-		w_c0_perfcntr1(0);
-	case 1:
-		w_c0_perfctrl0(0);
-		w_c0_perfcntr0(0);
-	}
-}
-
-static irqreturn_t mipsxx_perfcount_int(int irq, void *dev_id)
-{
-	return mipsxx_perfcount_handler();
-}
-
-static int __init mipsxx_init(void)
-{
-	int counters;
-
-	counters = n_counters();
-	if (counters == 0) {
-		printk(KERN_ERR "Oprofile: CPU has no performance counters\n");
-		return -ENODEV;
-	}
-
-#ifdef CONFIG_MIPS_MT_SMP
-	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
-	if (!cpu_has_mipsmt_pertccounters)
-		counters = counters_total_to_per_cpu(counters);
-#endif
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
-
-	op_model_mipsxx_ops.num_counters = counters;
-	switch (current_cpu_type()) {
-	case CPU_M14KC:
-		op_model_mipsxx_ops.cpu_type = "mips/M14Kc";
-		break;
-
-	case CPU_M14KEC:
-		op_model_mipsxx_ops.cpu_type = "mips/M14KEc";
-		break;
-
-	case CPU_20KC:
-		op_model_mipsxx_ops.cpu_type = "mips/20K";
-		break;
-
-	case CPU_24K:
-		op_model_mipsxx_ops.cpu_type = "mips/24K";
-		break;
-
-	case CPU_25KF:
-		op_model_mipsxx_ops.cpu_type = "mips/25K";
-		break;
-
-	case CPU_1004K:
-	case CPU_34K:
-		op_model_mipsxx_ops.cpu_type = "mips/34K";
-		break;
-
-	case CPU_1074K:
-	case CPU_74K:
-		op_model_mipsxx_ops.cpu_type = "mips/74K";
-		break;
-
-	case CPU_INTERAPTIV:
-		op_model_mipsxx_ops.cpu_type = "mips/interAptiv";
-		break;
-
-	case CPU_PROAPTIV:
-		op_model_mipsxx_ops.cpu_type = "mips/proAptiv";
-		break;
-
-	case CPU_P5600:
-		op_model_mipsxx_ops.cpu_type = "mips/P5600";
-		break;
-
-	case CPU_I6400:
-		op_model_mipsxx_ops.cpu_type = "mips/I6400";
-		break;
-
-	case CPU_M5150:
-		op_model_mipsxx_ops.cpu_type = "mips/M5150";
-		break;
-
-	case CPU_5KC:
-		op_model_mipsxx_ops.cpu_type = "mips/5K";
-		break;
-
-	case CPU_R10000:
-		if ((current_cpu_data.processor_id & 0xff) == 0x20)
-			op_model_mipsxx_ops.cpu_type = "mips/r10000-v2.x";
-		else
-			op_model_mipsxx_ops.cpu_type = "mips/r10000";
-		break;
-
-	case CPU_R12000:
-	case CPU_R14000:
-		op_model_mipsxx_ops.cpu_type = "mips/r12000";
-		break;
-
-	case CPU_R16000:
-		op_model_mipsxx_ops.cpu_type = "mips/r16000";
-		break;
-
-	case CPU_SB1:
-	case CPU_SB1A:
-		op_model_mipsxx_ops.cpu_type = "mips/sb1";
-		break;
-
-	case CPU_LOONGSON1:
-		op_model_mipsxx_ops.cpu_type = "mips/loongson1";
-		break;
-
-	case CPU_XLR:
-		op_model_mipsxx_ops.cpu_type = "mips/xlr";
-		break;
-
-	default:
-		printk(KERN_ERR "Profiling unsupported for this CPU\n");
-
-		return -ENODEV;
-	}
-
-	save_perf_irq = perf_irq;
-	perf_irq = mipsxx_perfcount_handler;
-
-	if (get_c0_perfcount_int)
-		perfcount_irq = get_c0_perfcount_int();
-	else if (cp0_perfcount_irq >= 0)
-		perfcount_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	else
-		perfcount_irq = -1;
-
-	if (perfcount_irq >= 0)
-		return request_irq(perfcount_irq, mipsxx_perfcount_int,
-				   IRQF_PERCPU | IRQF_NOBALANCING |
-				   IRQF_NO_THREAD | IRQF_NO_SUSPEND |
-				   IRQF_SHARED,
-				   "Perfcounter", save_perf_irq);
-
-	return 0;
-}
-
-static void mipsxx_exit(void)
-{
-	int counters = op_model_mipsxx_ops.num_counters;
-
-	if (perfcount_irq >= 0)
-		free_irq(perfcount_irq, save_perf_irq);
-
-	counters = counters_per_cpu_to_total(counters);
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
-
-	perf_irq = save_perf_irq;
-}
-
-struct op_mips_model op_model_mipsxx_ops = {
-	.reg_setup	= mipsxx_reg_setup,
-	.cpu_setup	= mipsxx_cpu_setup,
-	.init		= mipsxx_init,
-	.exit		= mipsxx_exit,
-	.cpu_start	= mipsxx_cpu_start,
-	.cpu_stop	= mipsxx_cpu_stop,
-};
-- 
2.7.4
