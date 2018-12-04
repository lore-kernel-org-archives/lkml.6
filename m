Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8AD2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ErFn7Utm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8AD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLDBhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:37:00 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17625 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeLDBg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:36:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c05da380000>; Mon, 03 Dec 2018 17:36:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 17:36:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Dec 2018 17:36:56 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:36:56 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:36:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Dec 2018 01:36:56 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c05da380000>; Mon, 03 Dec 2018 17:36:56 -0800
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple ARM SMMU's identically
Date:   Mon, 3 Dec 2018 17:36:50 -0800
Message-ID: <1543887414-18209-3-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543887416; bh=s8JdRXlCfFf/VUjvXGNSRSzU2Q30F9CtI7YcJoh1QzI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ErFn7UtmclIt02KWXZu69bBLvpQ0cpBH4GnIbyYcQGWPmdHIt/VnQQjjEsXjJP1fq
         Bsb9Tn2Z5ZdceBZOlZYqPmIosUmCs1Tq8383DF2ZKzdjzlsnaaIs3TNztF6fp1Lnnl
         eq5wbfCZQdtq8ieRyBR+ksVC1nfXt0SsVe/m8A0PvDe3FZ1d/G9qLpezA3a3tj1U55
         f91b/ji3SaagDyaOCSjtfHkXJvcSr2pbfE2GVTdbdT2cE2oqPpMvOZl+pYfbO3cBwy
         IFfXWzxgQ43RnAKr65VGmSE98HCqOQqHuAxcvSk0bfRUYlTy16iQEzkzGxdRqQyN9c
         iG8Zh5JI9L8Ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to program multiple ARM SMMU's identically as one SMMU device.
Tegra194 uses Two ARM SMMU's as one SMMU device and both ARM SMMU's need
to be programmed identically.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/lib-arm-smmu.c | 191 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/lib-arm-smmu.c b/drivers/iommu/lib-arm-smmu.c
index 6aba5db..7036763 100644
--- a/drivers/iommu/lib-arm-smmu.c
+++ b/drivers/iommu/lib-arm-smmu.c
@@ -69,9 +69,9 @@
  * therefore this actually makes more sense than it might first appear.
  */
 #ifdef CONFIG_64BIT
-#define smmu_write_atomic_lq		writeq_relaxed
+#define smmu_write_atomic_lq		writeq_all_relaxed
 #else
-#define smmu_write_atomic_lq		writel_relaxed
+#define smmu_write_atomic_lq		writel_all_relaxed
 #endif
 
 /* Translation context bank */
@@ -135,6 +135,48 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+#define to_smmu_intance(smmu, inst, addr) \
+	(addr - smmu->bases[0] + smmu->bases[inst])
+
+static void writel_all(struct arm_smmu_device *smmu,
+		       u32 value, void __iomem *addr)
+{
+	int i;
+
+	writel(value, addr);
+	for (i = 1; i < smmu->num_smmus; i++) {
+		void __iomem *reg_addr = to_smmu_intance(smmu, i, addr);
+
+		writel(value, reg_addr);
+	}
+}
+
+static void writel_all_relaxed(struct arm_smmu_device *smmu,
+			       u32 value, void __iomem *addr)
+{
+	int i;
+
+	writel_relaxed(value, addr);
+	for (i = 1; i < smmu->num_smmus; i++) {
+		void __iomem *reg_addr = to_smmu_intance(smmu, i, addr);
+
+		writel_relaxed(value, reg_addr);
+	}
+}
+
+static void writeq_all_relaxed(struct arm_smmu_device *smmu,
+			       u64 value, void __iomem *addr)
+{
+	int i;
+
+	writeq_relaxed(value, addr);
+	for (i = 1; i < smmu->num_smmus; i++) {
+		void __iomem *reg_addr = to_smmu_intance(smmu, i, addr);
+
+		writeq_relaxed(value, reg_addr);
+	}
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -179,25 +221,37 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 
 static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
 {
-	void __iomem *base = ARM_SMMU_GR0(smmu);
+	int i;
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu->global_sync_lock, flags);
-	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
-			    base + ARM_SMMU_GR0_sTLBGSTATUS);
+	for (i = 0; i < smmu->num_smmus; i++) {
+		void __iomem *base = ARM_SMMU_GR0(smmu);
+
+		if (i > 0)
+			base = to_smmu_intance(smmu, i, base);
+		__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
+				    base + ARM_SMMU_GR0_sTLBGSTATUS);
+	}
 	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
 }
 
 static void arm_smmu_tlb_sync_context(void *cookie)
 {
+	int i;
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
-	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
-			    base + ARM_SMMU_CB_TLBSTATUS);
+	for (i = 0; i < smmu->num_smmus; i++) {
+		void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+
+		if (i > 0)
+			base = to_smmu_intance(smmu, i, base);
+		__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
+				    base + ARM_SMMU_CB_TLBSTATUS);
+	}
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 }
 
