Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2425C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560D2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7560D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeKPAe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:34:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:23848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732953AbeKPAez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:34:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 06:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,236,1539673200"; 
   d="scan'208";a="92293579"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2018 06:26:52 -0800
Received: from [10.251.29.1] (kliang2-mobl1.ccr.corp.intel.com [10.251.29.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8B8FD580475;
        Thu, 15 Nov 2018 06:26:51 -0800 (PST)
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115135347.GI9600@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
Date:   Thu, 15 Nov 2018 09:26:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115135347.GI9600@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2018 8:53 AM, Jiri Olsa wrote:
> On Wed, Nov 14, 2018 at 01:24:15PM -0800, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
>> index fb0d71afee8b..b428a4b00bf7 100644
>> --- a/tools/perf/arch/x86/util/header.c
>> +++ b/tools/perf/arch/x86/util/header.c
>> @@ -4,6 +4,7 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>> +#include <regex.h>
>>   
>>   #include "../../util/header.h"
>>   
>> @@ -70,9 +71,73 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>   {
>>   	char *buf = malloc(128);
>>   
>> -	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
>> +	if (buf && __get_cpuid(buf, 128, "%s-%u-%X-%X$") < 0) {
>>   		free(buf);
>>   		return NULL;
>>   	}
>>   	return buf;
>>   }
>> +
>> +/* Full CPUID format for x86 is vendor-family-model-stepping */
>> +static bool is_full_cpuid(const char *cpuid)
>> +{
>> +	const char *tmp = cpuid;
>> +	int count = 0;
>> +
>> +	while ((tmp = strchr(tmp, '-')) != NULL) {
>> +		count++;
>> +		tmp++;
>> +	}
>> +
>> +	if (count == 3)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
>> +{
>> +	regex_t re;
>> +	regmatch_t pmatch[1];
>> +	int match;
>> +	bool full_mapcpuid = is_full_cpuid(mapcpuid);
>> +	bool full_cpuid = is_full_cpuid(cpuid);
> 
> cpuid will be always full from now right? why do we need to check it?
>

User may set cpuid by environment string "PERF_CPUID", which may not be 
full format.

> also please move this to arch/x86/util/pmu.c
> so it matches the weak function object

Sure.

> 
>> +
>> +	/*
>> +	 * Full CPUID format is required to identify a platform.
>> +	 * Error out if the cpuid string is incomplete.
>> +	 */
>> +	if (full_mapcpuid && !full_cpuid) {
>> +		pr_info("Invalid CPUID %s. Full CPUID is required, "
>> +			"vendor-family-model-stepping\n", cpuid);
>> +		return 1;
>> +	}
>> +
>> +	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
>> +		/* Warn unable to generate match particular string. */
>> +		pr_info("Invalid regular expression %s\n", mapcpuid);
>> +		return 1;
>> +	}
>> +
>> +	match = !regexec(&re, cpuid, 1, pmatch, 0);
>> +	regfree(&re);
>> +	if (match) {
>> +		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
>> +		size_t cpuid_len;
>> +
>> +		/* If the full CPUID format isn't required,
>> +		 * ignoring the stepping.
>> +		 */
>> +		if (!full_mapcpuid && full_cpuid)
>> +			cpuid_len = strrchr(cpuid, '-') - cpuid;
>> +		else
>> +			cpuid_len = strlen(cpuid);
>> +
>> +
>> +		/* Verify the entire string matched. */
>> +		if (match_len == cpuid_len)
>> +			return 0;
> 
> why is this necessary?
> 

It's from previous common code. As my understanding, it just double 
check the matched strings. There is no harmful. So I keep it.

Thanks,
Kan
