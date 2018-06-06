Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D757601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeFFIu5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:50:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:35166 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932150AbeFFIu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:50:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="205734181"
Date: Wed, 6 Jun 2018 16:50:54 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Tejun Heo <tj@kernel.org>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [LKP] [lkp-robot] [mm, memcontrol] 309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Message-ID: <20180606085053.GA21167@intel.com>
References: <20180528114019.GF9904@yexl-desktop>
 <20180601072604.GB27302@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601072604.GB27302@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 03:26:04PM +0800, Aaron Lu wrote:
> On Mon, May 28, 2018 at 07:40:19PM +0800, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed a +23.0% improvement of vm-scalability.throughput due to commit:
> > 
> > 
> > commit: 309fe96bfc0ae387f53612927a8f0dc3eb056efd ("mm, memcontrol: implement memory.swap.events")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: vm-scalability
> > on test machine: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	size: 1T
> > 	test: lru-shm
> > 	cpufreq_governor: performance
> > 
> > test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> > test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> > 
> 
> With the patch I just sent out:
> "mem_cgroup: make sure moving_account, move_lock_task and stat_cpu in the
> same cacheline"
> 
> Applying this commit on top doesn't yield 23% improvement any more, but
> a 6% performace drop...
> I found the culprit being the following one line introduced in this commit:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d90b0201a8c4..07ab974c0a49 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6019,13 +6019,17 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  	if (!memcg)
>  		return 0;
>  
> -	if (!entry.val)
> +	if (!entry.val) {
> +		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);

Removing this line restored performance but it really doesn't make any
sense. Ying suggested it might be code alignment related and suggested
to use a different compiler than gcc-7.2. Then I used gcc-6.4 and turned
out the test result to be pretty much the same for the two commits:

(each test has run for 3 times)
$ grep throughput base/*/stats.json
base/0/stats.json: "vm-scalability.throughput": 89207489,
base/1/stats.json: "vm-scalability.throughput": 89982933,
base/2/stats.json: "vm-scalability.throughput": 90436592,

$ grep throughput head/*/stats.json
head/0/stats.json: "vm-scalability.throughput": 90882775,
head/1/stats.json: "vm-scalability.throughput": 90675220,
head/2/stats.json: "vm-scalability.throughput": 91173479,

So probably it's really related to code alignment and this bisected
commit doesn't cause performance change(as expected).

>  		return 0;
> +	}
>  
>  	memcg = mem_cgroup_id_get_online(memcg);
>  
> If I remove that memcg_memory_event() call, performance will restore.
> 
> It's beyond my understanding why this code path matters since there is
> no swap device setup in the test machine so I don't see how possible
> get_swap_page() could ever be called.
> 
> Still investigating...
> 
