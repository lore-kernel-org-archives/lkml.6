Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E69C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482C21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ufK2D5Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfAaU2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:28:22 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24204 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfAaU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966423; x=1580502423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IsQIxzG6cbItOicp55m744yHgpadEsDovfCXfzq+GpQ=;
  b=ufK2D5WfVTKySUXlpEaRA3VJWDOKueL0rGPy87PXd4OsGNdDQIWRGJnN
   swN9d26syvf7Oj4s8JPIuW5uTeesPwGpdykLsDWzQLjfODO9DIioj0aJq
   aNK8hpRd+szbZ1E2ZXNx1r6ZaBer7bZRMGQEnqRNkvWeZsU1+c5CB44e0
   Q=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822774"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 20:26:57 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VKQos4102116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:26:52 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQn0G028898;
        Thu, 31 Jan 2019 21:26:49 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQnTC028894;
        Thu, 31 Jan 2019 21:26:49 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Filippo Sironi <sironi@amazon.de>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 03/14] X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
Date:   Thu, 31 Jan 2019 21:24:33 +0100
Message-Id: <1548966284-28642-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
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