@@ -212,13 +266,14 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	/*
 	 * NOTE: this is not a relaxed write; it needs to guarantee that PTEs
 	 * cleared by the current CPU are visible to the SMMU before the TLBI.
 	 */
-	writel(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
+	writel_all(smmu, cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
@@ -229,7 +284,7 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 	void __iomem *base = ARM_SMMU_GR0(smmu);
 
 	/* NOTE: see above */
-	writel(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
+	writel_all(smmu, smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 	arm_smmu_tlb_sync_global(smmu);
 }
 
@@ -237,11 +292,12 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 				size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
-	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	void __iomem *reg = ARM_SMMU_CB(smmu, cfg->cbndx);
 
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
 	if (stage1) {
@@ -251,7 +307,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			iova &= ~12UL;
 			iova |= cfg->asid;
 			do {
-				writel_relaxed(iova, reg);
+				writel_all_relaxed(smmu, iova, reg);
 				iova += granule;
 			} while (size -= granule);
 		} else {
@@ -267,7 +323,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
 		do {
-			smmu_write_atomic_lq(iova, reg);
+			smmu_write_atomic_lq(smmu, iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 	}
@@ -283,12 +339,13 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 				size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	void __iomem *base = ARM_SMMU_GR0(smmu_domain->smmu);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_GR0(smmu);
 
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
-	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
+	writel_all_relaxed(smmu, smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 
 static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
@@ -309,7 +366,8 @@ static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
 
-irqreturn_t arm_smmu_context_fault(int irq, void *dev)
+static irqreturn_t __arm_smmu_context_fault(int irq, void *dev,
+					    void __iomem *cb_base)
 {
 	u32 fsr, fsynr;
 	unsigned long iova;
@@ -317,9 +375,7 @@ irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	void __iomem *cb_base;
 
-	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
 
 	if (!(fsr & FSR_FAULT))
@@ -336,11 +392,33 @@ irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t arm_smmu_global_fault(int irq, void *dev)
+static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
+{
+	int i;
+	irqreturn_t irq_ret = IRQ_NONE;
+	struct iommu_domain *domain = dev;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	for (i = 0; i < smmu->num_smmus; i++) {
+		void __iomem *cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
+
+		if (i > 0)
+			cb_base = to_smmu_intance(smmu, i, cb_base);
+		irq_ret = __arm_smmu_context_fault(irq, dev, cb_base);
+		if (irq_ret == IRQ_HANDLED)
+			break;
+	}
+
+	return irq_ret;
+}
+
+static irqreturn_t __arm_smmu_global_fault(int irq, void *dev,
+					   void __iomem *gr0_base)
 {
-	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
-	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
+	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 
 	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
 	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
@@ -360,6 +438,25 @@ irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+irqreturn_t arm_smmu_global_fault(int irq, void *dev)
+{
+	int i;
+	irqreturn_t irq_ret = IRQ_NONE;
+	struct arm_smmu_device *smmu = dev;
+
+	for (i = 0; i < smmu->num_smmus; i++) {
+		void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
+
+		if (i > 0)
+			gr0_base = to_smmu_intance(smmu, i, gr0_base);
+		irq_ret = __arm_smmu_global_fault(irq, dev, gr0_base);
+		if (irq_ret == IRQ_HANDLED)
+			break;
+	}
+
+	return irq_ret;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -423,7 +520,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* Unassigned context banks only need disabling */
 	if (!cfg) {
-		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
+		writel_all_relaxed(smmu, 0, cb_base + ARM_SMMU_CB_SCTLR);
 		return;
 	}
 
@@ -440,7 +537,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		if (smmu->features & ARM_SMMU_FEAT_VMID16)
 			reg |= cfg->vmid << CBA2R_VMID_SHIFT;
 
-		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(idx));
+		writel_all_relaxed(smmu, reg, gr1_base + ARM_SMMU_GR1_CBA2R(idx));
 	}
 
 	/* CBAR */
@@ -459,7 +556,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		/* 8-bit VMIDs live in CBAR */
 		reg |= cfg->vmid << CBAR_VMID_SHIFT;
 	}
-	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
+	writel_all_relaxed(smmu, reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
 
 	/*
 	 * TTBCR
@@ -467,14 +564,14 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	 * access behaviour of some fields (in particular, ASID[15:8]).
 	 */
 	if (stage1 && smmu->version > ARM_SMMU_V1)
-		writel_relaxed(cb->tcr[1], cb_base + ARM_SMMU_CB_TTBCR2);
-	writel_relaxed(cb->tcr[0], cb_base + ARM_SMMU_CB_TTBCR);
+		writel_all_relaxed(smmu, cb->tcr[1], cb_base + ARM_SMMU_CB_TTBCR2);
+	writel_all_relaxed(smmu, cb->tcr[0], cb_base + ARM_SMMU_CB_TTBCR);
 
 	/* TTBRs */
 	if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
-		writel_relaxed(cfg->asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
-		writel_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
-		writel_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
+		writel_all_relaxed(smmu, cfg->asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
+		writel_all_relaxed(smmu, cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
+		writel_all_relaxed(smmu, cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
 		writeq_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
 		if (stage1)
@@ -484,8 +581,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 
 	/* MAIRs (stage-1 only) */
 	if (stage1) {
-		writel_relaxed(cb->mair[0], cb_base + ARM_SMMU_CB_S1_MAIR0);
-		writel_relaxed(cb->mair[1], cb_base + ARM_SMMU_CB_S1_MAIR1);
+		writel_all_relaxed(smmu, cb->mair[0], cb_base + ARM_SMMU_CB_S1_MAIR0);
+		writel_all_relaxed(smmu, cb->mair[1], cb_base + ARM_SMMU_CB_S1_MAIR1);
 	}
 
 	/* SCTLR */
@@ -495,7 +592,7 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= SCTLR_E;
 
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
+	writel_all_relaxed(smmu, reg, cb_base + ARM_SMMU_CB_SCTLR);
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
@@ -763,7 +860,7 @@ static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
 
 	if (!(smmu->features & ARM_SMMU_FEAT_EXIDS) && smr->valid)
 		reg |= SMR_VALID;
-	writel_relaxed(reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_SMR(idx));
+	writel_all_relaxed(smmu, reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_SMR(idx));
 }
 
 static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
@@ -776,7 +873,7 @@ static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
 	    smmu->smrs[idx].valid)
 		reg |= S2CR_EXIDVALID;
-	writel_relaxed(reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(idx));
+	writel_all_relaxed(smmu, reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(idx));
 }
 
 static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
@@ -1071,9 +1168,9 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
-		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		smmu_write_atomic_lq(smmu, va, cb_base + ARM_SMMU_CB_ATS1PR);
 	else /* Register is only 32-bit in v1 */
-		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		writel_all_relaxed(smmu, va, cb_base + ARM_SMMU_CB_ATS1PR);
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
 				      !(tmp & ATSR_ACTIVE), 5, 50)) {
@@ -1346,7 +1443,7 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* clear global FSR */
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
-	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
+	writel_all(smmu, reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 
 	/*
 	 * Reset stream mapping groups: Initial values mark all SMRn as
@@ -1371,7 +1468,7 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		 * TLB entries for reduced latency.
 		 */
 		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN | ARM_MMU500_ACR_S2CRB_TLBEN;
-		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
+		writel_all_relaxed(smmu, reg, gr0_base + ARM_SMMU_GR0_sACR);
 	}
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
@@ -1379,7 +1476,7 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		void __iomem *cb_base = ARM_SMMU_CB(smmu, i);
 
 		arm_smmu_write_context_bank(smmu, i);
-		writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
+		writel_all_relaxed(smmu, FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
 		/*
 		 * Disable MMU-500's not-particularly-beneficial next-page
 		 * prefetcher for the sake of errata #841119 and #826419.
@@ -1387,13 +1484,13 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		if (smmu->model == ARM_MMU500) {
 			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
 			reg &= ~ARM_MMU500_ACTLR_CPRE;
-			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
+			writel_all_relaxed(smmu, reg, cb_base + ARM_SMMU_CB_ACTLR);
 		}
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
+	writel_all_relaxed(smmu, 0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
+	writel_all_relaxed(smmu, 0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
@@ -1424,7 +1521,7 @@ void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Push the button */
 	arm_smmu_tlb_sync_global(smmu);
-	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel_all(smmu, reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
@@ -1666,6 +1763,6 @@ int arm_smmu_device_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel_all(smmu, sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
-- 
2.1.4

