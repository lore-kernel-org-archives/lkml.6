Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9442C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F36F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBYP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:27:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:44691 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfBYP1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:27:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 07:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="141464139"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 07:27:13 -0800
Received: from [10.251.90.22] (abudanko-mobl.ccr.corp.intel.com [10.251.90.22])
        by linux.intel.com (Postfix) with ESMTP id 64C45580261;
        Mon, 25 Feb 2019 07:27:06 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
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
 <20190212130822.GC775@krava>
 <d3b3ccaf-c8d2-03f7-580e-f3318b1650d2@linux.intel.com>
 <20190221094906.GD10990@krava>
 <4e3546bc-4898-3232-3235-1cc8d2cf5c09@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3e12075b-88e1-81e0-3b8a-6467ddc32475@linux.intel.com>
Date:   Mon, 25 Feb 2019 18:27:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4e3546bc-4898-3232-3235-1cc8d2cf5c09@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.02.2019 14:24, Alexey Budankov wrote:
> 
> On 21.02.2019 12:49, Jiri Olsa wrote:
>> On Wed, Feb 20, 2019 at 06:24:30PM +0300, Alexey Budankov wrote:
>>>
>>> On 12.02.2019 16:08, Jiri Olsa wrote:
>>>> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
>>>>
>>>> SNIP
>>>>
>>>>> +static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map);
>>>>> +
>>>>>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>>>>  {
>>>>> -	int delta_max, i, prio, ret;
>>>>> +	int i, ret = 0, init_blocks = 1;
>>>>>  
>>>>>  	map->aio.nr_cblocks = mp->nr_cblocks;
>>>>> +	if (map->aio.nr_cblocks == -1) {
>>>>> +		map->aio.nr_cblocks = 1;
>>>>> +		init_blocks = 0;
>>>>> +	}
>>>>> +
>>>>>  	if (map->aio.nr_cblocks) {
>>>>> -		map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
>>>>> -		if (!map->aio.aiocb) {
>>>>> -			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
>>>>> -			return -1;
>>>>> -		}
>>>>> -		map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
>>>>> -		if (!map->aio.cblocks) {
>>>>> -			pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
>>>>> -			return -1;
>>>>> -		}
>>>>>  		map->aio.data = calloc(map->aio.nr_cblocks, sizeof(void *));
>>>>>  		if (!map->aio.data) {
>>>>>  			pr_debug2("failed to allocate data buffer, error %m\n");
>>>>>  			return -1;
>>>>>  		}
>>>>> -		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>>>>>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
>>>>>  			ret = perf_mmap__aio_alloc(map, i);
>>>>>  			if (ret == -1) {
>>>>> @@ -251,29 +245,16 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>>>>  			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
>>>>>  			if (ret == -1)
>>>>>  				return -1;
>>>>> -			/*
>>>>> -			 * Use cblock.aio_fildes value different from -1
>>>>> -			 * to denote started aio write operation on the
>>>>> -			 * cblock so it requires explicit record__aio_sync()
>>>>> -			 * call prior the cblock may be reused again.
>>>>> -			 */
>>>>> -			map->aio.cblocks[i].aio_fildes = -1;
>>>>> -			/*
>>>>> -			 * Allocate cblocks with priority delta to have
>>>>> -			 * faster aio write system calls because queued requests
>>>>> -			 * are kept in separate per-prio queues and adding
>>>>> -			 * a new request will iterate thru shorter per-prio
>>>>> -			 * list. Blocks with numbers higher than
>>>>> -			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
>>>>> -			 */
>>>>> -			prio = delta_max - i;
>>>>> -			map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
>>>>>  		}
>>>>> +		if (init_blocks)
>>>>> +			ret = perf_mmap__aio_mmap_blocks(map);
>>>>>  	}
>>>>>  
>>>>> -	return 0;
>>>>> +	return ret;
>>>>>  }
>>>>
>>>> SNIP
>>>>
>>>> it seems like little refactoring happened in here (up and down) for
>>>> aio code, which is not explained and I'm unable to follow it.. please
>>>> separate this in simple change
>>>
>>> AIO buffers management has been taken out of HAVE_AIO_SUPPORT define
>>> to be used for compression in case of serial streaming. It will be 
>>> revisited after other issues are addressed.
>>
>> as I said earlier, please separate this from aio
> 
> Ok.

Addressed.

> 
> Thanks,
> Alexey
> 
> 
>>
>> jirka
>>
> 
