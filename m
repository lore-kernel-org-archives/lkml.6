Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B439C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E4920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E4920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFTNxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:25 -0400
Received: from foss.arm.com ([217.140.101.70]:37482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753644AbeFTNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D562480D;
        Wed, 20 Jun 2018 06:53:22 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034BF3F578;
        Wed, 20 Jun 2018 06:53:15 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 3/7] irqchip/gic-v3-its: Move minimum LPI requirements to individual busses
Date:   Wed, 20 Jun 2018 14:52:30 +0100
Message-Id: <20180620135234.32101-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the core ITS driver imposes the allocation to be
in chunks of 32. As we want to relax this on a per bus basis, let's
move the the the allocation constraints to each bus.

No functionnal change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |  3 +++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  6 ++++--
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  2 ++
 drivers/irqchip/irq-gic-v3-its.c              | 11 +++++++----
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 4eca5c763766..606efa64adff 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -45,6 +45,9 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 	 */
 	info->scratchpad[0].ul = mc_bus_dev->icid;
 	msi_info = msi_get_domain_info(msi_domain->parent);
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
 	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 25a98de5cfb2..75c3cafabc6a 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -86,8 +86,10 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
 
-	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, max(nvec, alias_count), info);
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max(nvec, alias_count);
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
 }
 
 static struct msi_domain_ops its_pci_msi_ops = {
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 8881a053c173..7b8e87b493fe 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -73,6 +73,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = dev_id;
 
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
 	return msi_info->ops->msi_prepare(domain->parent,
 					  dev, nvec, info);
 }
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c98e49f8c341..cfe65776bb4c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2179,12 +2179,15 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (!its_alloc_device_table(its, dev_id))
 		return NULL;
 
+	if (WARN_ON(!is_power_of_2(nvecs)))
+		nvecs = roundup_pow_of_two(nvecs);
+
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
-	 * We allocate at least one chunk worth of LPIs bet device,
-	 * and thus that many ITEs. The device may require less though.
+	 * Even if the device wants a single LPI, the ITT must be
+	 * sized as a power of two (and you need at least one bit...).
 	 */
-	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
+	nr_ites = max(2, nvecs);
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
@@ -2833,7 +2836,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 	BUG_ON(!vm);
 
-	bitmap = its_lpi_alloc_chunks(nr_irqs, &base, &nr_ids);
+	bitmap = its_lpi_alloc_chunks(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
 
-- 
2.17.1

