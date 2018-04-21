Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeDURDs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:03:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42760 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDURDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:03:47 -0400
X-Google-Smtp-Source: AIpwx48fkX2/p0yepXkyhOdnSqy51rIR3j5sXGPVAOA3Kc453lPSKa0cKgtRQXaxJW7aOOyxZp9+uA==
Date: Sat, 21 Apr 2018 22:35:40 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: hughd@google.com, minchan@kernel.org, ying.huang@intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: memory: Introduce new vmf_insert_mixed_mkwrite
Message-ID: <20180421170540.GA17849@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_insert_mixed_mkwrite() has inefficiency when it
returns err, driver has to convert err to vm_fault_t
type. With new vmf_insert_mixed_mkwrite we can handle
this limitation.

As of now vm_insert_mixed_mkwrite() is only getting
invoked from fs/dax.c, so this change has to go first
in linus tree before changes in dax.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/mm.h |  4 ++--
 mm/memory.c        | 15 +++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ac1f06..9fe441c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2423,8 +2423,8 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
-int vm_insert_mixed_mkwrite(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn);
+vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index 01f5464..721cfd5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1955,12 +1955,19 @@ int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_mixed);
 
-int vm_insert_mixed_mkwrite(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn)
+vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, true);
+	int err;
+
+	err =  __vm_insert_mixed(vma, addr, pfn, true);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL(vm_insert_mixed_mkwrite);
+EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
 /*
  * maps a range of physical memory into the requested pages. the old
-- 
1.9.1
