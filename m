Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE612054F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE612054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeJLCD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:03:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:38472 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbeJLCD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:03:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="81861470"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2018 11:35:27 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 7F897580409;
        Thu, 11 Oct 2018 11:35:25 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v13 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
Date:   Thu, 11 Oct 2018 21:35:24 +0300
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
    --call-graph dwarf,1024 --user-regs=IP,SP,BP --switch-events \
    -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
    matrix.gcc

Data loss metrics is the ratio lost_time/elapsed_time where 
lost_time is the sum of time intervals containing PERF_RECORD_LOST 
records and elapsed_time is the elapsed application run time 
under profiling.

Applying asynchronous trace streaming thru Posix AIO API [1] lowers 
data loss metrics value providing 2x improvement (from 98% to ~1%)

Asynchronous trace streaming is currently limited to glibc linkage.
musl libc [5] also provides Posix AIO API implementation, however 
the patchkit is not tested with it. There may be other libc libraries 
linked by Perf tool that currently lack Posix AIO API support [2], 
[3], [4] so NO_AIO define may be used to limit Perf tool binary to 
serial streaming only.

---
 Alexey Budankov (3):
	perf util: map data buffer for preserving collected data
	perf record: enable asynchronous trace writing
	perf record: extend trace writing to multi AIO

 tools/perf/Documentation/perf-record.txt |   5 +
 tools/perf/Makefile.config               |   5 +
 tools/perf/Makefile.perf                 |   7 +-
 tools/perf/builtin-record.c              | 249 ++++++++++++++++++++++++++++++-
 tools/perf/perf.h                        |   1 +
 tools/perf/util/evlist.c                 |   6 +-
 tools/perf/util/evlist.h                 |   2 +-
 tools/perf/util/mmap.c                   | 146 +++++++++++++++++-
 tools/perf/util/mmap.h                   |  26 +++-
 9 files changed, 436 insertions(+), 11 deletions(-)

---
 Changes in v13:
 - named new functions with _aio_ word
 - grouped aio functions under single #ifdef HAVE_AIO_SUPPORT
 - moved perf_mmap__aio_push() stub into header
 - removed trailed white space
 Changes in v12:
 - applied stub functions design for the whole patch kit
 - grouped AIO related data into a struct under struct perf_mmap
 - implemented record__aio_get/set_pos(), record__aio_enabled()
 - implemented simple --aio option
 - extended --aio option to --aio-cblocks=<n>
 Changes in v11:
 - replacing the both lseek() syscalls in every loop iteration by the only 
   two syscalls just before and after the loop at record__mmap_read_evlist() 
   and advancing *in-flight* off file pos value at perf_mmap__aio_push()
 Changes in v10:
 - moved specific code to perf_mmap__aio_mmap(), perf_mmap__aio_munmap();
 - adjusted error reporting by using %m
 - avoided lseek() setting file pos back in case of record__aio_write() failure
 - compacted code selecting between serial and AIO streaming
 - optimized call places of record__mmap_read_sync()
 - added description of aio-cblocks option into perf-record.txt
 Changes in v9:
 - enable AIO streaming only when --aio-cblocks option is specified explicitly
 - enable AIO based implementation when linking with glibc only
 - define NO_AIO to limit Perf binary to serial implementation
 Changes in v8:
 - run the whole thing thru checkpatch.pl and corrected found issues except
   lines longer than 80 symbols
 - corrected comments alignment and formatting
 - moved multi AIO implementation into 3rd patch in the series
 - implemented explicit cblocks array allocation
 - split AIO completion check into separate record__aio_complete()
 - set nr_cblocks default to 1 and max allowed value to 4
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

---

[1] http://man7.org/linux/man-pages/man7/aio.7.html
[2] https://android.googlesource.com/platform/bionic/+/master/docs/status.md
[3] https://www.uclibc.org/
[4] https://uclibc-ng.org/
[5] https://www.musl-libc.org/
