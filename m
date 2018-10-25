Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD67C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E3204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71E3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJYQz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:55:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38039 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeJYQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:55:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so7614379ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/av0pB8zJCwcJxHsePcmzWL1U7Z3G4tDndbbOHv8Og=;
        b=ZYnPUYx85isNjBvMBE4wP6K+7P1pgj2FysIh4wVyjjRWd2YaYVZnLOMnWWNsu9UYuc
         NiTmFOu3QlySQl5a/k8xDeG9LNE+0SDAl/+Bu6bPgGOUoY17AdaKHpYb7G0Gvf8vIBVH
         dF+MB6upL0IO5wk46GNNN2n/9I22qugHh6dcMjUjoPutTp5VHMcbDonh3CeWiNEuaFby
         uHC4OOtDLRoBexJEKCAlh42qwJexzFxuKs3uMhVOmvXWODe1YcYk3pG+EQIc9RID9/zz
         Bt9vM8o+Cc7nWe+1tMwqBo2yyXboMHqAi+IDiVd5JIdVTJCs4g7SvEHBpw/khVmwUTwz
         xprw==
X-Gm-Message-State: AGRZ1gKcEas/fKR4QX/0cMX1NSKZ6CUbe8wiGPw3OLXnT1Z1d9/YpCbT
        zGZszvcdlxk99mv4KpvlhCc=
X-Google-Smtp-Source: AJdET5e0QqkEcd4GBDzyoq1FkDzf2Fs/LbjX69f2r2oP9Z/TgnX0nNGmzCcvRPQgpQdJdzfGWCNp1A==
X-Received: by 2002:aa7:d4c9:: with SMTP id t9-v6mr741268edr.256.1540455853240;
        Thu, 25 Oct 2018 01:24:13 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m24-v6sm2628277edd.31.2018.10.25.01.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 01:24:12 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 2/3] mm, oom: keep retrying the oom_reap operation as long as there is substantial memory left
Date:   Thu, 25 Oct 2018 10:24:02 +0200
Message-Id: <20181025082403.3806-3-mhocko@kernel.org>
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

oom_reaper is not able to reap all types of memory. E.g. mlocked
mappings or page tables. In some cases this might be a lot of memory
and we do rely on exit_mmap to release that memory. Yet we cannot rely
on exit_mmap to set MMF_OOM_SKIP right now because there are several
places when sleeping locks are taken.

This patch adds a simple heuristic to check for the amount of memory
the mm is sitting on after oom_reaper is done with it. If this is still
a considerable amount of the original memory (more than 1/4 of the
original badness) then simply keep retrying oom_reap_task_mm. The
portion is quite arbitrary and a subject of future tuning based on real
life usecases but it should catch some outliars when the vast portion
of the memory is consumed by non-reapable memory.

Changes since RFC
- do not use hardcoded threshold for retry and rather use a portion of
  the original badness instead

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index b3b2c2bbd8ab..ab42717661dc 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -189,6 +189,16 @@ static bool is_dump_unreclaim_slabs(void)
 	return (global_node_page_state(NR_SLAB_UNRECLAIMABLE) > nr_lru);
 }
 
+/*
+ * Rough memory consumption of the given mm which should be theoretically freed
+ * when the mm is removed.
+ */
+static unsigned long oom_badness_pages(struct mm_struct *mm)
+{
+	return get_mm_rss(mm) + get_mm_counter(mm, MM_SWAPENTS) +
+		mm_pgtables_bytes(mm) / PAGE_SIZE;
+}
+
 /**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
@@ -230,8 +240,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	 * The baseline for the badness score is the proportion of RAM that each
 	 * task's rss, pagetable and swap space use.
 	 */
-	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
-		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+	points = oom_badness_pages(p->mm);
 	task_unlock(p);
 
 	/* Normalize to oom_score_adj units */
@@ -488,7 +497,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-static bool __oom_reap_task_mm(struct mm_struct *mm)
+static bool __oom_reap_task_mm(struct mm_struct *mm, unsigned long original_badness)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
@@ -532,6 +541,16 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 		}
 	}
 
+	/*
+	 * If we still sit on a noticeable amount of memory even after successfully
+	 * reaping the address space then keep retrying until exit_mmap makes some
+	 * further progress.
+	 * TODO: add a flag for a stage when the exit path doesn't block anymore
+	 * and hand over MMF_OOM_SKIP handling there in that case
+	 */
+	if (oom_badness_pages(mm) > (original_badness >> 2))
+		ret = false;
+
 	return ret;
 }
 
@@ -541,7 +560,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
  * Returns true on success and false if none or part of the address space
  * has been reclaimed and the caller should retry later.
  */
-static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
+static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm, unsigned long original_badness)
 {
 	bool ret = true;
 
@@ -564,7 +583,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	trace_start_task_reaping(tsk->pid);
 
 	/* failed to reap part of the address space. Try again later */
-	ret = __oom_reap_task_mm(mm);
+	ret = __oom_reap_task_mm(mm, original_badness);
 	if (!ret)
 		goto out_finish;
 
@@ -586,9 +605,10 @@ static void oom_reap_task(struct task_struct *tsk)
 {
 	int attempts = 0;
 	struct mm_struct *mm = tsk->signal->oom_mm;
+	unsigned long original_badness = oom_badness_pages(mm);
 
 	/* Retry the down_read_trylock(mmap_sem) a few times */
-	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
+	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm, original_badness))
 		schedule_timeout_idle(HZ/10);
 
 	if (attempts <= MAX_OOM_REAP_RETRIES ||
-- 
2.19.1

