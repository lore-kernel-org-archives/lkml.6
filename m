Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375CAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0015A2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0015A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeI1PGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:06:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50668 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeI1PGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:06:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0844320010E;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EF1D5200007;
        Fri, 28 Sep 2018 10:43:39 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AE6B2039E;
        Fri, 28 Sep 2018 10:43:39 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2 1/5] soc/fsl/qbman: Check if CPU is offline when initializing portals
Date:   Fri, 28 Sep 2018 11:43:20 +0300
Message-Id: <1538124204-31406-2-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Pledge <roy.pledge@nxp.com>

If the CPU to affine the portal interrupt is offline at boot time
affine the portal interrupt to another online CPU. If the CPU is later
brought online the hotplug handler will correctly adjust the affinity.
Moved common code in a function.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c     |  6 ++----
 drivers/soc/fsl/qbman/dpaa_sys.h | 20 ++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c     |  6 ++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485cedc648..f84ab596bde8 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -562,11 +562,9 @@ static int bman_create_portal(struct bman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
+
+	if (dpaa_set_portal_irq_affinity(c->dev, c->irq, c->cpu))
 		goto fail_affinity;
-	}
 
 	/* Need RCR to be empty before continuing */
 	ret = bm_rcr_get_fill(p);
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 9f379000da85..ae8afa552b1e 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -111,4 +111,24 @@ int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 #define QBMAN_MEMREMAP_ATTR	MEMREMAP_WC
 #endif
 
+static inline int dpaa_set_portal_irq_affinity(struct device *dev,
+					       int irq, int cpu)
+{
+	int ret = 0;
+
+	if (!irq_can_set_affinity(irq)) {
+		dev_err(dev, "unable to set IRQ affinity\n");
+		return -EINVAL;
+	}
+
+	if (cpu == -1 || !cpu_online(cpu))
+		cpu = cpumask_any(cpu_online_mask);
+
+	ret = irq_set_affinity(irq, cpumask_of(cpu));
+	if (ret)
+		dev_err(dev, "irq_set_affinity() on CPU %d failed\n", cpu);
+
+	return ret;
+}
+
 #endif	/* __DPAA_SYS_H */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ecb22749df0b..0ffe7a1d0eae 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1210,11 +1210,9 @@ static int qman_create_portal(struct qman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
+
+	if (dpaa_set_portal_irq_affinity(c->dev, c->irq, c->cpu))
 		goto fail_affinity;
-	}
 
 	/* Need EQCR to be empty before continuing */
 	isdr &= ~QM_PIRQ_EQCI;
-- 
2.1.0

