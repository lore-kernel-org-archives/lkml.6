Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeFAHLT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:11:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:27898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFAHLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:11:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="52582180"
Date: Fri, 1 Jun 2018 15:11:15 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <xiaolong.ye@intel.com>, lkp@01.org,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH] mem_cgroup: make sure moving_account, move_lock_task and
 stat_cpu in the same cacheline
Message-ID: <20180601071115.GA27302@intel.com>
References: <20180508053451.GD30203@yexl-desktop>
 <20180508172640.GB24175@cmpxchg.org>
 <20180528085201.GA2918@intel.com>
 <20180529084816.GS27180@dhcp22.suse.cz>
 <20180530082752.GF14785@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530082752.GF14785@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LKP robot found a 27% will-it-scale/page_fault3 performance regression
regarding commit e27be240df53("mm: memcg: make sure memory.events is
uptodate when waking pollers").

What the test does is:
1 mkstemp() a 128M file on a tmpfs;
2 start $nr_cpu processes, each to loop the following:
  2.1 mmap() this file in shared write mode;
  2.2 write 0 to this file in a PAGE_SIZE step till the end of the file;
  2.3 unmap() this file and repeat this process.
3 After 5 minutes, check how many loops they managed to complete,
  the higher the better.

The commit itself looks innocent enough as it merely changed some event
counting mechanism and this test didn't trigger those events at all.
Perf shows increased cycles spent on accessing root_mem_cgroup->stat_cpu
in count_memcg_event_mm()(called by handle_mm_fault()) and in
__mod_memcg_state() called by page_add_file_rmap(). So it's likely due
to the changed layout of 'struct mem_cgroup' that either make stat_cpu
falling into a constantly modifying cacheline or some hot fields stop
being in the same cacheline.

I verified this by moving memory_events[] back to where it was:

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71b..c767db1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -205,7 +205,6 @@ struct mem_cgroup {
 	int		oom_kill_disable;

 	/* memory.events */
-	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
 	struct cgroup_file events_file;

 	/* protect arrays of thresholds */
@@ -238,6 +237,7 @@ struct mem_cgroup {
 	struct mem_cgroup_stat_cpu __percpu *stat_cpu;
 	atomic_long_t		stat[MEMCG_NR_STAT];
 	atomic_long_t		events[NR_VM_EVENT_ITEMS];
+	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];

 	unsigned long		socket_pressure;

And performance restored.

Later investigation found that as long as the following 3 fields
moving_account, move_lock_task and stat_cpu are in the same cacheline,
performance will be good. To avoid future performance surprise by
other commits changing the layout of 'struct mem_cgroup', this patch
makes sure the 3 fields stay in the same cacheline.

One concern of this approach is, moving_account and move_lock_task
could be modified when a process changes memory cgroup while stat_cpu
is a always read field, it might hurt to place them in the same
cacheline. I assume it is rare for a process to change memory cgroup
so this should be OK.

LINK: https://lkml.kernel.org/r/20180528114019.GF9904@yexl-desktop
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 include/linux/memcontrol.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..c79972a78d6c 100644
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
@@ -225,17 +234,23 @@ struct mem_cgroup {
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
 
-- 
2.17.0
