Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ABA204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ABA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJYQ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:56:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34208 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeJYQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:55:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so7626501eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDnCjbwCU7GwgfYL0LS6gVq7nq2XeDqycf02/zMKIkE=;
        b=J//tV1U15E3oERrwPaL2Zwoug7ixFI+u1/orPJLPuV6cet5Xqn0sjV3yCwdOAAL+pO
         0KKRPGB9msjp4qUCF7MMs3JbytKr5QjQwuC8wCJZiK5AHR3M2xiS1uLxjmIoTMg/h4Wq
         gmey17qWaMv/n+Lei3CexJJKPQ+ZEcnQowpmoomJs92qHWjL/MT+JF7xobLWerI/Nxpu
         UteBvNufec2qyw6CRnEokgQQLhJqIG3PvT5SmJfJbhEITH5V3zBImLQGNfg7z3LJ/igd
         7pnuZgHJoK9nnH/auHTguHDzvzJHMwO6pdm43IB1L4AyfZLFW1kTdS4OrVVwyF2nRe6y
         f1bQ==
X-Gm-Message-State: AGRZ1gLOp+do+iKbsBIVtr4UFnz2fO5x3wKcjPO1tsDkpj4FcurrM4dR
        TB3NyEI0BL/xwJUr063cZAo=
X-Google-Smtp-Source: AJdET5eWwbM5m/AslgFynlgkSJzNzpCqEg3ERg/iUpG6InNnqruK65CIebOemb7tvqk0eA+6j5pz1Q==
X-Received: by 2002:a50:f00e:: with SMTP id r14-v6mr767992edl.58.1540455854130;
        Thu, 25 Oct 2018 01:24:14 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m24-v6sm2628277edd.31.2018.10.25.01.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 01:24:13 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path if it is guranteed to finish
Date:   Thu, 25 Oct 2018 10:24:03 +0200
Message-Id: <20181025082403.3806-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025082403.3806-1-mhocko@kernel.org>
References: <20181025082403.3806-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

David Rientjes has noted that certain user space memory allocators leave
a lot of page tables behind and the current implementation of oom_reaper
doesn't deal with those workloads very well. In order to improve these
workloads define a point when exit_mmap is guaranteed to finish the tear
down without any further blocking etc. This is right after we unlink
vmas (those still depend on locks which are held while performing memory
allocations from other contexts) and before we start releasing page
tables.

Opencode free_pgtables and explicitly unlink all vmas first. Then set
mm->mmap to NULL (there shouldn't be anybody looking at it at this
stage) and check for mm->mmap in the oom_reaper path. If the mm->mmap
is NULL we rely on the exit path and won't set MMF_OOM_SKIP from the
reaper.

Changes since RFC
- the task is still visible to the OOM killer after exit_mmap terminates
  so we should set MMF_OOM_SKIP from that path to be sure the oom killer
  doesn't get stuck on this task (see d7a94e7e11badf84 for more context)
  - per Tetsuo
- split free_pgtables into unlinking and actual freeing part. We cannot
  rely on free_pgd_range because of hugetlb pages on ppc resp. sparc
  which do their own tear down

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/internal.h |  3 +++
 mm/memory.c   | 28 ++++++++++++++++++----------
 mm/mmap.c     | 25 +++++++++++++++++++++----
 mm/oom_kill.c | 13 +++++++------
 4 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 87256ae1bef8..35adbfec4935 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -40,6 +40,9 @@ void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
+void __unlink_vmas(struct vm_area_struct *vma);
+void __free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
+		unsigned long floor, unsigned long ceiling);
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 
diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..cf910ed5f283 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -612,20 +612,23 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr = next, addr != end);
 }
 
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
+void __unlink_vmas(struct vm_area_struct *vma)
+{
+	while (vma) {
+		unlink_anon_vmas(vma);
+		unlink_file_vma(vma);
+		vma = vma->vm_next;
+	}
+}
+
+/* expects that __unlink_vmas has been called already */
+void __free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long floor, unsigned long ceiling)
 {
 	while (vma) {
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long addr = vma->vm_start;
 
-		/*
-		 * Hide vma from rmap and truncate_pagecache before freeing
-		 * pgtables
-		 */
-		unlink_anon_vmas(vma);
-		unlink_file_vma(vma);
-
 		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
@@ -637,8 +640,6 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = vma->vm_next;
-				unlink_anon_vmas(vma);
-				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
@@ -647,6 +648,13 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
+void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long floor, unsigned long ceiling)
+{
+	__unlink_vmas(vma);
+	__free_pgtables(tlb, vma, floor, ceiling);
+}
+
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
 	spinlock_t *ptl;
diff --git a/mm/mmap.c b/mm/mmap.c
index a02b314c0546..f4b562e21764 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3082,13 +3082,26 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 
-	/* oom_reaper cannot race with the page tables teardown */
+	/*
+	 * oom_reaper cannot race with the page tables teardown but we
+	 * want to make sure that the exit path can take over the full
+	 * tear down when it is safe to do so
+	 */
 	if (oom) {
 		down_write(&mm->mmap_sem);
-		set_bit(MMF_OOM_SKIP, &mm->flags);
+		__unlink_vmas(vma);
+		/*
+		 * the exit path is guaranteed to finish the memory tear down
+		 * without any unbound blocking at this stage so make it clear
+		 * to the oom_reaper
+		 */
+		mm->mmap = NULL;
+		up_write(&mm->mmap_sem);
+		__free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	} else {
+		free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	}
 
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
 
 	/*
@@ -3102,8 +3115,12 @@ void exit_mmap(struct mm_struct *mm)
 	}
 	vm_unacct_memory(nr_accounted);
 
+	/*
+	 * Now that the full address space is torn down, make sure the
+	 * OOM killer skips over this task
+	 */
 	if (oom)
-		up_write(&mm->mmap_sem);
+		set_bit(MMF_OOM_SKIP, &mm->flags);
 }
 
 /* Insert vm structure into process list sorted by address
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ab42717661dc..db1ebb45c66a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -570,12 +570,10 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm, unsi
 	}
 
 	/*
-	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
-	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
-	 * under mmap_sem for reading because it serializes against the
-	 * down_write() in exit_mmap().
+	 * If exit path clear mm->mmap then we know it will finish the tear down
+	 * and we can go and bail out here.
 	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+	if (!mm->mmap) {
 		trace_skip_task_reaping(tsk->pid);
 		goto out_unlock;
 	}
@@ -625,8 +623,11 @@ static void oom_reap_task(struct task_struct *tsk)
 	/*
 	 * Hide this mm from OOM killer because it has been either reaped or
 	 * somebody can't call up_write(mmap_sem).
+	 * Leave the MMF_OOM_SKIP to the exit path if it managed to reach the
+	 * point it is guaranteed to finish without any blocking
 	 */
-	set_bit(MMF_OOM_SKIP, &mm->flags);
+	if (mm->mmap)
+		set_bit(MMF_OOM_SKIP, &mm->flags);
 
 	/* Drop a reference taken by wake_oom_reaper */
 	put_task_struct(tsk);
-- 
2.19.1

