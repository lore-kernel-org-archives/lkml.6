Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19064C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B208D20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B208D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933507AbeGIQOl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:14:41 -0400
Received: from foss.arm.com ([217.140.101.70]:34426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933396AbeGIQO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:14:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE7E1713;
        Mon,  9 Jul 2018 09:14:27 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56C643F589;
        Mon,  9 Jul 2018 09:14:26 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        marc.zyngier@arm.com, peterz@infradead.org, mingo@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 4/4] irqdesc: Add domain handler for NMIs
Date:   Mon,  9 Jul 2018 17:14:06 +0100
Message-Id: <1531152846-19374-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NMI handling code should be executed between calls to nmi_enter and
nmi_exit.

Add a separate domain handler to properly setup NMI context when handling
an interrupt requested as NMI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/irqdesc.h |  3 +++
 kernel/irq/irqdesc.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40d..7c0a243 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -171,6 +171,9 @@ static inline int handle_domain_irq(struct irq_domain *domain,
 {
 	return __handle_domain_irq(domain, hwirq, true, regs);
 }
+
+int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
+		      struct pt_regs *regs);
 #endif
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index afc7f90..f2b6f9d 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -664,6 +664,39 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	set_irq_regs(old_regs);
 	return ret;
 }
+
+/**
+ * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ * @regs:	Register file coming from the low-level handling code
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ */
+int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
+		      struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned int irq;
+	int ret = 0;
+
+	nmi_enter();
+
+	irq = irq_find_mapping(domain, hwirq);
+
+	/*
+	 * ack_bad_irq is not NMI-safe, just report
+	 * an invalid interrupt.
+	 */
+	if (likely(irq))
+		generic_handle_irq(irq);
+	else
+		ret = -EINVAL;
+
+	nmi_exit();
+	set_irq_regs(old_regs);
+	return ret;
+}
 #endif
 
 /* Dynamic interrupt handling */
-- 
1.9.1

