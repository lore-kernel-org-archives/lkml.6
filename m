Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FEC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A28216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A28216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeHOM1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:27:38 -0400
Received: from exmail.andestech.com ([59.124.169.137]:29847 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeHOM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:27:38 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7F9YL1e011300;
        Wed, 15 Aug 2018 17:34:21 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 15 Aug 2018
 17:35:45 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 4/6] nds32/ftrace: Support dynamic function tracer
Date:   Wed, 15 Aug 2018 17:35:21 +0800
Message-ID: <43ec653b5275bcdcefa25f34846d0700b0caf18a.1534323834.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7F9YL1e011300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the implementation of dynamic function tracer.
The mcount call is composed of three instructions, so there are three
nop for enough placeholder.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/Kconfig              |   1 +
 arch/nds32/include/asm/ftrace.h |  26 +++++++
 arch/nds32/kernel/ftrace.c      | 164 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 66d507d..9db36c2 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -43,6 +43,7 @@ config NDS32
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_DYNAMIC_FTRACE
 	help
 	  Andes(nds32) Linux support.
 
diff --git a/arch/nds32/include/asm/ftrace.h b/arch/nds32/include/asm/ftrace.h
index bac7657..2f96cc9 100644
--- a/arch/nds32/include/asm/ftrace.h
+++ b/arch/nds32/include/asm/ftrace.h
@@ -15,6 +15,32 @@
 
 extern void _mcount(unsigned long parent_ip);
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define FTRACE_ADDR ((unsigned long)_ftrace_caller)
+
+#ifdef __NDS32_EL__
+#define INSN_NOP		0x09000040
+#define INSN_SIZE(insn)		(((insn & 0x00000080) == 0) ? 4 : 2)
+#define IS_SETHI(insn)		((insn & 0x000000fe) == 0x00000046)
+#define ENDIAN_CONVERT(insn)	be32_to_cpu(insn)
+#else /* __NDS32_EB__ */
+#define INSN_NOP		0x40000009
+#define INSN_SIZE(insn)		(((insn & 0x80000000) == 0) ? 4 : 2)
+#define IS_SETHI(insn)		((insn & 0xfe000000) == 0x46000000)
+#define ENDIAN_CONVERT(insn)	(insn)
+#endif
+
+extern void _ftrace_caller(unsigned long parent_ip);
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+struct dyn_arch_ftrace {
+};
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #endif /* __ASM_NDS32_FTRACE_H */
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 707fce7..3ca676b 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -4,6 +4,7 @@
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 
+#ifndef CONFIG_DYNAMIC_FTRACE
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
 				     struct ftrace_ops*, struct pt_regs*);
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
@@ -35,6 +36,168 @@ noinline void _mcount(unsigned long parent_ip)
 }
 EXPORT_SYMBOL(_mcount);
 
+#else /* CONFIG_DYNAMIC_FTRACE */
+
+noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
+				  struct ftrace_ops *op, struct pt_regs *regs)
+{
+	__asm__ ("");  /* avoid to optimize as pure function */
+}
+
+noinline void __naked _mcount(unsigned long parent_ip)
+{
+	__asm__ ("");  /* avoid to optimize as pure function */
+}
+EXPORT_SYMBOL(_mcount);
+
+#define XSTR(s) STR(s)
+#define STR(s) #s
+void _ftrace_caller(unsigned long parent_ip)
+{
+	/* save all state needed by the compiler prologue */
+
+	/*
+	 * prepare arguments for real tracing function
+	 * first  arg : __builtin_return_address(0) - MCOUNT_INSN_SIZE
+	 * second arg : parent_ip
+	 */
+	__asm__ __volatile__ (
+		"move $r1, %0				   \n\t"
+		"addi $r0, %1, #-" XSTR(MCOUNT_INSN_SIZE) "\n\t"
+		:
+		: "r" (parent_ip), "r" (__builtin_return_address(0)));
+
+	/* a placeholder for the call to a real tracing function */
+	__asm__ __volatile__ (
+		"ftrace_call:		\n\t"
+		"nop			\n\t"
+		"nop			\n\t"
+		"nop			\n\t");
+
+	/* restore all state needed by the compiler epilogue */
+}
+
+int __init ftrace_dyn_arch_init(void)
+{
+	return 0;
+}
+
+int ftrace_arch_code_modify_prepare(void)
+{
+	set_all_modules_text_rw();
+	return 0;
+}
+
+int ftrace_arch_code_modify_post_process(void)
+{
+	set_all_modules_text_ro();
+	return 0;
+}
+
+static unsigned long gen_sethi_insn(unsigned long addr)
+{
+	unsigned long opcode = 0x46000000;
+	unsigned long imm = addr >> 12;
+	unsigned long rt_num = 0xf << 20;
+
+	return ENDIAN_CONVERT(opcode | rt_num | imm);
+}
+
+static unsigned long gen_ori_insn(unsigned long addr)
+{
+	unsigned long opcode = 0x58000000;
+	unsigned long imm = addr & 0x0000fff;
+	unsigned long rt_num = 0xf << 20;
+	unsigned long ra_num = 0xf << 15;
+
+	return ENDIAN_CONVERT(opcode | rt_num | ra_num | imm);
+}
+
+static unsigned long gen_jral_insn(unsigned long addr)
+{
+	unsigned long opcode = 0x4a000001;
+	unsigned long rt_num = 0x1e << 20;
+	unsigned long rb_num = 0xf << 10;
+
+	return ENDIAN_CONVERT(opcode | rt_num | rb_num);
+}
+
+static void ftrace_gen_call_insn(unsigned long *call_insns,
+				 unsigned long addr)
+{
+	call_insns[0] = gen_sethi_insn(addr); /* sethi $r15, imm20u       */
+	call_insns[1] = gen_ori_insn(addr);   /* ori   $r15, $r15, imm15u */
+	call_insns[2] = gen_jral_insn(addr);  /* jral  $lp,  $r15         */
+}
+
+static int __ftrace_modify_code(unsigned long pc, unsigned long *old_insn,
+				unsigned long *new_insn, bool validate)
+{
+	unsigned long orig_insn[3];
+
+	if (validate) {
+		if (probe_kernel_read(orig_insn, (void *)pc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
+		if (memcmp(orig_insn, old_insn, MCOUNT_INSN_SIZE))
+			return -EINVAL;
+	}
+
+	if (probe_kernel_write((void *)pc, new_insn, MCOUNT_INSN_SIZE))
+		return -EPERM;
+
+	return 0;
+}
+
+static int ftrace_modify_code(unsigned long pc, unsigned long *old_insn,
+			      unsigned long *new_insn, bool validate)
+{
+	int ret;
+
+	ret = __ftrace_modify_code(pc, old_insn, new_insn, validate);
+	if (ret)
+		return ret;
+
+	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+
+	return ret;
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	unsigned long pc = (unsigned long)&ftrace_call;
+	unsigned long old_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+	unsigned long new_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+
+	if (func != ftrace_stub)
+		ftrace_gen_call_insn(new_insn, (unsigned long)func);
+
+	return ftrace_modify_code(pc, old_insn, new_insn, false);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+
+	ftrace_gen_call_insn(call_insn, addr);
+
+	return ftrace_modify_code(pc, nop_insn, call_insn, true);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+
+	ftrace_gen_call_insn(call_insn, addr);
+
+	return ftrace_modify_code(pc, call_insn, nop_insn, true);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
@@ -94,4 +257,5 @@ void __naked return_to_handler(void)
 		/* restore state nedded by the ABI  */
 		"lmw.bim $r0,[$sp],$r1,#0x0  \n\t");
 }
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.7.4

