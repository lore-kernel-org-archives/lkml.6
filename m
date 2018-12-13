Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A29DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2311A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2311A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeLMG0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:26:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:55915 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeLMG0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:26:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 22:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="118414093"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2018 22:26:35 -0800
Received: from [10.125.251.221] (abudanko-mobl.ccr.corp.intel.com [10.125.251.221])
        by linux.intel.com (Postfix) with ESMTP id B34E9580380;
        Wed, 12 Dec 2018 22:26:33 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
 <20181212121453.GB25240@krava>
Organization: Intel Corp.
Message-ID: <fe25c025-2e9d-70a5-f726-eff3117b74b2@linux.intel.com>
Date:   Thu, 13 Dec 2018 09:26:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212121453.GB25240@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 12.12.2018 15:14, Jiri Olsa wrote:
> On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index e68ba754a8e2..0d017ea85dcb 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -10,6 +10,9 @@
>>  #include <sys/mman.h>
>>  #include <inttypes.h>
>>  #include <asm/bug.h>
>> +#ifdef HAVE_LIBNUMA_SUPPORT
>> +#include <numaif.h>
>> +#endif
>>  #include "debug.h"
>>  #include "event.h"
>>  #include "mmap.h"
>> @@ -177,11 +180,27 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>  		}
>>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
>> +#ifndef HAVE_LIBNUMA_SUPPORT
>>  			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
>> +#else
>> +			size_t mmap_len = perf_mmap__mmap_len(map);
>> +			map->aio.data[i] = mmap(NULL, mmap_len,
>> +				PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>> +#endif
>>  			if (!map->aio.data[i]) {
>>  				pr_debug2("failed to allocate data buffer area, error %m");
>>  				return -1;
>>  			}
>> +#ifdef HAVE_LIBNUMA_SUPPORT
>> +			if (mp->affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
>> +				unsigned long node_mask = 1UL << cpu__get_node(map->cpu);
>> +				if (mbind(map->aio.data[i], mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
>> +					pr_debug2("failed to bind [%p-%p] to node %d\n",
>> +						  map->aio.data[i], map->aio.data[i] + mmap_len,
>> +						  cpu__get_node(map->cpu));
>> +				}
>> +			}
>> +#endif
> 
> could you please do the same thing as we did for aio functions
> (like record__aio_mmap_read_sync) and provide functions for both
> #fidef cases?

Implemented perf_mmap__aio_alloc(),
            perf_mmap__aio_free(),
            perf_mmap__aio_bind() in v2.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
