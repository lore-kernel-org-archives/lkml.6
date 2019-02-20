Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957832086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfBTPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:24:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:15316 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfBTPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:24:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="276501731"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2019 07:24:33 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 2FE0358019B;
        Wed, 20 Feb 2019 07:24:30 -0800 (PST)
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d3b3ccaf-c8d2-03f7-580e-f3318b1650d2@linux.intel.com>
Date:   Wed, 20 Feb 2019 18:24:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130822.GC775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map);
>> +
>>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>  {
>> -	int delta_max, i, prio, ret;
>> +	int i, ret = 0, init_blocks = 1;
>>  
>>  	map->aio.nr_cblocks = mp->nr_cblocks;
>> +	if (map->aio.nr_cblocks == -1) {
>> +		map->aio.nr_cblocks = 1;
>> +		init_blocks = 0;
>> +	}
>> +
>>  	if (map->aio.nr_cblocks) {
>> -		map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
>> -		if (!map->aio.aiocb) {
>> -			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
>> -			return -1;
>> -		}
>> -		map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
>> -		if (!map->aio.cblocks) {
>> -			pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
>> -			return -1;
>> -		}
>>  		map->aio.data = calloc(map->aio.nr_cblocks, sizeof(void *));
>>  		if (!map->aio.data) {
>>  			pr_debug2("failed to allocate data buffer, error %m\n");
>>  			return -1;
>>  		}
>> -		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
>>  			ret = perf_mmap__aio_alloc(map, i);
>>  			if (ret == -1) {
>> @@ -251,29 +245,16 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>  			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
>>  			if (ret == -1)
>>  				return -1;
>> -			/*
>> -			 * Use cblock.aio_fildes value different from -1
>> -			 * to denote started aio write operation on the
>> -			 * cblock so it requires explicit record__aio_sync()
>> -			 * call prior the cblock may be reused again.
>> -			 */
>> -			map->aio.cblocks[i].aio_fildes = -1;
>> -			/*
>> -			 * Allocate cblocks with priority delta to have
>> -			 * faster aio write system calls because queued requests
>> -			 * are kept in separate per-prio queues and adding
>> -			 * a new request will iterate thru shorter per-prio
>> -			 * list. Blocks with numbers higher than
>> -			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
>> -			 */
>> -			prio = delta_max - i;
>> -			map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
>>  		}
>> +		if (init_blocks)
>> +			ret = perf_mmap__aio_mmap_blocks(map);
>>  	}
>>  
>> -	return 0;
>> +	return ret;
>>  }
> 
> SNIP
> 
> it seems like little refactoring happened in here (up and down) for
> aio code, which is not explained and I'm unable to follow it.. please
> separate this in simple change

AIO buffers management has been taken out of HAVE_AIO_SUPPORT define
to be used for compression in case of serial streaming. It will be 
revisited after other issues are addressed.

Thanks,
Alexey

> 
> SNIP
> 
>> +#ifdef HAVE_AIO_SUPPORT
>> +static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map)
>> +{
>> +	int delta_max, i, prio;
>> +
>> +	map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
>> +	if (!map->aio.aiocb) {
>> +		pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
>> +		return -1;
>> +	}
>> +	map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
>> +	if (!map->aio.cblocks) {
>> +		pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
>> +		return -1;
>> +	}
>> +	delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>> +	for (i = 0; i < map->aio.nr_cblocks; ++i) {
>> +		/*
>> +		 * Use cblock.aio_fildes value different from -1
>> +		 * to denote started aio write operation on the
>> +		 * cblock so it requires explicit record__aio_sync()
>> +		 * call prior the cblock may be reused again.
>> +		 */
>> +		map->aio.cblocks[i].aio_fildes = -1;
>> +		/*
>> +		 * Allocate cblocks with priority delta to have
>> +		 * faster aio write system calls because queued requests
>> +		 * are kept in separate per-prio queues and adding
>> +		 * a new request will iterate thru shorter per-prio
>> +		 * list. Blocks with numbers higher than
>> +		 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
>> +		 */
>> +		prio = delta_max - i;
>> +		map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> SNIP
> 
