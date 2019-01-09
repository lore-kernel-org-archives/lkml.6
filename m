Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F97C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfAIJKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:10:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:9736 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfAIJKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:10:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:10:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="308837194"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2019 01:10:24 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id AD5E2580490;
        Wed,  9 Jan 2019 01:10:22 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
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
 <20190101213909.GB13760@krava>
Organization: Intel Corp.
Message-ID: <ed4aa1f6-c473-9088-32c7-a1190a23af18@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:10:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190101213909.GB13760@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.01.2019 0:39, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 03:24:36PM +0300, Alexey Budankov wrote:
>>
>> Allocate and bind AIO user space buffers to the memory nodes
>> that mmap kernel buffers are bound to.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v2:
>> - implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
>>   and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
>> ---
>>  tools/perf/util/mmap.c | 49 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index e68ba754a8e2..742fa9a8e498 100644
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
>> @@ -154,6 +157,46 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>  }
>>  
>>  #ifdef HAVE_AIO_SUPPORT
>> +
>> +#ifdef HAVE_LIBNUMA_SUPPORT
>> +static void perf_mmap__aio_alloc(void **data, size_t len)
>> +{
>> +	*data = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>> +}
> 
> please make perf_mmap__aio_alloc return the pointer,
> I dont see a need for **data arg
> 
> also perf_mmap__ preffix indicates it's function over
> 'struct perf_mmap', which should be the first arg..
> not sure, but perhaps that could make the code also
> simpler, like:
> 
> static int perf_mmap__aio_alloc(struct perf_mmap *, int index);
> static int perf_mmap__aio_bind(struct perf_mmap *, int index, int affinity);
> static void perf_mmap__aio_free(struct perf_mmap *, int index);

Makes sense. Applied all that in v3.

Thanks,
Alexey

> 
> jirka
> 
