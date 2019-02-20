Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B932075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBTOOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:14:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:41122 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:14:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="127905197"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2019 06:14:02 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id C760A58019B;
        Wed, 20 Feb 2019 06:14:00 -0800 (PST)
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
 <20190212130834.GE775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6671d202-0d47-0fdd-df69-1fa0b6e6e543@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:13:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130834.GE775@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.02.2019 16:08, Jiri Olsa wrote:
> On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  static void record__init_features(struct record *rec)
>> @@ -838,6 +881,9 @@ static void record__init_features(struct record *rec)
>>  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
>>  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
>>  
>> +	if (!record__comp_enabled(rec))
>> +		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
>> +
>>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>>  }
>>  
>> @@ -1147,6 +1193,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	fd = perf_data__fd(data);
>>  	rec->session = session;
>>  
>> +	rec->opts.comp_level = 0;
>> +	session->header.env.comp_level = rec->opts.comp_level;
>> +	session->header.env.comp_type = PERF_COMP_NONE;
> 
> hum I think both record and session are zerod from start,
> so this seems superfluous

Removed.

> 
> SNIP
> 
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index dec6d218c31c..5ad3a27a042f 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1463,6 +1463,21 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
>>  	return ret;
>>  }
>>  
>> +static int write_compressed(struct feat_fd *ff __maybe_unused,
>> +			    struct perf_evlist *evlist __maybe_unused)
>> +{
>> +	int ret;
>> +	u64 compression_info = ((u64)ff->ph->env.comp_type  << 32) | ff->ph->env.comp_level;
>> +
>> +	ret = do_write(ff, &compression_info, sizeof(compression_info));
>> +	if (ret)
>> +		return ret;
>> +
>> +	compression_info = ((u64)ff->ph->env.comp_ratio << 32) | ff->ph->env.comp_mmap_len;
> 
> let's not complicate this, if you have two u32 values
> to store, store two u32 values ;-)

Corrected.

> 
> also please add version in case we will add new fields in the future,
> so we can stay backward compatible

Implemented.

Thanks,
Alexey

> 
> jirka
> 
