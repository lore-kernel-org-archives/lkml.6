Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A2ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5089B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dBo/o16b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIZSZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55072 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:25:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121219euoutp0231945098c6a40638d43b2bb90f8a3c29~X8g4EApr11563315633euoutp027;
        Wed, 26 Sep 2018 12:12:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180926121219euoutp0231945098c6a40638d43b2bb90f8a3c29~X8g4EApr11563315633euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963939;
        bh=4xZbE1OUGZ8wUm3JsvJYbxPPjduHvJqY18zOObgSMUM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dBo/o16b4CNMT9tOsASdyLui8YEeIWgtvwUt731dwvJzNN4f4wwTBzFbKBtUIHNm3
         4vYDa5dVgXMcAZwMhKhNpXBffhECBh23Ao+VJY73z/52lC7tF2UevJLJxsrG2EIvaM
         U4dfmeQwfwAjoT50PrTHvyzzewxgbWarzVwxVrnI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926121219eucas1p26a20ac15bd0a4d365a0e38a7dc7bf012~X8g3fUGBD2051920519eucas1p23;
        Wed, 26 Sep 2018 12:12:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.31.04294.2A77BAB5; Wed, 26
        Sep 2018 13:12:18 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade~X8g2mzUd41639616396eucas1p1r;
        Wed, 26 Sep 2018 12:12:18 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-89-5bab77a298a8
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1D.0B.04128.2A77BAB5; Wed, 26
        Sep 2018 13:12:18 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:18 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
Date:   Wed, 26 Sep 2018 14:12:05 +0200
Message-id: <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87qLyldHGxw4bGjRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAldH1373gsW/Foa5TTA2Mixy6GDk4
        JARMJL4e5u1i5OIQEljBKHFm127mLkZOIOczo0TXBW+YmuNPyyBqljFKfN93kg3C+c8o8fPS
        Z7AGNgFzie1HW1hAbBEBN4kbjR1MIEXMApeZJC6f6GYCSQgLOEkc7X0FZrMIqEosbJ3HBmLz
        CvhL7F3+nBHElhCQk7h5rhNsKKdAgMSh6SuYIeKv2SQ2Tw6FsF0k7q38ChUXlnh1fAs7hC0j
        cXlyNwuEXS6x+8RNdpAjJARaGCWmNh5ggkhYS/xZNRFsMbMAn8SkbdOZId7klehoE4Io8ZC4
        dOANK8SXixklLhx/yTSBUXIBI8MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwARw+t/x
        LzsYd/1JOsQowMGoxMPLYbsqWog1say4MvcQowQHs5IIL3fZ6mgh3pTEyqrUovz4otKc1OJD
        jNIcLErivHxaadFCAumJJanZqakFqUUwWSYOTilglK1gbS6yD/zot0/+7PHHxgVXf9d2lKqk
        X7bkyf2S0HEv1f+0lfGKvJ9PMxhu8Mfw+Icv2XHiapHrrNdznBZ8UFQ3TMryTg2PFlyqULHp
        Z+3dd2ub24MjFynqSF35GRJdxOQZxFx0duX2QIGPgs0fvFad/Ol9WUbw+956Uz4vo9f3rx1Q
        ONKvxFKckWioxVxUnAgANsbbAPwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xa7qLyldHG9x5wWnRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAldH1373gsW/Foa5TTA2Mixy6GDk4
        JARMJI4/Leti5OIQEljCKLH14hQmCKeRSWL+/z3MXYycHGwC5hLbj7awgNgiAm4SNxo7wIqY
        BS4zSXxesJcVJCEs4CRxtPcVE4jNIqAqsbB1HhuIzSvgL7F3+XNGEFtCQE7i5rlOsKGcAgES
        h6avALOFgGqunJzJMoGRZwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAAN527OeWHYxd
        74IPMQpwMCrx8HLYrooWYk0sK67MPcQowcGsJMLLXbY6Wog3JbGyKrUoP76oNCe1+BCjNAeL
        kjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVANjqeTJ5fd+ZVw9vTSFSVDLede1XBWZSgclZrGm
        yXfW8/ecX7NuH7vrnzKhnA2pcv2p2+evNE5cenjBxlL/6R92lmxkzDr9qI2j0Md7buLySM3N
        +e95qkUftDw+4LnfpPnYrv/Vrl1f1bO6/1QsP+s5u6Pqk1J7zSqRjSlhW8Wvd0u9qAs8XbFB
        iaU4I9FQi7moOBEAh8xhM1wCAAA=
X-CMS-MailID: 20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect what kind of instruction is being probed and depending on the
result:
- if an A64 instruction handle it the old way, using existing A64
instructions probing code,
- if an A32 instruction decode it and handle using the new code, moved
from 32 bit arm kernel tree.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/kernel/debug-monitors.c |   8 +++
 arch/arm64/kernel/probes/uprobes.c | 111 ++++++++++++++++++++++++++++++++++---
 lib/probes/arm/actions-arm.c       |  35 ++++++++----
 lib/probes/arm/decode-arm.c        |  16 +++++-
 4 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 06ca574..ee10c0b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -366,6 +366,14 @@ int aarch32_break_handler(struct pt_regs *regs)
 	if (!bp)
 		return -EFAULT;
 
