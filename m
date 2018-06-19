Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE22C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B494520836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B494520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757252AbeFSL4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:56:13 -0400
Received: from foss.arm.com ([217.140.101.70]:48408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757233AbeFSL4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA5715BE;
        Tue, 19 Jun 2018 04:56:10 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF50E3F557;
        Tue, 19 Jun 2018 04:56:09 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 3/6] irqchip/gic-v2m: Fix SPI release on error path
Date:   Tue, 19 Jun 2018 12:55:43 +0100
Message-Id: <20180619115546.12196-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619115546.12196-1-marc.zyngier@arm.com>
References: <20180619115546.12196-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failing to allocate the required SPIs, we should free the actual
number of interrupts, and not its log2 value.

Fixes: de337ee30142 ("irqchip/gic-v2m: Add PCI Multi-MSI support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 0f52d44b3f69..f5fe0100f9ff 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -199,7 +199,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 fail:
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	gicv2m_unalloc_msi(v2m, hwirq, get_count_order(nr_irqs));
+	gicv2m_unalloc_msi(v2m, hwirq, nr_irqs);
 	return err;
 }
 
-- 
2.17.1

