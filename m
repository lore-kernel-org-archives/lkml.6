Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B83C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3F12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBTPTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:19:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:14866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfBTPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:19:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="145829083"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2019 07:19:06 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 5474658019B;
        Wed, 20 Feb 2019 07:19:04 -0800 (PST)
Subject: Re: [PATCH v2 4/4] perf report: support record trace file
 decompression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
 <20190212130850.GG775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f2b04e7b-6014-1799-3360-85ade10252c4@linux.intel.com>
Date:   Wed, 20 Feb 2019 18:19:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130850.GG775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:25:00PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  size_t perf_session__zstd_copy(void *to __maybe_unused,
>> @@ -533,6 +646,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>>  		tool->time_conv = process_event_op2_stub;
>>  	if (tool->feature == NULL)
>>  		tool->feature = process_event_op2_stub;
>> +	if (tool->compressed == NULL)
>> +		tool->compressed = perf_session__process_compressed_event;
>>  }
>>  
>>  static void swap_sample_id_all(union perf_event *event, void *data)
>> @@ -1469,7 +1584,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>>  	int fd = perf_data__fd(session->data);
>>  	int err;
>>  
>> -	dump_event(session->evlist, event, file_offset, &sample);
>> +	if (event->header.type != PERF_RECORD_COMPRESSED)
>> +		dump_event(session->evlist, event, file_offset, &sample);
>>  
>>  	/* These events are processed right away */
>>  	switch (event->header.type) {
>> @@ -1522,6 +1638,11 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>>  		return tool->time_conv(session, event);
>>  	case PERF_RECORD_HEADER_FEATURE:
>>  		return tool->feature(session, event);
>> +	case PERF_RECORD_COMPRESSED:
>> +		err = tool->compressed(session, event, file_offset);
>> +		if (err)
>> +			dump_event(session->evlist, event, file_offset, &sample);
> 
> I'm not sure about having compressed callback at all, but maybe
> it could be usefull for inject, to get the compressed data..?

This code implements handling thru callbacks, for some reason,
so the new part is designed the same way. Inject flow probably 
will benefit from this approach. It is required to be tested 
additionally.

Thanks,
Alexey


> 
> I assume inject is working now and it will get you the uncompressed
> perf.data?
> 
> jirka
> 
