Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9929ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F92087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z6bSzXvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1F92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJSWeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:34:07 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:50722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeJSWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:34:07 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D647524E1004;
        Fri, 19 Oct 2018 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539959265; bh=OSUixZQNyeRidmGANAIx2w8bezg6GgjgjqLesx3hi8k=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6bSzXvSEZurlgoeYAbLu6qmcBdam3CIZAwD+CiDBQg7nUjvhUVLzcMwclcsaqvlM
         tIsGodCXIslj47Wg8kxhq2Vocw0oTMnrKBE3lJSoJiPPlLWFByAGnYJMRiCqLdksWC
         3fHjiO3Q6+DcX/tKceNs3JmDLpuVbfb6FePRVhOS+mwFf8CQijdpfQ0rMNnMS9Hji7
         KqKRqUWmRJW4HX9j+dBsXquoZU5O6K9W1TPimYQrU2cucVzRqjGbf6XkHGDeBDATcb
         yxyIl7yQrLyrR4EO6TzgbD/9cpGs2Dlo5+iL9RUzrZfBQ3HjLLWmABaDHTO6DN1OpG
         es0qVnn+Bty7A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id DC0113C70;
        Fri, 19 Oct 2018 07:27:43 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC] ARC: ARCv2: Introduce SmaRT support
Date:   Fri, 19 Oct 2018 17:27:38 +0300
Message-Id: <20181019142738.31085-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compile-time 'ARC_USE_SMART' option for enabling SmaRT support.

Small real time trace (SmaRT) is an optional on-chip debug hardware
component that captures instruction-trace history. It stores the
address of the most recent non-sequential instructions executed into
internal buffer.

Usually we use MetaWare debugger to enable SmaRT and display trace
information.

This patch allows to display the decoded content of SmaRT buffer
without MetaWare debugger. It is done by extending ordinary exception
message with decoded SmaRT instruction-trace history.

In some cases it's really usefull as it allows to show pre-exception
instruction-trace which was not tainted by exception handler code,
printk code, etc...

Nevertheless this option has negative performance impact due to
implementation as we dump SmaRT buffer content into external memory
buffer in the begining of every slowpath exception handler code.
We choose this implementation as a compromise between performance
impact and SmaRT buffer tainting.
Although the performance impact is not really significant (according
to lmbench) we leave this option disabled by default.

Here is th examples of user-space and kernel-space fault messages with
'ARC_USE_SMART' option enabled:

User-space exception:
----------------------->8-------------------------
Exception: u_hell[99]: at 0x103a2 [off 0x103a2 in /root/u_hell, VMA: 00010000:00012000]
  ECR: 0x00050200 => Invalid Write @ 0x00000000 by insn @ 0x000103a2
