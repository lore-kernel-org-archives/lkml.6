Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB50FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8019F20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8019F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLGJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:23:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:53646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeLGJX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:23:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 01:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="108050889"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2018 01:23:21 -0800
Subject: Re: [PATCH] perf script: Fix LBR skid dump problems in brstackinsn
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, Andi Kleen <ak@linux.intel.com>
References: <20181120050617.4119-1-andi@firstfloor.org>
 <20181206170140.GJ19069@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <02342e01-2364-b1b4-6fd7-2fd85141967d@intel.com>
Date:   Fri, 7 Dec 2018 11:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181206170140.GJ19069@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/18 7:01 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 19, 2018 at 09:06:17PM -0800, Andi Kleen escreveu:
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> This is a fix for another instance of the skid problem Milian
>> recently found [1]
> 
> Milian, have you tested this?
> 
> Adrian, can I have your Reviewed-by or Acked-by?

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks,
> 
> - Arnaldo
>  
>> The LBRs don't freeze at the exact same time as the PMI is triggered.
>> The perf script brstackinsn code that dumps LBR assembler
>> assumes that the last branch in the LBR leads to the sample point.
>> But with skid it's possible that the CPU executes one or more branches
>> before the sample, but which do not appear in the LBR.
>>
>> What happens then is either that the sample point is before
>> the last LBR branch. In this case the dumper sees a negative
>> length and ignores it. Or it the sample point is long after
>> the last branch. Then the dumper sees a very long block and dumps
>> it upto its block limit (16k bytes), which is noise in the output.
>>
>> On typical sample session this can happen regularly.
>>
>> This patch tries to detect and handle the situation. On the last
>> block that is dumped by the LBR dumper we always stop on the first
>> branch. If the block length is negative just scan forward to the
>> first branch. Otherwise scan until a branch is found.
>>
>> The PT decoder already has a function that uses the instruction
>> decoder to detect branches, so we can just reuse it here.
>>
>> Then when a terminating branch is found print an indication
>> and stop dumping. This might miss a few instructions, but at least
>> shows no runaway blocks.
>>
>> Cc: milian.wolff@kdab.com
>> Cc: adrian.hunter@intel.com
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>  tools/perf/builtin-script.c                    | 18 +++++++++++++++++-
>>  tools/perf/util/dump-insn.c                    |  8 ++++++++
>>  tools/perf/util/dump-insn.h                    |  2 ++
>>  .../intel-pt-decoder/intel-pt-insn-decoder.c   |  8 ++++++++
>>  4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 4da5e32b9e03..11868bf39e66 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -1049,9 +1049,18 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>  
>>  	/*
>>  	 * Print final block upto sample
>> +	 *
>> +	 * Due to pipeline delays the LBRs might be missing a branch
>> +	 * or two, which can result in very large or negative blocks
>> +	 * between final branch and sample. When this happens just
>> +	 * continue walking after the last TO until we hit a branch.
>>  	 */
>>  	start = br->entries[0].to;
>>  	end = sample->ip;
>> +	if (end < start) {
>> +		/* Missing jump. Scan 128 bytes for the next branch */
>> +		end = start + 128;
>> +	}
>>  	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
>>  	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
>>  	if (len <= 0) {
>> @@ -1060,7 +1069,6 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>  			      machine, thread, &x.is64bit, &x.cpumode, false);
>>  		if (len <= 0)
>>  			goto out;
>> -
>>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
>>  			dump_insn(&x, sample->ip, buffer, len, NULL));
>>  		goto out;
>> @@ -1070,6 +1078,14 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>>  				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
>>  		if (ilen == 0)
>>  			break;
>> +		if (arch_is_branch(buffer + off, len - off, x.is64bit) &&
>> +			start + off != sample->ip) {
>> +			/*
>> +			 * Hit a missing branch. Just stop.
>> +			 */
>> +			printed += fprintf(fp, "\t... not reaching sample ...\n");
>> +			break;
>> +		}
>>  	}
>>  out:
>>  	return printed;
>> diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
>> index 10988d3de7ce..2bd8585db93c 100644
>> --- a/tools/perf/util/dump-insn.c
>> +++ b/tools/perf/util/dump-insn.c
>> @@ -13,3 +13,11 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
>>  		*lenp = 0;
>>  	return "?";
>>  }
>> +
>> +__weak
>> +int arch_is_branch(const unsigned char *buf __maybe_unused,
>> +		   size_t len __maybe_unused,
>> +		   int x86_64 __maybe_unused)
>> +{
>> +	return 0;
>> +}
>> diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
>> index 0e06280a8860..650125061530 100644
>> --- a/tools/perf/util/dump-insn.h
>> +++ b/tools/perf/util/dump-insn.h
>> @@ -20,4 +20,6 @@ struct perf_insn {
>>  
>>  const char *dump_insn(struct perf_insn *x, u64 ip,
>>  		      u8 *inbuf, int inlen, int *lenp);
>> +int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
>> +
>>  #endif
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> index 54818828023b..1c0e289f01e6 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> @@ -180,6 +180,14 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
>>  	return 0;
>>  }
>>  
>> +int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
>> +{
>> +	struct intel_pt_insn in;
>> +	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
>> +		return -1;
>> +	return in.branch != INTEL_PT_BR_NO_BRANCH;
>> +}
>> +
>>  const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
>>  		      u8 *inbuf, int inlen, int *lenp)
>>  {
>> -- 
>> 2.17.2
> 

