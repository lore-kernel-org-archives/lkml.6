Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE6A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544849;
	bh=+wCgwhmE0crG33pnIAHabdsgwJG41lVjJRhuJyWZKME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AqLPhmRT1mVQKQ9skp68zK4gPJV3Vr2rk1x7RXazQYqPSEGWFRk26Dc9cR8mV3tAi
	 BTc9q1dI7dT6+yyFBFUwLc38e/qmE1fpnhlgDeBRnIjM7giTx2tC4khtc28QBB4Sh/
	 Qh8lNa7ef2daCTPxi+367XESfkKveiwnpZg2XrJg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE6A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeLKPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeLKPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE7920989;
        Tue, 11 Dec 2018 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543354;
        bh=+wCgwhmE0crG33pnIAHabdsgwJG41lVjJRhuJyWZKME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4JKuBsJh9YHEtrhH8b8jB8De6wss8kM70lYAGKoTQlDInZadHMOIxTPQ/jYKt21o
         9o3R15rUoOChkYXl0dbGhK5dU2/58JbJEcihCSjTl6+8jnAms/s1mbdill4mL1nc5L
         WuOL6fIHftxKuNrw2eUdE4n33IrQq7jJ7L+hux9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "yuwang.yuwang" <yuwang.yuwang@alibaba-inc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amit Shah <amit@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/51] mm: dont warn about allocations which stall for too long
Date:   Tue, 11 Dec 2018 16:41:27 +0100
Message-Id: <20181211151614.632099430@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 400e22499dd92613821374c8c6c88c7225359980 upstream.

