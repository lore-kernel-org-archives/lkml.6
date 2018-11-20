Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1FAC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3852A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3852A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeKUAYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:24:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:41181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKUAYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:24:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 05:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="251195584"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 05:55:13 -0800
Received: from [10.254.81.131] (kliang2-mobl1.ccr.corp.intel.com [10.254.81.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0A9F1580432;
        Tue, 20 Nov 2018 05:55:12 -0800 (PST)
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115204411.GO9600@krava>
 <cc982c1b-0774-6f3e-a24a-3c3fba5c900b@linux.intel.com>
 <20181116021418.GB18319@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8db70e31-30d7-c937-f35b-bd6e7bd12ae4@linux.intel.com>
Date:   Tue, 20 Nov 2018 08:55:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116021418.GB18319@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2018 9:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 15, 2018 at 04:01:46PM -0500, Liang, Kan escreveu:
>>
>>
>> On 11/15/2018 3:44 PM, Jiri Olsa wrote:
>>> On Wed, Nov 14, 2018 at 01:24:15PM -0800, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Perf tools cannot find the proper event list for Cascadelake server.
>>>> Because Cascadelake server and Skylake server have the same CPU model
>>>> number, which are used by perf tools to find the event list.
>>>>
>>>> The stepping for Skylake server is up to 4.
>>>> The stepping for Cascadelake server starts from 5.
>>>> The stepping can be used to distinguish between them.
>>>>
>>>> The stepping is added in get_cpuid_str().
>>>> The stepping information for Skylake server is updated in mapfile.csv.
>>>> A x86 specific strcmp_cpuid_cmp() function is added to handle two CPUID
>>>> formats in mapfile.csv, "vendor-family-model-stepping" and
>>>> "vendor-family-model".
>>>> - If a cpuid-regular-expression from the mapfile.csv using the new
>>>>     stepping format, a cpuid-string generated on the machine must include
>>>>     stepping. Otherwise, it is a mismatch.
>>>> - If the cpuid-regular-expression using the old non-stepping format,
>>>>     the stepping in the cpuid-string will be ignored.
>>>>
>>>> The script, which using environment string "PERF_CPUID" without stepping
>>>> on Skylake server, will be broken. If so, users must fix their scripts.
>>>>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>
>> Thanks Jirka,
>>
>> Hi Arnaldo,
>>
>> Are you OK with the patch?
>> If yes, I will go ahead to cleanup the *_cpuid_str() by moving them to
>> header.c as promised. https://lkml.org/lkml/2018/11/15/929
>> The new patch will be on top of this patch.
> 
> I'm travelling, will look at it soon, can't now, battery almost deead
> :-\

Hi Arnaldo,

Have you got a chance to look at the code?

Thanks,
Kan



