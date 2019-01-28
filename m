Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF23C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfA1HC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:02:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:32417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfA1HC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:02:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 23:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="110299061"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2019 23:02:53 -0800
Received: from [10.125.252.29] (abudanko-mobl.ccr.corp.intel.com [10.125.252.29])
        by linux.intel.com (Postfix) with ESMTP id 36E975806C8;
        Sun, 27 Jan 2019 23:02:50 -0800 (PST)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/4] perf: enable compression of record mode trace to save
 storage space
Organization: Intel Corp.
Message-ID: <64502e28-b312-e59f-5cd7-732c4088c16b@linux.intel.com>
Date:   Mon, 28 Jan 2019 10:02:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch set implements runtime trace compression for record mode and 
trace file decompression for report mode. Zstandard API [1] is used for 
compression/decompression of data that come from perf_events kernel 
data buffers.

Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
size reduction on variety of tested workloads what saves user storage 
space on larger server systems where trace file size can easily reach 
several tens or even hundreds of GiBs, especially when profiling with 
stacks for later dwarf unwinding and context-switches tracing and etc.

  $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc

--mmap-flush option can be used to avoid compressing every single byte 
of data and increase compression ratio at the same time lowering tool 
runtime overhead.

The compression functionality can be disabled from the command line 
using NO_LIBZSTD define and Zstandard sources can be overridden using 
value of LIBZSTD_DIR define:

  $ make -C tools/perf NO_LIBZSTD=1 clean all
  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all

The patch set is for Arnaldo's perf/core repository.

---
Alexey Budankov (4):
  feature: realize libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
  perf record: implement -z=<level> and --mmap-flush=<thres> options
  perf record: enable runtime trace compression
  perf report: support record trace file decompression

 tools/build/Makefile.feature             |   6 +-
 tools/build/feature/Makefile             |   6 +-
 tools/build/feature/test-all.c           |   5 +
 tools/build/feature/test-libzstd.c       |  12 +
 tools/perf/Documentation/perf-record.txt |   9 +
 tools/perf/Makefile.config               |  20 ++
 tools/perf/Makefile.perf                 |   3 +
 tools/perf/builtin-record.c              | 167 +++++++++++---
 tools/perf/builtin-report.c              |   5 +-
 tools/perf/perf.h                        |   2 +
 tools/perf/util/env.h                    |  10 +
 tools/perf/util/event.c                  |   1 +
 tools/perf/util/event.h                  |   7 +
 tools/perf/util/evlist.c                 |   6 +-
 tools/perf/util/evlist.h                 |   2 +-
 tools/perf/util/header.c                 |  45 +++-
 tools/perf/util/header.h                 |   1 +
 tools/perf/util/mmap.c                   | 173 ++++++++++-----
 tools/perf/util/mmap.h                   |  31 ++-
 tools/perf/util/session.c                | 271 ++++++++++++++++++++++-
 tools/perf/util/session.h                |  26 +++
 tools/perf/util/tool.h                   |   2 +
 22 files changed, 695 insertions(+), 115 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c

---
Changes in v2:
- moved compression/decompression code to session layer
- enabled allocation aio data buffers for compression
- enabled trace compression for serial trace streaming

---
[1] https://github.com/facebook/zstd