Commit 63f53dea0c98 ("mm: warn about allocations which stall for too
long") was a great step for reducing possibility of silent hang up
problem caused by memory allocation stalls.  But this commit reverts it,
for it is possible to trigger OOM lockup and/or soft lockups when many
threads concurrently called warn_alloc() (in order to warn about memory
allocation stalls) due to current implementation of printk(), and it is
difficult to obtain useful information due to limitation of synchronous
warning approach.

Current printk() implementation flushes all pending logs using the
context of a thread which called console_unlock().  printk() should be
able to flush all pending logs eventually unless somebody continues
appending to printk() buffer.

Since warn_alloc() started appending to printk() buffer while waiting
for oom_kill_process() to make forward progress when oom_kill_process()
is processing pending logs, it became possible for warn_alloc() to force
oom_kill_process() loop inside printk().  As a result, warn_alloc()
significantly increased possibility of preventing oom_kill_process()
from making forward progress.

---------- Pseudo code start ----------
Before warn_alloc() was introduced:

  retry:
    if (mutex_trylock(&oom_lock)) {
      while (atomic_read(&printk_pending_logs) > 0) {
        atomic_dec(&printk_pending_logs);
        print_one_log();
      }
      // Send SIGKILL here.
      mutex_unlock(&oom_lock)
    }
    goto retry;

After warn_alloc() was introduced:

  retry:
    if (mutex_trylock(&oom_lock)) {
      while (atomic_read(&printk_pending_logs) > 0) {
        atomic_dec(&printk_pending_logs);
        print_one_log();
      }
      // Send SIGKILL here.
      mutex_unlock(&oom_lock)
    } else if (waited_for_10seconds()) {
      atomic_inc(&printk_pending_logs);
    }
    goto retry;
---------- Pseudo code end ----------

Although waited_for_10seconds() becomes true once per 10 seconds,
unbounded number of threads can call waited_for_10seconds() at the same
time.  Also, since threads doing waited_for_10seconds() keep doing
almost busy loop, the thread doing print_one_log() can use little CPU
resource.  Therefore, this situation can be simplified like

---------- Pseudo code start ----------
  retry:
    if (mutex_trylock(&oom_lock)) {
      while (atomic_read(&printk_pending_logs) > 0) {
        atomic_dec(&printk_pending_logs);
        print_one_log();
      }
      // Send SIGKILL here.
      mutex_unlock(&oom_lock)
    } else {
      atomic_inc(&printk_pending_logs);
    }
    goto retry;
---------- Pseudo code end ----------

when printk() is called faster than print_one_log() can process a log.

One of possible mitigation would be to introduce a new lock in order to
make sure that no other series of printk() (either oom_kill_process() or
warn_alloc()) can append to printk() buffer when one series of printk()
(either oom_kill_process() or warn_alloc()) is already in progress.

Such serialization will also help obtaining kernel messages in readable
form.

---------- Pseudo code start ----------
  retry:
    if (mutex_trylock(&oom_lock)) {
      mutex_lock(&oom_printk_lock);
      while (atomic_read(&printk_pending_logs) > 0) {
        atomic_dec(&printk_pending_logs);
        print_one_log();
      }
      // Send SIGKILL here.
      mutex_unlock(&oom_printk_lock);
      mutex_unlock(&oom_lock)
    } else {
      if (mutex_trylock(&oom_printk_lock)) {
        atomic_inc(&printk_pending_logs);
        mutex_unlock(&oom_printk_lock);
      }
    }
    goto retry;
---------- Pseudo code end ----------

But this commit does not go that direction, for we don't want to
introduce a new lock dependency, and we unlikely be able to obtain
useful information even if we serialized oom_kill_process() and
warn_alloc().

Synchronous approach is prone to unexpected results (e.g.  too late [1],
too frequent [2], overlooked [3]).  As far as I know, warn_alloc() never
helped with providing information other than "something is going wrong".
I want to consider asynchronous approach which can obtain information
during stalls with possibly relevant threads (e.g.  the owner of
oom_lock and kswapd-like threads) and serve as a trigger for actions
(e.g.  turn on/off tracepoints, ask libvirt daemon to take a memory dump
of stalling KVM guest for diagnostic purpose).

This commit temporarily loses ability to report e.g.  OOM lockup due to
unable to invoke the OOM killer due to !__GFP_FS allocation request.
But asynchronous approach will be able to detect such situation and emit
warning.  Thus, let's remove warn_alloc().

[1] https://bugzilla.kernel.org/show_bug.cgi?id=192981
[2] http://lkml.kernel.org/r/CAM_iQpWuPVGc2ky8M-9yukECtS+zKjiDasNymX7rMcBjBFyM_A@mail.gmail.com
[3] commit db73ee0d46379922 ("mm, vmscan: do not loop on too_many_isolated for ever"))

Link: http://lkml.kernel.org/r/1509017339-4802-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Reported-by: yuwang.yuwang <yuwang.yuwang@alibaba-inc.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

[Resolved backport conflict due to missing 8225196, a8e9925, 9e80c71 and
 9a67f64 in 4.9 -- all of which modified this hunk being removed.]
Signed-off-by: Amit Shah <amit@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28240ce475d6..3af727d95c17 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3530,8 +3530,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	enum compact_result compact_result;
 	int compaction_retries;
 	int no_progress_loops;
-	unsigned long alloc_start = jiffies;
-	unsigned int stall_timeout = 10 * HZ;
 	unsigned int cpuset_mems_cookie;
 
 	/*
@@ -3704,14 +3702,6 @@ retry:
 	if (order > PAGE_ALLOC_COSTLY_ORDER && !(gfp_mask & __GFP_REPEAT))
 		goto nopage;
 
-	/* Make sure we know about allocations which stall for too long */
-	if (time_after(jiffies, alloc_start + stall_timeout)) {
-		warn_alloc(gfp_mask,
-			"page allocation stalls for %ums, order:%u",
-			jiffies_to_msecs(jiffies-alloc_start), order);
-		stall_timeout += 10 * HZ;
-	}
-
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
 				 did_some_progress > 0, &no_progress_loops))
 		goto retry;
-- 
2.19.1



