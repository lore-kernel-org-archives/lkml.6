Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63668C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16221208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16221208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHWTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:41:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:63117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeHWTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:41:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="67585035"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2018 09:09:36 -0700
Received: from [10.252.7.112] (abudanko-mobl.ccr.corp.intel.com [10.252.7.112])
        by linux.intel.com (Postfix) with ESMTP id 361E9580332;
        Thu, 23 Aug 2018 09:09:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/2]: perf util: map data buffer for preserving
 collected data
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <1c3fd88f-c408-2863-15b3-221829f3d383@linux.intel.com>
 <e2c4db6b-555b-c029-5c35-986a90b284fe@linux.intel.com>
 <20180823143005.GB4766@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <62034f55-5d3a-79c7-b983-1e4f16e43c1f@linux.intel.com>
Date:   Thu, 23 Aug 2018 19:09:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823143005.GB4766@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 23.08.2018 17:30, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 23, 2018 at 01:30:47PM +0300, Alexey Budankov escreveu:
>> +++ b/tools/perf/util/evlist.c
>> @@ -718,6 +718,8 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
>>  void perf_evlist__munmap(struct perf_evlist *evlist)
>>  {
>>  	perf_evlist__munmap_nofree(evlist);
>> +	if (&evlist->mmap_aio)
> 
> Is the above test for evlist->mmap_aio being NULL? I think that '&' is
> not needed here, with it this test will always be true, right?

Right, looks like a typo.

> 
>> +		zfree(&evlist->mmap_aio);
> 
>>  	zfree(&evlist->mmap);
>>  	zfree(&evlist->overwrite_mmap);
>>  }
>> @@ -749,6 +751,13 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
>>  		 */
>>  		refcount_set(&map[i].refcnt, 0);
>>  	}
>> +
>> +	evlist->mmap_aio = zalloc(evlist->nr_mmaps * sizeof(struct aiocb *));
> 
> Right, and here you could have used calloc(evlist->nr_mmaps, sizeof(struct aiocb *))

yep, make sense.

> 
>> +	if (!evlist->mmap_aio) {
>> +		zfree(&map);
> 
> If you use zfree(&map); then map becomes NULL and you do not return NULL
> in the next line, if you insist in using the following 'return NULL;',
> then you could as well use just 'free(map);', as 'map' is a local
> variable and thus we need not set it to NULL :-)

yeah, I see. Let me resend. Thanks!

> 
>> +		return NULL;
>> +	}
>> +
>>  	return map;
>>  }
>>  
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index dc66436add98..f98b949561fd 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -15,6 +15,7 @@
>>  #include "util.h"
>>  #include <signal.h>
>>  #include <unistd.h>
>> +#include <aio.h>
>>  
>>  struct pollfd;
>>  struct thread_map;
>> @@ -43,6 +44,7 @@ struct perf_evlist {
>>  	} workload;
>>  	struct fdarray	 pollfd;
>>  	struct perf_mmap *mmap;
>> +	struct aiocb	 **mmap_aio;
>>  	struct perf_mmap *overwrite_mmap;
>>  	struct thread_map *threads;
>>  	struct cpu_map	  *cpus;
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index fc832676a798..e71d46cb01cc 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>  
>>  void perf_mmap__munmap(struct perf_mmap *map)
>>  {
>> +	if (map->data != NULL) {
>> +		munmap(map->data, perf_mmap__mmap_len(map));
>> +		map->data = NULL;
>> +	}
>>  	if (map->base != NULL) {
>>  		munmap(map->base, perf_mmap__mmap_len(map));
>>  		map->base = NULL;
>> @@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>>  		map->base = NULL;
>>  		return -1;
>>  	}
>> +	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
>> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +	if (map->data == MAP_FAILED) {
>> +		pr_debug2("failed to mmap perf event data buffer, error %d\n",
>> +				errno);
>> +		map->data = NULL;
>> +		return -1;
>> +	}
>>  	map->fd = fd;
>>  
>>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index d82294db1295..1974e621e36b 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -6,6 +6,7 @@
>>  #include <linux/types.h>
>>  #include <asm/barrier.h>
>>  #include <stdbool.h>
>> +#include <aio.h>
>>  #include "auxtrace.h"
>>  #include "event.h"
>>  
>> @@ -25,6 +26,8 @@ struct perf_mmap {
>>  	bool		 overwrite;
>>  	struct auxtrace_mmap auxtrace_mmap;
>>  	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
>> +	void 		 *data;
>> +	struct aiocb	 cblock;
>>  };
>>  
>>  /*
>>  
> 
