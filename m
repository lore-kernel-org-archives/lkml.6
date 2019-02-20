Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D40C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041BE20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBTPGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:06:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:42260 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfBTPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:06:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="125883488"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 07:06:08 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 5F64558019B;
        Wed, 20 Feb 2019 07:06:06 -0800 (PST)
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
 <20190212130951.GR775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0721740f-5b1b-06e5-eebb-d7068be54715@linux.intel.com>
Date:   Wed, 20 Feb 2019 18:06:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130951.GR775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:09, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
>>
>> Compression is implemented using simple Zstd API and employs AIO data
>> buffer as the memory to operate on. If the API call fails for some
>> reason compression falls back to memcpy().
>>
>> Data chunks are split and packed into PERF_RECORD_COMPRESSED records
>> by 64KB at max. mmap-flush option value can be used to avoid compression
>> of every single byte of data and increase compression ratio.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v2:
>> - enabled trace compression for serial trace streaming
>> - moved compression/decompression code to session layer
>>
>> ---
>>  tools/perf/builtin-record.c |  67 +++++++++-----
>>  tools/perf/util/mmap.c      | 173 +++++++++++++++++++++---------------
>>  tools/perf/util/mmap.h      |  24 +++--
>>  tools/perf/util/session.c   | 106 ++++++++++++++++++++++
>>  tools/perf/util/session.h   |  13 +++
>>  5 files changed, 280 insertions(+), 103 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 227dbbd47d3f..435ff88dfc5e 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -112,8 +112,7 @@ static bool switch_output_time(struct record *rec)
>>  	       trigger_is_ready(&switch_output_trigger);
>>  }
>>  
>> -static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
>> -			 void *bf, size_t size)
>> +static int record__write(struct record *rec, void *bf, size_t size)
> 
> please keep the 'struct perf_mmap *map' in, I'm using it in
> the multiple file storage, where each map holds pointer to
> its data file

Yes, it will be reverted.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
