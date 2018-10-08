Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606612145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606612145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIB0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:26:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:50504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJIB0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:26:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 11:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="95696130"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2018 11:13:17 -0700
Received: from [10.252.30.144] (abudanko-mobl.ccr.corp.intel.com [10.252.30.144])
        by linux.intel.com (Postfix) with ESMTP id D03B7580487;
        Mon,  8 Oct 2018 11:13:14 -0700 (PDT)
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
 <20181008174212.GR3541@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <18fab818-b0c9-8284-10ce-670eaf32a209@linux.intel.com>
Date:   Mon, 8 Oct 2018 21:13:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008174212.GR3541@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 08.10.2018 20:42, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov escreveu:
>>
>> Store -k clockid frequency into Perf trace to enable timestamps 
>> derived metrics conversion into wall clock time on reporting stage.
> 
> <SNIP>
> 
>> +++ b/tools/perf/util/env.h
>> @@ -63,6 +63,7 @@ struct perf_env {
>>  	struct numa_node	*numa_nodes;
>>  	struct memory_node	*memory_nodes;
>>  	unsigned long long	 memory_bsize;
>> +	size_t                   clockid_res_ns;
>>  };
>>  
>>  extern struct perf_env perf_env;
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 1ec1d9bc2d63..4ce5339158f7 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1034,6 +1034,13 @@ static int write_auxtrace(struct feat_fd *ff,
>>  	return err;
>>  }
>>  
>> +static int write_clockid(struct feat_fd *ff,
>> +			 struct perf_evlist *evlist __maybe_unused)
>> +{
>> +	return do_write(ff, &ff->ph->env.clockid_res_ns,
>> +			sizeof(ff->ph->env.clockid_res_ns));
>> +}
>> +
> 
> Is sizeof(size_t) the same everywhere? I think you should encode this
> always as a u64, read it, assign it to a temp u64 var, write the u64 to
> the perf.data header, read it using do_read_u64, that will take care of
> endianness, then set it to the size_t in the ff->ph->env.clockid_res_ns,
> right?

Right. Let me take care of all that.

Thanks!
Alexey

> 
> I'm removing the patch till this gets sorted out,
> 
> Thanks,
> 
> - Arnaldo
> 
