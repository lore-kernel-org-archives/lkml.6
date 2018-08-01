Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF7EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AB420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408204AbeHAT0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436510AbeHATSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C734FE84;
        Wed,  1 Aug 2018 16:54:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 032/336] mem_cgroup: make sure moving_account, move_lock_task and stat_cpu in the same cacheline
Date:   Wed,  1 Aug 2018 18:46:07 +0200
Message-Id: <20180801165030.308579987@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Lu <aaron.lu@intel.com>

[ Upstream commit e81bf9793b1861d74953ef041b4f6c7faecc2dbd ]

The LKP robot found a 27% will-it-scale/page_fault3 performance
regression regarding commit e27be240df53("mm: memcg: make sure
memory.events is uptodate when waking pollers").

What the test does is:
 1 mkstemp() a 128M file on a tmpfs;
 2 start $nr_cpu processes, each to loop the following:
   2.1 mmap() this file in shared write mode;
   2.2 write 0 to this file in a PAGE_SIZE step till the end of the file;
   2.3 unmap() this file and repeat this process.
 3 After 5 minutes, check how many loops they managed to complete, the
   higher the better.

The commit itself looks innocent enough as it merely changed some event
counting mechanism and this test didn't trigger those events at all.
Perf shows increased cycles spent on accessing root_mem_cgroup->stat_cpu
in count_memcg_event_mm()(called by handle_mm_fault()) and in
__mod_memcg_state() called by page_add_file_rmap().  So it's likely due
to the changed layout of 'struct mem_cgroup' that either make stat_cpu
falling into a constantly modifying cacheline or some hot fields stop
being in the same cacheline.

I verified this by moving memory_events[] back to where it was:

: --- a/include/linux/memcontrol.h
: +++ b/include/linux/memcontrol.h
: @@ -205,7 +205,6 @@ struct mem_cgroup {
:  	int		oom_kill_disable;
:
:  	/* memory.events */
: -	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
:  	struct cgroup_file events_file;
:
:  	/* protect arrays of thresholds */
: @@ -238,6 +237,7 @@ struct mem_cgroup {
:  	struct mem_cgroup_stat_cpu __percpu *stat_cpu;
:  	atomic_long_t		stat[MEMCG_NR_STAT];
:  	atomic_long_t		events[NR_VM_EVENT_ITEMS];
: +	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
:
:  	unsigned long		socket_pressure;

And performance restored.

Later investigation found that as long as the following 3 fields
moving_account, move_lock_task and stat_cpu are in the same cacheline,
performance will be good.  To avoid future performance surprise by other
commits changing the layout of 'struct mem_cgroup', this patch makes
sure the 3 fields stay in the same cacheline.

One concern of this approach is, moving_account and move_lock_task could
be modified when a process changes memory cgroup while stat_cpu is a
always read field, it might hurt to place them in the same cacheline.  I
assume it is rare for a process to change memory cgroup so this should
be OK.

Link: https://lkml.kernel.org/r/20180528114019.GF9904@yexl-desktop
Link: http://lkml.kernel.org/r/20180601071115.GA27302@intel.com
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/memcontrol.h |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -158,6 +158,15 @@ enum memcg_kmem_state {
 	KMEM_ONLINE,
 };
 
+#if defined(CONFIG_SMP)
+struct memcg_padding {
+	char x[0];
+} ____cacheline_internodealigned_in_smp;
+#define MEMCG_PADDING(name)      struct memcg_padding name;
+#else
+#define MEMCG_PADDING(name)
+#endif
+
 /*
  * The memory controller data structure. The memory controller controls both
  * page cache and RSS per cgroup. We would eventually like to provide
@@ -205,7 +214,6 @@ struct mem_cgroup {
 	int		oom_kill_disable;
 
 	/* memory.events */
-	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
 	struct cgroup_file events_file;
 
 	/* protect arrays of thresholds */
@@ -225,19 +233,26 @@ struct mem_cgroup {
 	 * mem_cgroup ? And what type of charges should we move ?
 	 */
 	unsigned long move_charge_at_immigrate;
+	/* taken only while moving_account > 0 */
+	spinlock_t		move_lock;
+	unsigned long		move_lock_flags;
+
+	MEMCG_PADDING(_pad1_);
+
 	/*
 	 * set > 0 if pages under this cgroup are moving to other cgroup.
 	 */
 	atomic_t		moving_account;
-	/* taken only while moving_account > 0 */
-	spinlock_t		move_lock;
 	struct task_struct	*move_lock_task;
-	unsigned long		move_lock_flags;
 
 	/* memory.stat */
 	struct mem_cgroup_stat_cpu __percpu *stat_cpu;
+
+	MEMCG_PADDING(_pad2_);
+
 	atomic_long_t		stat[MEMCG_NR_STAT];
 	atomic_long_t		events[NR_VM_EVENT_ITEMS];
+	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
 
 	unsigned long		socket_pressure;
 


