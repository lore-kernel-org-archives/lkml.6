Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05480C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BD12088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BD12088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeH1Tou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4130615BF;
        Tue, 28 Aug 2018 08:52:33 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C8473F557;
        Tue, 28 Aug 2018 08:52:30 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 19/27] irqchip/gic-v3: Remove acknowledge loop
Date:   Tue, 28 Aug 2018 16:51:29 +0100
Message-Id: <1535471497-38854-20-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple interrupts pending for a CPU is actually rare. Doing an
acknowledge loop does not give much better performance or even can
deteriorate them.

Do not loop when an interrupt has been acknowledged, just return
from interrupt and wait for another one to be raised.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 65 +++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 162c49c..a467fcf 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -348,48 +348,45 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;

-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();

-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;

-			if (static_branch_likely(&supports_deactivate_key))
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+		else
+			isb();
+
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_branch_likely(&supports_deactivate_key)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_branch_likely(&supports_deactivate_key)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_branch_likely(&supports_deactivate_key))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+	}
 }

 static u32 gic_get_pribits(void)
--
1.9.1
