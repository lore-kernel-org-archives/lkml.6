Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3118C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C28420859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfAISO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:14:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:37801 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfAISO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:14:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 10:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="124726543"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2019 10:14:56 -0800
Received: from [10.252.18.78] (abudanko-mobl.ccr.corp.intel.com [10.252.18.78])
        by linux.intel.com (Postfix) with ESMTP id D20415802E1;
        Wed,  9 Jan 2019 10:14:53 -0800 (PST)
Subject: Re: [PATCH v2 2/4] perf record: bind the AIO user space buffers to
 nodes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
 <20190101214117.GI13760@krava>
 <d03c0f6b-57d8-773b-7d82-316c2bef2fb3@linux.intel.com>
 <20190109164915.GB19455@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <69e3aa8e-ab49-7e97-7988-435aa6b0b211@linux.intel.com>
Date:   Wed, 9 Jan 2019 21:14:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109164915.GB19455@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.2019 19:49, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 12:12:37PM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 02.01.2019 0:41, Jiri Olsa wrote:
>>> On Mon, Dec 24, 2018 at 03:24:36PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> +static void perf_mmap__aio_free(void **data, size_t len __maybe_unused)
>>>> +{
>>>> +	zfree(data);
>>>> +}
>>>> +
>>>> +static void perf_mmap__aio_bind(void *data __maybe_unused, size_t len __maybe_unused,
>>>> +                                int cpu __maybe_unused, int affinity __maybe_unused)
>>>> +{
>>>> +}
>>>> +#endif
>>>> +
>>>>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>>>  {
>>>>  	int delta_max, i, prio;
>>>> @@ -177,11 +220,13 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>>>  		}
>>>>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>>>>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
>>>> -			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
>>>> +			size_t mmap_len = perf_mmap__mmap_len(map);
>>>> +			perf_mmap__aio_alloc(&(map->aio.data[i]), mmap_len);
>>>>  			if (!map->aio.data[i]) {
>>>>  				pr_debug2("failed to allocate data buffer area, error %m");
>>>>  				return -1;
>>>>  			}
>>>> +			perf_mmap__aio_bind(map->aio.data[i], mmap_len, map->cpu, mp->affinity);
>>>
>>> this all does not work if bind fails.. I think we need to
>>> propagate the error value here and fail
>>
>> Proceeding further from this point still makes sense because 
>> the buffer is available for operations and thread migration 
>> alone can bring performance benefits. So the error is not fatal 
>> and an explicit warning is implemented in v3. If you still think 
>> it is better to propagate error from here it can be implemented.
> 
> so if that fails that the aio buffers won't be bound to node,
> while mmaps are, so I guess the speedup is from there?
> 
> if I use:
> 
> # perf record --aio --affinity=node
> 
> and see:
>   "failed to bind..."
> 
> I can still see the benefit..? I guess the warning is ok then,

It still can bring benefits. kernel buffers are allocated locally, 
tool thread migrates to make sure it reads data locally from the buffers.
Even if aio buffers failed to be mapped locally, what is quite rare case,
--affinity=node could still be not slower than without thread migration.

> another option seems confusing

Do you mean --affinity=cpu?

So, well, that cases - bind fail + affinity=node or affinity=cpu - could 
be tested, of course, but it looks simpler and safer to implement error 
reporting and stop, because, again, the cases are quite rare. 
So let's stay on the safer side, in v4. :)

Thanks,
Alexey

> 
> jirka
> 
