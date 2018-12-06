Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F881C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674F620850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674F620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLFSKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:10:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:7651 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeLFSKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:10:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 10:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="105427579"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2018 10:10:12 -0800
Received: from [10.252.23.157] (rjmoreno-mobl.amr.corp.intel.com [10.252.23.157])
        by linux.intel.com (Postfix) with ESMTP id BBA175804F9;
        Thu,  6 Dec 2018 10:10:09 -0800 (PST)
Subject: Re: [PATCH v1] perf record: fix memory leak on AIO objects
 deallocation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
 <20181206170535.GK19069@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9a917681-2c90-632a-471d-024e725860e0@linux.intel.com>
Date:   Thu, 6 Dec 2018 21:10:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206170535.GK19069@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.2018 20:05, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 05, 2018 at 08:19:41PM +0300, Alexey Budankov escreveu:
>>
>> Sending a part which was missed between v12 and v13 of the patch set
>> introducing AIO trace streaming for perf record mode. 
>>
>> The part is essential to avoid memory leakage during deallocation
>> of AIO related trace data buffers.
>>
>> It is applied on top of acme perf/core repo.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> tools/perf/util/mmap.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index ab30555d2afc..169d02973757 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -207,8 +207,18 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>>  
>>  static void perf_mmap__aio_munmap(struct perf_mmap *map)
>>  {
>> +	int i;
>> +
>> +	for (i = 0; i < map->aio.nr_cblocks; ++i) {
>> +		if (map->aio.data[i])
>> +			zfree(&map->aio.data[i]);
>> +	}
>>  	if (map->aio.data)
>>  		zfree(&map->aio.data);
>> +	if (map->aio.cblocks)
>> +		zfree(&map->aio.cblocks);
>> +	if (map->aio.aiocb)
>> +		zfree(&map->aio.aiocb);
> 
> There is no need to check for NULL before calling zfree(), as it is just
> a wrapper for free that sets that variable to NULL after calling it.
> 
> And free(NULL) is valid, just a noop to avoid having all those tests
> before each call to free(). I'm making those plain zfree() and later
> will do a sweep at removing other cases.

Thank you.
-Alexey

> 
>>  }
>>  
>>  int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
> 
