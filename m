Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BA320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfANIqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:46:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:7567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfANIqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:46:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 00:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="106408421"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2019 00:46:17 -0800
Received: from [10.125.252.160] (abudanko-mobl.ccr.corp.intel.com [10.125.252.160])
        by linux.intel.com (Postfix) with ESMTP id B24C2580261;
        Mon, 14 Jan 2019 00:46:15 -0800 (PST)
Subject: Re: [PATCH v1 2/4] perf record: introduce z, mmap-flush options and
 PERF_RECORD_COMPRESSED record
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
 <d8b15698-67da-3fea-8bd5-32e18d223e99@linux.intel.com>
 <20190109165833.GD19455@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5281536b-b336-21c3-5251-82ec6a676341@linux.intel.com>
Date:   Mon, 14 Jan 2019 11:46:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109165833.GD19455@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 09.01.2019 19:58, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 04:45:21PM +0300, Alexey Budankov wrote:
>>
>> Introduce --compression_level=n, --mmap-flush options and PERF_RECORD_COMPRESSED 
>> event record that contains compressed parts of mmap kernel buffer data.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 11 +++
>>  tools/perf/builtin-record.c              | 97 ++++++++++++++++++++----
>>  tools/perf/perf.h                        |  2 +
>>  tools/perf/util/env.h                    | 10 +++
>>  tools/perf/util/event.c                  |  1 +
>>  tools/perf/util/event.h                  |  7 ++
>>  tools/perf/util/evlist.c                 |  6 +-
>>  tools/perf/util/evlist.h                 |  2 +-
>>  tools/perf/util/header.c                 | 47 +++++++++++-
>>  tools/perf/util/header.h                 |  1 +
>>  tools/perf/util/mmap.c                   |  4 +-
>>  tools/perf/util/mmap.h                   |  3 +-
>>  12 files changed, 169 insertions(+), 22 deletions(-)
> 
> also I'm getting here similar error (like for the affinity patchset)

Really weird. Hopefully it can be resolved in the next version of the patch set.

Thanks,
Alexey

> 
> [jolsa@krava perf]$ git am /tmp/comp
> Applying: feature: build libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
> Applying: perf record: introduce z, mmap-flush options and PERF_RECORD_COMPRESSED record
> error: corrupt patch at line 526
> Patch failed at 0002 perf record: introduce z, mmap-flush options and PERF_RECORD_COMPRESSED record
> 
> again the raw patch applies correctly:
> 
> [jolsa@krava perf]$ patch -p3 < /tmp/comp2
> patching file Documentation/perf-record.txt
> patching file builtin-record.c
> patching file perf.h
> patching file util/env.h
> patching file util/event.c
> patching file util/event.h
> patching file util/evlist.c
> patching file util/evlist.h
> patching file util/header.c
> patching file util/header.h
> patching file util/mmap.c
> patching file util/mmap.h
> 
> 
> jirka
> 
