Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBEBeJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:34:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44145 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbeBEB3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:18 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 35/64] arch/ia64: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:25 +0100
Message-Id: <20180205012754.23615-36-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This becomes quite straightforward with the mmrange in place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/ia64/kernel/perfmon.c | 10 +++++-----
 arch/ia64/mm/fault.c       |  8 ++++----
 arch/ia64/mm/init.c        | 13 +++++++------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 858602494096..53cde97fe67a 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2244,7 +2244,7 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 	struct vm_area_struct *vma = NULL;
 	unsigned long size;
 	void *smpl_buf;
-
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	/*
 	 * the fixed header + requested size and align to page boundary
@@ -2307,13 +2307,13 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 	 * now we atomically find some area in the address space and
 	 * remap the buffer in it.
 	 */
-	down_write(&task->mm->mmap_sem);
+	mm_write_lock(task->mm, &mmrange);
 
 	/* find some free area in address space, must have mmap sem held */
 	vma->vm_start = get_unmapped_area(NULL, 0, size, 0, MAP_PRIVATE|MAP_ANONYMOUS);
 	if (IS_ERR_VALUE(vma->vm_start)) {
 		DPRINT(("Cannot find unmapped area for size %ld\n", size));
-		up_write(&task->mm->mmap_sem);
+		mm_write_unlock(task->mm, &mmrange);
 		goto error;
 	}
 	vma->vm_end = vma->vm_start + size;
@@ -2324,7 +2324,7 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 	/* can only be applied to current task, need to have the mm semaphore held when called */
 	if (pfm_remap_buffer(vma, (unsigned long)smpl_buf, vma->vm_start, size)) {
 		DPRINT(("Can't remap buffer\n"));
-		up_write(&task->mm->mmap_sem);
+		mm_write_unlock(task->mm, &mmrange);
 		goto error;
 	}
 
@@ -2335,7 +2335,7 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 	insert_vm_struct(mm, vma);
 
 	vm_stat_account(vma->vm_mm, vma->vm_flags, vma_pages(vma));
-	up_write(&task->mm->mmap_sem);
+	mm_write_unlock(task->mm, &mmrange);
 
 	/*
 	 * keep track of user level virtual address
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 44f0ec5f77c2..9d379a9a9a5c 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -126,7 +126,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	if (mask & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	vma = find_vma_prev(mm, address, &prev_vma);
 	if (!vma && !prev_vma )
@@ -203,7 +203,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
   check_expansion:
@@ -234,7 +234,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	goto good_area;
 
   bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 #ifdef CONFIG_VIRTUAL_MEM_MAP
   bad_area_no_up:
 #endif
@@ -305,7 +305,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	return;
 
   out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 18278b448530..a870478bbe16 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -106,6 +106,7 @@ void
 ia64_init_addr_space (void)
 {
 	struct vm_area_struct *vma;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	ia64_set_rbs_bot();
 
@@ -122,13 +123,13 @@ ia64_init_addr_space (void)
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_flags = VM_DATA_DEFAULT_FLAGS|VM_GROWSUP|VM_ACCOUNT;
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-		down_write(&current->mm->mmap_sem);
+		mm_write_lock(current->mm, &mmrange);
 		if (insert_vm_struct(current->mm, vma)) {
-			up_write(&current->mm->mmap_sem);
+			mm_write_unlock(current->mm, &mmrange);
 			kmem_cache_free(vm_area_cachep, vma);
 			return;
 		}
-		up_write(&current->mm->mmap_sem);
+		mm_write_unlock(current->mm, &mmrange);
 	}
 
 	/* map NaT-page at address zero to speed up speculative dereferencing of NULL: */
@@ -141,13 +142,13 @@ ia64_init_addr_space (void)
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
 			vma->vm_flags = VM_READ | VM_MAYREAD | VM_IO |
 					VM_DONTEXPAND | VM_DONTDUMP;
-			down_write(&current->mm->mmap_sem);
+			mm_write_lock(current->mm, &mmrange);
 			if (insert_vm_struct(current->mm, vma)) {
-				up_write(&current->mm->mmap_sem);
+				mm_write_unlock(current->mm, &mmrange);
 				kmem_cache_free(vm_area_cachep, vma);
 				return;
 			}
-			up_write(&current->mm->mmap_sem);
+			mm_write_unlock(current->mm, &mmrange);
 		}
 	}
 }
-- 
2.13.6
