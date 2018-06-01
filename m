Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFAH0J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:26:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:48218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeFAH0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:26:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="43855683"
Date: Fri, 1 Jun 2018 15:26:04 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Tejun Heo <tj@kernel.org>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org
Subject: Re: [LKP] [lkp-robot] [mm, memcontrol] 309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Message-ID: <20180601072604.GB27302@intel.com>
References: <20180528114019.GF9904@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528114019.GF9904@yexl-desktop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 07:40:19PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a +23.0% improvement of vm-scalability.throughput due to commit:
> 
> 
> commit: 309fe96bfc0ae387f53612927a8f0dc3eb056efd ("mm, memcontrol: implement memory.swap.events")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: vm-scalability
> on test machine: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 1T
> 	test: lru-shm
> 	cpufreq_governor: performance
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 

With the patch I just sent out:
"mem_cgroup: make sure moving_account, move_lock_task and stat_cpu in the
same cacheline"

Applying this commit on top doesn't yield 23% improvement any more, but
a 6% performace drop...

I found the culprit being the following one line introduced in this commit:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d90b0201a8c4..07ab974c0a49 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6019,13 +6019,17 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	if (!memcg)
 		return 0;
 
-	if (!entry.val)
+	if (!entry.val) {
+		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		return 0;
+	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
If I remove that memcg_memory_event() call, performance will restore.

It's beyond my understanding why this code path matters since there is
no swap device setup in the test machine so I don't see how possible
get_swap_page() could ever be called.

Still investigating...
