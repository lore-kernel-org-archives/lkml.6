Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeBEBgv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:36:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752250AbeBEB2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:54 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 40/64] arch/sh: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:30 +0100
Message-Id: <20180205012754.23615-41-dbueso@wotan.suse.de>
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
 arch/sh/kernel/sys_sh.c            | 7 ++++---
 arch/sh/kernel/vsyscall/vsyscall.c | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 724911c59e7d..35b91b6c8d34 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -58,6 +58,7 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 {
 	struct vm_area_struct *vma;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if ((op <= 0) || (op > (CACHEFLUSH_D_PURGE|CACHEFLUSH_I)))
 		return -EINVAL;
@@ -69,10 +70,10 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	if (addr + len < addr)
 		return -EFAULT;
 
-	down_read(&current->mm->mmap_sem);
+	mm_read_lock(current->mm, &mmrange);
 	vma = find_vma (current->mm, addr);
 	if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end) {
-		up_read(&current->mm->mmap_sem);
+		mm_read_unlock(current->mm, &mmrange);
 		return -EFAULT;
 	}
 
@@ -91,6 +92,6 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	if (op & CACHEFLUSH_I)
 		flush_icache_range(addr, addr+len);
 
-	up_read(&current->mm->mmap_sem);
+	mm_read_unlock(current->mm, &mmrange);
 	return 0;
 }
diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index cc0cc5b4ff18..17520e6b7783 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -63,8 +63,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
@@ -83,7 +84,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	current->mm->context.vdso = (void *)addr;
 
 up_fail:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return ret;
 }
 
-- 
2.13.6
