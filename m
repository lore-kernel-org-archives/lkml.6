Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D7BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6162075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfBTOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:14:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:28163 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfBTOOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:14:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="119410561"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2019 06:14:43 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id B49C058028E;
        Wed, 20 Feb 2019 06:14:40 -0800 (PST)
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
 <20190212130946.GQ775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dcda8374-9bf4-8989-40b5-75b080b26a12@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:14:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130946.GQ775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:09, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> @@ -1147,6 +1193,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	fd = perf_data__fd(data);
>>  	rec->session = session;
>>  
>> +	rec->opts.comp_level = 0;
>> +	session->header.env.comp_level = rec->opts.comp_level;
>> +	session->header.env.comp_type = PERF_COMP_NONE;
>> +
>>  	record__init_features(rec);
>>  
>>  	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
>> @@ -1176,6 +1226,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  		err = -1;
>>  		goto out_child;
>>  	}
>> +	session->header.env.comp_mmap_len = session->evlist->mmap_len;
> 
> so the comp_mmap_len is the max length of the compressed packet?

comp_mmap_len is the size of buffer to encompass one compressed chunk 
of data after its decompression.

> 
> any idea if this value might have some impact on the processing speed?

It increases memory consumption at the loading and processing stages.

> 
> I see you mentioned the size reduction, could you also meassure
> the record overhead?

Let's get back to this after the code review.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
