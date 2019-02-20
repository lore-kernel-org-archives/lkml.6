Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F354C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2852086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBTPTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:19:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:31827 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfBTPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="320602201"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2019 07:19:53 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id EA63B58028E;
        Wed, 20 Feb 2019 07:19:50 -0800 (PST)
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
 <20190212130935.GO775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ea7651bc-0ea9-bdf8-f595-cf42dba4314d@linux.intel.com>
Date:   Wed, 20 Feb 2019 18:19:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130935.GO775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:09, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
>>
>> Implement -z,--compression_level=<n> and --mmap-flush=<dump_least_size>
>> options as well as a special PERF_RECORD_COMPRESSED record that contains
>> compressed parts of kernel data buffer.
>>
>> Because compression requires auxilary memory to implement encoding of
>> kernel data record->opts.nr_cblocks == -1 signifies to preallocate single
>> AIO data buffer aio.data[0] without accompnying AIO control blocks.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v2:
>> - enabled allocation aio data buffers for compression
>>
>> ---
>>  tools/perf/Documentation/perf-record.txt |   9 ++
>>  tools/perf/builtin-record.c              | 110 +++++++++++++++++++----
>>  tools/perf/perf.h                        |   2 +
>>  tools/perf/util/env.h                    |  10 +++
>>  tools/perf/util/event.c                  |   1 +
>>  tools/perf/util/event.h                  |   7 ++
>>  tools/perf/util/evlist.c                 |   6 +-
>>  tools/perf/util/evlist.h                 |   3 +-
>>  tools/perf/util/header.c                 |  45 +++++++++-
>>  tools/perf/util/header.h                 |   1 +
>>  tools/perf/util/mmap.c                   |  98 ++++++++++++--------
>>  tools/perf/util/mmap.h                   |   7 +-
>>  tools/perf/util/session.h                |   2 +
>>  13 files changed, 240 insertions(+), 61 deletions(-)
> 
> this patch is super complicated.. please think of reviewers
> when writing code ;-)
> 
> it needs to be split to small logical patches,
> where each change is explained in changelog

Yes, Will do.

Thanks,
Alexey

> 
> jirka
> 
