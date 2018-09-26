Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46012C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA7214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA7214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeIZTie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:38:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59478 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbeIZTfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF1631A0188;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0D1C1A004C;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 361E0203C2;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 05/22] soc/fsl/qbman: add APIs to retrieve the probing status
Date:   Wed, 26 Sep 2018 16:22:30 +0300
Message-Id: <20180926132247.10971-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a couple of new APIs to check the probing status of qman and bman:
 'int bman_is_probed()' and 'int qman_is_probed()'.
They return the following values.
 *  1 if qman/bman were probed correctly
 *  0 if qman/bman were not yet probed
 * -1 if probing of qman/bman failed
Drivers that use qman/bman driver services are required to use these
APIs before calling any functions exported by qman or bman drivers
or otherwise they will crash the kernel.
The APIs will be used in the following couple of qbman portal patches
and later in the series in the dpaa1 ethernet driver.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c | 11 +++++++++++
 include/soc/fsl/bman.h            |  8 ++++++++
 include/soc/fsl/qman.h            |  8 ++++++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index d180da003e4a..b209c79511bb 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -121,6 +121,7 @@ static void bm_set_memory(u64 ba, u32 size)
  */
 static dma_addr_t fbpr_a;
 static size_t fbpr_sz;
+static int __bman_probed;
 
 static int bman_fbpr(struct reserved_mem *rmem)
 {
@@ -167,6 +168,12 @@ static irqreturn_t bman_isr(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
+int bman_is_probed(void)
+{
+	return __bman_probed;
+}
+EXPORT_SYMBOL_GPL(bman_is_probed);
+
 static int fsl_bman_probe(struct platform_device *pdev)
 {
 	int ret, err_irq;
@@ -177,6 +184,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
 	u16 id, bm_pool_cnt;
 	u8 major, minor;
 
+	__bman_probed = -1;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
@@ -266,6 +275,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	__bman_probed = 1;
+
 	return 0;
 };
 
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 0cfe79f85a66..383a49dcce68 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -274,6 +274,7 @@ static const struct qman_error_info_mdata error_mdata[] = {
 static u32 __iomem *qm_ccsr_start;
 /* A SDQCR mask comprising all the available/visible pool channels */
 static u32 qm_pools_sdqcr;
+static int __qman_probed;
 
 static inline u32 qm_ccsr_in(u32 offset)
 {
@@ -689,6 +690,12 @@ static int qman_resource_init(struct device *dev)
 	return 0;
 }
 
+int qman_is_probed(void)
+{
+	return __qman_probed;
+}
+EXPORT_SYMBOL_GPL(qman_is_probed);
+
 static int fsl_qman_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -699,6 +706,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	u16 id;
 	u8 major, minor;
 
+	__qman_probed = -1;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
@@ -845,6 +854,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	__qman_probed = 1;
+
 	return 0;
 }
 
diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
index eaaf56df4086..5b99cb2ea5ef 100644
--- a/include/soc/fsl/bman.h
+++ b/include/soc/fsl/bman.h
@@ -126,4 +126,12 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num);
  */
 int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
 
+/**
+ * bman_is_probed - Check if bman is probed
+ *
+ * Returns 1 if the bman driver successfully probed, -1 if the bman driver
+ * failed to probe or 0 if the bman driver did not probed yet.
+ */
+int bman_is_probed(void);
+
 #endif	/* __FSL_BMAN_H */
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index d4dfefdee6c1..597783b8a3a0 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1186,4 +1186,12 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
  */
 int qman_release_cgrid(u32 id);
 
+/**
+ * qman_is_probed - Check if qman is probed
+ *
+ * Returns 1 if the qman driver successfully probed, -1 if the qman driver
+ * failed to probe or 0 if the qman driver did not probed yet.
+ */
+int qman_is_probed(void);
+
 #endif	/* __FSL_QMAN_H */
-- 
2.17.1

