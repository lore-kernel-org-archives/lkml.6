Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9A214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF9A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeHULnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:43:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:58432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeHULnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:43:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 01:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,268,1531810800"; 
   d="scan'208";a="67851227"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2018 01:22:56 -0700
Received: from [10.125.252.171] (abudanko-mobl.ccr.corp.intel.com [10.125.252.171])
        by linux.intel.com (Postfix) with ESMTP id 2F75A5802C8;
        Tue, 21 Aug 2018 01:22:53 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/2]: perf: reduce data loss when profiling highly parallel
 CPU bound workloads
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Organization: Intel Corp.
Message-ID: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
Date:   Tue, 21 Aug 2018 11:22:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in record mode the tool implements trace writing serially. 
The algorithm loops over mapped per-cpu data buffers and stores ready 
data chunks into a trace file using write() system call.

At some circumstances the kernel may lack free space in a buffer 
because the other buffer's half is not yet written to disk due to 
some other buffer's data writing by the tool at the moment.

Thus serial trace writing implementation may cause the kernel 
to loose profiling data and that is what observed when profiling 
highly parallel CPU bound workloads on machines with big number 
of cores.

Experiment with profiling matrix multiplication code executing 128 
threads on Intel Xeon Phi (KNM) with 272 cores, like below,
demonstrates data loss metrics value of 98%:

/usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
    --call-graph dwarf,1024 --user-regs=IP,SP,BP \
    --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
    matrix.gcc

Data loss metrics is the ratio lost_time/elapsed_time where 
lost_time is the sum of time intervals containing PERF_RECORD_LOST 
records and elapsed_time is the elapsed application run time 
under profiling.

Applying asynchronous trace streaming thru Posix AIO API
http://man7.org/linux/man-pages/man7/aio.7.html lowers data loss 
metrics value providing ~25% improvement in average.

Sanity testing:

tools/perf/perf test
 1: vmlinux symtab matches kallsyms                       : Ok
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
 4: Read samples using the mmap interface                 : Ok
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : Ok
 7: Simple expression parser                              : Ok
 8: PERF_RECORD_* events & perf_sample fields             : Ok
 9: Parse perf pmu format                                 : Ok
10: DSO data read                                         : Ok
11: DSO data cache                                        : Ok
12: DSO data reopen                                       : Ok
13: Roundtrip evsel->name                                 : Ok
14: Parse sched tracepoints fields                        : Ok
15: syscalls:sys_enter_openat event fields                : Ok
16: Setup struct perf_event_attr                          : Skip
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : FAILED!
19: Breakpoint overflow signal handler                    : Ok
20: Breakpoint overflow sampling                          : Ok
21: Breakpoint accounting                                 : Ok
22: Number of exit events of a simple workload            : Ok
23: Software clock events period values                   : Ok
24: Object code reading                                   : Ok
25: Sample parsing                                        : Ok
26: Use a dummy software event to keep tracking           : Ok
27: Parse with no sample_id_all bit set                   : Ok
28: Filter hist entries                                   : Ok
29: Lookup mmap thread                                    : Ok
30: Share thread mg                                       : Ok
31: Sort output of hist entries                           : Ok
32: Cumulate child hist entries                           : Ok
33: Track with sched_switch                               : Ok
34: Filter fds with revents mask in a fdarray             : Ok
35: Add fd to a fdarray, making it autogrow               : Ok
36: kmod_path__parse                                      : Ok
37: Thread map                                            : Ok
38: LLVM search and compile                               :
38.1: Basic BPF llvm compile                              : Skip
38.2: kbuild searching                                    : Skip
38.3: Compile source for BPF prologue generation          : Skip
38.4: Compile source for BPF relocation                   : Skip
39: Session topology                                      : Ok
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Skip
40.2: BPF pinning                                         : Skip
40.3: BPF prologue generation                             : Skip
40.4: BPF relocation checker                              : Skip
41: Synthesize thread map                                 : Ok
42: Remove thread map                                     : Ok
43: Synthesize cpu map                                    : Ok
44: Synthesize stat config                                : Ok
45: Synthesize stat                                       : Ok
46: Synthesize stat round                                 : Ok
47: Synthesize attr update                                : Ok
48: Event times                                           : Ok
49: Read backward ring buffer                             : Ok
50: Print cpu map                                         : Ok
51: Probe SDT events                                      : Ok
52: is_printable_array                                    : Ok
53: Print bitmap                                          : Ok
54: perf hooks                                            : Ok
55: builtin clang support                                 : Skip (not compiled in)
56: unit_number__scnprintf                                : Ok
57: mem2node                                              : Ok
58: x86 rdpmc                                             : Ok
59: Convert perf time to TSC                              : Ok
60: DWARF unwind                                          : Ok
61: x86 instruction decoder - new instructions            : Ok
62: Use vfs_getname probe to get syscall args filenames   : Skip
63: Add vfs_getname probe to get syscall args filenames   : Skip
64: Check open filename arg using perf trace + vfs_getname: Skip
65: probe libc's inet_pton & backtrace it with ping       : FAILED!

---
 Alexey Budankov (2):
        perf util: map data buffer for preserving collected data
	perf record: enable asynchronous trace writing

 tools/perf/builtin-record.c | 113 +++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/evlist.c    |   9 ++++
 tools/perf/util/evlist.h    |   2 +
 tools/perf/util/mmap.c      |  35 +++++++++-----
 tools/perf/util/mmap.h      |   5 +-
 5 files changed, 144 insertions(+), 20 deletions(-)
