Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D37C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C5920870
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C5920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIFQaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:30:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:14321 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:30:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 04:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="88154922"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2018 04:54:48 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id AD9BC5803D7;
        Thu,  6 Sep 2018 04:54:46 -0700 (PDT)
Subject: Re: [PATCH v7 1/2]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
 <20180906110441.GI8248@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <668c4974-27be-2546-0284-5b72c2a9a0e1@linux.intel.com>
Date:   Thu, 6 Sep 2018 14:54:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906110441.GI8248@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2018 14:04, Jiri Olsa wrote:
> On Wed, Sep 05, 2018 at 10:19:56AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -166,6 +174,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
>>  
>>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>>  {
>> +	int i;
>>  	/*
>>  	 * The last one will be done at perf_mmap__consume(), so that we
>>  	 * make sure we don't prevent tools from consuming every last event in
>> @@ -190,6 +199,50 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>>  		map->base = NULL;
>>  		return -1;
>>  	}
>> +	map->nr_cblocks = mp->nr_cblocks;
>> +	map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb*));
>> +	if (!map->cblocks) {
>> +		pr_debug2("failed to allocate perf event data buffers, error %d\n",
>> +				errno);
>> +		return -1;
>> +	}
>> +	map->data = calloc(map->nr_cblocks, sizeof(void*));
>> +	if (map->data) {
>> +		int delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>> +		for (i = 0; i < map->nr_cblocks; ++i) {
>> +			map->data[i] = malloc(perf_mmap__mmap_len(map));
>> +			if (map->data[i]) {
>> +				int prio;
>> +				unsigned char *data = map->data[i];
>> +				map->cblocks[i] = (struct aiocb *)&data[map->mask + 1];
> 
> the 'struct aiocb' is allocated at the last page of the buffer?
> is that enough space? could we please make this more transparent
> and allocate that space separately?

Would the array of pointers followed by the array of referenced objects fit?

> 
> thanks,
> jirka
> 
