Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81283C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6CA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfBYP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:27:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:38845 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfBYP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:27:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 07:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="321922729"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2019 07:27:31 -0800
Received: from [10.251.90.22] (abudanko-mobl.ccr.corp.intel.com [10.251.90.22])
        by linux.intel.com (Postfix) with ESMTP id 1CFE15804B4;
        Mon, 25 Feb 2019 07:27:28 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
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
 <20190212130902.GI775@krava>
 <d225cd8c-3447-331a-78ac-070c5b9a442d@linux.intel.com>
Organization: Intel Corp.
Message-ID: <92556e66-4942-c186-7562-a0ee6964d5f8@linux.intel.com>
Date:   Mon, 25 Feb 2019 18:27:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d225cd8c-3447-331a-78ac-070c5b9a442d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.02.2019 18:09, Alexey Budankov wrote:
> 
> On 12.02.2019 16:09, Jiri Olsa wrote:
>> On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
>>
>> SNIP
>>
>>> +	compress_fn = (record__comp_enabled(rec) ?
>>> +		perf_session__zstd_compress : perf_session__zstd_copy);
>>> +
>>>  	if (record__aio_enabled(rec))
>>>  		off = record__aio_get_pos(trace_fd);
>>>  
>>> @@ -799,11 +805,21 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>>  				map->flush = MMAP_FLUSH_DEFAULT;
>>>  			}
>>>  			if (!record__aio_enabled(rec)) {
>>> -				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>>> -					if (sync)
>>> -						map->flush = flush;
>>> -					rc = -1;
>>> -					goto out;
>>> +				if (!record__comp_enabled(rec)) {
>>> +					if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>>> +						if (sync)
>>> +							map->flush = flush;
>>> +						rc = -1;
>>> +						goto out;
>>> +					}
>>> +				} else {
>>> +					if (perf_mmap__pack(map, rec, record__pushfn,
>>> +							compress_fn, session) != 0) {
>>> +						if (sync)
>>> +							map->flush = flush;
>>> +						rc = -1;
>>> +						goto out;
>>> +					}
>>
>> I really dont like this.. the non-compression flow needs to stay untouched
>>
>> why don't you overload the record__pushfn function for compression
>> processing and stash the data in there?
> 
> Yes, this becomes complicated and overloading could be an option to simplify it.

Redesigned compress() to be the param for __push() __aio_push() so this 
__comp_enabled() if could be avoided. Overloading of __pushfn() doesn't 
fit for aio case.

> 
> Thanks,
> Alexey
> 
>>
>> thanks,
>> jirka
>>
> 
