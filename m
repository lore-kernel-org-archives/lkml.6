Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1102086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1102086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeKPCCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:02:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:30306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbeKPCCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:02:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 07:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,236,1539673200"; 
   d="scan'208";a="274265971"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2018 07:53:45 -0800
Received: from [10.251.29.1] (kliang2-mobl1.ccr.corp.intel.com [10.251.29.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 54664580495;
        Thu, 15 Nov 2018 07:53:44 -0800 (PST)
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115135347.GI9600@krava>
 <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
 <20181115152534.GL9600@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <13ef65c9-1622-2bb7-3d61-65f469fe1a10@linux.intel.com>
Date:   Thu, 15 Nov 2018 10:53:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115152534.GL9600@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	/*
>>>> +	 * Full CPUID format is required to identify a platform.
>>>> +	 * Error out if the cpuid string is incomplete.
>>>> +	 */
>>>> +	if (full_mapcpuid && !full_cpuid) {
>>>> +		pr_info("Invalid CPUID %s. Full CPUID is required, "
>>>> +			"vendor-family-model-stepping\n", cpuid);
>>>> +		return 1;
>>>> +	}
>>>> +
>>>> +	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
>>>> +		/* Warn unable to generate match particular string. */
>>>> +		pr_info("Invalid regular expression %s\n", mapcpuid);
>>>> +		return 1;
>>>> +	}
>>>> +
>>>> +	match = !regexec(&re, cpuid, 1, pmatch, 0);
>>>> +	regfree(&re);
>>>> +	if (match) {
>>>> +		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
>>>> +		size_t cpuid_len;
>>>> +
>>>> +		/* If the full CPUID format isn't required,
>>>> +		 * ignoring the stepping.
>>>> +		 */
>>>> +		if (!full_mapcpuid && full_cpuid)
>>>> +			cpuid_len = strrchr(cpuid, '-') - cpuid;
>>>> +		else
>>>> +			cpuid_len = strlen(cpuid);
>>>> +
>>>> +
>>>> +		/* Verify the entire string matched. */
>>>> +		if (match_len == cpuid_len)
>>>> +			return 0;
>>>
>>> why is this necessary?
>>>
>>
>> It's from previous common code. As my understanding, it just double check
>> the matched strings. There is no harmful. So I keep it.
> 
> right.. did you consider using the wildcard in the map file
> so it'd cover the stepping, having entries like:
> 
>    GenuineIntel-6-1F-*,v2,nehalemep,core
> 
> I haven't thought this one through, but seems we could bypass
> those '-stepping' checks.. but probably other changes would be
> necessary for the wildcard
> 

If using wildcard, the full cpuid format is required for all platforms.
The script which using environment string "PERF_CPUID" will definitely 
be broken on all platforms.
This patch (non-wildcard) only breaks the script on Skylake server and 
Cascadelake server.

I think that's the only drawback of using wildcard.

Thanks,
Kan

