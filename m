Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F99A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfA2K2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:28:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:11165 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2K2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:28:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 02:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="122209206"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 02:23:03 -0800
Received: from [10.125.252.22] (abudanko-mobl.ccr.corp.intel.com [10.125.252.22])
        by linux.intel.com (Postfix) with ESMTP id 954D358056F;
        Tue, 29 Jan 2019 02:23:00 -0800 (PST)
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <20190129091432.GF4344@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <19fdd01d-5872-3a67-90e9-87201a67b291@linux.intel.com>
Date:   Tue, 29 Jan 2019 13:22:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129091432.GF4344@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 29.01.2019 12:14, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 22, 2019 at 08:45:12PM +0300, Alexey Budankov escreveu:
>>
>> It has been observed that trace reading thread runs on the same hw thread
>> most of the time during perf record sampling collection. This scheduling
>> layout leads up to 30% profiling overhead in case when some cpu intensive
>> workload fully utilizes a large server system with NUMA. Overhead usually
>> arises from remote (cross node) HW and memory references that have much
>> longer latencies than local ones [1].
>>
>> This patch set implements --affinity option that lowers 30% overhead
>> completely for serial trace streaming (--affinity=cpu) and from 30% to
>> 10% for AIO1 (--aio=1) trace streaming (--affinity=node|cpu).
>> See OVERHEAD section below for more details.
>>
>> Implemented extension provides users with capability to instruct Perf 
>> tool to bounce trace reading thread's affinity mask between NUMA nodes 
>> (--affinity=node) or assign the thread to the exact cpu (--affinity=cpu) 
>> that trace buffer being processed belongs to.
>>
>> The extension brings improvement in case of full system utilization when 
>> Perf tool process contends with workload process on cpu cores. In case a 
>> system has free cores to execute Perf tool process during profiling the 
>> default system scheduling layout induces the lowest overhead.
>>
>> The patch set has been validated on BT benchmark from NAS Parallel 
>> Benchmarks [2] running on dual socket, 44 cores, 88 hw threads Broadwell 
>> system with kernels v4.4-21-generic (Ubuntu 16.04) and v4.20.0-rc5 
>> (tip perf/core). 
>>
>> The patch set is for Arnaldo's perf/core repository.
>>
>> OVERHEAD:
>> 			       BENCH REPORT BASED   ELAPSED TIME BASED
>> 	  v4.20.0-rc5 
>>           (tip perf/core):
>> 				
>> (current) SERIAL-SYS  / BASE : 1.27x (14.37/11.31), 1.29x (15.19/11.69)
>> 	  SERIAL-NODE / BASE : 1.15x (13.04/11.31), 1.17x (13.79/11.69)
>> 	  SERIAL-CPU  / BASE : 1.00x (11.32/11.31), 1.01x (11.89/11.69)
> 
> Can you explain those numbers a bit? You mean that in (14.37/11.31)
> without this patch your test workload (NAS Parallel Benchmarks) took
> 14.37 seconds to complete and with the patch applied it took 11.31
> seconds?

With patches applied workload takes 13.04 sec (--affinity=node) or 11.32 sec 
(--affinity=cpu) under profiling depending on the value of the option.

11.31 sec (BASE) is the elapsed time of workload without profiling as it is 
reported by the benchmark itself (Time in seconds = ).
11.69 sec (BASE) is the elapsed time of workload without profiling
as it is reported by /usr/bin/time.

14.37 sec (SERIAL-SYS) is the elapsed time of workload under profiling
as it is reported by the benchmark itself (Time in seconds =) without 
specifying --aio or --affinity options thus with serial trace writing 
and default system affinity:
/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 -a -e cycles -- ./bt.B.x
15.19 sec (SERIAL-SYS) is the elapsed time of workload under profiling
as it is reported by /usr/bin/time.

13.04 sec, 13.79 sec (SERIAL-NODE) are the elapsed times of workload 
under profiling with --affinity=node specified, reported by the benchmark 
and /usr/bin/time:
/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --affinity=node -a -e cycles -- ./bt.B.x

11.32 sec, 11.89 sec (SERIAL-CPU) are the elapsed times of workload under 
profiling with --affinity=cpu specified, reported by the benchmark itself 
and by /usr/bin/time:
/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --affinity=cpu -a -e cycles -- ./bt.B.x

For AIO trace writing (--aio=1) the experiment is the same:

AIO1-SYS:  /usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 -a -e cycles -- ./bt.B.x 
AIO1-NODE: /usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 --affinity=node -a -e cycles -- ./bt.B.x
AIO1-CPU:  /usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 --affinity=cpu -a -e cycles -- ./bt.B.x

