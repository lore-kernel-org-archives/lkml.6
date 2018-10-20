Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682DECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0252174A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iDgYcj/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0252174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJUGey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:34:54 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49228 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeJUGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074174; x=1571610174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=flonjFCGOLn0zOW5pISWCF/H9UYRV+aVRKitwTiaW5M=;
  b=iDgYcj/NLmmPXZxtEkk4pUaSeLdM4pTtpUq5u6WOt78CL8r1lQrY9EYv
   eQfRPYzOE9Ku3g1UtbhF0e+GD9YbnU9vYpO+gOXdBJ1e5XHyUqEE6rYjv
   h3VNjFrrUzRJlrkDTMVLo3+OTMalt+lmr2x3JEsrUU54BwZqTIgI9wTTZ
   8=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="765266627"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:52 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMmHc051471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:49 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMlNY031603;
        Sun, 21 Oct 2018 00:22:47 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMkl4031602;
        Sun, 21 Oct 2018 00:22:46 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     Filippo Sironi <sironi@amazon.de>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 04/13] X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
Date:   Sun, 21 Oct 2018 00:22:16 +0200
Message-Id: <1540074145-31285-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
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
index 14ffd97..8f7bc8f 100644
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

