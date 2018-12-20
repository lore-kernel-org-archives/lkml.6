Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC5721773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbeLTIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:28 -0500
Received: from ozlabs.ru ([107.173.13.209]:54358 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbeLTIY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:27 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id DAA7EAE802FB;
        Thu, 20 Dec 2018 03:24:22 -0500 (EST)
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
Subject: [PATCH kernel v7 08/20] powerpc/pseries: Remove IOMMU API support for non-LPAR systems
Date:   Thu, 20 Dec 2018 19:23:38 +1100
Message-Id: <20181220082350.58113-9-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_dma_bus_setup_pSeries and pci_dma_dev_setup_pSeries hooks are
registered for the pseries platform which does not have FW_FEATURE_LPAR;
these would be pre-powernv platforms which we never supported PCI pass
through for anyway so remove it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index cbcc8ce..2783cb7 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -645,7 +645,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
 	iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -756,10 +755,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		iommu_init_table(tbl, phb->node);
-		iommu_register_group(PCI_DN(dn)->table_group,
-				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, tbl);
-		iommu_add_device(&dev->dev);
 		return;
 	}
 
@@ -770,11 +766,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	while (dn && PCI_DN(dn) && PCI_DN(dn)->table_group == NULL)
 		dn = dn->parent;
 
-	if (dn && PCI_DN(dn)) {
+	if (dn && PCI_DN(dn))
 		set_iommu_table_base(&dev->dev,
 				PCI_DN(dn)->table_group->tables[0]);
-		iommu_add_device(&dev->dev);
-	} else
+	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
 }
-- 
2.17.1

