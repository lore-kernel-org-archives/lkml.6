Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDAFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B021850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeLXNVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:21:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:9854 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbeLXNVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:21:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 05:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="104404572"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Dec 2018 05:21:37 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id 39F5358044E;
        Mon, 24 Dec 2018 05:21:34 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/4] perf: enable compression of record mode trace to save
 storage space
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
Date:   Mon, 24 Dec 2018 16:21:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch set implements runtime record trace compression accompanied by 
trace file decompression implemented in the tool report mode. Zstandard 
library API [1] is used for compression/decompression of data that come 
from perf_events kernel data buffers.

Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
size reduction on the tested workloads what significantly saves user's 
storage space on larger server systems where trace file size can easily 
reach several tens or even hundreds of GiBs, especially when profiling 
with stacks for later dwarf unwinding, context-switches tracing and etc.

The option is effective jointly with asynchronous trace writing because 
compression requires auxiliary memory buffers to operate on and memory 
buffers for asynchronous trace writing serve that purpose.

Added --mmap-flush option can be used to avoid compressing every single 
byte of data from mmaped kernel buffers to the trace file and increase 
compression ratio at the same time lowering tool runtime overhead.

The feature can be disabled from the command line using NO_LIBZSTD define
and Zstandard sources can be overridden using value of LIBZSTD_DIR define.

The patch set is for Arnaldo's perf/core repository.

