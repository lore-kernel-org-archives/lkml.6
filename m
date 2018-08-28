Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B30C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F52089B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0F52089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeH1PWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:22:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:28576 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH1PWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:22:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 04:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="84026695"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2018 04:31:07 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 105625802AD;
        Tue, 28 Aug 2018 04:31:04 -0700 (PDT)
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
 <20180828085703.GG23727@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <38f9158b-dca5-2b09-99cb-f12bb62ad5dc@linux.intel.com>
Date:   Tue, 28 Aug 2018 14:31:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828085703.GG23727@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 11:57, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +	int trace_fd = rec->session->data->file.fd;
>> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
>> +	int mmap_aio_size = 0;
>> +	off_t off;
>>  
>>  	if (!evlist)
>>  		return 0;
>> @@ -528,14 +632,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>>  		return 0;
>>  
>> +	off = lseek(trace_fd, 0, SEEK_CUR);
>> +
>>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>>  		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
>>  
>>  		if (maps[i].base) {
>> -			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
>> -				rc = -1;
>> +			rc = perf_mmap__push(&maps[i], rec, record__pushfn, &off);
>> +			if (rc < 0)
>>  				goto out;
>> -			}
>> +			else if (rc > 0)
>> +				mmap_aio[mmap_aio_size++] = &maps[i].cblock;
> 
> I understand the purpose of mmap_aio array, but I don't see a reason
> to fill it in every time we call record__mmap_read_evlist

The cycle trips the same number of iterations over kernel buffers 
for every call of record__mmap_read_evlist(). Called perf_mmap__push() 
checks if there is data ready for spill in the corresponding buffer 
and if there is no such data returns 0. So every time we execute 
the cycle we get different set of buffers to spill and in this 
circumstances dynamic filling of mmap_aio looks preferable.
Lifetime management of perf_mmap object and referenced memory 
is not related another thing.

> 
> the way I see it, when 'pushing the data' it's either all or nothing,
> 
> if there's an error in pushing one map, we bail out completely..
> so the mmap_aio array could be preallocated (it is now) and
> pre-filled with cblock pointers
> 
> that would probably ease up the reference counting I mentioned
> in the previous email
> 
> thanks,
> jirka
> 
