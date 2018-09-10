Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999DF2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ay7pcf4d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TWmKgt5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999DF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIJLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:19:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeIJLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:19:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D776060B0D; Mon, 10 Sep 2018 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536560796;
        bh=kI6TdBBJNmw2T8z2d65Ar/djqQB/Ly8nyPWFA9W7aNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ay7pcf4dhSxn2O6tLRsyzLKvCW7X79UvDukMVDnLXgAXXOwSU7NjVtVUXtFkEgpMr
         l+oqwuydDIZF0gacPdBtIiugTh+Wb0lRLzgV8/HEOiweM1DHadyb8CeyD1ygnCKwq3
         A/Z5LwnIM5osl7k42uIABOj0lQhJUntSlvY+CToA=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DD60608BF;
        Mon, 10 Sep 2018 06:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536560791;
        bh=kI6TdBBJNmw2T8z2d65Ar/djqQB/Ly8nyPWFA9W7aNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWmKgt5TBmTNjmQEW/C+VU8mxhhqc9uQR7YMo49JNOanulKBQe4oEkDy9PSFH1gp4
         ggijHG+ZMlcnBOGP/RrveaBiWbACEWDasP4xW/TbwGSTSTkLjnBRnSQXukFaKbtU3l
         9GIYfJ53H0VeeP06EdDECEUznxjb887uPLg8YFdQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DD60608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 4/4] iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
Date:   Mon, 10 Sep 2018 11:55:51 +0530
Message-Id: <20180910062551.28175-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's implementation of arm,mmu-500 require to serialize all
TLB invalidations for context banks.
In case the TLB invalidation requests don't go through the first
time, there's a way to disable/enable the wait for safe logic.
Disabling this logic expadites the TLBIs.

Different bootloaders with their access control policies allow this
register access differntly. With one, we should be able to directly
make qcom-scm call to do io read/write, while with other we should
use the specific SCM command to send request to do the complete
register configuration.
A separate device tree flag for arm-smmu will allow to identify
which firmware configuration of the two mentioned above we use.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu-regs.h |   2 +
 drivers/iommu/arm-smmu.c      | 133 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..71662cae9806 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -177,6 +177,8 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_SMMU_CB_ATS1PR		0x800
 #define ARM_SMMU_CB_ATSR		0x8f0
 
+#define ARM_SMMU_GID_QCOM_CUSTOM_CFG	0x300
+
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
 #define SCTLR_CFIE			(1 << 6)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 411e5ac57c64..de9c4a5bf686 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -49,6 +49,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/qcom_scm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -181,7 +182,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_EXIDS		(1 << 12)
 	u32				features;
 
-#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_SECURE_CFG_ACCESS	 (1 << 0)
+#define ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
@@ -266,6 +268,7 @@ static bool using_legacy_binding, using_generic_binding;
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA, "qcom,smmu-500-fw-impl-errata" },
 	{ 0, NULL},
 };
 
@@ -531,12 +534,134 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 
+#define CUSTOM_CFG_MDP_SAFE_ENABLE		BIT(15)
+#define CUSTOM_CFG_IFE1_SAFE_ENABLE		BIT(14)
+#define CUSTOM_CFG_IFE0_SAFE_ENABLE		BIT(13)
+
+static int __qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu, int en)
+{
+	int ret;
+	u32 val, gid_phys_base;
+	phys_addr_t reg;
+	struct vm_struct *vm;
+
+	/* We want physical address of SMMU, so the vm_area */
+	vm = find_vm_area(smmu->base);
+
+	/*
+	 * GID (implementation defined address space) is located at
+	 * SMMU_BASE + (2 × PAGESIZE).
+	 */
+	gid_phys_base = vm->phys_addr + (2 << (smmu)->pgshift);
+	reg = gid_phys_base + ARM_SMMU_GID_QCOM_CUSTOM_CFG;
+
+	ret = qcom_scm_io_readl_atomic(reg, &val);
+	if (ret)
+		return ret;
+
+	if (en)
+		val |= CUSTOM_CFG_MDP_SAFE_ENABLE |
+		       CUSTOM_CFG_IFE0_SAFE_ENABLE |
+		       CUSTOM_CFG_IFE1_SAFE_ENABLE;
+	else
+		val &= ~(CUSTOM_CFG_MDP_SAFE_ENABLE |
+			 CUSTOM_CFG_IFE0_SAFE_ENABLE |
+			 CUSTOM_CFG_IFE1_SAFE_ENABLE);
+
+	ret = qcom_scm_io_writel_atomic(reg, val);
+
+	return ret;
+}
+
+static int qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu,
+				     int en, bool is_fw_impl)
+{
+	if (is_fw_impl)
+		return qcom_scm_qsmmu500_wait_safe_toggle(en);
+	else
+		return __qsmmu500_wait_safe_toggle(smmu, en);
+}
+
+static void qcom_errata_tlb_sync(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+	bool is_fw_impl;
+	u32 val;
+
+	writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
+
+	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
+				       !(val & sTLBGSTATUS_GSACTIVE), 0, 100))
+		return;
+
+	is_fw_impl = smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA ?
+			true : false;
+
+	/* SCM call here to disable the wait-for-safe logic. */
+	if (WARN(qsmmu500_wait_safe_toggle(smmu, false, is_fw_impl),
+		 "Failed to disable wait-safe logic, bad hw state\n"))
+		return;
+
+	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
+				       !(val & sTLBGSTATUS_GSACTIVE), 0, 10000))
+		return;
+
+	/* SCM call here to re-enable the wait-for-safe logic. */
+	WARN(qsmmu500_wait_safe_toggle(smmu, true, is_fw_impl),
+	     "Failed to re-enable wait-safe logic, bad hw state\n");
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU in bad state\n");
+}
+
+static void qcom_errata_tlb_sync_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	qcom_errata_tlb_sync(smmu_domain);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static void qcom_errata_tlb_inv_context_s1(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
+	qcom_errata_tlb_sync(cookie);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static void qcom_errata_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					     size_t granule, bool leaf,
+					     void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
 static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
+static const struct iommu_gather_ops qcom_errata_s1_tlb_ops = {
+	.tlb_flush_all	= qcom_errata_tlb_inv_context_s1,
+	.tlb_add_flush	= qcom_errata_tlb_inv_range_nosync,
+	.tlb_sync	= qcom_errata_tlb_sync_context,
+};
+
 static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
@@ -824,7 +949,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
+		if (of_device_is_compatible(smmu->dev->of_node,
+					    "qcom,sdm845-smmu-500"))
+			smmu_domain->tlb_ops = &qcom_errata_s1_tlb_ops;
+		else
+			smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

