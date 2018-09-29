Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94913C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042C2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4042C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeI3EXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbeI3ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H9-QN; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006t1-Ud; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Jones" <davej@redhat.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Sasha Levin" <sasha.levin@oracle.com>,
        "Ingo Molnar" <mingo@kernel.org>, "Armin Rigo" <arigo@tunes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.335260145@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 052/131] mm: replace remap_file_pages() syscall with
 emulation
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit c8d78c1823f46519473949d33f0d1d33fe21ea16 upstream.

remap_file_pages(2) was invented to be able efficiently map parts of
huge file into limited 32-bit virtual address space such as in database
workloads.

Nonlinear mappings are pain to support and it seems there's no
legitimate use-cases nowadays since 64-bit systems are widely available.

Let's drop it and get rid of all these special-cased code.

The patch replaces the syscall with emulation which creates new VMA on
each remap_file_pages(), unless they it can be merged with an adjacent
one.

I didn't find *any* real code that uses remap_file_pages(2) to test
emulation impact on.  I've checked Debian code search and source of all
packages in ALT Linux.  No real users: libc wrappers, mentions in
strace, gdb, valgrind and this kind of stuff.

There are few basic tests in LTP for the syscall.  They work just fine
with emulation.

To test performance impact, I've written small test case which
demonstrate pretty much worst case scenario: map 4G shmfs file, write to
begin of every page pgoff of the page, remap pages in reverse order,
read every page.

The test creates 1 million of VMAs if emulation is in use, so I had to
set vm.max_map_count to 1100000 to avoid -ENOMEM.

Before:		23.3 ( +-  4.31% ) seconds
After:		43.9 ( +-  0.85% ) seconds
Slowdown:	1.88x

I believe we can live with that.

Test case:

        #define _GNU_SOURCE
        #include <assert.h>
        #include <stdlib.h>
        #include <stdio.h>
        #include <sys/mman.h>

        #define MB	(1024UL * 1024)
        #define SIZE	(4096 * MB)

        int main(int argc, char **argv)
        {
                unsigned long *p;
                long i, pass;

                for (pass = 0; pass < 10; pass++) {
                        p = mmap(NULL, SIZE, PROT_READ|PROT_WRITE,
                                        MAP_SHARED | MAP_ANONYMOUS, -1, 0);
                        if (p == MAP_FAILED) {
                                perror("mmap");
                                return -1;
                        }

                        for (i = 0; i < SIZE / 4096; i++)
                                p[i * 4096 / sizeof(*p)] = i;

                        for (i = 0; i < SIZE / 4096; i++) {
                                if (remap_file_pages(p + i * 4096 / sizeof(*p), 4096,
                                                0, (SIZE - 4096 * (i + 1)) >> 12, 0)) {
                                        perror("remap_file_pages");
                                        return -1;
                                }
                        }

                        for (i = SIZE / 4096 - 1; i >= 0; i--)
                                assert(p[i * 4096 / sizeof(*p)] == SIZE / 4096 - i - 1);

                        munmap(p, SIZE);
                }

                return 0;
        }

[akpm@linux-foundation.org: fix spello]
[sasha.levin@oracle.com: initialize populate before usage]
[sasha.levin@oracle.com: grab file ref to prevent race while mmaping]
Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Armin Rigo <arigo@tunes.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/vm/remap_file_pages.txt |   7 +-
 include/linux/fs.h                    |   8 +-
 mm/Makefile                           |   2 +-
 mm/fremap.c                           | 283 --------------------------
 mm/mmap.c                             |  69 +++++++
 mm/nommu.c                            |   8 -
 6 files changed, 79 insertions(+), 298 deletions(-)
 delete mode 100644 mm/fremap.c

--- a/Documentation/vm/remap_file_pages.txt
+++ b/Documentation/vm/remap_file_pages.txt
@@ -18,10 +18,9 @@ on 32-bit systems to map files bigger th
 virtual address space. This use-case is not critical anymore since 64-bit
 systems are widely available.
 
