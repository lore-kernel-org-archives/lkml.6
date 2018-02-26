Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeBZMd5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:33:57 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34113 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBZMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:33:56 -0500
X-Google-Smtp-Source: AG47ELsg6yaMw/EM+nqQEPf2TtZpbPi6550OMoZKbky4l7b2Idn+NpqJPmC4vMF8dNLMwMOR4W3y1A==
Message-ID: <1519648433.4443.18.camel@redhat.com>
Subject: Re: [lkp-robot] [iversion]  c0cef30e4f:  aim7.jobs-per-min -18.0%
 regression
From: Jeff Layton <jlayton@redhat.com>
To: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        David Howells <dhowells@redhat.com>
Date: Mon, 26 Feb 2018 07:33:53 -0500
In-Reply-To: <1519645434.4443.15.camel@redhat.com>
References: <20180225150505.GD7144@yexl-desktop>
         <1519573271.4702.10.camel@redhat.com> <20180226083807.GE8942@yexl-desktop>
         <1519645434.4443.15.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 06:43 -0500, Jeff Layton wrote:
> On Mon, 2018-02-26 at 16:38 +0800, Ye Xiaolong wrote:
> > On 02/25, Jeff Layton wrote:
> > > On Sun, 2018-02-25 at 23:05 +0800, kernel test robot wrote:
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a -18.0% regression of aim7.jobs-per-min due to commit:
> > > > 
> > > > 
> > > > commit: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e ("iversion: make inode_cmp_iversion{+raw} return bool instead of s64")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > in testcase: aim7
> > > > on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> > > > with following parameters:
> > > > 
> > > > 	disk: 4BRD_12G
> > > > 	md: RAID0
> > > > 	fs: xfs
> > > > 	test: disk_src
> > > > 	load: 3000
> > > > 	cpufreq_governor: performance
> > > > 
> > > > test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> > > > test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> > > > 
> > > > 
> > > 
> > > I'm a bit suspicious of this result.
> > > 
> > > This patch only changes inode_cmp_iversion{+raw} (since renamed to
> > > inode_eq_iversion{+raw}), and that neither should ever be called from
> > > xfs. The patch is fairly trivial too, and I wouldn't expect a big
> > > performance hit.
> > 
> > I tried to queue 4 more times test for both commit c0cef30e4f and its parent,
> > the result seems quite stable.
> > 
> > c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e:
> >  "aim7.jobs-per-min": [
> >     32964.01,
> >     32938.68,
> >     33068.18,
> >     32886.32,
> >     32843.72,
> >     32798.83,
> >     32898.34,
> >     32952.55
> >   ],
> > 
> > 3da90b159b146672f830bcd2489dd3a1f4e9e089:
> >   "aim7.jobs-per-min": [
> >     40239.65,
> >     40163.33,
> >     40353.32,
> >     39976.9,
> >     40185.75,
> >     40411.3,
> >     40213.58,
> >     39900.69
> >   ],
> > 
> > Any other test data you may need?
> > 
> > > 
> > > Is IMA involved here at all? I didn't see any evidence of it, but the
> > > kernel config did have it enabled.
> > > 
> > 
> > Sorry, not quite familiar with IMA, could you tell more about how to check it?
> > 
> 
> Thanks for retesting it, but I'm at a loss for why we're seeing this:
> 
> IMA is the the integrity management subsystem. It will use the iversion
> field to determine whether to remeasure files during remeasurement.  It
> looks like the kernel config has it enabled, but it doesn't look like
> it's in use, based on the info in the initial report.
> 
> This patch only affects two inlined functions inode_cmp_iversion and
> inode_cmp_iversion_raw. The patch is pretty trivial (as Linus points
> out). These functions are only called from IMA and fs-specific code
> (usually in readdir implementations to detect directory changes).
> 
> XFS does not call either of these functions however, so I'm a little
> unclear on how this patch could slow anything down on this test. The
> only thing I can think to do here would be to profile this and see what
> stands out.
> 
> Note that we do need to keep this in perspective too. This 18%
> regression on this test follows around a ~230% improvement that occurred
> when we merged the bulk of these patches. It's should still be quite a
> bit faster than the v4.15 in this regard.
> 
> Still, it'd be good to understand what's going on here.
> 
> 

Could we see the dmesg from this boot? It'd be good to confirm that IMA
is not involved here, as that's the only place that I can see that would
call into this code at all here.

Thanks,
Jeff


