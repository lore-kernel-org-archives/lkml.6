Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CBC20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CBC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeFTNxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:53:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754446AbeFTNxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:53:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB94D15B2;
        Wed, 20 Jun 2018 06:53:49 -0700 (PDT)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.31.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B657D3F578;
        Wed, 20 Jun 2018 06:53:44 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        MaJun <majun258@huawei.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 7/7] irqchip/gic-v3-its: Reduce minimum LPI allocation to 1 for PCI devices
Date:   Wed, 20 Jun 2018 14:52:34 +0100
Message-Id: <20180620135234.32101-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620135234.32101-1-marc.zyngier@arm.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating a minimum of 32 LPIs per PCI device, let's reduce it to
be just 1, as most devices do not need that many interrupts.

We still have to special-case DevID 0, as there is plenty of broken
HW around where the PCI RID is not presented as a DevID to the ITS,
and all the devices are presented as DevID 0. In this case, we keep
the 32 minimal allocation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 75c3cafabc6a..8d6d009d1d58 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -66,7 +66,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct pci_dev *pdev, *alias_dev;
 	struct msi_domain_info *msi_info;
-	int alias_count = 0;
+	int alias_count = 0, minnvec = 1;
 
 	if (!dev_is_pci(dev))
 		return -EINVAL;
@@ -86,9 +86,17 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
 
-	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
 	nvec = max(nvec, alias_count);
-	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+	if (!info->scratchpad[0].ul)
+		minnvec = 32;
+	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
 	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
 }
 
-- 
2.17.1

