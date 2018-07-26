Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76583C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1949F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PSTCLHHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1949F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGZPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:54:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y9L6sVyCND3pCUBTkFzMbfyGpy1+MFBmetZ8xMn3P9k=; b=PSTCLHHat97cO2Pkyn3kKwypV
        F8xZus8U/PDiAYtMGPn1wAFbRfBD1vo9uNeJhCiH5EmQNyXsI6qUE4RysGu/GaEAys2MTs27P6CzN
        5BYZwEhsncOSQh3NSSz6lBYo5+RyPOUHp2c9DNkSUZRSjKYfAVnZJfsxkwUbzXEAzcwP0QTBnsLrk
        qNTpqG1pRMCospGex3jb6hNuIB5ZdIQBg0PdX5L1ZeLYFQE0pmKinjgbVKjQg0rP/tbkJCohp14d3
        iY7EBrs9mmMpKrahARInm6BPiI6lYnTLhKdn7lrrO69sqB8vyPvNmDGFJ9cel2Z9pF3XZDv/lrWV3
        utW8bXAPQ==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOi-0005mO-5N; Thu, 26 Jul 2018 14:37:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 5/9] RISC-V: implement low-level interrupt handling
Date:   Thu, 26 Jul 2018 16:37:19 +0200
Message-Id: <20180726143723.16585-6-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
References: <20180726143723.16585-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a routine that dispatches exceptions with the interrupt
flags set to either the IPI or irqdomain code (and the clock source in the
future).

Loosely based on the irq-riscv-int.c irqchip driver from the RISC-V tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/entry.S |  4 +--
 arch/riscv/kernel/irq.c   | 52 ++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 9aaf6c986771..fa2c08e3c05e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -168,8 +168,8 @@ ENTRY(handle_exception)
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	REG_L a1, handle_arch_irq
-	jr a1
+	move a1, s4 /* scause */
+	tail do_IRQ
 1:
 	/* Exceptions run with interrupts enabled */
 	csrs sstatus, SR_SIE
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7bcdaed15703..ab5f3e22c7cc 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -1,21 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
- *
- *   This program is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License
- *   as published by the Free Software Foundation, version 2.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
+ * Copyright (C) 2018 Christoph Hellwig
  */
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 
+/*
+ * Possible interrupt causes:
+ */
+#define INTERRUPT_CAUSE_SOFTWARE    1
+#define INTERRUPT_CAUSE_TIMER       5
+#define INTERRUPT_CAUSE_EXTERNAL    9
+
+/*
+ * The high order bit of the trap cause register is always set for
+ * interrupts, which allows us to differentiate them from exceptions
+ * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
+ * need to mask it off.
+ */
+#define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
+
+asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
+#ifdef CONFIG_SMP
+	case INTERRUPT_CAUSE_SOFTWARE:
+		/*
+		 * We only use software interrupts to pass IPIs, so if a non-SMP
+		 * system gets one, then we don't know what to do.
+		 */
+		riscv_software_interrupt();
+		break;
+#endif
+	case INTERRUPT_CAUSE_EXTERNAL:
+		handle_arch_irq(regs);
+		break;
+	default:
+		panic("unexpected interrupt cause");
+	}
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
 void __init init_IRQ(void)
 {
 	irqchip_init();
-- 
2.18.0

