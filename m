Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B53206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfAHOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:08:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbfAHOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9080C80D;
        Tue,  8 Jan 2019 06:08:56 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9546B3F70D;
        Tue,  8 Jan 2019 06:08:54 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 25/26] arm64: Skip irqflags tracing for NMI in IRQs disabled context
Date:   Tue,  8 Jan 2019 14:07:43 +0000
Message-Id: <1546956464-48825-26-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an NMI is raised while interrupts where disabled, the IRQ tracing
already is in the correct state (i.e. hardirqs_off) and should be left
as such when returning to the interrupted context.

Check whether PMR was masking interrupts when the NMI was raised and
skip IRQ tracing if necessary.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a0b0a22..bd0b078 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -617,7 +617,18 @@ el1_irq:
 	kernel_entry 1
 	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+alternative_else
+	mov	x20, #GIC_PRIO_IRQON
+alternative_endif
+	cmp	x20, #GIC_PRIO_IRQOFF
+	/* Irqs were disabled, don't trace */
+	b.ls	1f
+#endif
 	bl	trace_hardirqs_off
+1:
 #endif
 
 	irq_handler
@@ -637,8 +648,18 @@ alternative_else_nop_endif
 1:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	/*
+	 * if IRQs were disabled when we received the interrupt, we have an NMI
+	 * and we are not re-enabling interrupt upon eret. Skip tracing.
+	 */
+	cmp	x20, #GIC_PRIO_IRQOFF
+	b.ls	1f
+#endif
 	bl	trace_hardirqs_on
+1:
 #endif
+
 	kernel_exit 1
 ENDPROC(el1_irq)
 
-- 
1.9.1

