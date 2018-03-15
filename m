Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCOHfS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:35:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:8539 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCOHfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:35:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="211496609"
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0%
 regression
To: Jeff Layton <jlayton@redhat.com>,
        kernel test robot <xiaolong.ye@intel.com>
Cc: lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180225150505.GD7144@yexl-desktop>
 <1519573271.4702.10.camel@redhat.com>
From: kemi <kemi.wang@intel.com>
Message-ID: <1078e19a-3393-7cd9-3b1f-fae6cf0281d3@intel.com>
Date: Thu, 15 Mar 2018 15:33:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519573271.4702.10.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff
   Today, I deleted the previous kernel images for commit 3da90b159b146672f830bcd2489dd3a1f4e9e089
and commit c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e, respectively. And, re-run the same aim7 
jobs for three times for each commit. The aim7 score between two commit does not have obvious difference.

Perhaps something weird happen when compiling kernel. Please ignore this report, apologize for the bother.


On 2018年02月25日 23:41, Jeff Layton wrote:
> On Sun, 2018-02-25 at 23:05 +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -18.0% regression of aim7.jobs-per-min due to commit:
>>
>>
>> commit: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e ("iversion: make inode_cmp_iversion{+raw} return bool instead of s64")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: aim7
>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
>> with following parameters:
>>
>> 	disk: 4BRD_12G
>> 	md: RAID0
>> 	fs: xfs
>> 	test: disk_src
>> 	load: 3000
>> 	cpufreq_governor: performance
>>
>> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>>
>>
> 
> I'm a bit suspicious of this result.
> 
> This patch only changes inode_cmp_iversion{+raw} (since renamed to
> inode_eq_iversion{+raw}), and that neither should ever be called from
> xfs. The patch is fairly trivial too, and I wouldn't expect a big
> performance hit.
> 
> Is IMA involved here at all? I didn't see any evidence of it, but the
> kernel config did have it enabled.
> 
> 
>>
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         bin/lkp install job.yaml  # job file is attached in this email
>>         bin/lkp run     job.yaml
>>
>> =========================================================================================
>> compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
>>   gcc-7/performance/4BRD_12G/xfs/x86_64-rhel-7.2/3000/RAID0/debian-x86_64-2016-08-31.cgz/lkp-ivb-ep01/disk_src/aim7
>>
>> commit: 
>>   3da90b159b (" f2fs-for-4.16-rc1")
>>   c0cef30e4f ("iversion: make inode_cmp_iversion{+raw} return bool instead of s64")
>>
>> 3da90b159b146672 c0cef30e4ff0dc025f4a1660b8 
>> ---------------- -------------------------- 
>>          %stddev     %change         %stddev
>>              \          |                \  
>>      40183           -18.0%      32964        aim7.jobs-per-min
>>     448.60           +21.9%     546.68        aim7.time.elapsed_time
>>     448.60           +21.9%     546.68        aim7.time.elapsed_time.max
>>       5615 ±  5%     +33.4%       7489 ±  4%  aim7.time.involuntary_context_switches
>>       3086           +14.0%       3518        aim7.time.system_time
>>   19439782            -5.6%   18359474        aim7.time.voluntary_context_switches
>>     199333           +14.3%     227794 ±  2%  interrupts.CAL:Function_call_interrupts
>>       0.59            -0.1        0.50        mpstat.cpu.usr%
>>    2839401           +16.0%    3293688        softirqs.SCHED
>>    7600068           +15.1%    8747820        softirqs.TIMER
>>     118.00 ± 43%     +98.7%     234.50 ± 15%  vmstat.io.bo
>>      87840           -22.4%      68154        vmstat.system.cs
>>     552798 ±  6%     +15.8%     640107 ±  4%  numa-numastat.node0.local_node
>>     557345 ±  6%     +15.7%     644666 ±  4%  numa-numastat.node0.numa_hit
>>     528341 ±  7%     +21.7%     642933 ±  4%  numa-numastat.node1.local_node
>>     531604 ±  7%     +21.6%     646209 ±  4%  numa-numastat.node1.numa_hit
>>  2.147e+09           -12.4%   1.88e+09        cpuidle.C1.time
>>   13702041           -14.7%   11683737        cpuidle.C1.usage
>>  2.082e+08 ±  4%     +28.1%  2.667e+08 ±  5%  cpuidle.C1E.time
>>  4.719e+08 ±  2%     +23.1%  5.807e+08 ±  4%  cpuidle.C3.time
>>  1.141e+10           +31.0%  1.496e+10        cpuidle.C6.time
>>   15672622           +27.8%   20031028        cpuidle.C6.usage
>>   13520572 ±  3%     +29.5%   17514398 ±  9%  cpuidle.POLL.time
>>     278.25 ±  5%     -46.0%     150.25 ± 73%  numa-vmstat.node0.nr_dirtied
>>       3200 ± 14%     -20.6%       2542 ± 19%  numa-vmstat.node0.nr_mapped
>>     277.75 ±  5%     -46.2%     149.50 ± 73%  numa-vmstat.node0.nr_written
>>      28.50 ± 52%    +448.2%     156.25 ± 70%  numa-vmstat.node1.nr_dirtied
>>       2577 ± 19%     +26.3%       3255 ± 15%  numa-vmstat.node1.nr_mapped
>>     634338 ±  4%      +7.8%     683959 ±  4%  numa-vmstat.node1.numa_hit
>>     457411 ±  6%     +10.8%     506800 ±  5%  numa-vmstat.node1.numa_local
>>       3734 ±  8%     -11.5%       3306 ±  6%  proc-vmstat.numa_hint_faults_local
>>    1114538           +18.3%    1318978        proc-vmstat.numa_hit
>>    1106722           +18.5%    1311136        proc-vmstat.numa_local
>>      22100            +7.5%      23753 ±  4%  proc-vmstat.numa_pages_migrated
>>    1174556           +18.0%    1386359        proc-vmstat.pgalloc_normal
>>    1241445           +18.1%    1466086        proc-vmstat.pgfault
>>    1138310           +19.3%    1358132        proc-vmstat.pgfree
>>      22100            +7.5%      23753 ±  4%  proc-vmstat.pgmigrate_success
>>      53332 ± 43%    +143.0%     129617 ± 14%  proc-vmstat.pgpgout
>>       1.42 ±  2%      +1.7        3.07        perf-stat.branch-miss-rate%
>>  1.064e+10          +123.3%  2.375e+10        perf-stat.branch-misses
>>      10.79            +0.6       11.43        perf-stat.cache-miss-rate%
>>  5.583e+09            +5.9%  5.915e+09        perf-stat.cache-misses
>>   39652092            -5.0%   37662545        perf-stat.context-switches
>>       1.29           +11.7%       1.44        perf-stat.cpi
>>  4.637e+12           +12.8%   5.23e+12        perf-stat.cpu-cycles
>>  8.653e+11            +9.8%  9.498e+11 ±  2%  perf-stat.dTLB-loads
>>  3.654e+11           +12.4%  4.109e+11        perf-stat.dTLB-stores
>>       0.78           -10.5%       0.70        perf-stat.ipc
>>    1214932           +17.9%    1432266        perf-stat.minor-faults
>>  1.334e+09            -1.8%   1.31e+09        perf-stat.node-store-misses
>>  1.651e+09            -1.8%   1.62e+09        perf-stat.node-stores
>>    1214954           +17.9%    1432313        perf-stat.page-faults
>>     256.75          -100.0%       0.00        turbostat.Avg_MHz
>>      21.39           -21.4        0.00        turbostat.Busy%
>>       1200          -100.0%       0.00        turbostat.Bzy_MHz
>>   13695007          -100.0%       0.00        turbostat.C1
>>      11.92           -11.9        0.00        turbostat.C1%
>>    2116683 ±  2%    -100.0%       0.00        turbostat.C1E
>>       1.16 ±  4%      -1.2        0.00        turbostat.C1E%
>>    3112269          -100.0%       0.00        turbostat.C3
>>       2.62 ±  2%      -2.6        0.00        turbostat.C3%
>>   15671277          -100.0%       0.00        turbostat.C6
>>      63.38           -63.4        0.00        turbostat.C6%
>>      49.46          -100.0%       0.00        turbostat.CPU%c1
>>       1.42 ±  2%    -100.0%       0.00        turbostat.CPU%c3
>>      27.73          -100.0%       0.00        turbostat.CPU%c6
>>      31.41          -100.0%       0.00        turbostat.CorWatt
>>      63.25          -100.0%       0.00        turbostat.CoreTmp
>>   18919351          -100.0%       0.00        turbostat.IRQ
>>       1.21 ± 18%    -100.0%       0.00        turbostat.Pkg%pc2
>>       0.67 ± 31%    -100.0%       0.00        turbostat.Pkg%pc6
>>      63.25          -100.0%       0.00        turbostat.PkgTmp
>>      57.63          -100.0%       0.00        turbostat.PkgWatt
>>      30.73          -100.0%       0.00        turbostat.RAMWatt
>>      36030          -100.0%       0.00        turbostat.SMI
>>       3000          -100.0%       0.00        turbostat.TSC_MHz
>>
>>                                                                                 
>>                                   aim7.jobs-per-min                             
>>                                                                                 
>>   41000 +-+-----------------------------------------------------------------+   
>>         |  ..+....+....  ..+....+....+....   ..+....+....+...+....          |   
>>   40000 +-+            +.                 +..                     +         |   
>>   39000 +-+                                                                 |   
>>         |                                                                   |   
>>   38000 +-+                                                                 |   
>>   37000 +-+                                                                 |   
>>         |                                                                   |   
>>   36000 +-+                                                                 |   
>>   35000 +-+                                                                 |   
>>         |                                                                   |   
>>   34000 +-+                                                                 |   
>>   33000 +-+                                         O                  O    |   
>>         O    O    O    O   O    O    O    O    O         O   O    O         O   
>>   32000 +-+-----------------------------------------------------------------+   
>>                                                                                 
>>                                                                                                                                                                                                                                         
>>                                                                                 
>> [*] bisect-good sample
>> [O] bisect-bad  sample
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
>> Thanks,
>> Xiaolong
