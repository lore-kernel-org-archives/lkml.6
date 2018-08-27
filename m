Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F39C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77301204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77301204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeH0M6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:58:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:58054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeH0M6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:58:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 02:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="68389495"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2018 02:12:38 -0700
Received: from [10.125.252.155] (abudanko-mobl.ccr.corp.intel.com [10.125.252.155])
        by linux.intel.com (Postfix) with ESMTP id 7C0B95803DA;
        Mon, 27 Aug 2018 02:12:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
 <20180827083457.GE24695@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8afd6aaf-45ec-e477-78bd-83b6c99da713@linux.intel.com>
Date:   Mon, 27 Aug 2018 12:12:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827083457.GE24695@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27.08.2018 11:34, Jiri Olsa wrote:
> On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index e71d46cb01cc..c8b921c88a5d 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -292,11 +292,11 @@ int perf_mmap__read_init(struct perf_mmap *map)
>>  }
>>  
>>  int perf_mmap__push(struct perf_mmap *md, void *to,
>> -		    int push(void *to, void *buf, size_t size))
>> +		    int push(void *to, void *buf, size_t size, off_t), off_t *off)
>>  {
>>  	u64 head = perf_mmap__read_head(md);
>>  	unsigned char *data = md->base + page_size;
>> -	unsigned long size;
>> +	unsigned long size, size0 = 0;
>>  	void *buf;
>>  	int rc = 0;
>>  
>> @@ -308,23 +308,22 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>>  
>>  	if ((md->start & md->mask) + size != (md->end & md->mask)) {
>>  		buf = &data[md->start & md->mask];
>> -		size = md->mask + 1 - (md->start & md->mask);
>> -		md->start += size;
>> -
>> -		if (push(to, buf, size) < 0) {
>> -			rc = -1;
>> -			goto out;
>> -		}
>> +		size0 = md->mask + 1 - (md->start & md->mask);
>> +		md->start += size0;
>> +		memcpy(md->data, buf, size0);
>>  	}
>>  
>>  	buf = &data[md->start & md->mask];
>>  	size = md->end - md->start;
>>  	md->start += size;
>> +	memcpy(md->data + size0, buf, size);
> 
> this will need more comments.. and explanation why we copy the data
> over to another buffer.. it's interesting, it's still faster 

Sure. Comments will follow in v3. 
We copy data into a buffer to release space in the kernel buffer 
as fast as possible. That lets the kernel to store more data earlier 
than other per-cpu buffers are handled.

> 
> jirka
> 
