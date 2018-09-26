Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0FD214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0FD214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeIZTfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:35:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57614 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbeIZTfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31426200255;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24859200253;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D6C2203C2;
        Wed, 26 Sep 2018 15:22:51 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 04/22] soc/fsl/qman-portal: map CENA area in the iommu
Date:   Wed, 26 Sep 2018 16:22:29 +0300
Message-Id: <20180926132247.10971-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman portal CENA register area.
This is required for QMAN stashing to work without faults behind
an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..6d9da3b1b5ad 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 struct qman_portal *qman_dma_portal;
 EXPORT_SYMBOL(qman_dma_portal);
@@ -222,6 +223,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
 	int irq, cpu, err;
@@ -276,6 +278,21 @@ static int qman_portal_probe(struct platform_device *pdev)
 		goto err_ioremap2;
 	}
 
+	/* Create an 1-to-1 iommu mapping for cena portal area */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		/*
+		 * Note: not mapping this as cacheable triggers the infamous
+		 * QMan CIDE error.
+		 */
+		err = iommu_map(domain,
+				addr_phys[0]->start, addr_phys[0]->start,
+				resource_size(addr_phys[0]),
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (err)
+			dev_warn(dev, "failed to iommu_map() %d\n", err);
+	}
+
 	pcfg->pools = qm_get_pools_sdqcr();
 
 	spin_lock(&qman_lock);
-- 
2.17.1