+	/*
+	 * Since bp != false, a sofware breakpoint instruction is being handled.
+	 * If in user mode (compat_user_mode() few lines above),
+	 * try to handle it by an uprobe handler, if registered.
+	 */
+	if (!brk_handler((unsigned long)pc, BRK64_ESR_UPROBES, regs))
+		return 0;
+
 	send_user_sigtrap(TRAP_BRKPT);
 	return 0;
 }
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index e7b8912..872c8ec 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -11,9 +11,49 @@
 #include <asm/cacheflush.h>
 
 #include "decode-insn.h"
+#include "decode.h"
+#include "decode-arm.h"
+#include <../../../arm/include/asm/opcodes.h>
 
 #define UPROBE_INV_FAULT_CODE	UINT_MAX
 
+uprobe_opcode_t get_swbp_insn(void)
+{
+	if (is_compat_task())
+		return AARCH32_BREAK_ARM;
+	else
+		return UPROBE_SWBP_INSN;
+}
+
+bool is_swbp_insn(uprobe_opcode_t *insn)
+{
+	return ((__mem_to_opcode_arm(*insn) & 0x0fffffff) ==
+				(AARCH32_BREAK_ARM & 0x0fffffff)) ||
+				*insn == UPROBE_SWBP_INSN;
+}
+
+int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+	     unsigned long vaddr)
+{
+	if (auprobe->arch == UPROBE_AARCH32)
+		return uprobe_write_opcode(auprobe, mm, vaddr,
+				__opcode_to_mem_arm(auprobe->bp_insn));
+	else
+		return uprobe_write_opcode(auprobe, mm, vaddr,
+				UPROBE_SWBP_INSN);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
+		unsigned long vaddr)
+{
+	if (auprobe->arch == UPROBE_AARCH32)
+		return uprobe_write_opcode(auprobe, mm, vaddr,
+				auprobe->orig_insn);
+	else
+		return uprobe_write_opcode(auprobe, mm, vaddr,
+				*(uprobe_opcode_t *)&auprobe->insn);
+}
+
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		void *src, unsigned long len)
 {
@@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		unsigned long addr)
 {
 	probes_opcode_t insn;
+	enum probes_insn retval;
+	unsigned int bpinsn;
 
-	/* TODO: Currently we do not support AARCH32 instruction probing */
-	if (mm->context.flags & MMCF_AARCH32)
-		return -ENOTSUPP;
-	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
+	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
+
+	if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
+	/* check if AARCH32 */
+	if (is_compat_task()) {
+
+		/* Thumb is not supported yet */
+		if (addr & 0x3)
+			return -EINVAL;
+
+		retval = arm_probes_decode_insn(insn, &auprobe->api, false,
+					     uprobes_probes_actions, NULL);
+		auprobe->arch = UPROBE_AARCH32;
+
+		/*
+		 * original instruction could have been modified
+		 * when preparing for xol on AArch32
+		 */
+		auprobe->orig_insn = insn;
+
+		bpinsn = AARCH32_BREAK_ARM & 0x0fffffff;
+		if (insn >= 0xe0000000) /* Unconditional instruction */
+			bpinsn |= 0xe0000000;
+		else /* Copy condition from insn */
+			bpinsn |= insn & 0xf0000000;
+
+		auprobe->bp_insn = bpinsn;
+	} else {
+		retval = arm64_probes_decode_insn(insn, &auprobe->api);
+		auprobe->arch = UPROBE_AARCH64;
+	}
 
-	switch (arm64_probes_decode_insn(insn, &auprobe->api)) {
+	switch (retval) {
 	case INSN_REJECTED:
 		return -EINVAL;
 
@@ -66,6 +134,9 @@ int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
+	if (auprobe->prehandler)
+		auprobe->prehandler(auprobe, &utask->autask, regs);
+
 	/* Initialize with an invalid fault code to detect if ol insn trapped */
 	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
 
@@ -88,6 +159,9 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 	user_disable_single_step(current);
 
+	if (auprobe->posthandler)
+		auprobe->posthandler(auprobe, &utask->autask, regs);
+
 	return 0;
 }
 bool arch_uprobe_xol_was_trapped(struct task_struct *t)
@@ -103,10 +177,24 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
 	return false;
 }
 
+bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	probes_opcode_t insn = *(probes_opcode_t *)(&auprobe->insn[0]);
+	pstate_check_t *check = (*aarch32_opcode_cond_checks[insn >> 28]);
+
+	if (auprobe->arch == UPROBE_AARCH64)
+		return false;
+
+	if (!check(regs->pstate & 0xffffffff)) {
+		instruction_pointer_set(regs, instruction_pointer(regs) + 4);
+		return true;
+	}
+	return false;
+}
+
 bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	probes_opcode_t insn;
-	unsigned long addr;
 
 	if (!auprobe->simulate)
 		return false;
