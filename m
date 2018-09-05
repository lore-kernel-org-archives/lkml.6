Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECAE20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECAE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIELpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:45:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:9801 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbeIELpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:45:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 00:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,332,1531810800"; 
   d="scan'208";a="70457290"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2018 00:16:46 -0700
Received: from [10.125.251.242] (abudanko-mobl.ccr.corp.intel.com [10.125.251.242])
        by linux.intel.com (Postfix) with ESMTP id A6888580268;
        Wed,  5 Sep 2018 00:16:44 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v7 0/2]: perf: reduce data loss when profiling highly parallel
 CPU bound workloads
Organization: Intel Corp.
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
Date:   Wed, 5 Sep 2018 10:16:42 +0300
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
The algorithm loops over mapped per-cpu data buffers and stores 
ready data chunks into a trace file using write() system call.

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
(http://man7.org/linux/man-pages/man7/aio.7.html) 
lowers data loss metrics value providing 2x improvement -
lowering 98% loss to almost 0%.

---
 Alexey Budankov (2):
        perf util: map data buffer for preserving collected data
	perf record: enable asynchronous trace writing
 
 tools/perf/builtin-record.c | 197 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/perf.h           |   1 +
 tools/perf/util/evlist.c    |   7 +-
 tools/perf/util/evlist.h    |   3 +-
 tools/perf/util/mmap.c      | 110 +++++++++++++++++++++----
 tools/perf/util/mmap.h      |  10 ++-
 6 files changed, 302 insertions(+), 26 deletions(-)

---
 Changes in v7:
 - implemented handling record.aio setting from perfconfig file
 Changes in v6:
 - adjusted setting of priorities for cblocks;
 - handled errno == EAGAIN case from aio_write() return;
 Changes in v5:
 - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
 - data loss metrics decreased from 25% to 2x in trialed configuration;
 - reshaped layout of data structures;
 - implemented --aio option;
 - avoided nanosleep() prior calling aio_suspend();
 - switched to per-cpu aio multi buffer record__aio_sync();
 - record_mmap_read_sync() now does global sync just before 
   switching trace file or collection stop;
 Changes in v4:
 - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management
 - converted void *bf to struct perf_mmap *md in signatures
 - written comment in perf_mmap__push() just before perf_mmap__get();
 - written comment in record__mmap_read_sync() on possible restarting 
   of aio_write() operation and releasing perf_mmap object after all;
 - added perf_mmap__put() for the cases of failed aio_write();
 Changes in v3:
 - written comments about nanosleep(0.5ms) call prior aio_suspend()
   to cope with intrusiveness of its implementation in glibc;
 - written comments about rationale behind coping profiling data 
   into mmap->data buffer;
 Changes in v2:
 - converted zalloc() to calloc() for allocation of mmap_aio array,
 - cleared typo and adjusted fallback branch code;
