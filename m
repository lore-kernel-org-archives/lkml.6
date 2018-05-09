Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935328AbeEIPA6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:00:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:46586 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935065AbeEIPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:00:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="39650549"
Date: Wed, 9 May 2018 23:02:21 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel test robot <xiaolong.ye@intel.com>, lkp@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LKP] [lkp-robot] [mm] e27be240df: will-it-scale.per_process_ops
 -27.2% regression
Message-ID: <20180509150221.GA4848@intel.com>
References: <20180508053451.GD30203@yexl-desktop>
 <20180508172640.GB24175@cmpxchg.org>
 <20180509023211.GB10016@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509023211.GB10016@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 10:32:11AM +0800, Aaron Lu wrote:
> On Tue, May 08, 2018 at 01:26:40PM -0400, Johannes Weiner wrote:
> > Hello,
> > 
> > On Tue, May 08, 2018 at 01:34:51PM +0800, kernel test robot wrote:
> > > FYI, we noticed a -27.2% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: e27be240df53f1a20c659168e722b5d9f16cc7f4 ("mm: memcg: make sure memory.events is uptodate when waking pollers")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: will-it-scale
> > > on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 128G memory
> > > with following parameters:
> > > 
> > > 	nr_task: 100%
> > > 	mode: process
> > > 	test: page_fault3
> > > 	cpufreq_governor: performance
> > > 
> > > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > > test-url: https://github.com/antonblanchard/will-it-scale
> > 
> > This is surprising. Do you run these tests in a memory cgroup with a
> > limit set? Can you dump that cgroup's memory.events after the run?
> 
> There is no cgroup related setup so yes, this is surprising.
> But the result is quite stable, I have just confirmed on another
> Haswell-EP machine.
> 
> perf shows increased cycles spent for lock_page_memcg and
> unlock_page_memcg, maybe this can shed some light. Full profile for this
> commit and its parent are attached.
> 
> I have also attached dmesg for both commits in case they are useful,
> please feel free to let me know if you need any other information. We
> also collected a ton of other information during the run like
> /proc/vmstat, /proc/meminfo, /proc/interrupt etc.

Test on Broadwell-EP also showed 35% regression, here are a list of
functions that take more CPU cycles with this commit according to perf:

a38c015f3156895b e27be240df53f1a20c659168e7                                                                                    
---------------- --------------------------                                                                                    
         %stddev     %change         %stddev
             \          |                \
  58033709           -35.0%   37727244        will-it-scale.workload
... ...
      3.82            +6.1        9.97        perf-profile.self.cycles-pp.handle_mm_fault
      3.19            +6.2        9.37        perf-profile.self.cycles-pp.page_remove_rmap
      0.25            +6.5        6.71        perf-profile.self.cycles-pp.__unlock_page_memcg
      3.63            +7.5       11.15        perf-profile.self.cycles-pp.page_add_file_rmap
      0.60            +8.1        8.70        perf-profile.self.cycles-pp.lock_page_memcg