Thanks,
Alexey

> 
> If so its really interesting that all the "after" numbers, in seconds,
> are the same in _all_ the tests, is that right?
> 
> Please clarify.
> 
> - Arnaldo
> 
>> 	
>> 	  AIO1-SYS    / BASE : 1.29x (14.58/11.31), 1.29x (15.26/11.69)
>> 	  AIO1-NODE   / BASE : 1.08x (12.23/11.31), 1,11x (13.01/11.69)
>> 	  AIO1-CPU    / BASE : 1.07x (12.14/11.31), 1.08x (12.83/11.69)
>>
>> 	  v4.4.0-21-generic
>>           (Ubuntu 16.04 LTS):
>>
>> (current) SERIAL-SYS  / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
>> 	  SERIAL-NODE / BASE : 1.19x (13.02/10.87), 1.23x (14.03/11.32)
>> 	  SERIAL-CPU  / BASE : 1.03x (11.21/10.87), 1.07x (12.18/11.32)
>> 	
>> 	  AIO1-SYS    / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
>> 	  AIO1-NODE   / BASE : 1.10x (12.04/10.87), 1.15x (13.03/11.32)
>> 	  AIO1-CPU    / BASE : 1.12x (12.20/10.87), 1.15x (13.09/11.32)
>>
>> ---
>> Alexey Budankov (4):
>>   perf record: allocate affinity masks
>>   perf record: bind the AIO user space buffers to nodes
>>   perf record: apply affinity masks when reading mmap buffers
>>   perf record: implement --affinity=node|cpu option
>>
>>  tools/perf/Documentation/perf-record.txt |   5 ++
>>  tools/perf/builtin-record.c              |  45 +++++++++-
>>  tools/perf/perf.h                        |   8 ++
>>  tools/perf/util/cpumap.c                 |  10 +++
>>  tools/perf/util/cpumap.h                 |   1 +
>>  tools/perf/util/evlist.c                 |   6 +-
>>  tools/perf/util/evlist.h                 |   2 +-
>>  tools/perf/util/mmap.c                   | 105 ++++++++++++++++++++++-
>>  tools/perf/util/mmap.h                   |   3 +-
>>  9 files changed, 175 insertions(+), 10 deletions(-)
>>
>> ---
>> Changes in v5:
>> - avoided multiple allocations of online cpu maps by 
>>   implementing it once in cpu_map__online()
>> - reduced indentation at record__parse_affinity()
>>
>> Changes in v4:
>> - fixed compilation issue converting pr_warn() to pr_warning()
>> - implemented stop if mbind() fails
>> - corrected mmap_params->cpu_map initialization to be based on /sys/devices/system/cpu/online
>> - separated node cpu map generation into build_node_mask()
>>
>> Changes in v3:
>> - converted PERF_AFFINITY_EOF to PERF_AFFINITY_MAX
>> - corrected code style issues
>> - adjusted __aio_alloc,__aio_bind,__aio_free() implementation
>> - separated mask manipulations into __adjust_affinity() and __setup_affinity_mask()
>> - implemented mapping of c index into online cpu index
>> - adjusted indentation at record__parse_affinity()
>>
>> Changes in v2:
>> - made debug affinity mode message user friendly
>> - converted affinity mode defines to enum values
>> - implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
>>   and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
>> - separated AIO buffers binding to patch 2/4
>>
>> ---
>> [1] https://en.wikipedia.org/wiki/Non-uniform_memory_access
>> [2] https://www.nas.nasa.gov/publications/npb.html
>> [3] http://man7.org/linux/man-pages/man2/sched_setaffinity.2.html
>> [4] http://man7.org/linux/man-pages/man2/mbind.2.html
>>
>> ---
>> ENVIRONMENT AND MEASUREMENTS:
>>
>>   MACHINE:
>>
>> 	broadwell, dual socket, 44 core, 88 threads
>>
>> 	/proc/cpuinfo
>>
>> 	processor	: 87
>> 	vendor_id	: GenuineIntel
>> 	cpu family	: 6
>> 	model		: 79
>> 	model name	: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>> 	stepping	: 1
>> 	microcode	: 0xb000019
>> 	cpu MHz		: 1200.117
>> 	cache size	: 56320 KB
>> 	physical id	: 1
>> 	siblings	: 44
>> 	core id		: 28
>> 	cpu cores	: 22
>> 	apicid		: 121
>> 	initial apicid	: 121
>> 	fpu		: yes
>> 	fpu_exception	: yes
>> 	cpuid level	: 20
>> 	wp		: yes
>> 	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdseed adx smap xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts
>> 	bugs		:
>> 	bogomips	: 4391.42
>> 	clflush size	: 64
>> 	cache_alignment	: 64
>> 	address sizes	: 46 bits physical, 48 bits virtual
>> 	power management:
>>   		
>>   BASE:
>>
>> 	/usr/bin/time ./bt.B.x 
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>> 	
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>> 	
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    10.87
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 64608.74
>> 	Mop/s/thread    =                   734.19
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>> 	
>> 	956.25user 19.14system 0:11.32elapsed 8616%CPU (0avgtext+0avgdata 210496maxresident)k
>> 	0inputs+0outputs (0major+57939minor)pagefaults 0swaps
>>
>>   SERIAL-SYS:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 0
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 0
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    13.73
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 51136.52
>> 	Mop/s/thread    =                   581.10
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1661,120 MB perf.data ]
>>
>> 	1184.84user 40.70system 0:14.69elapsed 8341%CPU (0avgtext+0avgdata 208612maxresident)k
>> 	0inputs+3402072outputs (0major+137077minor)pagefaults 0swaps
>>
>>   SERIAL-NODE:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --affinity=node -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 0
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 1
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    13.02
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 53924.69
>> 	Mop/s/thread    =                   612.78
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1557,152 MB perf.data ]
>>
>> 	1120.42user 29.92system 0:14.03elapsed 8198%CPU (0avgtext+0avgdata 206388maxresident)k
>> 	0inputs+3189128outputs (0major+149207minor)pagefaults 0swaps
>>
>>   SERIAL-CPU:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --affinity=cpu -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 0
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 2
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    11.21
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 62642.24
>> 	Mop/s/thread    =                   711.84
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1365,043 MB perf.data ]
>>
>> 	976.06user 31.35system 0:12.18elapsed 8264%CPU (0avgtext+0avgdata 208488maxresident)k
>> 	0inputs+2795704outputs (0major+126032minor)pagefaults 0swaps
>>
>>   AIO1-SYS:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 1
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 0
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    14.23
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 49338.27
>> 	Mop/s/thread    =                   560.66
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1720,590 MB perf.data ]
>>
>> 	1229.19user 41.99system 0:15.22elapsed 8350%CPU (0avgtext+0avgdata 208604maxresident)k
>> 	0inputs+3523880outputs (0major+124670minor)pagefaults 0swaps
>>
>>   AIO1-NODE:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 --affinity=node -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 1
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 1
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    12.04
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 58313.58
>> 	Mop/s/thread    =                   662.65
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1471,279 MB perf.data ]
>>
>> 	1055.62user 30.43system 0:13.03elapsed 8333%CPU (0avgtext+0avgdata 208424maxresident)k
>> 	0inputs+3013288outputs (0major+79088minor)pagefaults 0swaps
>>
>>   AIO1-CPU:
>>
>> 	/usr/bin/time ./tip/tools/perf/perf record -v -N -B -T -R -F 25000 --aio=1 --affinity=cpu -a -e cycles -- ./bt.B.x 
>> 	Using CPUID GenuineIntel-6-4F-1
>> 	nr_cblocks: 1
>> 	affinity (UNSET:0, NODE:1, CPU:2) = 2
>> 	mmap size 528384B
>>
>> 	NAS Parallel Benchmarks (NPB3.3-OMP) - BT Benchmark
>>
>> 	No input file inputbt.data. Using compiled defaults
>> 	Size:  102x 102x 102
>> 	Iterations:  200       dt:   0.0003000
>> 	Number of available threads:    88
>>
>> 	BT Benchmark Completed.
>> 	Class           =                        B
>> 	Size            =            102x 102x 102
>> 	Iterations      =                      200
>> 	Time in seconds =                    12.20
>> 	Total threads   =                       88
>> 	Avail threads   =                       88
>> 	Mop/s total     =                 57538.84
>> 	Mop/s/thread    =                   653.85
>> 	Operation type  =           floating point
>> 	Verification    =               SUCCESSFUL
>> 	Version         =                    3.3.1
>> 	Compile date    =              20 Sep 2018
>>
>> 	[ perf record: Captured and wrote 1486,859 MB perf.data ]
>>
>> 	1051.97user 42.07system 0:13.09elapsed 8352%CPU (0avgtext+0avgdata 206388maxresident)k
>> 	0inputs+3045168outputs (0major+174612minor)pagefaults 0swaps
> 
