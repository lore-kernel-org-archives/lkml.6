Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F9C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74E2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF74E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeJKXns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:43:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:29477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:43:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="77286405"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2018 09:15:53 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 64EDE580496;
        Thu, 11 Oct 2018 09:15:51 -0700 (PDT)
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
 <20181011134544.GA29634@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9fc9227f-0853-8ed8-6f06-a9ecc9b2965d@linux.intel.com>
Date:   Thu, 11 Oct 2018 19:15:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011134544.GA29634@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 16:45, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -329,7 +469,7 @@ static int record__mmap_evlist(struct record *rec,
>>  
>>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>>  				 opts->auxtrace_mmap_pages,
>> -				 opts->auxtrace_snapshot_mode) < 0) {
>> +				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
>>  		if (errno == EPERM) {
>>  			pr_err("Permission error mapping pages.\n"
>>  			       "Consider increasing "
>> @@ -513,6 +653,29 @@ static struct perf_event_header finished_round_event = {
>>  	.type = PERF_RECORD_FINISHED_ROUND,
>>  };
>>  
>> +#ifdef HAVE_AIO_SUPPORT
>> +static void record__mmap_read_sync(struct record *rec)
>> +{
>> +	int i;
>> +	struct perf_evlist *evlist = rec->evlist;
>> +	struct perf_mmap *maps = evlist->mmap;
>> +
>> +	if (!rec->opts.nr_cblocks)
>> +		return;
>> +
>> +	for (i = 0; i < evlist->nr_mmaps; i++) {
>> +		struct perf_mmap *map = &maps[i];
>> +
>> +		if (map->base)
>> +			record__aio_sync(map);
>> +	}
>> +}
>> +#else
>> +static void record__mmap_read_sync(struct record *rec __maybe_unused)
>> +{
>> +}
>> +#endif
> 
> please move this up so we have just one  'ifdef HAVE_AIO_SUPPORT' block
> 
> and change the name to record__aio_mmap_read_sync, so it's obvious it's
> aio related, like the rest of the functions you added

Accepted.

> 
> thanks,
> jirka
> 
