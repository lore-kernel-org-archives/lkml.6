Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32159C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4522147C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="E7WISb8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4522147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLCJcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:32:53 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:14192 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLCJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829501; x=1575365501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vH6KcgJi0ANq7McundbRewzxUzs129ERbd9UtM9xeHg=;
  b=E7WISb8UeedAunS/Zj01mYnzfAbSjJtHf121BOvT6xR/Gh259cd3dXJa
   ywEZqZ8G8miyJtPb7Oi5LCYdkDHzAB/32iPU5kXwSsn/kZhywpHl/GtzJ
   Gk4sPYkJftwSb04/5lrgcHoHLeGJaFaUWH6PkHlRUzbJSRz94S2rE+U4b
   s=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="645647387"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:32 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VSUL072849
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:29 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VRvh018124;
        Mon, 3 Dec 2018 10:31:27 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VRTH018123;
        Mon, 3 Dec 2018 10:31:27 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     Filippo Sironi <sironi@amazon.de>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 04/14] X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
Date:   Mon,  3 Dec 2018 10:30:57 +0100
Message-Id: <1543829467-18025-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
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
index 7cf2185..b953545 100644
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

