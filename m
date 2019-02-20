Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B5520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBTOZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:25:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:59407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfBTOZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:25:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:25:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="127907242"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2019 06:25:56 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 7965158028E;
        Wed, 20 Feb 2019 06:25:55 -0800 (PST)
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
 <20190212130941.GP775@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <590f43ab-4d38-4902-1628-7afd6d83678f@linux.intel.com>
Date:   Wed, 20 Feb 2019 17:25:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212130941.GP775@krava>
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
>> +static int process_compressed(struct feat_fd *ff,
>> +			      void *data __maybe_unused)
>> +{
>> +	u64 compression_info;
>> +
>> +	if (do_read_u64(ff, &compression_info))
>> +		return -1;
>> +
>> +	ff->ph->env.comp_type  = (compression_info >> 32) & 0xffffffffULL;
>> +	ff->ph->env.comp_level = compression_info & 0xffffffffULL;
>> +
>> +	if (do_read_u64(ff, &compression_info))
>> +		return -1;
>> +
>> +	ff->ph->env.comp_ratio = (compression_info >> 32) & 0xffffffffULL;
>> +	ff->ph->env.comp_mmap_len = compression_info & 0xffffffffULL;
>> +
>> +	return 0;
>> +}
>> +
>>  struct feature_ops {
>>  	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
>>  	void (*print)(struct feat_fd *ff, FILE *fp);
>> @@ -2651,7 +2693,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>>  	FEAT_OPN(CACHE,		cache,		true),
>>  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>>  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
>> -	FEAT_OPR(CLOCKID,       clockid,        false)
>> +	FEAT_OPR(CLOCKID,       clockid,        false),
>> +	FEAT_OPR(COMPRESSED,	compressed,	false)
> 
> please separate the COMPRESSED feature ddition into single patch

Moved to a separate patch.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
