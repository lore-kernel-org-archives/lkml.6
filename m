Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2482AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F4220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfAaSYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:24:03 -0500
Received: from foss.arm.com ([217.140.101.70]:49376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfAaSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:24:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C92DEBD;
        Thu, 31 Jan 2019 10:24:02 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0B193F59C;
        Thu, 31 Jan 2019 10:24:00 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/3] arm64: entry: Remove unneeded need_resched() loop
Date:   Thu, 31 Jan 2019 18:23:37 +0000
Message-Id: <20190131182339.9835-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131182339.9835-1-valentin.schneider@arm.com>
References: <20190131182339.9835-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/entry.S | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0ec0c46b2c0c..4d0c81f29a60 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -611,7 +611,7 @@ el1_irq:
 #ifdef CONFIG_PREEMPT
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 	cbnz	x24, 1f				// preempt count != 0
-	bl	el1_preempt
+	bl	preempt_schedule_irq		// irq en/disable is done inside
 1:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -620,15 +620,6 @@ el1_irq:
 	kernel_exit 1
 ENDPROC(el1_irq)
 
-#ifdef CONFIG_PREEMPT
-el1_preempt:
-	mov	x24, lr
-1:	bl	preempt_schedule_irq		// irq en/disable is done inside
-	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
-	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
-	ret	x24
-#endif
-
 /*
  * EL0 mode handlers.
  */
-- 
2.20.1

