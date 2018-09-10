Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6117AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2695520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2695520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeIJPih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:38:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:32774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeIJPih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:38:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 03:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="90399219"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2018 03:45:10 -0700
Received: from [10.125.252.9] (abudanko-mobl.ccr.corp.intel.com [10.125.252.9])
        by linux.intel.com (Postfix) with ESMTP id 6BD1A5803C2;
        Mon, 10 Sep 2018 03:45:08 -0700 (PDT)
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com> <20180910095909.GA15548@krava>
 <20180910100303.GA101776@gmail.com> <20180910100841.GB15548@krava>
 <20180910101325.GA5544@gmail.com> <20180910102328.GC15548@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <de3896ff-8cd0-e811-7e6a-64ddd0401897@linux.intel.com>
Date:   Mon, 10 Sep 2018 13:45:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910102328.GC15548@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.09.2018 13:23, Jiri Olsa wrote:
> On Mon, Sep 10, 2018 at 12:13:25PM +0200, Ingo Molnar wrote:
>>
>> * Jiri Olsa <jolsa@redhat.com> wrote:
>>
>>> On Mon, Sep 10, 2018 at 12:03:03PM +0200, Ingo Molnar wrote:
>>>>
>>>> * Jiri Olsa <jolsa@redhat.com> wrote:
>>>>
>>>>>> Per-CPU threading the record session would have so many other advantages as well (scalability, 
>>>>>> etc.).
>>>>>>
>>>>>> Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
>>>>>> moment?
>>>>>
>>>>> it's still usable, I can rebase it and post a branch pointer,
>>>>> the problem is I haven't been able to find a case with a real
>>>>> performance benefit yet.. ;-)
>>>>>
>>>>> perhaps because I haven't tried on server with really big cpu
>>>>> numbers
>>>>
>>>> Maybe Alexey could pick up from there? Your concept looked fairly mature to me
>>>> and I tried it on a big-CPU box back then and there were real improvements.
>>>
>>> too bad u did not share your results, it could have been already in ;-)
>>
>> Yeah :-/ Had a proper round of testing on my TODO, then the big box I'd have tested it on
>> broke ...
>>
>>> let me rebase/repost once more and let's see
>>
>> Thanks!
>>
>>> I think we could benefit from both multiple threads event reading
>>> and AIO writing for perf.data.. it could be merged together
>>
>> So instead of AIO writing perf.data, why not just turn perf.data into a directory structure 
>> with per CPU files? That would allow all sorts of neat future performance features such as 
> 
> that's basically what the multiple-thread record patchset does

Re-posting part of my answer here...

Please note that tool threads may contend, and actually do, with 
application threads, under heavy load when all CPU cores are utilized,
and this may alter performance profile.

So this or that tool design is also a matter of proper system balancing
when profiling so that the gathered performance data would be actual.

Thanks,
Alexey

> 
> jirka
> 
>> mmap() or splice() based zero-copy.
>>
>> User-space post-processing can then read the files and put them into global order - or use the 
>> per CPU nature of them, which would be pretty useful too.
>>
>> Also note how well this works on NUMA as well, as the backing pages would be allocated in a 
>> NUMA-local fashion.
>>
>> I.e. the whole per-CPU threading would enable such a separation of the tracing/event streams 
>> and would allow true scalability.
>>
>> Thanks,
>>
>> 	Ingo
> 