Examples:

  $ make -C tools/perf NO_LIBZSTD=1 clean all
  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all

  $ tools/perf/perf record -F 42000 --aio -z 1 --mmap-flush 0x1000 -e cycles -- matrix.gcc
  Addr of buf1 = 0x7fc1bf183010
  Offs of buf1 = 0x7fc1bf183180
  Addr of buf2 = 0x7fc1bd182010
  Offs of buf2 = 0x7fc1bd1821c0
  Addr of buf3 = 0x7fc1bb181010
  Offs of buf3 = 0x7fc1bb181100
  Addr of buf4 = 0x7fc1b9180010
  Offs of buf4 = 0x7fc1b9180140
  Threads #: 8 Pthreads
  Matrix size: 2048
  Using multiply kernel: multiply1
  Execution time = 25.499 seconds
  [ perf record: Woken up 1157 times to write data ]
  [ perf record: Compressed 316.684 MB to 58.034 MB, ratio is 5.457 ]
  [ perf record: Captured and wrote 58.059 MB perf.data ]

  $ tools/perf/perf report -D --header
  # ========
  # captured on    : Mon Dec 24 13:19:52 2018
  # header version : 1
  # data offset    : 296
  # data size      : 60878779
  # feat offset    : 60879075
  # hostname : nntvtune39
  # os release : 4.19.9-300.fc29.x86_64
  # perf version : 4.13.rc5.gdbb7997
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
  # cpuid : GenuineIntel,6,94,3
  # total memory : 16153380 kB
  # cmdline : /root/abudanko/kernel/acme/tools/perf/perf record -F 42000 --aio -z 1 --mmap-flush 0x1000 -e cycles -- ../../matrix/linux/matrix.gcc 
  # event : name = cycles, , id = { 2315, 2316, 2317, 2318, 2319, 2320, 2321, 2322 }, size = 112, { sample_period, sample_freq } = 42000, sample_type = IP|TID|TIME|PERIOD, read_form>
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: intel_pt = 8, software = 1, power = 11, uprobe = 7, uncore_imc = 12, cpu = 4, cstate_core = 18, uncore_cbox_2 = 15, breakpoint = 5, uncore_cbox_0 = 13, tracepoint >
  # CACHE info available, use -I to display
  # time of first sample : 0.000000
  # time of last sample : 0.000000
  # sample duration :      0.000 ms
  # MEM_TOPOLOGY info available, use -I to display
  # compressed : Zstd, level = 1, ratio = 5
  # missing features: TRACING_DATA BUILD_ID BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID 
  # ========
  #
  
  0x128 [0x20]: event: 79
  .
  . ... raw event: size 32 bytes
  .  0000:  4f 00 00 00 00 00 20 00 1f 00 00 00 00 00 00 00  O..... .........
  .  0010:  11 a6 ef 1f 00 00 00 00 f8 fe 7c b5 f5 ff ff ff  ..........|.....
  
  0 0x128 [0x20]: PERF_RECORD_TIME_CONV: unhandled!
  
  0x148 [0x50]: event: 1
  .
  . ... raw event: size 80 bytes
  .  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
  .  0010:  00 00 00 a8 ff ff ff ff 00 80 33 18 00 00 00 00  ..........3.....
  .  0020:  00 00 00 a8 ff ff ff ff 5b 6b 65 72 6e 65 6c 2e  ........[kernel.
  .  0030:  6b 61 6c 6c 73 79 6d 73 5d 5f 74 65 78 74 00 00  kallsyms]_text..
  .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  
  0 0x148 [0x50]: PERF_RECORD_MMAP -1/0: [0xffffffffa8000000(0x18338000) @ 0xffffffffa8000000]: x [kernel.kallsyms]_text

  ...
  0x62d8e [0x8]: event: 68
  .
  . ... raw event: size 8 bytes
  .  0000:  44 00 00 00 00 00 08 00                          D.......        
  
  0 0x62d8e [0x8]: PERF_RECORD_FINISHED_ROUND
  
  0 [0x28]: event: 9
  .
  . ... raw event: size 40 bytes
  .  0000:  09 00 00 00 01 00 28 00 76 78 06 a8 ff ff ff ff  ......(.vx......
  .  0010:  94 29 00 00 94 29 00 00 82 02 f4 af 33 3e 01 00  .)...)......3>..
  .  0020:  01 00 00 00 00 00 00 00                          ........        
  
  349866692969090 0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): 10644/10644: 0xffffffffa8067876 period: 1 addr: 0
   ... thread: perf:10644
   ...... dso: vmlinux
  
  0 [0x30]: event: 3
  .
  . ... raw event: size 48 bytes
  .  0000:  03 00 00 00 00 20 30 00 94 29 00 00 94 29 00 00  ..... 0..)...)..
  .  0010:  6d 61 74 72 69 78 2e 67 63 63 00 00 00 00 00 00  matrix.gcc......
  .  0020:  94 29 00 00 94 29 00 00 36 09 f4 af 33 3e 01 00  .)...)..6...3>..
  ...
  349892217639276 0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): 10644/10644: 0xffffffffa8288030 period: 45296 addr: 0
   ... thread: matrix.gcc:10644
   ...... dso: vmlinux

  0 [0x30]: event: 4
  .
  . ... raw event: size 48 bytes
  .  0000:  04 00 00 00 00 00 30 00 94 29 00 00 94 29 00 00  ......0..)...)..
  .  0010:  94 29 00 00 94 29 00 00 09 b6 57 a1 39 3e 01 00  .)...)....W.9>..
  .  0020:  94 29 00 00 94 29 00 00 60 b5 57 a1 39 3e 01 00  .)...)..`.W.9>..
  
  349892217648480 0 [0x30]: PERF_RECORD_EXIT(10644:10644):(10644:10644)
  
  Aggregated stats:
             TOTAL events:    8248327
              MMAP events:        100
              LOST events:          0
              COMM events:          2
              EXIT events:          9
          THROTTLE events:     163377
        UNTHROTTLE events:     163377
              FORK events:          8
              READ events:          0
            SAMPLE events:    7909529
             MMAP2 events:          9
               AUX events:          0
      ITRACE_START events:          0
      LOST_SAMPLES events:          0
            SWITCH events:          0
   SWITCH_CPU_WIDE events:          0
        NAMESPACES events:          0
              ATTR events:          0
        EVENT_TYPE events:          0
      TRACING_DATA events:          0
          BUILD_ID events:          0
    FINISHED_ROUND events:       1562
          ID_INDEX events:          0
     AUXTRACE_INFO events:          0
          AUXTRACE events:          0
    AUXTRACE_ERROR events:          0
        THREAD_MAP events:          1
           CPU_MAP events:          1
       STAT_CONFIG events:          0
              STAT events:          0
        STAT_ROUND events:          0
      EVENT_UPDATE events:          0
         TIME_CONV events:          1
           FEATURE events:          0
        COMPRESSED events:      10351
  cycles stats:
             TOTAL events:    7909529
              MMAP events:          0
              LOST events:          0
              COMM events:          0
              EXIT events:          0
          THROTTLE events:          0
        UNTHROTTLE events:          0
              FORK events:          0
              READ events:          0
            SAMPLE events:    7909529
             MMAP2 events:          0
               AUX events:          0
      ITRACE_START events:          0
      LOST_SAMPLES events:          0
            SWITCH events:          0
   SWITCH_CPU_WIDE events:          0
        NAMESPACES events:          0
              ATTR events:          0
        EVENT_TYPE events:          0
      TRACING_DATA events:          0
          BUILD_ID events:          0
    FINISHED_ROUND events:          0
          ID_INDEX events:          0
     AUXTRACE_INFO events:          0
          AUXTRACE events:          0
    AUXTRACE_ERROR events:          0
        THREAD_MAP events:          0
           CPU_MAP events:          0
       STAT_CONFIG events:          0
              STAT events:          0
        STAT_ROUND events:          0
      EVENT_UPDATE events:          0
         TIME_CONV events:          0
           FEATURE events:          0
        COMPRESSED events:          0
  
Dump of trace  without compression:

  $ tools/perf/perf report -D --header
  # ========
  # captured on    : Fri Dec 21 16:44:00 2018
  # header version : 1
  ..
  # time of first sample : 102911.898905
  # time of last sample : 102940.879058
  # sample duration :  28980.153 ms
  # MEM_TOPOLOGY info available, use -I to display
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID COMPRESSED 
  # ========
  #

---
Alexey Budankov (4):
  feature: build libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
  perf record: introduce z, mmap-flush options and PERF_RECORD_COMPRESSED record
  perf record: enable runtime trace compression
  perf report: support record trace file decompression

 tools/build/Makefile.feature             |   6 +-
 tools/build/feature/Makefile             |   6 +-
 tools/build/feature/test-all.c           |   5 +
 tools/build/feature/test-libzstd.c       |  12 ++
 tools/perf/Documentation/perf-record.txt |  11 ++
 tools/perf/Makefile.config               |  20 +++
 tools/perf/Makefile.perf                 |   3 +
 tools/perf/builtin-record.c              | 213 +++++++++++++++++++++--
 tools/perf/builtin-report.c              | 151 +++++++++++++++-
 tools/perf/perf.h                        |   2 +
 tools/perf/util/env.h                    |  10 ++
 tools/perf/util/event.c                  |   1 +
 tools/perf/util/event.h                  |   7 +
 tools/perf/util/evlist.c                 |   6 +-
 tools/perf/util/evlist.h                 |   2 +-
 tools/perf/util/header.c                 |  47 ++++-
 tools/perf/util/header.h                 |   1 +
 tools/perf/util/machine.c                |   4 +
 tools/perf/util/mmap.c                   |  17 +-
 tools/perf/util/mmap.h                   |   5 +-
 tools/perf/util/session.c                |  59 ++++++-
 tools/perf/util/session.h                |  16 ++
 tools/perf/util/tool.h                   |   2 +
 23 files changed, 572 insertions(+), 34 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c

---
[1] https://github.com/facebook/zstd