-The plan is to deprecate the syscall and replace it with an emulation.
-The emulation will create new VMAs instead of nonlinear mappings. It's
-going to work slower for rare users of remap_file_pages() but ABI is
-preserved.
+The syscall is deprecated and replaced it with an emulation now. The
+emulation creates new VMAs instead of nonlinear mappings. It's going to
+work slower for rare users of remap_file_pages() but ABI is preserved.
 
 One side effect of emulation (apart from performance) is that user can hit
 vm.max_map_count limit more easily due to additional VMAs. See comment for
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2430,8 +2430,12 @@ extern int sb_min_blocksize(struct super
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
-extern int generic_file_remap_pages(struct vm_area_struct *, unsigned long addr,
-		unsigned long size, pgoff_t pgoff);
+static inline int generic_file_remap_pages(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long size, pgoff_t pgoff)
+{
+	BUG();
+	return 0;
+}
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -3,7 +3,7 @@
 #
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= fremap.o gup.o highmem.o madvise.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= gup.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   vmalloc.o pagewalk.o pgtable-generic.o
 
--- a/mm/fremap.c
+++ /dev/null
@@ -1,283 +0,0 @@
-/*
- *   linux/mm/fremap.c
- * 
- * Explicit pagetable population and nonlinear (random) mappings support.
- *
- * started by Ingo Molnar, Copyright (C) 2002, 2003
- */
-#include <linux/export.h>
-#include <linux/backing-dev.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/file.h>
-#include <linux/mman.h>
-#include <linux/pagemap.h>
-#include <linux/swapops.h>
-#include <linux/rmap.h>
-#include <linux/syscalls.h>
-#include <linux/mmu_notifier.h>
-
-#include <asm/mmu_context.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-#include "internal.h"
-
-static int mm_counter(struct page *page)
-{
-	return PageAnon(page) ? MM_ANONPAGES : MM_FILEPAGES;
-}
-
-static void zap_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long addr, pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	struct page *page;
-	swp_entry_t entry;
-
-	if (pte_present(pte)) {
-		flush_cache_page(vma, addr, pte_pfn(pte));
-		pte = ptep_clear_flush(vma, addr, ptep);
-		page = vm_normal_page(vma, addr, pte);
-		if (page) {
-			if (pte_dirty(pte))
-				set_page_dirty(page);
-			update_hiwater_rss(mm);
-			dec_mm_counter(mm, mm_counter(page));
-			page_remove_rmap(page);
-			page_cache_release(page);
-		}
-	} else {	/* zap_pte() is not called when pte_none() */
-		if (!pte_file(pte)) {
-			update_hiwater_rss(mm);
-			entry = pte_to_swp_entry(pte);
-			if (non_swap_entry(entry)) {
-				if (is_migration_entry(entry)) {
-					page = migration_entry_to_page(entry);
-					dec_mm_counter(mm, mm_counter(page));
-				}
-			} else {
-				free_swap_and_cache(entry);
-				dec_mm_counter(mm, MM_SWAPENTS);
-			}
-		}
-		pte_clear_not_present_full(mm, addr, ptep, 0);
-	}
-}
-
-/*
- * Install a file pte to a given virtual memory address, release any
- * previously existing mapping.
- */
-static int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pgoff, pgprot_t prot)
-{
-	int err = -ENOMEM;
-	pte_t *pte, ptfile;
-	spinlock_t *ptl;
-
-	pte = get_locked_pte(mm, addr, &ptl);
-	if (!pte)
-		goto out;
-
-	ptfile = pgoff_to_pte(pgoff);
-
-	if (!pte_none(*pte))
-		zap_pte(mm, vma, addr, pte);
-
-	set_pte_at(mm, addr, pte, pte_file_mksoft_dirty(ptfile));
-	/*
-	 * We don't need to run update_mmu_cache() here because the "file pte"
-	 * being installed by install_file_pte() is not a real pte - it's a
-	 * non-present entry (like a swap entry), noting what file offset should
-	 * be mapped there when there's a fault (in a non-linear vma where
-	 * that's not obvious).
-	 */
-	pte_unmap_unlock(pte, ptl);
-	err = 0;
-out:
-	return err;
-}
-
-int generic_file_remap_pages(struct vm_area_struct *vma, unsigned long addr,
-			     unsigned long size, pgoff_t pgoff)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	int err;
-
-	do {
-		err = install_file_pte(mm, vma, addr, pgoff, vma->vm_page_prot);
-		if (err)
-			return err;
-
-		size -= PAGE_SIZE;
-		addr += PAGE_SIZE;
-		pgoff++;
-	} while (size);
-
-	return 0;
-}
-EXPORT_SYMBOL(generic_file_remap_pages);
-
-/**
- * sys_remap_file_pages - remap arbitrary pages of an existing VM_SHARED vma
- * @start: start of the remapped virtual memory range
- * @size: size of the remapped virtual memory range
- * @prot: new protection bits of the range (see NOTE)
- * @pgoff: to-be-mapped page of the backing store file
- * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
- *
- * sys_remap_file_pages remaps arbitrary pages of an existing VM_SHARED vma
- * (shared backing store file).
- *
- * This syscall works purely via pagetables, so it's the most efficient
- * way to map the same (large) file into a given virtual window. Unlike
- * mmap()/mremap() it does not create any new vmas. The new mappings are
- * also safe across swapout.
- *
- * NOTE: the @prot parameter right now is ignored (but must be zero),
- * and the vma's default protection is used. Arbitrary protections
- * might be implemented in the future.
- */
-SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
-		unsigned long, prot, unsigned long, pgoff, unsigned long, flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct address_space *mapping;
-	struct vm_area_struct *vma;
-	int err = -EINVAL;
-	int has_write_lock = 0;
-	vm_flags_t vm_flags = 0;
-
-	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. "
-			"See Documentation/vm/remap_file_pages.txt.\n",
-			current->comm, current->pid);
-
-	if (prot)
-		return err;
-	/*
-	 * Sanitize the syscall parameters:
-	 */
-	start = start & PAGE_MASK;
-	size = size & PAGE_MASK;
-
-	/* Does the address range wrap, or is the span zero-sized? */
-	if (start + size <= start)
-		return err;
-
-	/* Does pgoff wrap? */
-	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
-		return err;
-
-	/* Can we represent this offset inside this architecture's pte's? */
-#if PTE_FILE_MAX_BITS < BITS_PER_LONG
-	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
-#endif
-
-	/* We need down_write() to change vma->vm_flags. */
-	down_read(&mm->mmap_sem);
- retry:
-	vma = find_vma(mm, start);
-
-	/*
-	 * Make sure the vma is shared, that it supports prefaulting,
-	 * and that the remapped range is valid and fully within
-	 * the single existing vma.
-	 */
-	if (!vma || !(vma->vm_flags & VM_SHARED))
-		goto out;
-
-	if (!vma->vm_ops || !vma->vm_ops->remap_pages)
-		goto out;
-
-	if (start < vma->vm_start || start + size > vma->vm_end)
-		goto out;
-
-	/* Must set VM_NONLINEAR before any pages are populated. */
-	if (!(vma->vm_flags & VM_NONLINEAR)) {
-		/*
-		 * vm_private_data is used as a swapout cursor
-		 * in a VM_NONLINEAR vma.
-		 */
-		if (vma->vm_private_data)
-			goto out;
-
-		/* Don't need a nonlinear mapping, exit success */
-		if (pgoff == linear_page_index(vma, start)) {
-			err = 0;
-			goto out;
-		}
-
-		if (!has_write_lock) {
-get_write_lock:
-			up_read(&mm->mmap_sem);
-			down_write(&mm->mmap_sem);
-			has_write_lock = 1;
-			goto retry;
-		}
-		mapping = vma->vm_file->f_mapping;
-		/*
-		 * page_mkclean doesn't work on nonlinear vmas, so if
-		 * dirty pages need to be accounted, emulate with linear
-		 * vmas.
-		 */
-		if (mapping_cap_account_dirty(mapping)) {
-			unsigned long addr;
-			struct file *file = get_file(vma->vm_file);
-			/* mmap_region may free vma; grab the info now */
-			vm_flags = vma->vm_flags;
-
-			addr = mmap_region(file, start, size, vm_flags, pgoff);
-			fput(file);
-			if (IS_ERR_VALUE(addr)) {
-				err = addr;
-			} else {
-				BUG_ON(addr != start);
-				err = 0;
-			}
-			goto out_freed;
-		}
-		mutex_lock(&mapping->i_mmap_mutex);
-		flush_dcache_mmap_lock(mapping);
-		vma->vm_flags |= VM_NONLINEAR;
-		vma_interval_tree_remove(vma, &mapping->i_mmap);
-		vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
-		flush_dcache_mmap_unlock(mapping);
-		mutex_unlock(&mapping->i_mmap_mutex);
-	}
-
-	if (vma->vm_flags & VM_LOCKED) {
-		/*
-		 * drop PG_Mlocked flag for over-mapped range
-		 */
-		if (!has_write_lock)
-			goto get_write_lock;
-		vm_flags = vma->vm_flags;
-		munlock_vma_pages_range(vma, start, start + size);
-		vma->vm_flags = vm_flags;
-	}
-
-	mmu_notifier_invalidate_range_start(mm, start, start + size);
-	err = vma->vm_ops->remap_pages(vma, start, size, pgoff);
-	mmu_notifier_invalidate_range_end(mm, start, start + size);
-
-	/*
-	 * We can't clear VM_NONLINEAR because we'd have to do
-	 * it after ->populate completes, and that would prevent
-	 * downgrading the lock.  (Locks can't be upgraded).
-	 */
-
-out:
-	if (vma)
-		vm_flags = vma->vm_flags;
-out_freed:
-	if (likely(!has_write_lock))
-		up_read(&mm->mmap_sem);
-	else
-		up_write(&mm->mmap_sem);
-	if (!err && ((vm_flags & VM_LOCKED) || !(flags & MAP_NONBLOCK)))
-		mm_populate(start, size);
-
-	return err;
-}
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2620,6 +2620,75 @@ SYSCALL_DEFINE2(munmap, unsigned long, a
 	return vm_munmap(addr, len);
 }
 
