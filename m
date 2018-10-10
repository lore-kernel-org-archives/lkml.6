Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA9F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJJT3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:29:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59250 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeJJT3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:29:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68E2720015E;
        Wed, 10 Oct 2018 14:07:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6431B200153;
        Wed, 10 Oct 2018 14:07:52 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AC32B20604;
        Wed, 10 Oct 2018 14:07:51 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, arnd@arndb.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3 08/22] soc/fsl/qbman_portals: add APIs to retrieve the probing status
Date:   Wed, 10 Oct 2018 15:07:23 +0300
Message-Id: <20181010120737.30300-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a couple of new APIs to check the probing status of the required
cpu bound qman and bman portals:
 'int bman_portals_probed()' and 'int qman_portals_probed()'.
They return the following values.
 *  1 if qman/bman portals were all probed correctly
 *  0 if qman/bman portals were not yet probed
 * -1 if probing of qman/bman portals failed
Portals are considered successful probed if no error occurred during
the probing of any of the portals and if enough portals were probed
to have one available for each cpu.
The error handling paths were slightly rearranged in order to fit this
new functionality without being too intrusive.
Drivers that use qman/bman portal driver services are required to use
these APIs before calling any functions exported by these drivers or
otherwise they will crash the kernel.
First user will be the dpaa1 ethernet driver, coming in a subsequent
patch.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 22 ++++++++++++++++++----
 drivers/soc/fsl/qbman/qman_portal.c | 23 +++++++++++++++++++----
 include/soc/fsl/bman.h              |  8 ++++++++
 include/soc/fsl/qman.h              |  9 +++++++++
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index f9edd28894fd..6f184a3f51f3 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -32,6 +32,7 @@
 
 static struct bman_portal *affine_bportals[NR_CPUS];
 static struct cpumask portal_cpus;
+static int __bman_portals_probed;
 /* protect bman global registers and global data shared among portals */
 static DEFINE_SPINLOCK(bman_lock);
 
@@ -85,6 +86,12 @@ static int bman_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+int bman_portals_probed(void)
+{
+	return __bman_portals_probed;
+}
+EXPORT_SYMBOL_GPL(bman_portals_probed);
+
 static int bman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -102,8 +109,10 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
-	if (!pcfg)
+	if (!pcfg) {
+		__bman_portals_probed = -1;
 		return -ENOMEM;
+	}
 
 	pcfg->dev = dev;
 
@@ -111,14 +120,14 @@ static int bman_portal_probe(struct platform_device *pdev)
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	pcfg->cpu = -1;
@@ -126,7 +135,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(dev, "Can't get %pOF IRQ'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
 
@@ -154,6 +163,9 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 
 	cpumask_set_cpu(cpu, &portal_cpus);
+	if (!__bman_portals_probed &&
+	    cpumask_weight(&portal_cpus) == num_online_cpus())
+		__bman_portals_probed = 1;
 	spin_unlock(&bman_lock);
 	pcfg->cpu = cpu;
 
@@ -173,6 +185,8 @@ static int bman_portal_probe(struct platform_device *pdev)
 err_ioremap2:
 	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
+	 __bman_portals_probed = -1;
+
 	return -ENXIO;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index eef93cab84f1..c003f54a21e4 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -39,6 +39,7 @@ EXPORT_SYMBOL(qman_dma_portal);
 #define CONFIG_FSL_DPA_PIRQ_FAST  1
 
 static struct cpumask portal_cpus;
+static int __qman_portals_probed;
 /* protect qman global registers and global data shared among portals */
 static DEFINE_SPINLOCK(qman_lock);
 
@@ -219,6 +220,12 @@ static int qman_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+int qman_portals_probed(void)
+{
+	return __qman_portals_probed;
+}
+EXPORT_SYMBOL_GPL(qman_portals_probed);
+
 static int qman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -238,8 +245,10 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
-	if (!pcfg)
+	if (!pcfg) {
+		__qman_portals_probed = -1;
 		return -ENOMEM;
+	}
 
 	pcfg->dev = dev;
 
@@ -247,19 +256,20 @@ static int qman_portal_probe(struct platform_device *pdev)
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	err = of_property_read_u32(node, "cell-index", &val);
 	if (err) {
 		dev_err(dev, "Can't get %pOF property 'cell-index'\n", node);
+		__qman_portals_probed = -1;
 		return err;
 	}
 	pcfg->channel = val;
@@ -267,7 +277,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(dev, "Can't get %pOF IRQ\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
 
@@ -312,6 +322,9 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	cpumask_set_cpu(cpu, &portal_cpus);
+	if (!__qman_portals_probed &&
+	    cpumask_weight(&portal_cpus) == num_online_cpus())
+		__qman_portals_probed = 1;
 	spin_unlock(&qman_lock);
 	pcfg->cpu = cpu;
 
@@ -336,6 +349,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 err_ioremap2:
 	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
+	__qman_portals_probed = -1;
+
 	return -ENXIO;
 }
 
diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
index 5b99cb2ea5ef..173e4049d963 100644
--- a/include/soc/fsl/bman.h
+++ b/include/soc/fsl/bman.h
@@ -133,5 +133,13 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
  * failed to probe or 0 if the bman driver did not probed yet.
  */
 int bman_is_probed(void);
+/**
+ * bman_portals_probed - Check if all cpu bound bman portals are probed
+ *
+ * Returns 1 if all the required cpu bound bman portals successfully probed,
+ * -1 if probe errors appeared or 0 if the bman portals did not yet finished
+ * probing.
+ */
+int bman_portals_probed(void);
 
 #endif	/* __FSL_BMAN_H */
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 597783b8a3a0..7732e48081eb 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1194,4 +1194,13 @@ int qman_release_cgrid(u32 id);
  */
 int qman_is_probed(void);
 
+/**
+ * qman_portals_probed - Check if all cpu bound qman portals are probed
+ *
+ * Returns 1 if all the required cpu bound qman portals successfully probed,
+ * -1 if probe errors appeared or 0 if the qman portals did not yet finished
+ * probing.
+ */
+int qman_portals_probed(void);
+
 #endif	/* __FSL_QMAN_H */
-- 
2.17.1

