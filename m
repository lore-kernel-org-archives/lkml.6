Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9465C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E2D208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E2D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeH1OTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:19:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:38927 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbeH1OTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:19:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 03:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="84014982"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2018 03:28:34 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 0BB595802AD;
        Tue, 28 Aug 2018 03:28:31 -0700 (PDT)
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
 <20180828085343.GF23727@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1c950a87-2224-080e-329e-cf9536ccef02@linux.intel.com>
Date:   Tue, 28 Aug 2018 13:28:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828085343.GF23727@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 11:53, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>>  
>> -	if (push(to, buf, size) < 0) {
>> -		rc = -1;
>> +	rc = push(to, md, size0 + size, *off) < 0 ? -1 : 1;
>> +	if (rc == -1)
>>  		goto out;
>> -	}
>> +
>> +	perf_mmap__get(md);
>> +	*off += size0 + size;
> 
> this get is for the perf_mmap pointer storage in the mmap_aio array right?

Right. perf_mmap__get() here guards whole perf_mmap object and memory 
referenced thru it from premature deallocation because mmap->base kernel 
buffer can be released earlier than aio requests started on mmap->data 
complete and the both buffers are referenced thru the same perf_mmap object.

> 
> I see it's released in record__mmap_read_sync, which might also return
> without releasing it.. this needs to be fixed and explained in here,
> why we take the reference in the first place

So we increment after successful push() from map->base to map->data 
with following aio_write() and decrement when aio_write() is fully 
complete, because it may require restart if the kernel didn't write 
whole chunk at once.

Probably we are still missing one more perf_mmap__put() after:
	pr_err("failed to write perf data, error: %m\n"); 
prior nullifying the appropriate cblock.

Updated [PATCH v4 2/2]:
- Written comment in perf_mmap__push() just before perf_mmap__get();
- Written comment in record__mmap_read_sync() on possible restarting 
  of aio_write() operation and releasing perf_mmap object after all;
- added perf_mmap__put() for the cases of failed aio_write();

Thanks!

> 
> thanks,
> jirka
> 
