Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1527DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABCA223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABCA223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeKLVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:51:07 -0500
Received: from foss.arm.com ([217.140.101.70]:34762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKLVvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:51:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47BD31650;
        Mon, 12 Nov 2018 03:58:09 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34A083F5A0;
        Mon, 12 Nov 2018 03:58:07 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v6 19/24] irqchip/gic: Add functions to access irq priorities
Date:   Mon, 12 Nov 2018 11:57:10 +0000
Message-Id: <1542023835-21446-20-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add accessors to the GIC distributor/redistributors priority registers.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 10 ++++++++++
 drivers/irqchip/irq-gic-common.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 01e673c..910746f 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -98,6 +98,16 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	return ret;
 }
 
+void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio)
+{
+	writeb_relaxed(prio, base + GIC_DIST_PRI + irq);
+}
+
+u8 gic_get_irq_prio(unsigned int irq, void __iomem *base)
+{
+	return readb_relaxed(base + GIC_DIST_PRI + irq);
+}
+
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void))
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3919cd7..1586dbd 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -35,6 +35,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
+void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio);
+u8 gic_get_irq_prio(unsigned int irq, void __iomem *base);
 
 void gic_set_kvm_info(const struct gic_kvm_info *info);
 
-- 
1.9.1

