Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CF9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03372075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03372075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIFQfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:35:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:62673 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:35:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="68004365"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2018 04:59:35 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id D7D2F5801E6;
        Thu,  6 Sep 2018 04:59:33 -0700 (PDT)
Subject: Re: [PATCH v7 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <dc18a621-4464-e5a5-ce10-5f7b2f6a9176@linux.intel.com>
 <20180906110418.GG8248@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e1824f4f-62e4-189d-83fd-526463d66b76@linux.intel.com>
Date:   Thu, 6 Sep 2018 14:59:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906110418.GG8248@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2018 14:04, Jiri Olsa wrote:
> On Wed, Sep 05, 2018 at 10:39:25AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 384d17cd1379..1d57d8387caf 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -332,12 +332,12 @@ int perf_mmap__read_init(struct perf_mmap *map)
>>  	return __perf_mmap__read_init(map);
>>  }
>>  
>> -int perf_mmap__push(struct perf_mmap *md, void *to,
>> -		    int push(void *to, void *buf, size_t size))
>> +int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
>> +		    int push(void *to, struct aiocb *cblock, void *data, size_t size))
>>  {
>>  	u64 head = perf_mmap__read_head(md);
>>  	unsigned char *data = md->base + page_size;
>> -	unsigned long size;
>> +	unsigned long size, size0 = 0;
>>  	void *buf;
>>  	int rc = 0;
>>  
>> @@ -345,31 +345,58 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>  	if (rc < 0)
>>  		return (rc == -EAGAIN) ? 0 : -1;
>>  
>> +	/* md->base data is copied into md->data[idx] buffer to
>> +	 * release space in the kernel buffer as fast as possible,
> 
> please start the comment with the extra '/*', like:
> 
> 	/*
> 	 * md->base data is copied into md->data[idx] buffer to
> 	 * release space in the kernel buffer as fast as possible,
> 	...

Accepted!

> 
> jirka
> 