SmaRT (64 entries):
 [   0]    V 0x90232358 -> 0x9022ce3c [src do_page_fault+0x2c/0x2d8] [dst populate_smart+0x0/0x9c]
 [   1]    V 0x9022e3f8 -> 0x9023232c [src EV_TLBProtV+0xec/0xf0] [dst do_page_fault+0x0/0x2d8]
 [   2]    V 0x90233194 -> 0x9022e30c [src do_slow_path_pf+0x10/0x14] [dst EV_TLBProtV+0x0/0xf0]
 [   3]    V 0x90233120 -> 0x90233184 [src EV_TLBMissD+0x80/0xe0] [dst do_slow_path_pf+0x0/0x14]
 [   4]  E V 0x000103a2 -> 0x902330a0 [off 0x103a2 in /root/u_hell, VMA: 00010000:00012000] [dst EV_TLBMissD+0x0/0xe0]
 [   5] U  V 0x2004f238 -> 0x00010398 [off 0x43238 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x10398 in /root/u_hell, VMA: 00010000:00012000]
 [   6] U  V 0x20049a82 -> 0x2004f214 [off 0x3da82 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x43214 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
 [   7] U  V 0x20049a64 -> 0x20049a76 [off 0x3da64 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x3da76 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
 [   8] U  V 0x2001d8e4 -> 0x20049a58 [off 0x118e4 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x3da58 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
 [   9] U  V 0x2001d8f4 -> 0x2001d8a8 [off 0x118f4 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x118a8 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
 [  10] U  V 0x2001d5c8 -> 0x2001d8f0 [off 0x115c8 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000] [off 0x118f0 in /lib/libuClibc-1.0.18.so, VMA: 2000c000:20072000]
...[snip]...
----------------------->8-------------------------

Kernel-space exception:
----------------------->8-------------------------
Exception: at dw_mci_probe+0xf0/0x944:
  ECR: 0x00050100 => Invalid Read @ 0x00000000 by insn @ 0x905e26e0
SmaRT (64 entries):
 [   0]    V 0x90232358 -> 0x9022ce3c [src do_page_fault+0x2c/0x2d8] [dst populate_smart+0x0/0x9c]
 [   1]    V 0x9022e3f8 -> 0x9023232c [src EV_TLBProtV+0xec/0xf0] [dst do_page_fault+0x0/0x2d8]
 [   2]    V 0x9022e398 -> 0x9022e3a0 [src EV_TLBProtV+0x8c/0xf0] [dst EV_TLBProtV+0x94/0xf0]
 [   3]    V 0x90233194 -> 0x9022e30c [src do_slow_path_pf+0x10/0x14] [dst EV_TLBProtV+0x0/0xf0]
 [   4]    V 0x902330dc -> 0x90233184 [src EV_TLBMissD+0x3c/0xe0] [dst do_slow_path_pf+0x0/0x14]
 [   5]  E V 0x905e26e0 -> 0x902330a0 [src dw_mci_probe+0xf0/0x944] [dst EV_TLBMissD+0x0/0xe0]
 [   6]    V 0x904cb940 -> 0x905e26d6 [src clk_get_rate+0xdc/0x208] [dst dw_mci_probe+0xe6/0x944]
 [   7]    V 0x9074e14a -> 0x904cb932 [src mutex_unlock+0x1e/0x24] [dst clk_get_rate+0xce/0x208]
 [   8]    V 0x904cb92e -> 0x9074e12c [src clk_get_rate+0xca/0x208] [dst mutex_unlock+0x0/0x24]
 [   9]    V 0x904cb8ea -> 0x904cb91e [src clk_get_rate+0x86/0x208] [dst clk_get_rate+0xba/0x208]
 [  10]    V 0x904cb8c2 -> 0x904cb8d0 [src clk_get_rate+0x5e/0x208] [dst clk_get_rate+0x6c/0x208]
 [  11]    V 0x9074e01a -> 0x904cb884 [src mutex_trylock+0x4e/0x50] [dst clk_get_rate+0x20/0x208]
 [  12]    V 0x9074e00e -> 0x9074e018 [src mutex_trylock+0x42/0x50] [dst mutex_trylock+0x4c/0x50]
 [  13]    V 0x9074dfdc -> 0x9074dff0 [src mutex_trylock+0x10/0x50] [dst mutex_trylock+0x24/0x50]
 [  14]    V 0x904cb880 -> 0x9074dfcc [src clk_get_rate+0x1c/0x208] [dst mutex_trylock+0x0/0x50]
 [  15]    V 0x905e26d2 -> 0x904cb864 [src dw_mci_probe+0xe2/0x944] [dst clk_get_rate+0x0/0x208]
...[snip]...
----------------------->8-------------------------

TODO:
  Add runtime procfs options to configure/suspend SmaRT.
  Add SmaRT BCR encoding struct.
  Check SmaRT version number in BCR.

NOTE:
this RFC has prerequisite:
  http://patchwork.ozlabs.org/patch/986820/

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig               |   8 +++
 arch/arc/include/asm/arcregs.h |  14 ++++++
 arch/arc/include/asm/bug.h     |   7 +++
 arch/arc/kernel/setup.c        |   6 +++
 arch/arc/kernel/traps.c        |   7 +++
 arch/arc/kernel/troubleshoot.c | 112 +++++++++++++++++++++++++++++++++++++++++
 arch/arc/mm/fault.c            |   1 +
 7 files changed, 155 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a045f3086047..f006fe81e085 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -528,6 +528,14 @@ config ARC_DBG_TLB_PARANOIA
 	bool "Paranoia Checks in Low Level TLB Handlers"
 	default n
 
+config ARC_USE_SMART
+	bool "Enable real time trace on-chip debug HW"
+	depends on ISA_ARCV2
+	help
+	  Enable Small real time trace on-chip debug hardware component that
+	  captures instruction-trace history if exists. This trace will be
+	  printed if any unexpected exception is occured.
+
 endif
 
 config ARC_UBOOT_SUPPORT
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 49bfbd879caa..11f4c5c0df4d 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -118,6 +118,20 @@
 #define ARC_AUX_DPFP_2H         0x304
 #define ARC_AUX_DPFP_STAT       0x305
 
+/* SmaRT registers */
+#define ARC_AUX_SMART_CONTROL	0x700
+#define SMART_CTL_EN		BIT(0)
+#define SMART_CTL_DATA_POS	8
+#define SMART_CTL_DATA_SRC	0
+#define SMART_CTL_DATA_DST	1
+#define SMART_CTL_DATA_FLAG	2
+#define SMART_CTL_IDX_POS	10
+#define ARC_AUX_SMART_DATA	0x701
+#define SMART_FLAG_U		BIT(8)
+#define SMART_FLAG_E		BIT(9)
+#define SMART_FLAG_R		BIT(10)
+#define SMART_FLAG_V		BIT(31)
+
 #ifndef __ASSEMBLY__
 
 #include <soc/arc/aux.h>
diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index b68f7f82f2d8..bc9c14bcee2a 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -15,6 +15,13 @@
 
 struct task_struct;
 
+#ifdef CONFIG_ARC_USE_SMART
+void populate_smart(void);
+#define POPULATE_SMART()	populate_smart()
+#else
+#define POPULATE_SMART()
+#endif /* CONFIG_ARC_USE_SMART */
+
 void show_regs(struct pt_regs *regs);
 void show_exception_mesg(struct pt_regs *regs);
 void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index b2cae79a25d7..e83bbc86397e 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -447,6 +447,12 @@ void setup_processor(void)
 	pr_info("%s", arc_platform_smp_cpuinfo());
 
 	arc_chk_core_config();
+
+#ifdef CONFIG_ARC_USE_SMART
+	if (cpuinfo_arc700[cpu_id].extn.smart)
+		write_aux_reg(ARC_AUX_SMART_CONTROL, SMART_CTL_EN);
+#endif
+
 }
 
 static inline int is_kernel(unsigned long addr)
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index e66fd40296b3..0228f7182e6d 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -70,6 +70,7 @@ int name(unsigned long address, struct pt_regs *regs) \
 {						\
 	siginfo_t info;				\
 						\
+	POPULATE_SMART();			\
 	clear_siginfo(&info);			\
 	info.si_signo = signr;			\
 	info.si_errno = 0;			\
@@ -96,6 +97,8 @@ DO_ERROR_INFO(SIGSEGV, "gcc generated __builtin_trap", do_trap5_error, 0)
 int do_misaligned_access(unsigned long address, struct pt_regs *regs,
 			 struct callee_regs *cregs)
 {
+	POPULATE_SMART();
+
 	/* If emulation not enabled, or failed, kill the task */
 	if (misaligned_fixup(address, regs, cregs) != 0)
 		return do_misaligned_error(address, regs);
@@ -128,6 +131,8 @@ void do_non_swi_trap(unsigned long address, struct pt_regs *regs)
 {
 	unsigned int param = regs->ecr_param;
 
+	POPULATE_SMART();
+
 	switch (param) {
 	case 1:
 		trap_is_brkpt(address, regs);
@@ -159,6 +164,8 @@ void do_insterror_or_kprobe(unsigned long address, struct pt_regs *regs)
 {
 	int rc;
 
+	POPULATE_SMART();
+
 	/* Check if this exception is caused by kprobes */
 	rc = notify_die(DIE_IERR, "kprobe_ierr", regs, address, 0, SIGILL);
 	if (rc == NOTIFY_STOP)
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index fdfba1942a06..22017474a29c 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -14,10 +14,23 @@
 #include <linux/file.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/debug.h>
+#include <linux/percpu-defs.h>
 
 #include <asm/arcregs.h>
 #include <asm/irqflags.h>
 
+#ifdef CONFIG_ARC_USE_SMART
+#define MAX_SMART_BUFF	4096
+
+struct smart_buff {
+	u32 src[MAX_SMART_BUFF];
+	u32 dst[MAX_SMART_BUFF];
+	u32 flags[MAX_SMART_BUFF];
+};
+
+DEFINE_PER_CPU(struct smart_buff, smart_buff_log);
+#endif /* CONFIG_ARC_USE_SMART */
+
 /*
  * Common routine to print scratch regs (r0-r12) or callee regs (r13-r25)
  *   -Prints 3 regs per line and a CR.
@@ -189,9 +202,104 @@ static inline void show_exception_mesg_k(struct pt_regs *regs)
 	show_ecr_verbose(regs);
 }
 
+#ifdef CONFIG_ARC_USE_SMART
+static inline bool smart_exist(void)
+{
+	struct bcr_generic bcr;
+
+	READ_BCR(ARC_REG_SMART_BCR, bcr);
+	return !!bcr.ver ;
+}
+
+static inline u32 smart_stack_size(void)
+{
+	return read_aux_reg(ARC_REG_SMART_BCR) >> SMART_CTL_IDX_POS;
+}
+
+static inline void smart_enable(void)
+{
+	write_aux_reg(ARC_AUX_SMART_CONTROL, SMART_CTL_EN);
+}
+
+static inline void smart_disable(void)
+{
+	write_aux_reg(ARC_AUX_SMART_CONTROL, 0);
+}
+
+static void show_smart(void)
+{
+	struct smart_buff *smart_buff_cpu = this_cpu_ptr(&smart_buff_log);
+	int i, stack_size;
+	char *buf;
+
+	if (!smart_exist())
+		return;
+
+	stack_size = smart_stack_size();
+	pr_info("SmaRT (%d entries):\n", stack_size);
+
+	buf = (char *)__get_free_page(GFP_NOWAIT);
+	if (!buf)
+		return;
+
+	for (i = 0; i < stack_size; i++) {
+		pr_info(" [%4d] %s%s%s%s %#010x -> %#010x ", i,
+			smart_buff_cpu->flags[i] & SMART_FLAG_U ? "U" : " ",
+			smart_buff_cpu->flags[i] & SMART_FLAG_E ? "E" : " ",
+			smart_buff_cpu->flags[i] & SMART_FLAG_R ? "R" : " ",
+			smart_buff_cpu->flags[i] & SMART_FLAG_V ? "V" : " ",
+			smart_buff_cpu->src[i], smart_buff_cpu->dst[i]);
+
+		if (smart_buff_cpu->src[i] < 0x80000000)
+			show_faulting_vma(smart_buff_cpu->src[i], buf);
+		else
+			pr_cont("[src %pS] ", (void *)smart_buff_cpu->src[i]);
+
+		if (smart_buff_cpu->dst[i] < 0x80000000)
+			show_faulting_vma(smart_buff_cpu->dst[i], buf);
+		else
+			pr_cont("[dst %pS]\n", (void *)smart_buff_cpu->dst[i]);
+	}
+
+	free_page((unsigned long)buf);
+}
+#endif /* CONFIG_ARC_USE_SMART */
+
 /************************************************************************
  *  API called by rest of kernel
  ***********************************************************************/
+#ifdef CONFIG_ARC_USE_SMART
+void populate_smart(void)
+{
+	struct smart_buff *smart_buff_cpu;
+	u32 stack_size;
+	int i;
+
+	if (!smart_exist())
+		return;
+
+	smart_disable();
+
+	smart_buff_cpu = this_cpu_ptr(&smart_buff_log);
+	stack_size = smart_stack_size();
+	for (i = 0; i < stack_size; i++) {
+		write_aux_reg(ARC_AUX_SMART_CONTROL,
+			(SMART_CTL_DATA_SRC << SMART_CTL_DATA_POS)
+			| (i << SMART_CTL_IDX_POS));
+		smart_buff_cpu->src[i] = read_aux_reg(ARC_AUX_SMART_DATA);
+		write_aux_reg(ARC_AUX_SMART_CONTROL,
+			(SMART_CTL_DATA_DST << SMART_CTL_DATA_POS)
+			| (i << SMART_CTL_IDX_POS));
+		smart_buff_cpu->dst[i] = read_aux_reg(ARC_AUX_SMART_DATA);
+		write_aux_reg(ARC_AUX_SMART_CONTROL,
+			(SMART_CTL_DATA_FLAG << SMART_CTL_DATA_POS)
+			| (i << SMART_CTL_IDX_POS));
+		smart_buff_cpu->flags[i] = read_aux_reg(ARC_AUX_SMART_DATA);
+	}
+
+	smart_enable();
+}
+#endif /* CONFIG_ARC_USE_SMART */
 
 void show_exception_mesg(struct pt_regs *regs)
 {
@@ -199,6 +307,10 @@ void show_exception_mesg(struct pt_regs *regs)
 		show_exception_mesg_u(regs);
 	else
 		show_exception_mesg_k(regs);
+
+#ifdef CONFIG_ARC_USE_SMART
+	show_smart();
+#endif /* CONFIG_ARC_USE_SMART */
 }
 
 void show_regs(struct pt_regs *regs)
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 026d662a7668..7a759fd874de 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -72,6 +72,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
+	POPULATE_SMART();
 	clear_siginfo(&info);
 
 	/*
-- 
2.14.4