+
+/*
+ * Emulation of deprecated remap_file_pages() syscall.
+ */
+SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
+		unsigned long, prot, unsigned long, pgoff, unsigned long, flags)
+{
+
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long populate = 0;
+	unsigned long ret = -EINVAL;
+	struct file *file;
+
+	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. "
+			"See Documentation/vm/remap_file_pages.txt.\n",
+			current->comm, current->pid);
+
+	if (prot)
+		return ret;
+	start = start & PAGE_MASK;
+	size = size & PAGE_MASK;
+
+	if (start + size <= start)
+		return ret;
+
+	/* Does pgoff wrap? */
+	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
+		return ret;
+
+	down_write(&mm->mmap_sem);
+	vma = find_vma(mm, start);
+
+	if (!vma || !(vma->vm_flags & VM_SHARED))
+		goto out;
+
+	if (start < vma->vm_start || start + size > vma->vm_end)
+		goto out;
+
+	if (pgoff == linear_page_index(vma, start)) {
+		ret = 0;
+		goto out;
+	}
+
+	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
+	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
+	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
+
+	flags &= MAP_NONBLOCK;
+	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
+	if (vma->vm_flags & VM_LOCKED) {
+		flags |= MAP_LOCKED;
+		/* drop PG_Mlocked flag for over-mapped range */
+		munlock_vma_pages_range(vma, start, start + size);
+	}
+
+	file = get_file(vma->vm_file);
+	ret = do_mmap_pgoff(vma->vm_file, start, size,
+			prot, flags, pgoff, &populate);
+	fput(file);
+out:
+	up_write(&mm->mmap_sem);
+	if (populate)
+		mm_populate(ret, populate);
+	if (!IS_ERR_VALUE(ret))
+		ret = 0;
+	return ret;
+}
+
 static inline void verify_mm_writelocked(struct mm_struct *mm)
 {
 #ifdef CONFIG_DEBUG_VM
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1999,14 +1999,6 @@ void filemap_map_pages(struct vm_area_st
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
-int generic_file_remap_pages(struct vm_area_struct *vma, unsigned long addr,
-			     unsigned long size, pgoff_t pgoff)
-{
-	BUG();
-	return 0;
-}
-EXPORT_SYMBOL(generic_file_remap_pages);
-
 int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long addr, void *buf, int len, int write)
 {

