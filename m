Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A55C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543E3218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfAaPAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:00:11 -0500
Received: from foss.arm.com ([217.140.101.70]:45760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731754AbfAaPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:00:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66E91684;
        Thu, 31 Jan 2019 07:00:10 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDE0A3F59C;
        Thu, 31 Jan 2019 07:00:08 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v10 23/25] arm64: Skip preemption when exiting an NMI
Date:   Thu, 31 Jan 2019 14:59:01 +0000
Message-Id: <1548946743-38979-24-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of an NMI should not set any TIF flags. For NMIs received from
EL0 the current exit path is safe to use.

However, an NMI received at EL1 could have interrupted some task context
that has set the TIF_NEED_RESCHED flag. Preempting a task should not
happen as a result of an NMI.

Skip preemption after handling an NMI from EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 35a47f6..acf1250 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -624,7 +624,15 @@ el1_irq:
 
 #ifdef CONFIG_PREEMPT
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
-	cbnz	x24, 1f				// preempt count != 0
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	x24, x24, x0
+alternative_else_nop_endif
+	cbnz	x24, 1f				// preempt count != 0 || NMI return path
 	bl	el1_preempt
 1:
 #endif
-- 
1.9.1

