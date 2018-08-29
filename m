Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeH2Sbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:31:39 -0400
Received: from foss.arm.com ([217.140.101.70]:55828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeH2Sbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:31:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6732180D;
        Wed, 29 Aug 2018 07:34:25 -0700 (PDT)
Received: from [10.33.0.154] (e111474-lin.blackburn.arm.com [10.33.0.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 691243F557;
        Wed, 29 Aug 2018 07:34:23 -0700 (PDT)
Subject: Re: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
 <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
From:   Robert Walker <robert.walker@arm.com>
Message-ID: <8ff74d1f-e211-7423-2ad4-35369444488e@arm.com>
Date:   Wed, 29 Aug 2018 15:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,


On 29/08/18 14:49, Kim Phillips wrote:
> On Wed, 29 Aug 2018 10:44:23 +0100
> Robert Walker <robert.walker@arm.com> wrote:
>
>> This patch adds support for generating instruction samples from trace of
>> AArch32 programs using the A32 and T32 instruction sets.
>>
>> T32 has variable 2 or 4 byte instruction size, so the conversion between
>> addresses and instruction counts requires extra information from the trace
>> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
>> member has been added to the feature check for OpenCSD.
>>
>> Signed-off-by: Robert Walker <robert.walker@arm.com>
>> ---
> ...
>> +++ b/tools/build/feature/test-libopencsd.c
>> @@ -3,6 +3,13 @@
>>   
>>   int main(void)
>>   {
>> +	/*
>> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
>> +	 * OpenCSD 0.9
> 0.9 != 0.9.1 in the above commit text: which is it?
I'll change it to 0.9.1 if there's another version of the patch (it was 
introduced in 0.9, but 0.9.1 has a necessary bug fix)
>> +	 */
>> +	ocsd_generic_trace_elem elem;
>> +	(void)elem.num_instr_range;
>> +
> This breaks building against older versions of OpenCSD, right?
>
>>   	(void)ocsd_get_version();
> Why don't we maintain building against older versions of the library,
> and use the version information to make the decision on whether to use
> the new feature being introduced in this patch?
The intention is to fail the feature detection check if the older 
version is installed - perf will still compile, but without the 
CoreSight trace support.

OpenCSD is still in development, so new features like this are being 
added and it would add a lot of #ifdef mess to the perf code to continue 
to support any machines with the old library version installed - there 
will only be a handful of machines affected and it's trivial to upgrade 
them (the new Debian packages are available).  How long would we 
continue to support such an older version?  I also don't see any 
precedent for supporting multiple dependent library versions in perf.
>
> Thanks,
>
> Kim
Regards

Rob
