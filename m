Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D70C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F3D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBDKMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:12:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:57441 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfBDKMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:12:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 02:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="130926444"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2019 02:12:17 -0800
Received: from [10.125.252.124] (abudanko-mobl.ccr.corp.intel.com [10.125.252.124])
        by linux.intel.com (Postfix) with ESMTP id 220BD58040E;
        Mon,  4 Feb 2019 02:12:13 -0800 (PST)
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20190203153018.9650-1-jolsa@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
Date:   Mon, 4 Feb 2019 13:12:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 03.02.2019 18:30, Jiri Olsa wrote:
> hi,
> this patchset adds the --dir option to record command (and all
> the other record command that overload cmd_record) that allows
> the data to be stored in directory with multiple data files.
> 
> It's next step for multiple threads implementation in record.
> It's now possible to make directory data via --dir option, like:
> 
>   $ perf record --dir perf bench sched messaging

Is it possible to name data directory differently from perf.data 
e.g. using --output option, like this?

  $ perf record --output result_1 --dir perf bench sched messaging

Thanks,
Alexey

>   $ ls -l perf.data
>   total 344
>   -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
>   -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
>   -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
>   -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
>   -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
>   -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
>   -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
>   -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
>   -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header
> 
> There's a data file created for every cpu and it's storing
> data for those cpu maps. The report command will read it
> transparently, sort it and display as single file data.
> 
> It's possible to transform directory data into standard
> perf.data file via simple inject command:
>     
>   $ perf inject -o perf.data.file -i perf.data
> 
> The old perf fails over the directory data with following message:
>   $ perf report
>   incompatible file format (rerun with -v to learn more)
> 
> I'm now testing the record threads support, so I'd like to
> have some agreement on the directory data support before.
> 
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/dir
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (14):
>       perf tools: Make rm_rf to remove single file
>       perf session: Add process callback to reader object
>       perf data: Move size to struct perf_data_file
>       perf data: Add global path holder
>       perf data: Make check_backup work over directories
>       perf data: Add perf_data__(create_dir|free_dir) functions
>       perf data: Add perf_data__open_dir_data function
>       perf data: Add directory support
>       perf data: Don't store auxtrace index for directory data file
>       perf data: Add perf_data__update_dir function
>       perf data: Make perf_data__size to work over directory
>       perf session: Add __perf_session__process_dir_events function
>       perf session: Add path to reader object
>       perf record: Add --dir option to store data in directory
> 
>  tools/perf/Documentation/perf-record.txt |   3 ++
>  tools/perf/builtin-annotate.c            |   4 +--
>  tools/perf/builtin-buildid-cache.c       |   4 +--
>  tools/perf/builtin-buildid-list.c        |   8 ++---
>  tools/perf/builtin-c2c.c                 |   4 +--
>  tools/perf/builtin-diff.c                |  12 +++----
>  tools/perf/builtin-evlist.c              |   4 +--
>  tools/perf/builtin-inject.c              |  10 +++---
>  tools/perf/builtin-kmem.c                |   2 +-
>  tools/perf/builtin-kvm.c                 |   8 ++---
>  tools/perf/builtin-lock.c                |   8 ++---
>  tools/perf/builtin-mem.c                 |   8 ++---
>  tools/perf/builtin-record.c              |  72 +++++++++++++++++++++++++++++++------
>  tools/perf/builtin-report.c              |   6 ++--
>  tools/perf/builtin-sched.c               |  16 ++++-----
>  tools/perf/builtin-script.c              |  12 +++----
>  tools/perf/builtin-stat.c                |   6 ++--
>  tools/perf/builtin-timechart.c           |   8 ++---
>  tools/perf/builtin-trace.c               |   8 ++---
>  tools/perf/util/data-convert-bt.c        |   2 +-
>  tools/perf/util/data.c                   | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/data.h                   |  24 +++++++++----
>  tools/perf/util/mmap.h                   |  23 ++++++------
>  tools/perf/util/session.c                | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  tools/perf/util/util.c                   |  10 ++++--
>  25 files changed, 479 insertions(+), 131 deletions(-)
> 
