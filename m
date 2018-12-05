Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DEBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353AC20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353AC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeLEIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:53:05 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:33316 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbeLEIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:52:10 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 5 Dec 2018 00:52:02 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1AF6F41280;
        Wed,  5 Dec 2018 00:52:05 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v7 08/14] x86/ftrace: Use text_poke_*() infrastructure
Date:   Tue, 4 Dec 2018 17:34:02 -0800
Message-ID: <20181205013408.47725-9-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205013408.47725-1-namit@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A following patch is going to make module allocated memory
non-executable. This requires to modify ftrace and make the memory
executable again after it is configured.

In addition, this patch makes ftrace use the general text poking
infrastructure instead ftrace's homegrown text patching. This provides
the advantages of having slightly "safer" code patching and avoiding
races with module removal or other mechanisms that patch the kernel
code.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/ftrace.c | 74 +++++++++++++---------------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..f05a0f9e2837 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 
 #include <trace/syscall.h>
 
@@ -29,23 +30,10 @@
 #include <asm/kprobes.h>
 #include <asm/ftrace.h>
 #include <asm/nops.h>
+#include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-int ftrace_arch_code_modify_prepare(void)
-{
-	set_kernel_text_rw();
-	set_all_modules_text_rw();
-	return 0;
-}
-
-int ftrace_arch_code_modify_post_process(void)
-{
-	set_all_modules_text_ro();
-	set_kernel_text_ro();
-	return 0;
-}
-
 union ftrace_code_union {
 	char code[MCOUNT_INSN_SIZE];
 	struct {
@@ -79,22 +67,6 @@ within(unsigned long addr, unsigned long start, unsigned long end)
 	return addr >= start && addr < end;
 }
 
-static unsigned long text_ip_addr(unsigned long ip)
-{
-	/*
-	 * On x86_64, kernel text mappings are mapped read-only, so we use
-	 * the kernel identity mapping instead of the kernel text mapping
-	 * to modify the kernel text.
-	 *
-	 * For 32bit kernels, these mappings are same and we can use
-	 * kernel identity mapping to modify code.
-	 */
-	if (within(ip, (unsigned long)_text, (unsigned long)_etext))
-		ip = (unsigned long)__va(__pa_symbol(ip));
-
-	return ip;
-}
-
 static const unsigned char *ftrace_nop_replace(void)
 {
 	return ideal_nops[NOP_ATOMIC5];
@@ -124,13 +96,8 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
 		return -EINVAL;
 
-	ip = text_ip_addr(ip);
-
 	/* replace the text with the new text */
-	if (probe_kernel_write((void *)ip, new_code, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	sync_core();
+	text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 
 	return 0;
 }
@@ -302,10 +269,7 @@ int ftrace_int3_handler(struct pt_regs *regs)
 
 static int ftrace_write(unsigned long ip, const char *val, int size)
 {
-	ip = text_ip_addr(ip);
-
-	if (probe_kernel_write((void *)ip, val, size))
-		return -EPERM;
+	text_poke((void *)ip, val, size);
 
 	return 0;
 }
@@ -653,9 +617,11 @@ void arch_ftrace_update_code(int command)
 {
 	/* See comment above by declaration of modifying_ftrace_code */
 	atomic_inc(&modifying_ftrace_code);
+	mutex_lock(&text_mutex);
 
 	ftrace_modify_all_code(command);
 
+	mutex_unlock(&text_mutex);
 	atomic_dec(&modifying_ftrace_code);
 }
 
@@ -741,6 +707,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long offset;
+	unsigned long npages;
 	unsigned long size;
 	unsigned long ip;
 	unsigned long *ptr;
@@ -748,7 +715,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	union ftrace_op_code_union op_ptr;
-	int ret;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		start_offset = (unsigned long)ftrace_regs_caller;
@@ -772,19 +738,16 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		return 0;
 
 	*tramp_size = size + MCOUNT_INSN_SIZE + sizeof(void *);
+	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
-	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0)) {
-		tramp_free(trampoline, *tramp_size);
-		return 0;
-	}
+	text_poke_early(trampoline, (void *)start_offset, size);
 
 	ip = (unsigned long)trampoline + size;
 
 	/* The trampoline ends with a jmp to ftrace_epilogue */
 	jmp = ftrace_jmp_replace(ip, (unsigned long)ftrace_epilogue);
-	memcpy(trampoline + size, jmp, MCOUNT_INSN_SIZE);
+	text_poke_early(trampoline + size, jmp, MCOUNT_INSN_SIZE);
 
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
@@ -813,11 +776,19 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	op_ptr.offset = offset;
 
 	/* put in the new offset to the ftrace_ops */
-	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
+	text_poke_early(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
+	set_memory_ro((unsigned long)trampoline, npages);
+
+	/*
+	 * TODO: Once we have better code (and page-table) protection
+	 * mechanisms, ensure that the code has not been tampered before.
+	 */
+	set_memory_x((unsigned long)trampoline, npages);
+
 	return (unsigned long)trampoline;
 }
 
@@ -853,8 +824,6 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 		 */
 		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 			return;
-		npages = PAGE_ALIGN(ops->trampoline_size) >> PAGE_SHIFT;
-		set_memory_rw(ops->trampoline, npages);
 	} else {
 		ops->trampoline = create_trampoline(ops, &size);
 		if (!ops->trampoline)
@@ -863,6 +832,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 		npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	}
 
+	mutex_lock(&text_mutex);
+
 	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS);
 	ip = ops->trampoline + offset;
 
@@ -871,7 +842,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
-	set_memory_ro(ops->trampoline, npages);
+
+	mutex_unlock(&text_mutex);
 
 	/* The update should never fail */
 	WARN_ON(ret);
-- 
2.17.1

