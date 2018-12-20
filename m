Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565D21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeLTIYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:45 -0500
Received: from ozlabs.ru ([107.173.13.209]:54618 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbeLTIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:44 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id A2404AE80337;
        Thu, 20 Dec 2018 03:24:40 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 13/20] powerpc/powernv/npu: Convert NPU IOMMU helpers to iommu_table_group_ops
Date:   Thu, 20 Dec 2018 19:23:43 +1100
Message-Id: <20181220082350.58113-14-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment NPU IOMMU is manipulated directly from the IODA2 PCI
PE code; PCI PE acts as a master to NPU PE. Soon we will have compound
IOMMU groups with several PEs from several different PHB (such as
interconnected GPUs and NPUs) so there will be no single master but
a one big IOMMU group.

This makes a first step and converts an NPU PE with a set of extern
function to a table group.

This should cause no behavioral change. Note that
pnv_npu_release_ownership() has never been implemented.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/powernv/pci.h      |  5 ----
 arch/powerpc/platforms/powernv/npu-dma.c  | 34 ++++++++++++++++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++--
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index ddb4f02..cf9f748 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -216,11 +216,6 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
-extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
-		struct iommu_table *tbl);
-extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
-extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
-extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
 
 /* pci-ioda-tce.c */
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 26063fb..dc629ee 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -121,9 +121,14 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
 	return pe;
 }
 
-long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
+static long pnv_npu_unset_window(struct iommu_table_group *table_group,
+		int num);
+
+static long pnv_npu_set_window(struct iommu_table_group *table_group, int num,
 		struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc;
 	const unsigned long size = tbl->it_indirect_levels ?
@@ -134,7 +139,7 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 
 	/* NPU has just one TVE so if there is another table, remove it first */
 	if (npe->table_group.tables[num2])
-		pnv_npu_unset_window(npe, num2);
+		pnv_npu_unset_window(&npe->table_group, num2);
 
 	pe_info(npe, "Setting up window %llx..%llx pg=%lx\n",
 			start_addr, start_addr + win_size - 1,
@@ -160,8 +165,10 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 	return 0;
 }
 
-long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
+static long pnv_npu_unset_window(struct iommu_table_group *table_group, int num)
 {
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc;
 
@@ -206,7 +213,8 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 	if (!gpe)
 		return;
 
-	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
+	rc = pnv_npu_set_window(&npe->table_group, 0,
+			gpe->table_group.tables[0]);
 
 	/*
 	 * NVLink devices use the same TCE table configuration as
@@ -231,7 +239,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 	if (phb->type != PNV_PHB_NPU_NVLINK || !npe->pdev)
 		return -EINVAL;
 
-	rc = pnv_npu_unset_window(npe, 0);
+	rc = pnv_npu_unset_window(&npe->table_group, 0);
 	if (rc != OPAL_SUCCESS)
 		return rc;
 
@@ -284,9 +292,12 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
 	}
 }
 
+#ifdef CONFIG_IOMMU_API
 /* Switch ownership from platform code to external user (e.g. VFIO) */
-void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
+static void pnv_npu_take_ownership(struct iommu_table_group *table_group)
 {
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc;
 
@@ -297,7 +308,7 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
 	 * if it was enabled at the moment of ownership change.
 	 */
 	if (npe->table_group.tables[0]) {
-		pnv_npu_unset_window(npe, 0);
+		pnv_npu_unset_window(&npe->table_group, 0);
 		return;
 	}
 
@@ -312,6 +323,12 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
 	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
 }
 
+static struct iommu_table_group_ops pnv_pci_npu_ops = {
+	.set_window = pnv_npu_set_window,
+	.unset_window = pnv_npu_unset_window,
+	.take_ownership = pnv_npu_take_ownership,
+};
+
 struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 {
 	struct pnv_phb *phb = npe->phb;
@@ -322,6 +339,8 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 	if (!gpe || !gpdev)
 		return NULL;
 
+	npe->table_group.ops = &pnv_pci_npu_ops;
+
 	list_for_each_entry(npdev, &pbus->devices, bus_list) {
 		gptmp = pnv_pci_get_gpu_dev(npdev);
 
@@ -334,6 +353,7 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 
 	return gpe;
 }
+#endif /* !CONFIG_IOMMU_API */
 
 /*
  * NPU2 ATS
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1ee3c5d6..6972054 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2672,12 +2672,13 @@ static struct pnv_ioda_pe *gpe_table_group_to_npe(
 static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
 		int num, struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
 	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
 
 	if (ret)
 		return ret;
 
-	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num, tbl);
+	ret = npe->table_group.ops->set_window(&npe->table_group, num, tbl);
 	if (ret)
 		pnv_pci_ioda2_unset_window(table_group, num);
 
@@ -2688,17 +2689,20 @@ static long pnv_pci_ioda2_npu_unset_window(
 		struct iommu_table_group *table_group,
 		int num)
 {
+	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
 	long ret = pnv_pci_ioda2_unset_window(table_group, num);
 
 	if (ret)
 		return ret;
 
-	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
+	return npe->table_group.ops->unset_window(&npe->table_group, num);
 }
 
 static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
 {
-	pnv_npu_take_ownership(gpe_table_group_to_npe(table_group));
+	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
+
+	npe->table_group.ops->take_ownership(&npe->table_group);
 	pnv_ioda2_take_ownership(table_group);
 }
 
-- 
2.17.1

