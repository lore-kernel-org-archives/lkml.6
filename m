Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74EB20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfBVFHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:07:39 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:46408 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbfBVFHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:07:39 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2019 00:07:38 EST
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 22 Feb 2019 13:37:36 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: junil0814.lee@lge.com
Received: from unknown (HELO localhost.localdomain) (10.168.178.220)
        by 156.147.1.126 with ESMTP; 22 Feb 2019 13:37:35 +0900
X-Original-SENDERIP: 10.168.178.220
X-Original-MAILFROM: junil0814.lee@lge.com
From:   Junil Lee <junil0814.lee@lge.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        pasha.tatashin@oracle.com, kirill.shutemov@linux.intel.com,
        jrdr.linux@gmail.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, andreyknvl@google.com,
        arunks@codeaurora.org, keith.busch@intel.com, guro@fb.com,
        hannes@cmpxchg.org, rientjes@google.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        yuzhoujian@didichuxing.com, Junil Lee <junil0814.lee@lge.com>
Subject: [PATCH] mm, oom: OOM killer use rss size without shmem
Date:   Fri, 22 Feb 2019 13:37:33 +0900
Message-Id: <1550810253-152925-1-git-send-email-junil0814.lee@lge.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oom killer use get_mm_rss() function to estimate how free memory
will be reclaimed when the oom killer select victim task.

However, the returned rss size by get_mm_rss() function was changed from
"mm, shmem: add internal shmem resident memory accounting" commit.
This commit makes the get_mm_rss() return size including SHMEM pages.

The oom killer can't get free memory from SHMEM pages directly after
kill victim process, it leads to mis-calculate victim points.

Therefore, make new API as get_mm_rss_wo_shmem() which returns the rss
value excluding SHMEM_PAGES.

Signed-off-by: Junil Lee <junil0814.lee@lge.com>
---
 include/linux/mm.h | 6 ++++++
 mm/oom_kill.c      | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d483db..bca3acc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1701,6 +1701,12 @@ static inline int mm_counter(struct page *page)
 	return mm_counter_file(page);
 }
 
+static inline unsigned long get_mm_rss_wo_shmem(struct mm_struct *mm)
+{
+	return get_mm_counter(mm, MM_FILEPAGES) +
+		get_mm_counter(mm, MM_ANONPAGES);
+}
+
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
 {
 	return get_mm_counter(mm, MM_FILEPAGES) +
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3a24848..e569737 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -230,7 +230,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
+	points = get_mm_rss_wo_shmem(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
@@ -419,7 +419,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 
 		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
 			task->pid, from_kuid(&init_user_ns, task_uid(task)),
-			task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
+			task->tgid, task->mm->total_vm, get_mm_rss_wo_shmem(task->mm),
 			mm_pgtables_bytes(task->mm),
 			get_mm_counter(task->mm, MM_SWAPENTS),
 			task->signal->oom_score_adj, task->comm);
-- 
2.6.2

