Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EB2223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EB2223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbeKLVvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:51:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKLVvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:51:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0205015BF;
        Mon, 12 Nov 2018 03:58:16 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 363A83F5A0;
        Mon, 12 Nov 2018 03:58:14 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 22/24] arm64: Skip preemption when exiting an NMI
Date:   Mon, 12 Nov 2018 11:57:13 +0000
Message-Id: <1542023835-21446-23-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eb8120e..e02ee55 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -636,6 +636,14 @@ el1_irq:
 
 #ifdef CONFIG_PREEMPT
 	ldr	w24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	w24, w24, w0
+alternative_else_nop_endif
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get flags
 	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
-- 
1.9.1

