Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E39C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7982081D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7982081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKIMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:35:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:5509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeKIMfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:35:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 18:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="scan'208";a="94826158"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2018 18:56:34 -0800
Date:   Fri, 9 Nov 2018 10:56:34 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Rong Chen <rong.a.chen@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@wand.net.nz>
Cc:     lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [bpf] fd978bf7fd: will-it-scale.per_process_ops -4.0%
 regression
Message-ID: <20181109025634.GC20462@intel.com>
References: <20181102021408.GJ24195@shao2-debian>
 <a66d304e-43ec-5558-67dc-5edfd856b607@iogearbox.net>
 <9de53d57-b1be-2186-c90b-dbeda21ed717@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9de53d57-b1be-2186-c90b-dbeda21ed717@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:19:54AM +0800, Rong Chen wrote:
> 
> 
> On 11/02/2018 04:36 PM, Daniel Borkmann wrote:
> > Hi Rong,
> > 
> > On 11/02/2018 03:14 AM, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -4.0% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: fd978bf7fd312581a7ca454a991f0ffb34c4204b ("bpf: Add reference tracking to verifier")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: will-it-scale
> > > on test machine: 80 threads Skylake with 64G memory
> > > with following parameters:
> > > 
> > > 	nr_task: 100%
> > > 	mode: process
> > > 	test: mmap1
> > > 	cpufreq_governor: performance
> > Hmm, so the test cases you are running are these ones:
> > 
> >    https://github.com/antonblanchard/will-it-scale/blob/master/tests/mmap1.c
> >    https://github.com/antonblanchard/will-it-scale/blob/master/tests/mmap2.c
> > 
> > The commit from Joe referenced above only adds a feature to the (eBPF) verifier. Looking
> > through will-it-scale test suite, looks like there's neither cBPF nor eBPF in use and if
> > it would have been the former (e.g. via seccomp BPF), then also this has no effect on it
> > since this doesn't load through bpf(2); meaning if so then something must use eBPF here,
> > but then it's also unclear right now how this would even remotely affect mmap() test
> > performance by -4%. Hm, are you certain it's not a false bisection? If so, what else is
> > loading eBPF on your machine in parallel when you run the tests?
> 
> Please accept my apologies for taking your time, It's a false bisection.

It shouldn't be a false bisection - I rerun the two kernels using this
workload with this commit and its parent on the same test box, the
performance gap is there.

> Something strange happened, we're trying to figure out the root cause.

Yeah, it's not clear what it is :-)

Daniel & Joe,

We will see if we can find something and will let you know if we do.
Before then, I think you can ignore this report, thanks for your time.

Regards,
Aaron

> > > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > > test-url: https://github.com/antonblanchard/will-it-scale
> > > 
> > > In addition to that, the commit also has significant impact on the following tests:
> > > 
> > > +------------------+---------------------------------------------------------------+
> > > | testcase: change | will-it-scale: will-it-scale.per_process_ops -3.8% regression |
> > > | test machine     | 80 threads Skylake with 64G memory                            |
> > > | test parameters  | cpufreq_governor=performance                                  |
> > > |                  | mode=process                                                  |
> > > |                  | nr_task=100%                                                  |
> > > |                  | test=mmap2                                                    |
> > > +------------------+---------------------------------------------------------------+
> > > 
> > > 
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > To reproduce:
> > > 
> > >          git clone https://github.com/intel/lkp-tests.git
> > >          cd lkp-tests
> > >          bin/lkp install job.yaml  # job file is attached in this email
> > >          bin/lkp run     job.yaml
> > > 
> > > =========================================================================================
> > > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> > >    gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-04-03.cgz/lkp-skl-2sp2/mmap1/will-it-scale
> > > 
> > > commit:
> > >    84dbf35073 ("bpf: Macrofy stack state copy")
> > >    fd978bf7fd ("bpf: Add reference tracking to verifier")
> > > 
> > > 84dbf3507349696b fd978bf7fd312581a7ca454a99
> > > ---------------- --------------------------
> > >           %stddev     %change         %stddev
> > >               \          |                \
> > >       16811            -4.0%      16140        will-it-scale.per_process_ops
> > >     1344946            -4.0%    1291230        will-it-scale.workload
> > >      107.75 ± 38%    +252.4%     379.75 ± 93%  cpuidle.POLL.usage
> > >      121.70 ± 18%     +18.9%     144.70 ±  4%  sched_debug.cfs_rq:/.exec_clock.stddev
> > >        4933            +2.0%       5031        proc-vmstat.nr_inactive_anon
> > >        4933            +2.0%       5031        proc-vmstat.nr_zone_inactive_anon
> > >        9874            +9.0%      10765 ±  7%  slabinfo.proc_inode_cache.active_objs
> > >        9874            +9.0%      10765 ±  7%  slabinfo.proc_inode_cache.num_objs
> > >       12248 ± 50%     +52.2%      18640 ±  2%  numa-meminfo.node0.Inactive
> > >       33943 ±  8%     +16.2%      39453 ±  6%  numa-meminfo.node0.SReclaimable
> > >       91549 ±  9%      -9.9%      82530 ±  7%  numa-meminfo.node1.Slab
> > >       18091 ± 15%     +29.2%      23382 ± 17%  numa-vmstat.node0
> > >        3027 ± 52%     +52.6%       4620 ±  3%  numa-vmstat.node0.nr_inactive_anon
> > >        8485 ±  8%     +16.2%       9862 ±  6%  numa-vmstat.node0.nr_slab_reclaimable
> > >        3027 ± 52%     +52.6%       4620 ±  3%  numa-vmstat.node0.nr_zone_inactive_anon
> > >     1.4e+12            -2.5%  1.364e+12        perf-stat.branch-instructions
> > >       41.42            +0.7       42.15        perf-stat.cache-miss-rate%
> > >   2.166e+10            -2.1%   2.12e+10        perf-stat.cache-references
> > >       12.16            +2.7%      12.49        perf-stat.cpi
> > >   1.741e+12            -2.8%  1.692e+12        perf-stat.dTLB-loads
> > >        0.00 ±  3%      +0.0        0.00 ±  9%  perf-stat.dTLB-store-miss-rate%
> > >   5.713e+11            -3.9%   5.49e+11        perf-stat.dTLB-stores
> > >   6.103e+12            -2.6%  5.943e+12        perf-stat.instructions
> > >        0.08            -2.6%       0.08        perf-stat.ipc
> > >   1.954e+09            -1.8%  1.919e+09        perf-stat.node-load-misses
> > >     4538060            +1.4%    4602862        perf-stat.path-length
> > >       49.62            -0.5       49.14        perf-profile.calltrace.cycles-pp.do_munmap.vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       47.64            -0.5       47.17        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.do_munmap.vm_munmap.__x64_sys_munmap
> > >       47.49            -0.5       47.02        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.do_munmap.vm_munmap
> > >       49.99            -0.5       49.53        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       49.96            -0.5       49.51        perf-profile.calltrace.cycles-pp.vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       48.02            -0.4       47.58        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_munmap.vm_munmap.__x64_sys_munmap.do_syscall_64
> > >        1.41            -0.0        1.37        perf-profile.calltrace.cycles-pp.unmap_region.do_munmap.vm_munmap.__x64_sys_munmap.do_syscall_64
> > >       47.73            +0.4       48.11        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region
> > >       47.85            +0.4       48.25        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap
> > >       48.28            +0.4       48.68        perf-profile.calltrace.cycles-pp.__vm_enough_memory.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
> > >       48.23            +0.4       48.63        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap.vm_mmap_pgoff
> > >       48.96            +0.4       49.41        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
> > >       49.11            +0.5       49.56        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       49.24            +0.5       49.70        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       49.25            +0.5       49.72        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       49.62            -0.5       49.15        perf-profile.children.cycles-pp.do_munmap
> > >       49.99            -0.5       49.53        perf-profile.children.cycles-pp.__x64_sys_munmap
> > >       49.97            -0.5       49.51        perf-profile.children.cycles-pp.vm_munmap
> > >        0.51 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.___might_sleep
> > >        1.16            -0.0        1.11        perf-profile.children.cycles-pp.unmap_vmas
> > >        1.15            -0.0        1.10        perf-profile.children.cycles-pp.unmap_page_range
> > >        1.41            -0.0        1.37        perf-profile.children.cycles-pp.unmap_region
> > >        0.32 ±  2%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.up_write
> > >        0.32 ±  2%      +0.0        0.34        perf-profile.children.cycles-pp.vm_area_alloc
> > >        0.29            +0.0        0.32        perf-profile.children.cycles-pp.kmem_cache_alloc
> > >       48.28            +0.4       48.68        perf-profile.children.cycles-pp.__vm_enough_memory
> > >       48.96            +0.4       49.41        perf-profile.children.cycles-pp.mmap_region
> > >       49.11            +0.5       49.56        perf-profile.children.cycles-pp.do_mmap
> > >       49.25            +0.5       49.71        perf-profile.children.cycles-pp.vm_mmap_pgoff
> > >       49.25            +0.5       49.72        perf-profile.children.cycles-pp.ksys_mmap_pgoff
> > >        0.47 ±  3%      -0.0        0.43        perf-profile.self.cycles-pp.___might_sleep
> > >        0.32 ±  3%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.up_write
> > >        0.27            +0.0        0.30        perf-profile.self.cycles-pp.kmem_cache_alloc
> > >        0.49            +0.0        0.53        perf-profile.self.cycles-pp.percpu_counter_add_batch
> > > 
> > > 
> > >                              will-it-scale.per_process_ops
> > >    18000 +-+-----------------------------------------------------------------+
> > >          |                                                                   |
> > >    17500 +-+   +.+                                                           |
> > >          |+.+++  :            +.++++.+++           ++++.++++.++              |
> > >          |        :++. +      :        :          :            :             |
> > >    17000 +-+      +   + ++.++:          :  ++.+++ :            ++.+ ++.   +. |
> > >          |                   +          +.+      +                 +   +++  +|
> > >    16500 +-+                                                                 |
> > >          |              O  OOOO OOOO O O                                     |
> > >    16000 +-+           O O            O O O                                  |
> > >          |                                                                   |
> > >          O     O  OOO O                                                      |
> > >    15500 +O+OOO  O                                                           |
> > >          |                                                                   |
> > >    15000 +-+-----------------------------------------------------------------+
> > >                                  will-it-scale.workload
> > >    1.42e+06 +-+--------------------------------------------------------------+
> > >     1.4e+06 +-+   ++                                                         |
> > >             |++.++ :                 ++.                   +++.+             |
> > >    1.38e+06 +-+     :           +.+++   ++          ++++.++    :             |
> > >    1.36e+06 +-+     +.+++++.    :         :         :           :+           |
> > >             |               ++++          ++.+++++.+            + ++.+++++.++|
> > >    1.34e+06 +-+                                                              |
> > >    1.32e+06 +-+                                                              |
> > >     1.3e+06 +-+               O                                              |
> > >             |            OO OO OO OOOOO  OOO                                 |
> > >    1.28e+06 +-+                         O                                    |
> > >    1.26e+06 +-+       O                                                      |
> > >             O     O O  OO                                                    |
> > >    1.24e+06 +OO OO O                                                         |
> > >    1.22e+06 +-+--------------------------------------------------------------+
> > > [*] bisect-good sample
> > > [O] bisect-bad  sample
> > > 
> > > ***************************************************************************************************
> > > lkp-skl-2sp2: 80 threads Skylake with 64G memory
> > > =========================================================================================
> > > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> > >    gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-04-03.cgz/lkp-skl-2sp2/mmap2/will-it-scale
> > > 
> > > commit:
> > >    84dbf35073 ("bpf: Macrofy stack state copy")
> > >    fd978bf7fd ("bpf: Add reference tracking to verifier")
> > > 
> > > 84dbf3507349696b fd978bf7fd312581a7ca454a99
> > > ---------------- --------------------------
> > >           %stddev     %change         %stddev
> > >               \          |                \
> > >       16832            -3.8%      16186        will-it-scale.per_process_ops
> > >     1346634            -3.8%    1294984        will-it-scale.workload
> > >      390809 ± 21%     +51.6%     592424 ± 27%  cpuidle.C1.time
> > >        6897            +2.7%       7085        proc-vmstat.nr_mapped
> > >      936.00 ±  7%     +15.6%       1082 ±  5%  slabinfo.Acpi-ParseExt.active_objs
> > >      936.00 ±  7%     +15.6%       1082 ±  5%  slabinfo.Acpi-ParseExt.num_objs
> > >      968.00 ±  9%     +27.5%       1233 ± 16%  slabinfo.pool_workqueue.active_objs
> > >      968.00 ±  9%     +29.7%       1255 ± 16%  slabinfo.pool_workqueue.num_objs
> > >        8430           -14.1%       7244 ±  2%  numa-meminfo.node0.KernelStack
> > >        4283 ± 14%     -22.4%       3325 ± 10%  numa-meminfo.node0.PageTables
> > >       73929 ±  3%     -10.6%      66061 ±  6%  numa-meminfo.node0.SUnreclaim
> > >        5569 ±  2%     +21.0%       6738 ±  3%  numa-meminfo.node1.KernelStack
> > >       55085 ±  5%     +17.5%      64739 ±  5%  numa-meminfo.node1.SUnreclaim
> > >       81155 ±  6%     +16.2%      94292 ±  7%  numa-meminfo.node1.Slab
> > >      230.00          -100.0%       0.00        numa-vmstat.node0.nr_active_file
> > >      100.25 ±  3%     -88.8%      11.25 ±173%  numa-vmstat.node0.nr_inactive_file
> > >        8431           -14.1%       7245 ±  2%  numa-vmstat.node0.nr_kernel_stack
> > >        1071 ± 14%     -22.4%     831.25 ± 10%  numa-vmstat.node0.nr_page_table_pages
> > >       18482 ±  3%     -10.6%      16515 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
> > >      230.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
> > >      100.25 ±  3%     -88.8%      11.25 ±173%  numa-vmstat.node0.nr_zone_inactive_file
> > >        5569 ±  2%     +21.0%       6738 ±  3%  numa-vmstat.node1.nr_kernel_stack
> > >        2778 ±  3%     +28.4%       3567 ± 16%  numa-vmstat.node1.nr_mapped
> > >       13771 ±  5%     +17.5%      16184 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
> > >   1.506e+12            -2.5%  1.468e+12        perf-stat.branch-instructions
> > >       41.41            +0.8       42.20        perf-stat.cache-miss-rate%
> > >   2.165e+10            -1.7%  2.129e+10        perf-stat.cache-references
> > >       11.25            +2.8%      11.57        perf-stat.cpi
> > >   1.891e+12            -2.8%  1.838e+12        perf-stat.dTLB-loads
> > >   6.543e+11            -3.7%    6.3e+11        perf-stat.dTLB-stores
> > >   6.591e+12            -2.6%  6.419e+12        perf-stat.instructions
> > >        0.09            -2.7%       0.09        perf-stat.ipc
> > >   1.967e+09            -1.3%  1.941e+09        perf-stat.node-load-misses
> > >     4894750            +1.3%    4956596        perf-stat.path-length
> > >       40.37 ± 12%     -16.2%      33.81 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
> > >        0.05 ±  2%     +18.7%       0.06 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
> > >        6.37 ± 40%     -50.2%       3.17 ± 32%  sched_debug.cfs_rq:/.removed.load_avg.avg
> > >       31.64 ± 18%     -28.5%      22.63 ± 16%  sched_debug.cfs_rq:/.removed.load_avg.stddev
> > >      293.89 ± 40%     -50.1%     146.61 ± 32%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
> > >        1459 ± 18%     -28.3%       1045 ± 16%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
> > >        2.46 ± 43%     -60.9%       0.96 ± 66%  sched_debug.cfs_rq:/.removed.util_avg.avg
> > >       12.42 ± 26%     -46.5%       6.64 ± 59%  sched_debug.cfs_rq:/.removed.util_avg.stddev
> > >      385.92 ±  6%     +12.8%     435.46 ±  2%  sched_debug.cpu.nr_switches.min
> > >      -14.21           -31.4%      -9.75        sched_debug.cpu.nr_uninterruptible.min
> > >       47.54            -0.2       47.31        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.do_munmap.vm_munmap
> > >       47.67            -0.2       47.45        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.do_munmap.vm_munmap.__x64_sys_munmap
> > >       48.04            -0.2       47.86        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_munmap.vm_munmap.__x64_sys_munmap.do_syscall_64
> > >       99.36            -0.0       99.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
> > >        1.47            +0.0        1.51        perf-profile.calltrace.cycles-pp.unmap_region.do_munmap.vm_munmap.__x64_sys_munmap.do_syscall_64
> > >       94.77            -0.3       94.52        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> > >       95.04            -0.2       94.81        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
> > >       95.77            -0.2       95.60        perf-profile.children.cycles-pp.percpu_counter_add_batch
> > >       49.72            -0.1       49.58        perf-profile.children.cycles-pp.do_munmap
> > >        0.53 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.___might_sleep
> > >        0.30 ±  2%      +0.0        0.33        perf-profile.children.cycles-pp.perf_event_mmap
> > >        0.30 ±  3%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.vm_area_alloc
> > >        0.33 ±  2%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.up_write
> > >        1.48            +0.0        1.51        perf-profile.children.cycles-pp.unmap_region
> > >       94.77            -0.3       94.52        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> > >        0.48 ±  2%      -0.0        0.44        perf-profile.self.cycles-pp.___might_sleep
> > >        0.33 ±  2%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.up_write
> > >        0.53            +0.0        0.57        perf-profile.self.cycles-pp.unmap_page_range
> > >        0.47            +0.0        0.52 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
> > > 
> > > 
> > > 
> > > 
> > > 
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are provided
> > > for informational purposes only. Any difference in system hardware or software
> > > design or configuration may affect actual performance.
> > > 
> > > 
> > > Thanks,
> > > Rong Chen
> > > 
> 
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
