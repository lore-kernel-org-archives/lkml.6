Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9609DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D60C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D60C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeIZTfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:35:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59500 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbeIZTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CC6F1A0251;
        Wed, 26 Sep 2018 15:22:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0000F1A004C;
        Wed, 26 Sep 2018 15:22:54 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A292203C2;
        Wed, 26 Sep 2018 15:22:54 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 08/22] soc/fsl/qbman_portals: add APIs to retrieve the probing status
Date:   Wed, 26 Sep 2018 16:22:33 +0300
Message-Id: <20180926132247.10971-9-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
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
Drivers that use qman/bman portal driver services are required to use
these APIs before calling any functions exported by these drivers or
otherwise they will crash the kernel.
First user will be the dpaa1 ethernet driver, coming in a subsequent
patch.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 10 ++++++++++
 drivers/soc/fsl/qbman/qman_portal.c | 10 ++++++++++
 include/soc/fsl/bman.h              |  8 ++++++++
 include/soc/fsl/qman.h              |  9 +++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index f9edd28894fd..8048d35de8a2 100644
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
@@ -148,6 +155,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 	spin_lock(&bman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
 	if (cpu >= nr_cpu_ids) {
+		__bman_portals_probed = 1;
 		/* unassigned portal, skip init */
 		spin_unlock(&bman_lock);
 		return 0;
@@ -173,6 +181,8 @@ static int bman_portal_probe(struct platform_device *pdev)
 err_ioremap2:
 	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
+	 __bman_portals_probed = 1;
+
 	return -ENXIO;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index eef93cab84f1..1b2fc981c269 100644
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
@@ -306,6 +313,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 	spin_lock(&qman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
 	if (cpu >= nr_cpu_ids) {
+		__qman_portals_probed = 1;
 		/* unassigned portal, skip init */
 		spin_unlock(&qman_lock);
 		return 0;
@@ -336,6 +344,8 @@ static int qman_portal_probe(struct platform_device *pdev)
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

