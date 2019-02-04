Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67772C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285720815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfBDQzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:55:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:1254 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfBDQzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:55:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 08:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="316220799"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2019 08:55:29 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AEAD85800E0;
        Mon,  4 Feb 2019 08:55:28 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
Date:   Mon, 4 Feb 2019 11:55:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 11:23 AM, Peter Zijlstra wrote:
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
>> and irrelevant. The 0x0000004e should be just coincidence.
>> If so, I don't think X86_STEPPING_ANY is very useful.
> 
> Sure; but since we have this happy accident, we can still use it for a
> notational convenience, right?

We cannot apply X86_STEPPING_ANY to ignore the stepping. There will be 
problems for 0-8 stepping for KABYLAKE_MOBILE.
I think what we need is x86_match_cpu_with_stepping_range().
But I don't think it is worth enabling it just for this rare case.

Thanks,
Kan
