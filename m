Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B4DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE562146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBTOxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:53:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:17189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfBTOxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:53:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="148391110"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2019 06:53:21 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id BBFB258019B;
        Wed, 20 Feb 2019 06:53:18 -0800 (PST)
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
 <20190212130856.GH775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c3993c13-3a8d-c56d-5c5a-3a537747d079@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:53:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130856.GH775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -774,6 +775,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	struct perf_mmap *maps;
>>  	int trace_fd = rec->data.file.fd;
>>  	off_t off;
>> +	struct perf_session *session = rec->session;
>> +	perf_mmap__compress_fn_t compress_fn;
>>  
>>  	if (!evlist)
>>  		return 0;
>> @@ -785,6 +788,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>>  		return 0;
>>  
>> +	compress_fn = (record__comp_enabled(rec) ?
>> +		perf_session__zstd_compress : perf_session__zstd_copy);
>> +
> 
> I don't follow what's the perf_session__zstd_copy function for..?

It bridges AIO without compression case.

Thanks,
Alexey

> 
> for !record__comp_enabled case we seem not to use it
> and calling the current perf_mmap__push interface
> 
> however I dont see point to have this function at all
> 
> jirka
> 
> 
>>  	if (record__aio_enabled(rec))
>>  		off = record__aio_get_pos(trace_fd);
>>  
>> @@ -799,11 +805,21 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  				map->flush = MMAP_FLUSH_DEFAULT;
>>  			}
>>  			if (!record__aio_enabled(rec)) {
>> -				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> -					if (sync)
>> -						map->flush = flush;
>> -					rc = -1;
>> -					goto out;
>> +				if (!record__comp_enabled(rec)) {
>> +					if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>> +						if (sync)
>> +							map->flush = flush;
>> +						rc = -1;
>> +						goto out;
>> +					}
>> +				} else {
>> +					if (perf_mmap__pack(map, rec, record__pushfn,
>> +							compress_fn, session) != 0) {
>> +						if (sync)
>> +							map->flush = flush;
>> +						rc = -1;
>> +						goto out;
>> +					}
> 
> SNIP
> 
