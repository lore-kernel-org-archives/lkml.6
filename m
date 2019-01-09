Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8159C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7890A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pubBVEM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfAIJmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:25 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7747 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfAIJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026943; x=1578562943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IsQIxzG6cbItOicp55m744yHgpadEsDovfCXfzq+GpQ=;
  b=pubBVEM9PryNa/OfHHuGh+4Odx1VuqAIrmvMUVf9xxUG6/zhjIMNBgFa
   K60exyx4AfqYbc1xQ1DxATBSkSfd29RLcyagx0FTPCAXtnXo7HUaol5VU
   g20CSo81fXJpxiPryLkYc2Lo1OfLODgxc8UhbdKW4HtKM0Cq7Kw17tgv+
   4=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="775449722"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Jan 2019 09:42:19 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 5B13CA297B;
        Wed,  9 Jan 2019 09:42:19 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gHGx031303;
        Wed, 9 Jan 2019 10:42:17 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gHJM031302;
        Wed, 9 Jan 2019 10:42:17 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     Filippo Sironi <sironi@amazon.de>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 03/13] X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
Date:   Wed,  9 Jan 2019 10:42:03 +0100
Message-Id: <1547026933-31226-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

cmpxchg_gpte() calls get_user_pages_fast() to retrieve the number of
pages and the respective struct page to map in the kernel virtual
address space.
This doesn't work if get_user_pages_fast() is invoked with a userspace
virtual address that's backed by PFNs outside of kernel reach (e.g., when
limiting the kernel memory with mem= in the command line and using
/dev/mem to map memory).

If get_user_pages_fast() fails, look up the VMA that back the userspace
virtual address, compute the PFN and the physical address, and map it in
the kernel virtual address space with memremap().

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/paging_tmpl.h | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39..c40af67 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -141,15 +141,35 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	struct page *page;
 
 	npages = get_user_pages_fast((unsigned long)ptep_user, 1, 1, &page);
-	/* Check if the user is doing something meaningless. */
-	if (unlikely(npages != 1))
-		return -EFAULT;
-
-	table = kmap_atomic(page);
-	ret = CMPXCHG(&table[index], orig_pte, new_pte);
-	kunmap_atomic(table);
-
-	kvm_release_page_dirty(page);
+	if (likely(npages == 1)) {
+		table = kmap_atomic(page);
+		ret = CMPXCHG(&table[index], orig_pte, new_pte);
+		kunmap_atomic(table);
+
+		kvm_release_page_dirty(page);
+	} else {
+		struct vm_area_struct *vma;
+		unsigned long vaddr = (unsigned long)ptep_user & PAGE_MASK;
+		unsigned long pfn;
+		unsigned long paddr;
+
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
+		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
+			up_read(&current->mm->mmap_sem);
+			return -EFAULT;
+		}
+		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+		paddr = pfn << PAGE_SHIFT;
+		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
+		if (!table) {
+			up_read(&current->mm->mmap_sem);
+			return -EFAULT;
+		}
+		ret = CMPXCHG(&table[index], orig_pte, new_pte);
+		memunmap(table);
+		up_read(&current->mm->mmap_sem);
+	}
 
 	return (ret != orig_pte);
 }
-- 
2.7.4

