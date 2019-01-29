Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F99D20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfA2NK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:10:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfA2NK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:10:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 493922D077169EA4E213;
        Tue, 29 Jan 2019 21:10:54 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Jan 2019 21:10:46 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <julien.thierry@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <marc.zyngier@arm.com>,
        <daniel.thompson@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <dave.martin@arm.com>,
        <mark.rutland@arm.com>, <jason@lakedaemon.net>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>,
        <thunder.leizhen@huawei.com>
Subject: [PATCH] arm64: fix potential deadlock in arm64-provide-pseudo-NMI-with-GICv3
Date:   Tue, 29 Jan 2019 21:12:23 +0800
Message-ID: <20190129131223.32505-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some exception handlers, the interrupt is not reenabled by daifclr at first.
The later process may call local_irq_enable() to enable the interrupt, like
gic_handle_irq(). As we known, function local_irq_enable() just change the pmr now.
The following codes what i found may cause a deadlock or some issues else:

do_sp_pc_abort			<- el0_sp_pc
do_el0_ia_bp_hardening	<- el0_ia
kgdb_roundup_cpus		<- el1_dbg

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/kernel/kgdb.c | 4 ++++
 arch/arm64/mm/fault.c    | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a20de58061a8..119fbf2c0788 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -25,6 +25,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -291,6 +292,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 
 void kgdb_roundup_cpus(unsigned long flags)
 {
+	if (gic_prio_masking_enabled())
+		gic_arch_enable_irqs();
+
 	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
 	local_irq_disable();
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 97ba2ba78aee..f7c39a0b28bc 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -780,6 +781,8 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();
 
+	if (gic_prio_masking_enabled())
+		gic_arch_enable_irqs();
 	local_irq_enable();
 	do_mem_abort(addr, esr, regs);
 }
@@ -794,6 +797,9 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
+
+		if (gic_prio_masking_enabled())
+			gic_arch_enable_irqs();
 		local_irq_enable();
 	}
 
-- 
2.17.1

