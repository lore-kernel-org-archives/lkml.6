Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49374C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F287C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeFUIJf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:09:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeFUIJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D627EAEFF;
        Thu, 21 Jun 2018 08:09:28 +0000 (UTC)
Date:   Thu, 21 Jun 2018 10:09:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180621080927.GE10465@dhcp22.suse.cz>
References: <20180620103736.13880-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620103736.13880-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version with feedback from Johannes integrated. Still
not runtime tested but I am posting it to make further review easier.

From ed2796dc3894f93ddf0fc9ec74b83c58abc2b4ff Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 20 Jun 2018 10:25:10 +0200
Subject: [PATCH] memcg, oom: move out_of_memory back to the charge path

3812c8c8f395 ("mm: memcg: do not trap chargers with full callstack on OOM")
has changed the ENOMEM semantic of memcg charges. Rather than invoking
the oom killer from the charging context it delays the oom killer to the
page fault path (pagefault_out_of_memory). This in turn means that many
users (e.g. slab or g-u-p) will get ENOMEM when the corresponding memcg
hits the hard limit and the memcg is is OOM. This is behavior is
inconsistent with !memcg case where the oom killer is invoked from the
allocation context and the allocator keeps retrying until it succeeds.

The difference in the behavior is user visible. mmap(MAP_POPULATE) might
result in not fully populated ranges while the mmap return code doesn't
tell that to the userspace. Random syscalls might fail with ENOMEM etc.

The primary motivation of the different memcg oom semantic was the
deadlock avoidance. Things have changed since then, though. We have
an async oom teardown by the oom reaper now and so we do not have to
rely on the victim to tear down its memory anymore. Therefore we can
return to the original semantic as long as the memcg oom killer is not
handed over to the users space.

There is still one thing to be careful about here though. If the oom
killer is not able to make any forward progress - e.g. because there is
no eligible task to kill - then we have to bail out of the charge path
to prevent from same class of deadlocks. We have basically two options
here. Either we fail the charge with ENOMEM or force the charge and
allow overcharge. The first option has been considered more harmful than
useful because rare inconsistencies in the ENOMEM behavior is hard to
test for and error prone. Basically the same reason why the page
allocator doesn't fail allocations under such conditions. The later
might allow runaways but those should be really unlikely unless somebody
misconfigures the system. E.g. allowing to migrate tasks away from the
memcg to a different unlimited memcg with move_charge_at_immigrate
disabled.

Changes since rfc v1
- s@memcg_may_oom@in_user_fault@ suggested by Johannes. It is much more
  clear what is the purpose of the flag now
- make oom_kill_disable an exceptional case because it should be rare
  and the normal oom handling a core of the function - per Johannes

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h |  8 ++--
 include/linux/sched.h      |  2 +-
 mm/memcontrol.c            | 75 ++++++++++++++++++++++++++++++--------
 3 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..8753bc313ef6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -496,14 +496,14 @@ void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
 
 static inline void mem_cgroup_oom_enable(void)
 {
-	WARN_ON(current->memcg_may_oom);
-	current->memcg_may_oom = 1;
+	WARN_ON(current->in_user_fault);
+	current->in_user_fault = 1;
 }
 
 static inline void mem_cgroup_oom_disable(void)
 {
-	WARN_ON(!current->memcg_may_oom);
-	current->memcg_may_oom = 0;
+	WARN_ON(!current->in_user_fault);
+	current->in_user_fault = 0;
 }
 
 static inline bool task_in_memcg_oom(struct task_struct *p)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a27..34cc95b751cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -722,7 +722,7 @@ struct task_struct {
 	unsigned			restore_sigmask:1;
 #endif
 #ifdef CONFIG_MEMCG
-	unsigned			memcg_may_oom:1;
+	unsigned			in_user_fault:1;
 #ifndef CONFIG_SLOB
 	unsigned			memcg_kmem_skip_account:1;
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5ef320a..cff6c75137c1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1483,28 +1483,53 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
+enum oom_status {
+	OOM_SUCCESS,
+	OOM_FAILED,
+	OOM_ASYNC,
+	OOM_SKIPPED
+};
+
+static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
-		return;
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
+		return OOM_SKIPPED;
+
 	/*
 	 * We are in the middle of the charge context here, so we
 	 * don't want to block when potentially sitting on a callstack
 	 * that holds all kinds of filesystem and mm locks.
 	 *
-	 * Also, the caller may handle a failed allocation gracefully
-	 * (like optional page cache readahead) and so an OOM killer
-	 * invocation might not even be necessary.
+	 * cgroup1 allows disabling the OOM killer and waiting for outside
+	 * handling until the charge can succeed; remember the context and put
+	 * the task to sleep at the end of the page fault when all locks are
+	 * released.
+	 *
+	 * On the other hand, in-kernel OOM killer allows for an async victim
+	 * memory reclaim (oom_reaper) and that means that we are not solely
+	 * relying on the oom victim to make a forward progress and we can
+	 * invoke the oom killer here.
 	 *
-	 * That's why we don't do anything here except remember the
-	 * OOM context and then deal with it at the end of the page
-	 * fault when the stack is unwound, the locks are released,
-	 * and when we know whether the fault was overall successful.
+	 * Please note that mem_cgroup_out_of_memory might fail to find a
+	 * victim and then we have to bail out from the charge path.
 	 */
-	css_get(&memcg->css);
-	current->memcg_in_oom = memcg;
-	current->memcg_oom_gfp_mask = mask;
-	current->memcg_oom_order = order;
+	if (memcg->oom_kill_disable) {
+		if (!current->in_user_fault)
+			return OOM_SKIPPED;
+		css_get(&memcg->css);
+		current->memcg_in_oom = memcg;
+		current->memcg_oom_gfp_mask = mask;
+		current->memcg_oom_order = order;
+
+		return OOM_ASYNC;
+	}
+
+	if (mem_cgroup_out_of_memory(memcg, mask, order))
+		return OOM_SUCCESS;
+
+	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
+		"This looks like a misconfiguration or a kernel bug.");
+	return OOM_FAILED;
 }
 
 /**
@@ -1899,6 +1924,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
+	bool oomed = false;
+	enum oom_status oom_status;
 
 	if (mem_cgroup_is_root(memcg))
 		return 0;
@@ -1986,6 +2013,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_retries--)
 		goto retry;
 
+	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
+		goto nomem;
+
 	if (gfp_mask & __GFP_NOFAIL)
 		goto force;
 
@@ -1994,8 +2024,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	memcg_memory_event(mem_over_limit, MEMCG_OOM);
 
-	mem_cgroup_oom(mem_over_limit, gfp_mask,
+	/*
+	 * keep retrying as long as the memcg oom killer is able to make
+	 * a forward progress or bypass the charge if the oom killer
+	 * couldn't make any progress.
+	 */
+	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
+	switch (oom_status) {
+	case OOM_SUCCESS:
+		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+		oomed = true;
+		goto retry;
+	case OOM_FAILED:
+		goto force;
+	default:
+		goto nomem;
+	}
 nomem:
 	if (!(gfp_mask & __GFP_NOFAIL))
 		return -ENOMEM;
-- 
2.17.1

-- 
Michal Hocko
SUSE Labs
