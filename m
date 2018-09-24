Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F7D21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F7D21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeIYB10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:27:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:10626 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIYB10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:27:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 12:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="259876380"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2018 12:23:42 -0700
Received: from [10.252.24.57] (abudanko-mobl.ccr.corp.intel.com [10.252.24.57])
        by linux.intel.com (Postfix) with ESMTP id 448E75801CD;
        Mon, 24 Sep 2018 12:23:39 -0700 (PDT)
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914082653.GG24224@krava> <20180914082858.GH24224@krava>
 <71153c79-f0b9-4bf7-7491-202f46c6b5ed@linux.intel.com>
 <4f63c3d5-2a33-28ed-4e45-086045e9ab50@linux.intel.com>
 <b2f205a9-2d8d-7cf2-0ed7-b6b1ecff990b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <961c875a-5a63-b6fa-4711-7bc7795e511f@linux.intel.com>
Date:   Mon, 24 Sep 2018 22:23:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b2f205a9-2d8d-7cf2-0ed7-b6b1ecff990b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.09.2018 15:15, Alexey Budankov wrote:
> Hello Jiri,
> 
> On 21.09.2018 9:13, Alexey Budankov wrote:
>> Hello Jiri,
>>
>> On 14.09.2018 12:37, Alexey Budankov wrote:
>>> On 14.09.2018 11:28, Jiri Olsa wrote:
>>>> On Fri, Sep 14, 2018 at 10:26:53AM +0200, Jiri Olsa wrote:
>>>>
>>>> SNIP
>>>>
>>>>>>> The threaded monitoring currently can't monitor backward maps
>>>>>>> and there are probably more limitations which I haven't spotted
>>>>>>> yet.
>>>>>>>
>>>>>>> So far I tested on laptop:
>>>>>>>   http://people.redhat.com/~jolsa/record_threads/test-4CPU.txt
>>>>>>>
>>>>>>> and a one bigger server:
>>>>>>>   http://people.redhat.com/~jolsa/record_threads/test-208CPU.txt
>>>>>>>
>>>>>>> I can see decrease in recorded LOST events, but both the benchmark
>>>>>>> and the monitoring must be carefully configured wrt:
>>>>>>>   - number of events (frequency)
>>>>>>>   - size of the memory maps
>>>>>>>   - size of events (callchains)
>>>>>>>   - final perf.data size
>>>>>>>
>>>>>>> It's also available in:
>>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>>>>>>   perf/record_threads
>>>>>>>
>>>>>>> thoughts? ;-) thanks
>>>>>>> jirka
>>>>>>
>>>>>> It is preferable to split into smaller pieces that bring 
>>>>>> some improvement proved by metrics numbers and ready for 
>>>>>> merging and upstream. Do we have more metrics than the 
>>>>>> data loss from trace AIO patches?
>>>>>
>>>>> well the primary focus is to get more events in,
>>>>> so the LOST metric is the main one
>>>>
>>>> actualy I was hoping, could you please run it through the same
>>>> tests as you do for AIO code on some huge server? 
>>>
>>> Yeah, I will, but it takes some time.
>>
>> Here it is:
>>
>> Hardware:
>> cat /proc/cpuinfo
>> processor	: 271
>> vendor_id	: GenuineIntel
>> cpu family	: 6
>> model		: 133
>> model name	: Intel(R) Xeon Phi(TM) CPU 7285 @ 1.30GHz
>> stepping	: 0
>> microcode	: 0xe
>> cpu MHz		: 1064.235
>> cache size	: 1024 KB
>> physical id	: 0
>> siblings	: 272
>> core id		: 73
>> cpu cores	: 68
>> apicid		: 295
>> initial apicid	: 295
>> fpu		: yes
>> fpu_exception	: yes
>> cpuid level	: 13
>> wp		: yes
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ring3mwait cpuid_fault epb pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms avx512f rdseed adx avx512pf avx512er avx512cd xsaveopt dtherm ida arat pln pts avx512_vpopcntdq avx512_4vnniw avx512_4fmaps
>> bugs		: cpu_meltdown spectre_v1 spectre_v2
>> bogomips	: 2594.07
>> clflush size	: 64
>> cache_alignment	: 64
>> address sizes	: 46 bits physical, 48 bits virtual
>> power management:
>>
>> uname -a
>> Linux nntpat98-196 4.18.0-rc7+ #2 SMP Thu Sep 6 13:24:37 MSK 2018 x86_64 x86_64 x86_64 GNU/Linux
>>
>> cat /proc/sys/kernel/perf_event_paranoid
>> 0
>>
>> cat /proc/sys/kernel/perf_event_mlock_kb 
>> 516
>>
>> cat /proc/sys/kernel/perf_event_max_sample_rate 
>> 3000
>>
>> cat /etc/redhat-release 
>> Red Hat Enterprise Linux Server release 7.5 (Maipo)
>>
>> Metrics:
>> runtime overhead (%) : elapsed_time_under_profiling / elapsed_time
>> data loss (%)        : paused_time / elapsed_time_under_profiling
>> LOST events          : stat from perf report --stats
>> SAMPLE events        : stat from perf report --stats
>> perf.data size (B)   : size of trace file on disk
>>
>> Events:
>> cpu/period=P,event=0x3c/Duk;CPU_CLK_UNHALTED.THREAD
>> cpu/period=P,umask=0x3/Duk;CPU_CLK_UNHALTED.REF_TSC
>> cpu/period=P,event=0xc0/Duk;INST_RETIRED.ANY
>> cpu/period=0xaae61,event=0xc2,umask=0x10/uk;UOPS_RETIRED.ALL
>> cpu/period=0x11171,event=0xc2,umask=0x20/uk;UOPS_RETIRED.SCALAR_SIMD
>> cpu/period=0x11171,event=0xc2,umask=0x40/uk;UOPS_RETIRED.PACKED_SIMD
>>
>> =================================================
>>
>> Command:
>> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf.thr record --threads=T \
>> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>>         -e cpu/period=P,event=0x3c/Duk,\
>>            cpu/period=P,umask=0x3/Duk,\
>>            cpu/period=P,event=0xc0/Duk,\
>>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
>>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
>>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
>>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
>>
>> Workload: matrix multiplication in 256 threads
>>
>> /usr/bin/time ./matrix.icc
>> Addr of buf1 = 0x7ff9faa73010
>> Offs of buf1 = 0x7ff9faa73180
>> Addr of buf2 = 0x7ff9f8a72010
>> Offs of buf2 = 0x7ff9f8a721c0
>> Addr of buf3 = 0x7ff9f6a71010
>> Offs of buf3 = 0x7ff9f6a71100
>> Addr of buf4 = 0x7ff9f4a70010
>> Offs of buf4 = 0x7ff9f4a70140
>> Threads #: 256 Pthreads
>> Matrix size: 2048
>> Using multiply kernel: multiply1
>> Freq = 0.997720 GHz
>> Execution time = 9.061 seconds
>> 1639.55user 6.59system 0:07.12elapsed 23094%CPU (0avgtext+0avgdata 100448maxresident)k
>> 96inputs+0outputs (1major+33839minor)pagefaults 0swaps
>>
>> T : 272
>>         P (period, ms)       : 0.1
>> 	runtime overhead (%) : 45x ~ 323.54 / 7.12
>> 	data loss (%)        : 96
>> 	LOST events          : 323662
>> 	SAMPLE events        : 31885479
>>         perf.data size (GiB) : 42
>>
>> 	P (period, ms)       : 0.25
>> 	runtime overhead (%) : 25x ~ 180.76 / 7.12
>> 	data loss (%)        : 69 
>> 	LOST events          : 10636
>> 	SAMPLE events        : 18692998
>>         perf.data size (GiB) : 23.5
>>
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 16x ~ 119.49 / 7.12
>> 	data loss (%)        : 1
>> 	LOST events          : 6
>> 	SAMPLE events        : 11178524
>>         perf.data size (GiB) : 14
>>
>> T : 128
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 15x ~ 111.98 / 7.12
>> 	data loss (%)        : 62
>> 	LOST events          : 2825
>> 	SAMPLE events        : 11267247
>>         perf.data size (GiB) : 15
>>
>> T : 64
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 14x ~ 101.55 / 7.12
>> 	data loss (%)        : 67
>> 	LOST events          : 5155
>> 	SAMPLE events        : 10966297
>>         perf.data size (GiB) : 13.7
>>
>> Workload: matrix multiplication in 128 threads
>>
>> /usr/bin/time ./matrix.gcc
>> Addr of buf1 = 0x7f072e630010
>> Offs of buf1 = 0x7f072e630180
>> Addr of buf2 = 0x7f072c62f010
>> Offs of buf2 = 0x7f072c62f1c0
>> Addr of buf3 = 0x7f072a62e010
>> Offs of buf3 = 0x7f072a62e100
>> Addr of buf4 = 0x7f072862d010
>> Offs of buf4 = 0x7f072862d140
>> Threads #: 128 Pthreads
>> Matrix size: 2048
>> Using multiply kernel: multiply1
>> Execution time = 6.639 seconds
>> 767.03user 11.17system 0:06.81elapsed 11424%CPU (0avgtext+0avgdata 100756maxresident)k
>> 88inputs+0outputs (0major+139898minor)pagefaults 0swaps
>>
>> T : 272
>>         P (period, ms)       : 0.1
>> 	runtime overhead (%) : 29x ~ 198.81 / 6.81
>> 	data loss (%)        : 21
>> 	LOST events          : 2502
>> 	SAMPLE events        : 22481062
>>         perf.data size (GiB) : 27.6
>>
>> 	P (period, ms)       : 0.25
>> 	runtime overhead (%) : 13x ~ 88.47 / 6.81
>> 	data loss (%)        : 0
>> 	LOST events          : 0
>> 	SAMPLE events        : 9572787
>>         perf.data size (GiB) : 11.3
>>
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 10x ~ 67.11 / 6.81
>> 	data loss (%)        : 1
>> 	LOST events          : 137
>> 	SAMPLE events        : 6985930
>>         perf.data size (GiB) : 8
>>
>> T : 128
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 9.5x ~ 64.33 / 6.81
>> 	data loss (%)        : 1
>> 	LOST events          : 3
>> 	SAMPLE events        : 6666903
>>         perf.data size (GiB) : 7.8
>>
>> T : 64
>> 	P (period, ms)       : 0.25
>> 	runtime overhead (%) : 17x ~ 114.27 / 6.81
>> 	data loss (%)        : 2
>> 	LOST events          : 52
>> 	SAMPLE events        : 12643645
>>         perf.data size (GiB) : 15.5
>>
>> 	P (period, ms)       : 0.35 
>> 	runtime overhead (%) : 10x ~ 68.60 / 6.81
>> 	data loss (%)        : 1
>> 	LOST events          : 93
>> 	SAMPLE events        : 7164368
>>         perf.data size (GiB) : 8.5
> 
> and this is for AIO and serial:
> 
> Command:
> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf.aio record --aio=N \
> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>         -e cpu/period=P,event=0x3c/Duk,\
>            cpu/period=P,umask=0x3/Duk,\
>            cpu/period=P,event=0xc0/Duk,\
>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
> 
> Workload: matrix multiplication in 256 threads
> 
>  N : 512
>         P (period, ms)       : 2.5
>  	runtime overhead (%) : 2.7x ~ 19.21 / 7.12
>  	data loss (%)        : 42
>  	LOST events          : 1600
>  	SAMPLE events        : 1235928
>         perf.data size (GiB) : 1.5
>  
>  N : 272
>  	P (period, ms)       : 1.5
>  	runtime overhead (%) : 2.5x ~ 18.09 / 7.12
>  	data loss (%)        : 89
>  	LOST events          : 3457
>  	SAMPLE events        : 1222143
>         perf.data size (GiB) : 1.5
> 
>  	P (period, ms)       : 2
>  	runtime overhead (%) : 2.5x ~ 17.93 / 7.12
>  	data loss (%)        : 65
>  	LOST events          : 2496
>  	SAMPLE events        : 1240754
>         perf.data size (GiB) : 1.5
> 
>  	P (period, ms)       : 2.5
>  	runtime overhead (%) : 2.5x ~ 17.87 / 7.12
>  	data loss (%)        : 44
>  	LOST events          : 1621
>  	SAMPLE events        : 1221949
>         perf.data size (GiB) : 1.5
> 
>  	P (period, ms)       : 3
>  	runtime overhead (%) : 2.5x ~ 18.43 / 7.12
>  	data loss (%)        : 12
>  	LOST events          : 350
>  	SAMPLE events        : 1117972
>         perf.data size (GiB) : 1.3
>  
>  N : 128
>  	P (period, ms)       : 3
>  	runtime overhead (%) : 2.4x ~ 17.08 / 7.12
>  	data loss (%)        : 11
>  	LOST events          : 335
>  	SAMPLE events        : 1116832
>         perf.data size (GiB) : 1.3
>  
>  N : 64
>  	P (period, ms)       : 3
>  	runtime overhead (%) : 2.2x ~ 16.03 / 7.12
>  	data loss (%)        : 11
>  	LOST events          : 329
>  	SAMPLE events        : 1108205
>         perf.data size (GiB) : 1.3
>  
> Workload: matrix multiplication in 128 threads
> 
>  N : 512
>         P (period, ms)       : 1
>  	runtime overhead (%) : 3.5x ~ 23.72 / 6.81
>  	data loss (%)        : 18
>  	LOST events          : 1043
>  	SAMPLE events        : 2015306
>         perf.data size (GiB) : 2.3
> 
>  N : 272
>         P (period, ms)       : 0.5
>  	runtime overhead (%) : 3x ~ 22.72 / 6.81
>  	data loss (%)        : 90
>  	LOST events          : 5842
>  	SAMPLE events        : 2205937
>         perf.data size (GiB) : 2.5
> 
>         P (period, ms)       : 1
>  	runtime overhead (%) : 3x ~ 22.79 / 6.81
>  	data loss (%)        : 11
>  	LOST events          : 481
>  	SAMPLE events        : 2017099
>         perf.data size (GiB) : 2.5
>  
>  	P (period, ms)       : 1.5
>  	runtime overhead (%) : 3x ~ 19.93 / 6.81
>  	data loss (%)        : 5
>  	LOST events          : 190
>  	SAMPLE events        : 1308692
>         perf.data size (GiB) : 1.5
>  
>  	P (period, ms)       : 2
>  	runtime overhead (%) : 3x ~ 18.95 / 6.81
>  	data loss (%)        : 0
>  	LOST events          : 0
>  	SAMPLE events        : 1010769
>         perf.data size (GiB) : 1.2
>  
>  N : 128
>  	P (period, ms)       : 1.5
>  	runtime overhead (%) : 3x ~ 19.08 / 6.81
>  	data loss (%)        : 6
>  	LOST events          : 220
>  	SAMPLE events        : 1322240
>         perf.data size (GiB) : 1.5
>  
>  N : 64
>  	P (period, ms)       : 1.5
>  	runtime overhead (%) : 3x ~ 19.43 / 6.81
>  	data loss (%)        : 3
>  	LOST events          : 130
>  	SAMPLE events        : 1386521
>         perf.data size (GiB) : 1.6
> 
> =================================================
> 
> Command:
> /usr/bin/time /tmp/vtune_amplifier_2019.574715/bin64/perf record \
> 	-a -N -B -T -R --call-graph dwarf,1024 --user-regs=ip,bp,sp \
>         -e cpu/period=P,event=0x3c/Duk,\
>            cpu/period=P,umask=0x3/Duk,\
>            cpu/period=P,event=0xc0/Duk,\
>            cpu/period=0x30d40,event=0xc2,umask=0x10/uk,\
>            cpu/period=0x4e20,event=0xc2,umask=0x20/uk,\
>            cpu/period=0x4e20,event=0xc2,umask=0x40/uk \
>          --clockid=monotonic_raw -- ./matrix.(icc|gcc)
> 
> Workload: matrix multiplication in 256 threads
> 
> 	P (period, ms)       : 7.5
>  	runtime overhead (%) : 1.6x ~ 11.6 / 7.12
>  	data loss (%)        : 1
>  	LOST events          : 1
>  	SAMPLE events        : 451062
>         perf.data size (GiB) : 0.5
> 
> Workload: matrix multiplication in 128 threads
> 
> 	P (period, ms)       : 3
>  	runtime overhead (%) : 1.8x ~ 12.58 / 6.81
>  	data loss (%)        : 9
>  	LOST events          : 147
>  	SAMPLE events        : 673299
>         perf.data size (GiB) : 0.8

