Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34302084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34302084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeH1ToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:15 -0400
Received: from foss.arm.com ([217.140.101.70]:40944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1ToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AE41684;
        Tue, 28 Aug 2018 08:51:58 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40CB03F557;
        Tue, 28 Aug 2018 08:51:56 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v5 04/27] arm64: daifflags: Use irqflags functions for daifflags
Date:   Tue, 28 Aug 2018 16:51:14 +0100
Message-Id: <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the work done in daifflags save/restore is already provided
by irqflags functions. Daifflags should always be a superset of irqflags
(it handles irq status + status of other flags). Modifying behaviour of
irqflags should alter the behaviour of daifflags.

Use irqflags_save/restore functions for the corresponding daifflags
operation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 22e4c83..8d91f22 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -36,11 +36,8 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;
 
-	asm volatile(
-		"mrs	%0, daif		// local_daif_save\n"
-		: "=r" (flags)
-		:
-		: "memory");
+	flags = arch_local_save_flags();
+
 	local_daif_mask();
 
 	return flags;
@@ -60,11 +57,9 @@ static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
 		trace_hardirqs_on();
-	asm volatile(
-		"msr	daif, %0		// local_daif_restore"
-		:
-		: "r" (flags)
-		: "memory");
+
+	arch_local_irq_restore(flags);
+
 	if (arch_irqs_disabled_flags(flags))
 		trace_hardirqs_off();
 }
-- 
1.9.1

