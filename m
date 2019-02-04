Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C721C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240822082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfBDQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:23:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:54736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfBDQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:23:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 08:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="123846213"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 08:23:15 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8547458044E;
        Mon,  4 Feb 2019 08:23:14 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204160454.GE29639@zn.tnic>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f67d228e-c65d-479c-30ec-ee532833d8f9@linux.intel.com>
Date:   Mon, 4 Feb 2019 11:23:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204160454.GE29639@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 11:04 AM, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 10:57:32AM -0500, Liang, Kan wrote:
>>
>>
>> On 2/4/2019 10:44 AM, Peter Zijlstra wrote:
>>> On Mon, Feb 04, 2019 at 04:38:27PM +0100, Peter Zijlstra wrote:
>>>> +static const struct x86_cpu_desc isolation_ucodes[] = {
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
>>>
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
>>>> +	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
>>>
>>> Do we want a special stepping (0 / -1) to be able to denote 'all' ?
>>>
>>
>> Something like as below?
>> #define X86_STEPPING_ANY	0xff
>>
>> As my understanding, the microcode version for each stepping is independent
>> and irrelevant.
> 
> Huh?
> 
> Why are we looking at the stepping then?
> 
> x86_match_cpu_with_stepping() <---
> 

I mean that the microcode version number is irrelevant between stepping.
Let's use SKL server as an example.
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),

We need the function to check the min microcode version number for each 
stepping.


Thanks,
Kan
