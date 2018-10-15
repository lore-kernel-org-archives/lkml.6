Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F60C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A282089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="leBpmpr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A282089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeJOTvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:51:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43214 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbeJOTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:51:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FC4sfY015460;
        Mon, 15 Oct 2018 05:05:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=KZ35JQWM/Wq8FbORwZA+A/NzZONHOaqj3Sc8XfTbtHE=;
 b=leBpmpr1cs/cKfObP3ZOxRD+pmf1/5BX4WIMF7/zHMGVE4yZbks0tdkbwCGEKXHvWzdy
 gl6LgAOKlD/U5fXFMd+tzn7wFh0g7l6djQvrMAhvLmIDYrJPlNMiEdq5ekcl4bh4Y3qN
 XM6H6f6DA4nejCahauVYH1mbDNFDVspUnNVcoxwiFDQYwhO+jyyywbPQ+dl9iZH7TiB2
 yBfxIDU/9SKSRVW8+a8ES+HD5jFyJu7wHB96rEyni8zBiPhaD9m+aOZ11l9OxUAMYFDU
 L9/bnoFA7TMRpChwuZOZFvYg+Rcc2BuosgEdSZMljfME7rH1bysl8DIiIiWCQDFZqk2k Xw== 
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0a-0016f401.pphosted.com with ESMTP id 2n4pmqgrdf-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 05:05:34 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 15 Oct
 2018 15:05:21 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 15 Oct 2018 05:05:21 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id C7EDD3F7040;
        Mon, 15 Oct 2018 05:05:16 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <corbet@lwn.net>,
        <joro@8bytes.org>, <robh+dt@kernel.org>,
        <gregory.clement@bootlin.com>, <mark.rutland@arm.com>,
        <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <nadavh@marvell.com>,
        <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 1/4] iommu/arm-smmu: introduce wrapper for writeq/readq
Date:   Mon, 15 Oct 2018 15:00:43 +0300
Message-ID: <1539604846-21151-2-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

This patch introduce the smmu_writeq_relaxed/smmu_readq_relaxed
helpers, as preparation to add specific Marvell work-around for
accessing 64bit width registers of ARM SMMU.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fd1b80e..fccb1d4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -88,9 +88,11 @@
  * therefore this actually makes more sense than it might first appear.
  */
 #ifdef CONFIG_64BIT
-#define smmu_write_atomic_lq		writeq_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					smmu_writeq_relaxed(smmu, val, reg)
 #else
-#define smmu_write_atomic_lq		writel_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					writel_relaxed(val, reg)
 #endif
 
 /* Translation context bank */
@@ -270,6 +272,19 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
+				       u64 val,
+				       void __iomem *addr)
+{
+	writeq_relaxed(val, addr);
+}
+
+static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
+				     void __iomem *addr)
+{
+	return readq_relaxed(addr);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -465,6 +480,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					  size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
@@ -483,7 +499,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			iova >>= 12;
 			iova |= (u64)cfg->asid << 48;
 			do {
-				writeq_relaxed(iova, reg);
+				smmu_writeq_relaxed(smmu, iova, reg);
 				iova += granule >> 12;
 			} while (size -= granule);
 		}
@@ -492,7 +508,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
 		do {
-			smmu_write_atomic_lq(iova, reg);
+			smmu_write_atomic_lq(smmu, iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 	}
@@ -548,7 +564,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		return IRQ_NONE;
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	iova = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_FAR);
 
 	dev_err_ratelimited(smmu->dev,
 	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
@@ -698,9 +714,11 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		writel_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
 		writel_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
-		writeq_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
+		smmu_writeq_relaxed(smmu, cb->ttbr[0],
+				    cb_base + ARM_SMMU_CB_TTBR0);
 		if (stage1)
-			writeq_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
+			smmu_writeq_relaxed(smmu, cb->ttbr[1],
+					    cb_base + ARM_SMMU_CB_TTBR1);
 	}
 
 	/* MAIRs (stage-1 only) */
@@ -1279,7 +1297,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
-		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		smmu_write_atomic_lq(smmu, va, cb_base + ARM_SMMU_CB_ATS1PR);
 	else /* Register is only 32-bit in v1 */
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
@@ -1292,7 +1310,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		return ops->iova_to_phys(ops, iova);
 	}
 
-	phys = readq_relaxed(cb_base + ARM_SMMU_CB_PAR);
+	phys = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_PAR);
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 	if (phys & CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
-- 
1.9.1

