Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9A72081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2qCbR5C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9A72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbeKFCRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbeKFCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5Gs1eX097148;
        Mon, 5 Nov 2018 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=kTwyB7gUqH7ZPYa5YenpKewBt6cK4ioVbtrtT8tR8jw=;
 b=2qCbR5C3zZAqth0hgukqdlybcV4uHhL5fs1YXUBigjThoXJj6vgpqR/0m6GGO1TvcjUO
 GKEA2ixpVWQNoigKTcwSGoaVMvCtkkXYNzBXrlIfd8itxzOhfXQLkXswQXI6/2VnsuWv
 Jz7vdnLJMcMqu7h2zCsaiSNo7C+J5Ihn0Ttn3aIPNsvQBr5GebXjUrjemEbEgbxHgI6M
 qdex2jnmyZCoZ2ZY+WLq0y/n2abwOCE76N83Ww4e6k0uyMumWH8taJitb/NgdpmYWGjI
 ZKwU6nWWsP0KzteRuU69AVpdGlTPqYWIYMsFD/7qvy0a+50JdFlFpQSE3uK/W+0ob06L CA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nh33tr6ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuILC004739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:18 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuHKW017779;
        Mon, 5 Nov 2018 16:56:17 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:17 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 07/13] mm: change locked_vm's type from unsigned long to atomic_long_t
Date:   Mon,  5 Nov 2018 11:55:52 -0500
Message-Id: <20181105165558.11698-8-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, mmap_sem must be held as writer to modify the locked_vm field
in mm_struct.

This creates a bottleneck when multithreading VFIO page pinning because
each thread holds the mmap_sem as reader for the majority of the pinning
time but also takes mmap_sem as writer regularly, for short times, when
modifying locked_vm.

The problem gets worse when other workloads compete for CPU with ktask
threads doing page pinning because the other workloads force ktask
threads that hold mmap_sem as writer off the CPU, blocking ktask threads
trying to get mmap_sem as reader for an excessively long time (the
mmap_sem reader wait time grows linearly with the thread count).

Requiring mmap_sem for locked_vm also abuses mmap_sem by making it
protect data that could be synchronized separately.

So, decouple locked_vm from mmap_sem by making locked_vm an
atomic_long_t.  locked_vm's old type was unsigned long and changing it
to a signed type makes it lose half its capacity, but that's only a
concern for 32-bit systems and LONG_MAX * PAGE_SIZE is 8T on x86 in that
case, so there's headroom.

Now that mmap_sem is not taken as writer here, ktask threads holding
mmap_sem as reader can run more often.  Performance results appear later
in the series.

On powerpc, this was cross-compiled-tested only.