@@ -154,9 +242,14 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 {
 	unsigned long orig_ret_vaddr;
 
-	orig_ret_vaddr = procedure_link_pointer(regs);
 	/* Replace the return addr with trampoline addr */
-	procedure_link_pointer_set(regs, trampoline_vaddr);
+	if (is_compat_task()) {
+		orig_ret_vaddr = link_register(regs);
+		link_register_set(regs, trampoline_vaddr);
+	} else {
+		orig_ret_vaddr = procedure_link_pointer(regs);
+		procedure_link_pointer_set(regs, trampoline_vaddr);
+	}
 
 	return orig_ret_vaddr;
 }
diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
index 2393573..cee1496 100644
--- a/lib/probes/arm/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -15,10 +15,7 @@
 
 #include "decode.h"
 #include "decode-arm.h"
-
-#ifdef CONFIG_ARM64
 #include <../../../arm/include/asm/opcodes.h>
-#endif /* CONFIG_ARM64  */
 
 static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
 {
@@ -75,8 +72,13 @@ static void uprobe_set_pc(struct arch_uprobe *auprobe,
 {
 	u32 pcreg = auprobe->pcreg;
 
-	autask->backup = pt_regs_read_reg(regs, pcreg);
-	pt_regs_write_reg(regs, pcreg, instruction_pointer(regs) + 8);
+	if (pcreg == 15) {
+		autask->backup = instruction_pointer(regs);
+		instruction_pointer_set(regs, instruction_pointer(regs) + 8);
+	} else {
+		autask->backup = pt_regs_read_reg(regs, pcreg);
+		pt_regs_write_reg(regs, pcreg, instruction_pointer(regs) + 8);
+	}
 }
 
 static void uprobe_unset_pc(struct arch_uprobe *auprobe,
@@ -84,7 +86,10 @@ static void uprobe_unset_pc(struct arch_uprobe *auprobe,
 			    struct pt_regs *regs)
 {
 	/* PC will be taken care of by common code */
-	pt_regs_write_reg(regs, auprobe->pcreg, autask->backup);
+	if (auprobe->pcreg == 15)
+		instruction_pointer_set(regs, autask->backup);
+	else
+		pt_regs_write_reg(regs, auprobe->pcreg, autask->backup);
 }
 
 static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
@@ -93,8 +98,13 @@ static void uprobe_aluwrite_pc(struct arch_uprobe *auprobe,
 {
 	u32 pcreg = auprobe->pcreg;
 
-	alu_write_pc(pt_regs_read_reg(regs, pcreg), regs);
-	pt_regs_write_reg(regs, pcreg, autask->backup);
+	if (pcreg == 15) {
+		alu_write_pc(instruction_pointer(regs), regs);
+		instruction_pointer_set(regs, autask->backup);
+	} else {
+		alu_write_pc(pt_regs_read_reg(regs, pcreg), regs);
+		pt_regs_write_reg(regs, pcreg, autask->backup);
+	}
 }
 
 static void uprobe_write_pc(struct arch_uprobe *auprobe,
@@ -103,8 +113,13 @@ static void uprobe_write_pc(struct arch_uprobe *auprobe,
 {
 	u32 pcreg = auprobe->pcreg;
 
-	load_write_pc(pt_regs_read_reg(regs, pcreg), regs);
-	pt_regs_write_reg(regs, pcreg, autask->backup);
+	if (pcreg == 15) {
+		load_write_pc(instruction_pointer(regs), regs);
+		instruction_pointer_set(regs, autask->backup);
+	} else {
+		load_write_pc(pt_regs_read_reg(regs, pcreg), regs);
+		pt_regs_write_reg(regs, pcreg, autask->backup);
+	}
 }
 
 enum probes_insn
diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
index 36eb939..2f2a810 100644
--- a/lib/probes/arm/decode-arm.c
+++ b/lib/probes/arm/decode-arm.c
@@ -87,11 +87,18 @@ void __kprobes simulate_blx2bx(probes_opcode_t insn,
 		struct arch_probes_insn *asi, struct pt_regs *regs)
 {
 	int rm = insn & 0xf;
-	long rmv = pt_regs_read_reg(regs, rm);
+	long rmv;
 	long cpsr;
 
+	if (rm == 15)
+		rmv = (long) instruction_pointer(regs);
+	else
+		rmv = pt_regs_read_reg(regs, rm);
+
 	if (insn & (1 << 5))
-		link_register_set(regs, (long) instruction_pointer(regs));
+		link_register_set(regs,
+				(long) instruction_pointer(regs)
+					+ ARM_COMPAT_LR_OFFSET);
 
 	instruction_pointer_set(regs, rmv & ~0x1);
 	cpsr = state_register(regs) & ~PSR_T_BIT;
@@ -108,7 +115,10 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
 	int rd = (insn >> 12) & 0xf;
 	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
 
-	pt_regs_write_reg(regs, rd, state_register(regs) & mask);
+	if (rd == 15)
+		instruction_pointer_set(regs, state_register(regs) & mask);
+	else
+		pt_regs_write_reg(regs, rd, state_register(regs) & mask);
 }
 
 void __kprobes simulate_mov_ipsp(probes_opcode_t insn,
-- 
2.7.4

