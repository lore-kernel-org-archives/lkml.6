Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA35C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04172084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04172084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJHT32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:29:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:57622 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHT32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:29:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 05:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="269439524"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Oct 2018 05:18:00 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id CAA795801E6;
        Mon,  8 Oct 2018 05:17:58 -0700 (PDT)
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
 <20181008105033.GB17270@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f598a308-464a-635a-9310-d9aaead88a14@linux.intel.com>
Date:   Mon, 8 Oct 2018 15:17:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008105033.GB17270@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 13:50, Jiri Olsa wrote:
> On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -
>> +#ifdef HAVE_AIO_SUPPORT
>> +	lseek(trace_fd, off, SEEK_SET);
>> +#endif
>>  	/*
>>  	 * Mark the round finished in case we wrote
>>  	 * at least one event.
>> @@ -650,6 +799,9 @@ record__switch_output(struct record *rec, bool at_exit)
>>  	/* Same Size:      "2015122520103046"*/
>>  	char timestamp[] = "InvalidTimestamp";
>>  
>> +#ifdef HAVE_AIO_SUPPORT
>> +	record__mmap_read_sync(rec);
>> +#endif
> 
> same, please define the record__mmap_read_sync dummy
> so we can skip that #ifdef #endif

Accepted.

> 
>>  	record__synthesize(rec, true);
>>  	if (target__none(&rec->opts.target))
>>  		record__synthesize_workload(rec, true);
>> @@ -1157,6 +1309,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  		record__synthesize_workload(rec, true);
>>  
>>  out_child:
>> +
>> +#ifdef HAVE_AIO_SUPPORT
>> +	record__mmap_read_sync(rec);
>> +#endif
> 
> ditto

Accepted.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
> SNIP
> 