[XXX Can send separately.]

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 15 ++++++++-------
 arch/powerpc/mm/mmu_context_iommu.c | 16 ++++++++--------
 drivers/fpga/dfl-afu-dma-region.c   | 16 +++++++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c | 14 +++++++-------
 drivers/vfio/vfio_iommu_type1.c     | 11 ++++++-----
 fs/proc/task_mmu.c                  |  2 +-
 include/linux/mm_types.h            |  2 +-
 kernel/fork.c                       |  2 +-
 mm/debug.c                          |  3 ++-
 mm/mlock.c                          |  4 ++--
 mm/mmap.c                           | 18 +++++++++---------
 mm/mremap.c                         |  6 +++---
 12 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 62a8d03ba7e9..b5637de6dde5 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -58,33 +58,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 
 static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 {
-	long ret = 0;
+	long locked_vm, ret = 0;
 
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic_long_read(&current->mm->locked_vm);
 	if (inc) {
 		unsigned long locked, lock_limit;
 
-		locked = current->mm->locked_vm + stt_pages;
+		locked = locked_vm + stt_pages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += stt_pages;
+			atomic_long_add(stt_pages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
-			stt_pages = current->mm->locked_vm;
+		if (WARN_ON_ONCE(stt_pages > locked_vm))
+			stt_pages = locked_vm;
 
-		current->mm->locked_vm -= stt_pages;
+		atomic_long_sub(stt_pages, &current->mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
 			inc ? '+' : '-',
 			stt_pages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
+			atomic_long_read(&current->mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 56c2234cc6ae..a8f66975bf53 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -41,31 +41,31 @@ struct mm_iommu_table_group_mem_t {
 static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 		unsigned long npages, bool incr)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0, locked, lock_limit, locked_vm;
 
 	if (!npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-
+	locked_vm = atomic_long_read(&mm->locked_vm);
 	if (incr) {
-		locked = mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			mm->locked_vm += npages;
+			atomic_long_add(npages, &mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > mm->locked_vm))
-			npages = mm->locked_vm;
-		mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic_long_sub(npages, &mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
 			current ? current->pid : 0,
 			incr ? '+' : '-',
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic_long_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 
diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 025aba3ea76c..1a7939c511a0 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -45,6 +45,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 {
 	unsigned long locked, lock_limit;
+	long locked_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
@@ -53,24 +54,25 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic_long_read(&current->mm->locked_vm);
 	if (incr) {
-		locked = current->mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += npages;
+			atomic_long_add(npages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-			npages = current->mm->locked_vm;
-		current->mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic_long_sub(npages, &current->mm->locked_vm);
 	}
 
 	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
 		incr ? '+' : '-', npages << PAGE_SHIFT,
-		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- exceeded" : "");
+		atomic_long_read(&current->mm->locked_vm) << PAGE_SHIFT,
+		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
 
 	up_write(&current->mm->mmap_sem);
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index b30926e11d87..c834bc2d1e6b 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -45,16 +45,16 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-	locked = mm->locked_vm + npages;
+	locked = atomic_long_read(&mm->locked_vm) + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 		ret = -ENOMEM;
 	else
-		mm->locked_vm += npages;
+		atomic_long_add(npages, &mm->locked_vm);
 
 	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic_long_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
@@ -69,12 +69,12 @@ static void decrement_locked_vm(struct mm_struct *mm, long npages)
 		return;
 
 	down_write(&mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > mm->locked_vm))
-		npages = mm->locked_vm;
-	mm->locked_vm -= npages;
+	if (WARN_ON_ONCE(npages > atomic_long_read(&mm->locked_vm)))
+		npages = atomic_long_read(&mm->locked_vm);
+	atomic_long_sub(npages, &mm->locked_vm);
 	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic_long_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 }
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e7cfbf0c8071..f307dc9d5e19 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -276,13 +276,13 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 				limit = task_rlimit(dma->task,
 						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-				if (mm->locked_vm + npage > limit)
+				if (atomic_long_read(&mm->locked_vm) + npage > limit)
 					ret = -ENOMEM;
 			}
 		}
 
 		if (!ret)
-			mm->locked_vm += npage;
+			atomic_long_add(npage, &mm->locked_vm);
 
 		up_write(&mm->mmap_sem);
 	}
@@ -419,7 +419,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	 * pages are already counted against the user.
 	 */
 	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
-		if (!dma->lock_cap && mm->locked_vm + 1 > limit) {
+		if (!dma->lock_cap &&
+		    atomic_long_read(&mm->locked_vm) + 1 > limit) {
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 					limit << PAGE_SHIFT);
@@ -445,8 +446,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		}
 
 		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
-			if (!dma->lock_cap &&
-			    mm->locked_vm + lock_acct + 1 > limit) {
+			if (!dma->lock_cap && atomic_long_read(&mm->locked_vm) +
+			    lock_acct + 1 > limit) {
 				put_pfn(pfn, dma->prot);
 				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 					__func__, limit << PAGE_SHIFT);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 39e96a21366e..f0468bfe022e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -58,7 +58,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	swap = get_mm_counter(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
-	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
+	SEQ_PUT_DEC(" kB\nVmLck:\t", atomic_long_read(&mm->locked_vm));
 	SEQ_PUT_DEC(" kB\nVmPin:\t", mm->pinned_vm);
 	SEQ_PUT_DEC(" kB\nVmHWM:\t", hiwater_rss);
 	SEQ_PUT_DEC(" kB\nVmRSS:\t", total_rss);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..ee02933d10e5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -399,7 +399,7 @@ struct mm_struct {
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
 
 		unsigned long total_vm;	   /* Total pages mapped */
-		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+		atomic_long_t locked_vm;   /* Pages that have PG_mlocked set */
 		unsigned long pinned_vm;   /* Refcount permanently increased */
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
diff --git a/kernel/fork.c b/kernel/fork.c
index 2f78d32eaa0f..e0d4d5b8f151 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -978,7 +978,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
-	mm->locked_vm = 0;
+	atomic_long_set(&mm->locked_vm, 0);
 	mm->pinned_vm = 0;
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/debug.c b/mm/debug.c
index cdacba12e09a..3d8db069176f 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -152,7 +152,8 @@ void dump_mm(const struct mm_struct *mm)
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
 		mm->map_count,
-		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
+		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm,
+		atomic_long_read(&mm->locked_vm),
 		mm->pinned_vm, mm->data_vm, mm->exec_vm, mm->stack_vm,
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
 		mm->start_brk, mm->brk, mm->start_stack,
diff --git a/mm/mlock.c b/mm/mlock.c
index 41cc47e28ad6..b213ad97585c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -562,7 +562,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		nr_pages = -nr_pages;
 	else if (old_flags & VM_LOCKED)
 		nr_pages = 0;
-	mm->locked_vm += nr_pages;
+	atomic_long_add(nr_pages, &mm->locked_vm);
 
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
@@ -687,7 +687,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (down_write_killable(&current->mm->mmap_sem))
 		return -EINTR;
 
-	locked += current->mm->locked_vm;
+	locked += atomic_long_read(&current->mm->locked_vm);
 	if ((locked > lock_limit) && (!capable(CAP_IPC_LOCK))) {
 		/*
 		 * It is possible that the regions requested intersect with
diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292e16a7..5c4b39b99fb4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1339,7 +1339,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
 	/*  mlock MCL_FUTURE? */
 	if (flags & VM_LOCKED) {
 		locked = len >> PAGE_SHIFT;
-		locked += mm->locked_vm;
+		locked += atomic_long_read(&mm->locked_vm);
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		lock_limit >>= PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -1825,7 +1825,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 					vma == get_gate_vma(current->mm))
 			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			atomic_long_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	}
 
 	if (file)
@@ -2291,7 +2291,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked;
 		unsigned long limit;
-		locked = mm->locked_vm + grow;
+		locked = atomic_long_read(&mm->locked_vm) + grow;
 		limit = rlimit(RLIMIT_MEMLOCK);
 		limit >>= PAGE_SHIFT;
 		if (locked > limit && !capable(CAP_IPC_LOCK))
@@ -2385,7 +2385,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic_long_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
@@ -2466,7 +2466,7 @@ int expand_downwards(struct vm_area_struct *vma,
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic_long_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start = address;
@@ -2787,11 +2787,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
+	if (atomic_long_read(&mm->locked_vm)) {
 		struct vm_area_struct *tmp = vma;
 		while (tmp && tmp->vm_start < end) {
 			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -= vma_pages(tmp);
+				atomic_long_sub(vma_pages(tmp), &mm->locked_vm);
 				munlock_vma_pages_all(tmp);
 			}
 
@@ -3050,7 +3050,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	mm->total_vm += len >> PAGE_SHIFT;
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED)
-		mm->locked_vm += (len >> PAGE_SHIFT);
+		atomic_long_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	vma->vm_flags |= VM_SOFTDIRTY;
 	return 0;
 }
@@ -3122,7 +3122,7 @@ void exit_mmap(struct mm_struct *mm)
 		up_write(&mm->mmap_sem);
 	}
 
-	if (mm->locked_vm) {
+	if (atomic_long_read(&mm->locked_vm)) {
 		vma = mm->mmap;
 		while (vma) {
 			if (vma->vm_flags & VM_LOCKED)
diff --git a/mm/mremap.c b/mm/mremap.c
index 7f9f9180e401..abcc58690f17 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -360,7 +360,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm += new_len >> PAGE_SHIFT;
+		atomic_long_add(new_len >> PAGE_SHIFT, &mm->locked_vm);
 		*locked = true;
 	}
 
@@ -411,7 +411,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
-		locked = mm->locked_vm << PAGE_SHIFT;
+		locked = atomic_long_read(&mm->locked_vm) << PAGE_SHIFT;
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		locked += new_len - old_len;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -600,7 +600,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 			vm_stat_account(mm, vma->vm_flags, pages);
 			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
+				atomic_long_add(pages, &mm->locked_vm);
 				locked = true;
 				new_addr = addr;
 			}
-- 
2.19.1

