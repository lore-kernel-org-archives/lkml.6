Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C07C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3897720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3897720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeHaMXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:23:52 -0400
Received: from foss.arm.com ([217.140.101.70]:53924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbeHaMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:23:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17454168F;
        Fri, 31 Aug 2018 01:17:35 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9FBD3F721;
        Fri, 31 Aug 2018 01:17:33 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 4/4] irqdesc: Add domain handler for NMIs
Date:   Fri, 31 Aug 2018 09:17:17 +0100
Message-Id: <1535703437-9453-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
References: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
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
 include/linux/irqdesc.h |  5 +++++
 kernel/irq/irqdesc.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40d..ba05b0d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -171,6 +171,11 @@ static inline int handle_domain_irq(struct irq_domain *domain,
 {
 	return __handle_domain_irq(domain, hwirq, true, regs);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
+int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
+		      struct pt_regs *regs);
+#endif
 #endif
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5..58934ea 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -665,6 +665,41 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	set_irq_regs(old_regs);
 	return ret;
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
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
+#endif
 #endif
 
 /* Dynamic interrupt handling */
-- 
1.9.1

