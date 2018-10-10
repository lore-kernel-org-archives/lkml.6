Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFFC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A5521524
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A5521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJJT3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:29:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33132 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJT3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:29:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E918A1A006A;
        Wed, 10 Oct 2018 14:07:50 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2AC91A020F;
        Wed, 10 Oct 2018 14:07:50 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 257FA20604;
        Wed, 10 Oct 2018 14:07:50 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, arnd@arndb.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3 03/22] soc/fsl/qman: map FQD and PFDR areas in the iommu
Date:   Wed, 10 Oct 2018 15:07:21 +0300
Message-Id: <20181010120737.30300-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman private data memory areas
(FQD and PFDR). This is required for QMAN to work without faults
behind an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 619e22030460..0cfe79f85a66 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 u16 qman_ip_rev;
 EXPORT_SYMBOL(qman_ip_rev);
@@ -692,6 +693,7 @@ static int fsl_qman_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct resource *res;
 	int ret, err_irq;
 	u16 id;
@@ -769,6 +771,19 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
 
+	/* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
+		ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
+	}
+
 	ret = qman_init_ccsr(dev);
 	if (ret) {
 		dev_err(dev, "CCSR setup failed\n");
-- 
2.17.1

