Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30699208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="duLg/Imo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30699208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeIZSZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48451 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeIZSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:25:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121217euoutp0129e7cca67346be2142ac392cec9cca02~X8g2Cdhr72985529855euoutp01Y;
        Wed, 26 Sep 2018 12:12:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926121217euoutp0129e7cca67346be2142ac392cec9cca02~X8g2Cdhr72985529855euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963937;
        bh=2/Z7m7WUc7C3MdpGLYqOQp+M/wvsuhI5WqFMeq1JK/s=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=duLg/ImofGt4SCGqz90/PZBiwl4IvOcGiPBNvnrfXTOqXS6O/rHh0xof7liN9iY6h
         sIm03CKteois6Ee1ooPd8sb5P48sPY8AgKP0q1Yf3HQ6YfXkB+4uWDZ2OCmWXYYAsK
         UU4VBXkqHNegEk1Ki++2PDmF6hd5Vc09ImofXLCo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121216eucas1p1f6ecf320f6f4746624bb44c38b38709a~X8g1RsZNR0974609746eucas1p1T;
        Wed, 26 Sep 2018 12:12:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 50.3E.04806.0A77BAB5; Wed, 26
        Sep 2018 13:12:16 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926121216eucas1p28c13ab1a21ac5ef5058206b92954604f~X8g0jVjVq1327013270eucas1p2B;
        Wed, 26 Sep 2018 12:12:16 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-93-5bab77a022a6
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.7D.04284.F977BAB5; Wed, 26
        Sep 2018 13:12:15 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:15 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 4/7] arm64: change arm64 probes handler prototype
Date:   Wed, 26 Sep 2018 14:12:02 +0200
Message-id: <1537963925-25313-5-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djP87oLyldHG3y6I2PRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfHqQmnBfZuKzb/62RoYPxp1MXJy
        SAiYSHy/d5Cti5GLQ0hgBaPEn0uvGCGcz4wSry4/YYOpWrqmjxnEFhJYxihxeX0FhP2fUeLK
        swAQm03AXGL70RYWEFtEwE3iRmMHE8ggZoHLTBKXT3QzgSSEBVwkVrbcYQexWQRUJVpmn2YE
        sXkF/CW6W+8wQyyTk7h5rhPM5hQIkDg0fQUzyCAJgcdsEps7H7JDFLlIfDz5EapBWOLV8S1Q
        cRmJzo6DTBB2ucTuEzfZIZpbGCWmNh6ASlhL/Fk1Eew1ZgE+iUnbpgMN4gCK80p0tAlBlHhI
        fH05iwkSFIsZJeb83MIygVFyASPDKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMAkcPrf
        8a87GPf9STrEKMDBqMTDy2G7KlqINbGsuDL3EKMEB7OSCC932epoId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rx8WmnRQgLpiSWp2ampBalFMFkmDk6pBsazD+O0Tnm+nb5y4gGH6cfEL/Qv7lB8
        sKJHWoTF62LvyeOWasUS26dYvdsXNEXnrmHxL434Rk0ph4gpzsYNE2JjJReXChYfWNV5v9+p
        r+Fd58cbzfMbLlSvCzU1m91bsoNz/a0vAlfOrMmccDRIPvtPXNzFP24lL48lRoc/4fjz2vhw
        5oeSqQZKLMUZiYZazEXFiQDh30X4/gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xa7rzy1dHG7zZY2PRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfHqQmnBfZuKzb/62RoYPxp1MXJy
        SAiYSCxd08cMYgsJLGGUuDyPqYuRC8huZJLYdL4XLMEmYC6x/WgLC4gtIuAmcaOxA6yIWeAy
        k8TnBXtZQRLCAi4SK1vusIPYLAKqEi2zTzOC2LwC/hLdrXeYIbbJSdw81wlmcwoESByavgJq
        s7/ElZMzWSYw8ixgZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGMDbjv3cvIPx0sbgQ4wC
        HIxKPLwctquihVgTy4orcw8xSnAwK4nwcpetjhbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96g
        MkpIID2xJDU7NbUgtQgmy8TBKdXAGH5p99PIjo2r3y4NefWCfxnvetOLU9dJi24+svO1lr2W
        m4cFx69475qslRfapHzeCk96uUzANHHJ3kczD4g69Z/reBGyeI0e20srb9Ot9Sf38eqkh978
        x/CTPyHmzTNWXtWCCvsF78zfHH6Xlmx45sqRt+/DLi/dtr6hONpgoUHdAVt2Mc6q6UosxRmJ
        hlrMRcWJACWAtStcAgAA