> > Thanks,
> > Xiaolong
> > > 
> > > > 
> > > > Details are as below:
> > > > -------------------------------------------------------------------------------------------------->
> > > > 
> > > > 
> > > > To reproduce:
> > > > 
> > > >         git clone https://github.com/intel/lkp-tests.git
> > > >         cd lkp-tests
> > > >         bin/lkp install job.yaml  # job file is attached in this email
> > > >         bin/lkp run     job.yaml
> > > > 
> > > > =========================================================================================
> > > > compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
> > > >   gcc-7/performance/4BRD_12G/xfs/x86_64-rhel-7.2/3000/RAID0/debian-x86_64-2016-08-31.cgz/lkp-ivb-ep01/disk_src/aim7
> > > > 
> > > > commit: 
> > > >   3da90b159b (" f2fs-for-4.16-rc1")
> > > >   c0cef30e4f ("iversion: make inode_cmp_iversion{+raw} return bool instead of s64")
> > > > 
> > > > 3da90b159b146672 c0cef30e4ff0dc025f4a1660b8 
> > > > ---------------- -------------------------- 
> > > >          %stddev     %change         %stddev
> > > >              \          |                \  
> > > >      40183           -18.0%      32964        aim7.jobs-per-min
> > > >     448.60           +21.9%     546.68        aim7.time.elapsed_time
> > > >     448.60           +21.9%     546.68        aim7.time.elapsed_time.max
> > > >       5615 ±  5%     +33.4%       7489 ±  4%  aim7.time.involuntary_context_switches
> > > >       3086           +14.0%       3518        aim7.time.system_time
> > > >   19439782            -5.6%   18359474        aim7.time.voluntary_context_switches
> > > >     199333           +14.3%     227794 ±  2%  interrupts.CAL:Function_call_interrupts
> > > >       0.59            -0.1        0.50        mpstat.cpu.usr%
> > > >    2839401           +16.0%    3293688        softirqs.SCHED
> > > >    7600068           +15.1%    8747820        softirqs.TIMER
> > > >     118.00 ± 43%     +98.7%     234.50 ± 15%  vmstat.io.bo
> > > >      87840           -22.4%      68154        vmstat.system.cs
> > > >     552798 ±  6%     +15.8%     640107 ±  4%  numa-numastat.node0.local_node
> > > >     557345 ±  6%     +15.7%     644666 ±  4%  numa-numastat.node0.numa_hit
> > > >     528341 ±  7%     +21.7%     642933 ±  4%  numa-numastat.node1.local_node
> > > >     531604 ±  7%     +21.6%     646209 ±  4%  numa-numastat.node1.numa_hit
> > > >  2.147e+09           -12.4%   1.88e+09        cpuidle.C1.time
> > > >   13702041           -14.7%   11683737        cpuidle.C1.usage
> > > >  2.082e+08 ±  4%     +28.1%  2.667e+08 ±  5%  cpuidle.C1E.time
> > > >  4.719e+08 ±  2%     +23.1%  5.807e+08 ±  4%  cpuidle.C3.time
> > > >  1.141e+10           +31.0%  1.496e+10        cpuidle.C6.time
> > > >   15672622           +27.8%   20031028        cpuidle.C6.usage
> > > >   13520572 ±  3%     +29.5%   17514398 ±  9%  cpuidle.POLL.time
> > > >     278.25 ±  5%     -46.0%     150.25 ± 73%  numa-vmstat.node0.nr_dirtied
> > > >       3200 ± 14%     -20.6%       2542 ± 19%  numa-vmstat.node0.nr_mapped
> > > >     277.75 ±  5%     -46.2%     149.50 ± 73%  numa-vmstat.node0.nr_written
> > > >      28.50 ± 52%    +448.2%     156.25 ± 70%  numa-vmstat.node1.nr_dirtied
> > > >       2577 ± 19%     +26.3%       3255 ± 15%  numa-vmstat.node1.nr_mapped
> > > >     634338 ±  4%      +7.8%     683959 ±  4%  numa-vmstat.node1.numa_hit
> > > >     457411 ±  6%     +10.8%     506800 ±  5%  numa-vmstat.node1.numa_local
> > > >       3734 ±  8%     -11.5%       3306 ±  6%  proc-vmstat.numa_hint_faults_local
> > > >    1114538           +18.3%    1318978        proc-vmstat.numa_hit
> > > >    1106722           +18.5%    1311136        proc-vmstat.numa_local
> > > >      22100            +7.5%      23753 ±  4%  proc-vmstat.numa_pages_migrated
> > > >    1174556           +18.0%    1386359        proc-vmstat.pgalloc_normal
> > > >    1241445           +18.1%    1466086        proc-vmstat.pgfault
> > > >    1138310           +19.3%    1358132        proc-vmstat.pgfree
> > > >      22100            +7.5%      23753 ±  4%  proc-vmstat.pgmigrate_success
> > > >      53332 ± 43%    +143.0%     129617 ± 14%  proc-vmstat.pgpgout
> > > >       1.42 ±  2%      +1.7        3.07        perf-stat.branch-miss-rate%
> > > >  1.064e+10          +123.3%  2.375e+10        perf-stat.branch-misses
> > > >      10.79            +0.6       11.43        perf-stat.cache-miss-rate%
> > > >  5.583e+09            +5.9%  5.915e+09        perf-stat.cache-misses
> > > >   39652092            -5.0%   37662545        perf-stat.context-switches
> > > >       1.29           +11.7%       1.44        perf-stat.cpi
> > > >  4.637e+12           +12.8%   5.23e+12        perf-stat.cpu-cycles
> > > >  8.653e+11            +9.8%  9.498e+11 ±  2%  perf-stat.dTLB-loads
> > > >  3.654e+11           +12.4%  4.109e+11        perf-stat.dTLB-stores
> > > >       0.78           -10.5%       0.70        perf-stat.ipc
> > > >    1214932           +17.9%    1432266        perf-stat.minor-faults
> > > >  1.334e+09            -1.8%   1.31e+09        perf-stat.node-store-misses
> > > >  1.651e+09            -1.8%   1.62e+09        perf-stat.node-stores
> > > >    1214954           +17.9%    1432313        perf-stat.page-faults
> > > >     256.75          -100.0%       0.00        turbostat.Avg_MHz
> > > >      21.39           -21.4        0.00        turbostat.Busy%
> > > >       1200          -100.0%       0.00        turbostat.Bzy_MHz
> > > >   13695007          -100.0%       0.00        turbostat.C1
> > > >      11.92           -11.9        0.00        turbostat.C1%
> > > >    2116683 ±  2%    -100.0%       0.00        turbostat.C1E
> > > >       1.16 ±  4%      -1.2        0.00        turbostat.C1E%
> > > >    3112269          -100.0%       0.00        turbostat.C3
> > > >       2.62 ±  2%      -2.6        0.00        turbostat.C3%
> > > >   15671277          -100.0%       0.00        turbostat.C6
> > > >      63.38           -63.4        0.00        turbostat.C6%
> > > >      49.46          -100.0%       0.00        turbostat.CPU%c1
> > > >       1.42 ±  2%    -100.0%       0.00        turbostat.CPU%c3
> > > >      27.73          -100.0%       0.00        turbostat.CPU%c6
> > > >      31.41          -100.0%       0.00        turbostat.CorWatt
> > > >      63.25          -100.0%       0.00        turbostat.CoreTmp
> > > >   18919351          -100.0%       0.00        turbostat.IRQ
> > > >       1.21 ± 18%    -100.0%       0.00        turbostat.Pkg%pc2
> > > >       0.67 ± 31%    -100.0%       0.00        turbostat.Pkg%pc6
> > > >      63.25          -100.0%       0.00        turbostat.PkgTmp
> > > >      57.63          -100.0%       0.00        turbostat.PkgWatt
> > > >      30.73          -100.0%       0.00        turbostat.RAMWatt
> > > >      36030          -100.0%       0.00        turbostat.SMI
> > > >       3000          -100.0%       0.00        turbostat.TSC_MHz
> > > > 
> > > >                                                                                 
> > > >                                   aim7.jobs-per-min                             
> > > >                                                                                 
> > > >   41000 +-+-----------------------------------------------------------------+   
> > > >         |  ..+....+....  ..+....+....+....   ..+....+....+...+....          |   
> > > >   40000 +-+            +.                 +..                     +         |   
> > > >   39000 +-+                                                                 |   
> > > >         |                                                                   |   
> > > >   38000 +-+                                                                 |   
> > > >   37000 +-+                                                                 |   
> > > >         |                                                                   |   
> > > >   36000 +-+                                                                 |   
> > > >   35000 +-+                                                                 |   
> > > >         |                                                                   |   
> > > >   34000 +-+                                                                 |   
> > > >   33000 +-+                                         O                  O    |   
> > > >         O    O    O    O   O    O    O    O    O         O   O    O         O   
> > > >   32000 +-+-----------------------------------------------------------------+   
> > > >                                                                                 
> > > >                                                                                                                                                                                                                                         
> > > >                                                                                 
> > > > [*] bisect-good sample
> > > > [O] bisect-bad  sample
> > > > 
> > > > 
> > > > 
> > > > Disclaimer:
> > > > Results have been estimated based on internal Intel analysis and are provided
> > > > for informational purposes only. Any difference in system hardware or software
> > > > design or configuration may affect actual performance.
> > > > 
> > > > 
> > > > Thanks,
> > > > Xiaolong
> > > 
> > > -- 
> > > Jeff Layton <jlayton@redhat.com>
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>