---
Examples:

  $ make -C tools/perf NO_LIBZSTD=1 clean all
  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all

  $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
  Addr of buf1 = 0x7fc266d52010
  Offs of buf1 = 0x7fc266d52180
  Addr of buf2 = 0x7fc264d51010
  Offs of buf2 = 0x7fc264d511c0
  Addr of buf3 = 0x7fc262d50010
  Offs of buf3 = 0x7fc262d50100
  Addr of buf4 = 0x7fc260d4f010
  Offs of buf4 = 0x7fc260d4f140
  Threads #: 8 Pthreads
  Matrix size: 2048
  Using multiply kernel: multiply1
  Execution time = 31.471 seconds
  [ perf record: Woken up 120 times to write data ]
  [ perf record: Compressed 38.118 MB to 7.084 MB, ratio is 5.381 ]
  [ perf record: Captured and wrote 7.100 MB perf.data (999192 samples) ]

  $ tools/perf/perf report -D --header
  # ========
  # captured on    : Sat Jan 26 11:49:55 2019
  # header version : 1
  # data offset    : 296
  # data size      : 7444119
  # feat offset    : 7444415
  # hostname : nntvtune39
  # os release : 4.19.15-300.fc29.x86_64
  # perf version : 4.13.rc5.g3cfa299
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
  # cpuid : GenuineIntel,6,94,3
  # total memory : 16153184 kB
  # cmdline : /root/abudanko/kernel/acme/tools/perf/perf record -z 1 -e cycles -- ../../matrix/linux/matrix.gcc 
  # event : name = cycles, , id = { 2171, 2172, 2173, 2174, 2175, 2176, 2177, 2178 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format =>
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: intel_pt = 8, software = 1, power = 11, uprobe = 7, uncore_imc = 12, cpu = 4, cstate_core = 18, uncore_cbox_2 = 15, breakpoint = 5, uncore_cbox_0 = 13, tracepoint = 2>
  # CACHE info available, use -I to display
  # time of first sample : 230574.239204
  # time of last sample : 230605.735403
  # sample duration :  31496.200 ms
  # MEM_TOPOLOGY info available, use -I to display
  # compressed : Zstd, level = 1, ratio = 5
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID 
  # ========
  #

  0x128 [0x20]: event: 79
  .
  . ... raw event: size 32 bytes
  .  0000:  4f 00 00 00 00 00 20 00 1f 00 00 00 00 00 00 00  O..... .........
  .  0010:  11 a6 ef 1f 00 00 00 00 e7 16 81 83 f5 ff ff ff  ................

  0 0x128 [0x20]: PERF_RECORD_TIME_CONV: unhandled!

  0x148 [0x50]: event: 1
  .
  . ... raw event: size 80 bytes
  .  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
  .  0010:  00 00 00 89 ff ff ff ff 00 10 31 37 00 00 00 00  ..........17....
  .  0020:  00 00 00 89 ff ff ff ff 5b 6b 65 72 6e 65 6c 2e  ........[kernel.
  .  0030:  6b 61 6c 6c 73 79 6d 73 5d 5f 74 65 78 74 00 00  kallsyms]_text..
  .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

  0 0x148 [0x50]: PERF_RECORD_MMAP -1/0: [0xffffffff89000000(0x37311000) @ 0xffffffff89000000]: x [kernel.kallsyms]_text

  ...

  0x6375d [0x8]: event: 68
  .
  . ... raw event: size 8 bytes
  .  0000:  44 00 00 00 00 00 08 00                          D.......        

  0 0x6375d [0x8]: PERF_RECORD_FINISHED_ROUND

  0 [0x28]: event: 9
  .
  . ... raw event: size 40 bytes
  .  0000:  09 00 00 00 01 00 28 00 76 78 06 89 ff ff ff ff  ......(.vx......
  .  0010:  d4 1d 00 00 d4 1d 00 00 26 43 9f bf b4 d1 00 00  ........&C......
  .  0020:  01 00 00 00 00 00 00 00                          ........        

  230574239204134 0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): 7636/7636: 0xffffffff89067876 period: 1 addr: 0
   ... thread: perf:7636
   ...... dso: /proc/kcore

  0 [0x30]: event: 3
  .
  . ... raw event: size 48 bytes
  .  0000:  03 00 00 00 00 20 30 00 d4 1d 00 00 d4 1d 00 00  ..... 0.........
  .  0010:  6d 61 74 72 69 78 2e 67 63 63 00 00 00 00 00 00  matrix.gcc......
  .  0020:  d4 1d 00 00 d4 1d 00 00 34 4a 9f bf b4 d1 00 00  ........4J......

  230574239205940 0 [0x30]: PERF_RECORD_COMM exec: matrix.gcc:7636/7636

  0 [0x28]: event: 9
  .
  . ... raw event: size 40 bytes
  .  0000:  09 00 00 00 01 00 28 00 76 78 06 89 ff ff ff ff  ......(.vx......
  .  0010:  d4 1d 00 00 d4 1d 00 00 1f af 9f bf b4 d1 00 00  ................
  .  0020:  3f 0c 00 00 00 00 00 00                          ?.......        

  230574239231775 0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): 7636/7636: 0xffffffff89067876 period: 3135 addr: 0
   ... thread: matrix.gcc:7636
   ...... dso: /proc/kcore


  Aggregated stats:
             TOTAL events:    1001434
              MMAP events:        100
              LOST events:          0
              COMM events:          2
              EXIT events:          9
          THROTTLE events:          0
        UNTHROTTLE events:          0
              FORK events:          8
              READ events:          0
            SAMPLE events:     999192
             MMAP2 events:          7
               AUX events:          0
      ITRACE_START events:          0
      LOST_SAMPLES events:          0
            SWITCH events:          0
   SWITCH_CPU_WIDE events:          0
        NAMESPACES events:          0
           KSYMBOL events:          0
         BPF_EVENT events:          0
              ATTR events:          0
        EVENT_TYPE events:          0
      TRACING_DATA events:          0
          BUILD_ID events:          0
    FINISHED_ROUND events:        319
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
        COMPRESSED events:       1794
  cycles stats:
             TOTAL events:     999192
              MMAP events:          0
              LOST events:          0
              COMM events:          0
              EXIT events:          0
          THROTTLE events:          0
        UNTHROTTLE events:          0
              FORK events:          0
              READ events:          0
            SAMPLE events:     999192
             MMAP2 events:          0
               AUX events:          0
      ITRACE_START events:          0
      LOST_SAMPLES events:          0
            SWITCH events:          0
   SWITCH_CPU_WIDE events:          0
        NAMESPACES events:          0
           KSYMBOL events:          0
         BPF_EVENT events:          0
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
---