X-CMS-MailID: 20180926121216eucas1p28c13ab1a21ac5ef5058206b92954604f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121216eucas1p28c13ab1a21ac5ef5058206b92954604f
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121216eucas1p28c13ab1a21ac5ef5058206b92954604f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A probes_handler_t() handler function prototype differ between ARM32 and
ARM64 arch subtrees. Make ARM64 prototype the same as ARM32 prototype and
adjust the ARM64 code to work with the new prototype.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/include/asm/probes.h          |  6 +++++-
 arch/arm64/kernel/probes/kprobes.c       |  2 +-
 arch/arm64/kernel/probes/simulate-insn.c | 32 ++++++++++++++++++++++++--------
 arch/arm64/kernel/probes/simulate-insn.h | 24 ++++++++++++++++--------
 arch/arm64/kernel/probes/uprobes.c       |  3 +--
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 6a5b289..1747e9a 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -16,7 +16,11 @@
 #define _ARM_PROBES_H
 
 typedef u32 probe_opcode_t;
-typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
+struct arch_probe_insn;
+
+typedef void (probes_handler_t) (u32 opcode,
+			   struct arch_probe_insn *api,
+			   struct pt_regs *);
 
 /* architecture specific copy of original instruction */
 struct arch_probe_insn {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index e78c3ef..3988967 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -69,7 +69,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (p->ainsn.api.handler)
-		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
+		p->ainsn.api.handler((u32)p->opcode, &p->ainsn.api, regs);
 
 	/* single step simulated, now go for post processing */
 	post_kprobe_handler(kcb, regs);
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index be05868..22dc7a7 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -92,9 +92,11 @@ static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
  * instruction simulation functions
  */
 void __kprobes
-simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
+simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	long imm, xn, val;
+	long addr = instruction_pointer(regs);
 
 	xn = opcode & 0x1f;
 	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
@@ -110,9 +112,11 @@ simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = bbl_displacement(opcode);
+	long addr = instruction_pointer(regs);
 
 	/* Link register is x30 */
 	if (opcode & (1 << 31))
@@ -122,9 +126,11 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (aarch32_opcode_cond_checks[opcode & 0xf](regs->pstate & 0xffffffff))
 		disp = bcond_displacement(opcode);
@@ -133,9 +139,11 @@ simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
+simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int xn = (opcode >> 5) & 0x1f;
+	long addr = instruction_pointer(regs);
 
 	/* update pc first in case we're doing a "blr lr" */
 	instruction_pointer_set(regs, get_x_reg(regs, xn));
@@ -146,9 +154,11 @@ simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_cbnz(opcode, regs))
@@ -161,9 +171,11 @@ simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_tbnz(opcode, regs))
@@ -176,11 +188,13 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	u64 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (u64 *) (addr + disp);
@@ -194,11 +208,13 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	s32 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (s32 *) (addr + disp);
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index 050bde6..31b3840 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -16,13 +16,21 @@
 #ifndef _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 #define _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 
-void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 636ca01..a83642c 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -112,10 +112,9 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		return false;
 
 	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
-	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
-		auprobe->api.handler(insn, addr, regs);
+		auprobe->api.handler(insn, &auprobe->api, regs);
 
 	return true;
 }
-- 
2.7.4

