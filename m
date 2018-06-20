Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF37C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1285B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1285B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeFTLVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:21:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46347 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeFTLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:21:09 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5KBKsDa061699;
        Wed, 20 Jun 2018 20:20:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 20 Jun 2018 20:20:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5KBKnuQ061680
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 20:20:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM killer.
Date:   Wed, 20 Jun 2018 20:20:38 +0900
Message-Id: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleeping with oom_lock held can cause AB-BA lockup bug because
__alloc_pages_may_oom() does not wait for oom_lock. Since
blocking_notifier_call_chain() in out_of_memory() might sleep, sleeping
with oom_lock held is currently an unavoidable problem.

As a preparation for not to sleep with oom_lock held, this patch brings
OOM notifier callbacks to outside of OOM killer, with two small behavior
changes explained below.

One is that this patch makes it impossible for SysRq-f and PF-OOM to
reclaim via OOM notifier. But such change should be tolerable because
"we unlikely try to use SysRq-f for reclaiming memory via OOM notifier
callbacks" and "pagefault_out_of_memory() will be called when OOM killer
selected current thread as an OOM victim after OOM notifier callbacks
already failed to reclaim memory".

The other is that this patch makes it possible to reclaim memory via OOM
notifier after OOM killer is disabled (that is, suspend/hibernate is in
progress). But such change should be safe because of pm_suspended_storage()
check.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/oom.h |  1 +
 mm/oom_kill.c       | 35 ++++++++++++++++++------
 mm/page_alloc.c     | 76 +++++++++++++++++++++++++++++++----------------------
 3 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6adac11..085b033 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -101,6 +101,7 @@ extern unsigned long oom_badness(struct task_struct *p,
 		struct mem_cgroup *memcg, const nodemask_t *nodemask,
 		unsigned long totalpages);
 
+extern unsigned long try_oom_notifier(void);
 extern bool out_of_memory(struct oom_control *oc);
 
 extern void exit_oom_victim(void);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e7..2ff5db2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1010,6 +1010,33 @@ int unregister_oom_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 
 /**
+ * try_oom_notifier - Try to reclaim memory from OOM notifier list.
+ *
+ * Returns non-zero if notifier callbacks released something, zero otherwise.
+ */
+unsigned long try_oom_notifier(void)
+{
+	static DEFINE_MUTEX(oom_notifier_lock);
+	unsigned long freed = 0;
+
+	/*
+	 * Since OOM notifier callbacks must not depend on __GFP_DIRECT_RECLAIM
+	 * && !__GFP_NORETRY memory allocation, waiting for mutex here is safe.
+	 * If lockdep reports possible deadlock dependency, it will be a bug in
+	 * OOM notifier callbacks.
+	 *
+	 * If SIGKILL is pending, it is likely that current thread was selected
+	 * as an OOM victim. In that case, current thread should return as soon
+	 * as possible using memory reserves.
+	 */
+	if (mutex_lock_killable(&oom_notifier_lock))
+		return 0;
+	blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
+	mutex_unlock(&oom_notifier_lock);
+	return freed;
+}
+
+/**
  * out_of_memory - kill the "best" process when we run out of memory
  * @oc: pointer to struct oom_control
  *
@@ -1020,19 +1047,11 @@ int unregister_oom_notifier(struct notifier_block *nb)
  */
 bool out_of_memory(struct oom_control *oc)
 {
-	unsigned long freed = 0;
 	enum oom_constraint constraint = CONSTRAINT_NONE;
 
 	if (oom_killer_disabled)
 		return false;
 
-	if (!is_memcg_oom(oc)) {
-		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
-		if (freed > 0)
-			/* Got some memory back in the last second. */
-			return true;
-	}
-
 	/*
 	 * If current has a pending SIGKILL or is exiting, then automatically
 	 * select it.  The goal is to allow it to allocate so that it may
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100..c72ef1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3447,10 +3447,50 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	return page;
 }
 
+static inline bool can_oomkill(gfp_t gfp_mask, unsigned int order,
+			       const struct alloc_context *ac)
+{
+	/* Coredumps can quickly deplete all memory reserves */
+	if (current->flags & PF_DUMPCORE)
+		return false;
+	/* The OOM killer will not help higher order allocs */
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
+		return false;
+	/*
+	 * We have already exhausted all our reclaim opportunities without any
+	 * success so it is time to admit defeat. We will skip the OOM killer
+	 * because it is very likely that the caller has a more reasonable
+	 * fallback than shooting a random task.
+	 */
+	if (gfp_mask & __GFP_RETRY_MAYFAIL)
+		return false;
+	/* The OOM killer does not needlessly kill tasks for lowmem */
+	if (ac->high_zoneidx < ZONE_NORMAL)
+		return false;
+	if (pm_suspended_storage())
+		return false;
+	/*
+	 * XXX: GFP_NOFS allocations should rather fail than rely on
+	 * other request to make a forward progress.
+	 * We are in an unfortunate situation where out_of_memory cannot
+	 * do much for this context but let's try it to at least get
+	 * access to memory reserved if the current task is killed (see
+	 * out_of_memory). Once filesystems are ready to handle allocation
+	 * failures more gracefully we should just bail out here.
+	 */
+
+	/* The OOM killer may not free memory on a specific node */
+	if (gfp_mask & __GFP_THISNODE)
+		return false;
+
+	return true;
+}
+
 static inline struct page *
 __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	const struct alloc_context *ac, unsigned long *did_some_progress)
 {
+	const bool oomkill = can_oomkill(gfp_mask, order, ac);
 	struct oom_control oc = {
 		.zonelist = ac->zonelist,
 		.nodemask = ac->nodemask,
@@ -3462,6 +3502,10 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 
 	*did_some_progress = 0;
 
+	/* Try to reclaim via OOM notifier callback. */
+	if (oomkill)
+		*did_some_progress = try_oom_notifier();
+
 	/*
 	 * Acquire the oom lock.  If that fails, somebody else is
 	 * making progress for us.
@@ -3485,37 +3529,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	if (page)
 		goto out;
 
-	/* Coredumps can quickly deplete all memory reserves */
-	if (current->flags & PF_DUMPCORE)
-		goto out;
-	/* The OOM killer will not help higher order allocs */
-	if (order > PAGE_ALLOC_COSTLY_ORDER)
-		goto out;
-	/*
-	 * We have already exhausted all our reclaim opportunities without any
-	 * success so it is time to admit defeat. We will skip the OOM killer
-	 * because it is very likely that the caller has a more reasonable
-	 * fallback than shooting a random task.
-	 */
-	if (gfp_mask & __GFP_RETRY_MAYFAIL)
-		goto out;
-	/* The OOM killer does not needlessly kill tasks for lowmem */
-	if (ac->high_zoneidx < ZONE_NORMAL)
-		goto out;
-	if (pm_suspended_storage())
-		goto out;
-	/*
-	 * XXX: GFP_NOFS allocations should rather fail than rely on
-	 * other request to make a forward progress.
-	 * We are in an unfortunate situation where out_of_memory cannot
-	 * do much for this context but let's try it to at least get
-	 * access to memory reserved if the current task is killed (see
-	 * out_of_memory). Once filesystems are ready to handle allocation
-	 * failures more gracefully we should just bail out here.
-	 */
-
-	/* The OOM killer may not free memory on a specific node */
-	if (gfp_mask & __GFP_THISNODE)
+	if (!oomkill)
 		goto out;
 
 	/* Exhausted what can be done so it's blame time */
-- 
1.8.3.1