Please see more comparable data by P (period, ms), 
runtime overhead and data loss metrics at the same time.

It start from serial implementation as the baseline and 
then demonstrates possible improvement applying configurable 
--aio(=N) and --threads(=T) implementations.

Smaller P values, with data loss and runtime overhead values
equal or in small vicinity of the ones from serial implementation,
might mean possible gain.

Workload: matrix multiplication in 128 threads

Serial:
 	P (period, ms)       : 3
  	runtime overhead (%) : 1.8x ~ 12.58 / 6.81
  	data loss (%)        : 9
  	LOST events          : 147
  	SAMPLE events        : 673299
        perf.data size (GiB) : 0.8

AIO:
    N : 1
 	P (period, ms)       : 3
  	runtime overhead (%) : 1.8x ~ 12.42 / 6.81
  	data loss (%)        : 2
  	LOST events          : 19
  	SAMPLE events        : 664749
        perf.data size (GiB) : 0.75

    N : 4
 	P (period, ms)       : 1.8
  	runtime overhead (%) : 1.8x ~ 12.74 / 6.81
  	data loss (%)        : 10
  	LOST events          : 257
  	SAMPLE events        : 1079250
        perf.data size (GiB) : 1.25

Threads:
    T : 1
 	P (period, ms)       : 3
  	runtime overhead (%) : 2.6x ~ 17.73 / 6.81
  	data loss (%)        : 6
  	LOST events          : 95
  	SAMPLE events        : 665844
        perf.data size (GiB) : 0.78

    T : 2
 	P (period, ms)       : 3
  	runtime overhead (%) : 2.6x ~ 18.04 / 6.81
  	data loss (%)        : 0
  	LOST events          : 0
  	SAMPLE events        : 662075
        perf.data size (GiB) : 0.8

 	P (period, ms)       : 1.8
  	runtime overhead (%) : 3x ~ 20.83 / 6.81
  	data loss (%)        : 4
  	LOST events          : 76
  	SAMPLE events        : 1085826
        perf.data size (GiB) : 1.25

    T : 4
 	P (period, ms)       : 3
  	runtime overhead (%) : 2.6x ~ 17.85 / 6.81 
  	data loss (%)        : 0
  	LOST events          : 0
  	SAMPLE events        : 665262
        perf.data size (GiB) : 0.78

 	P (period, ms)       : 1.8
  	runtime overhead (%) : 3x ~ 21.15 / 6.81 
  	data loss (%)        : 0
  	LOST events          : 0
  	SAMPLE events        : 1126563
        perf.data size (GiB) : 1.3

 	P (period, ms)       : 1
  	runtime overhead (%) : 4.35x ~ 29.6 / 6.81
  	data loss (%)        : 0
  	LOST events          : 6
  	SAMPLE events        : 2124837
        perf.data size (GiB) : 2.5

 	P (period, ms)       : 0.8
  	runtime overhead (%) : 4.8x ~ 32.62 / 6.81
  	data loss (%)        : 12
  	LOST events          : 536
  	SAMPLE events        : 2620345
        perf.data size (GiB) : 3

Thanks,
Alexey

> 
> Thanks,
> Alexey
> 
>>
>> Thanks,
>> Alexey
>>
>>>
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>
>>
> 
