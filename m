Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A21C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F523F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F523F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGDVug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:50:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:64679 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753154AbeGDVuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:50:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="213480094"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2018 14:50:31 -0700
Subject: [PATCH v5 02/11] device-dax: Enable page_mapping()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jan Kara <jack@suse.cz>, hch@lst.de, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:40:34 -0700
Message-ID: <153074043405.27838.13174871137034713893.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of enabling memory_failure() handling for device-dax
mappings, set the ->mapping association of pages backing device-dax
mappings. The rmap implementation requires page_mapping() to return the
address_space hosting the vmas that map the page.

The ->mapping pointer is never cleared. There is no possibility for the
page to become associated with another address_space while the device is
enabled. When the device is disabled the 'struct page' array for the
device is destroyed / later reinitialized to zero.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/device.c |   55 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index ad5e7b4a15dc..95cfcfd612df 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -245,12 +245,11 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 }
 
 static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
-				struct vm_fault *vmf)
+				struct vm_fault *vmf, pfn_t *pfn)
 {
 	struct device *dev = &dev_dax->dev;
 	struct dax_region *dax_region;
 	phys_addr_t phys;
-	pfn_t pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -272,20 +271,19 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
-				struct vm_fault *vmf)
+				struct vm_fault *vmf, pfn_t *pfn)
 {
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	struct device *dev = &dev_dax->dev;
 	struct dax_region *dax_region;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -321,22 +319,21 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
 
-	return vmf_insert_pfn_pmd(vmf->vma, vmf->address, vmf->pmd, pfn,
+	return vmf_insert_pfn_pmd(vmf->vma, vmf->address, vmf->pmd, *pfn,
 			vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
-				struct vm_fault *vmf)
+				struct vm_fault *vmf, pfn_t *pfn)
 {
 	unsigned long pud_addr = vmf->address & PUD_MASK;
 	struct device *dev = &dev_dax->dev;
 	struct dax_region *dax_region;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -373,14 +370,14 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
 
-	return vmf_insert_pfn_pud(vmf->vma, vmf->address, vmf->pud, pfn,
+	return vmf_insert_pfn_pud(vmf->vma, vmf->address, vmf->pud, *pfn,
 			vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
-				struct vm_fault *vmf)
+				struct vm_fault *vmf, pfn_t *pfn)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -389,8 +386,10 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
-	int rc, id;
 	struct file *filp = vmf->vma->vm_file;
+	unsigned long fault_size;
+	int rc, id;
+	pfn_t pfn;
 	struct dev_dax *dev_dax = filp->private_data;
 
 	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) size = %d\n", current->comm,
@@ -400,17 +399,39 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 	id = dax_read_lock();
 	switch (pe_size) {
 	case PE_SIZE_PTE:
-		rc = __dev_dax_pte_fault(dev_dax, vmf);
+		fault_size = PAGE_SIZE;
+		rc = __dev_dax_pte_fault(dev_dax, vmf, &pfn);
 		break;
 	case PE_SIZE_PMD:
-		rc = __dev_dax_pmd_fault(dev_dax, vmf);
+		fault_size = PMD_SIZE;
+		rc = __dev_dax_pmd_fault(dev_dax, vmf, &pfn);
 		break;
 	case PE_SIZE_PUD:
-		rc = __dev_dax_pud_fault(dev_dax, vmf);
+		fault_size = PUD_SIZE;
+		rc = __dev_dax_pud_fault(dev_dax, vmf, &pfn);
 		break;
 	default:
 		rc = VM_FAULT_SIGBUS;
 	}
+
+	if (rc == VM_FAULT_NOPAGE) {
+		unsigned long i;
+
+		/*
+		 * In the device-dax case the only possibility for a
+		 * VM_FAULT_NOPAGE result is when device-dax capacity is
+		 * mapped. No need to consider the zero page, or racing
+		 * conflicting mappings.
+		 */
+		for (i = 0; i < fault_size / PAGE_SIZE; i++) {
+			struct page *page;
+
+			page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
+			if (page->mapping)
+				continue;
+			page->mapping = filp->f_mapping;
+		}
+	}
 	dax_read_unlock(id);
 
 	return rc;

