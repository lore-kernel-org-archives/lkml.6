Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C78C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321372186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbfBKURc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:17:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:2781 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfBKURU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:17:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="137777301"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2019 12:17:19 -0800
Received: from [10.252.27.66] (abudanko-mobl.ccr.corp.intel.com [10.252.27.66])
        by linux.intel.com (Postfix) with ESMTP id 2229D5800C6;
        Mon, 11 Feb 2019 12:17:16 -0800 (PST)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/4] perf: enable compression of record mode trace to save
 storage space
Organization: Intel Corp.
Message-ID: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Date:   Mon, 11 Feb 2019 23:17:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the rebase to the tip of Arnaldo's perf/core repository.

The patch set implements runtime trace compression for record mode and 
trace file decompression for report mode. Zstandard API [1] is used for 
compression/decompression of data that come from perf_events kernel 
data buffers.

Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
size reduction on variety of tested workloads what saves user storage 
space on larger server systems where trace file size can easily reach 
several tens or even hundreds of GiBs, especially when profiling with 
dwarf-based stacks and tracing of  context-switches.

--mmap-flush option can be used to avoid compressing every single byte 
of data and increase compression ratio at the same time lowering tool 
runtime overhead.

  $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
  $ tools/perf/perf record -z 1 --mmap-flush 1024 -e cycles -- matrix.gcc
  $ tools/perf/perf record -z 1 --mmap-flush 1024 --aio -e cycles -- matrix.gcc

The compression functionality can be disabled from the command line 
using NO_LIBZSTD define and Zstandard sources can be overridden using 
value of LIBZSTD_DIR define:

  $ make -C tools/perf NO_LIBZSTD=1 clean all
  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all

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
 tools/perf/util/evlist.h                 |   3 +-
 tools/perf/util/header.c                 |  45 +++-
 tools/perf/util/header.h                 |   1 +
 tools/perf/util/mmap.c                   | 265 +++++++++++++---------
 tools/perf/util/mmap.h                   |  31 ++-
 tools/perf/util/session.c                | 271 ++++++++++++++++++++++-
 tools/perf/util/session.h                |  26 +++
 tools/perf/util/tool.h                   |   2 +
 22 files changed, 742 insertions(+), 161 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c

---
Changes in v2:
- moved compression/decompression code to session layer
- enabled allocation aio data buffers for compression
- enabled trace compression for serial trace streaming

---
[1] https://github.com/facebook/zstd

