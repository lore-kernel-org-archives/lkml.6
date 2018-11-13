Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F02CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9C4223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9C4223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbeKMQjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:39:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:35422 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKMQjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:39:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 22:42:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="107786729"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2018 22:42:39 -0800
Subject: Re: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <c6b674a9-4995-f391-772a-b256516daeab@intel.com>
 <ef034248-156f-7a66-e4f1-a717ce8705ee@linux.intel.com>
 <b11a5599-fda4-8747-8878-e743b8a501e0@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <9bcd88eb-9433-debf-b831-29e064e87522@linux.intel.com>
Date:   Tue, 13 Nov 2018 14:42:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <b11a5599-fda4-8747-8878-e743b8a501e0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/12 23:46, Dave Hansen wrote:
> On 11/11/18 9:38 PM, Li, Aubrey wrote:
>
>>> Do we want this, or do we want something more time-based?
>>>
>> This counter is introduced here to solve the race of context switch and
>> VZEROUPPER. 3 context switches mean the same thread is on-off CPU 3 times.
>> Due to scheduling latency, 3 jiffies could only happen AVX task on-off just
>> 1 time. So IMHO the context switches number is better here.
> 
> Imagine we have a HZ=1000 system where AVX_STATE_DECAY_COUNT=3.  That
> means that a task can be marked as a non-AVX-512-user after not using it
> for ~3 ms.  But, with HZ=250, that's ~12ms.

From the other side, if we set a 4ms decay, when HZ=1000, context switch count
is 4, that means, we have 4 times of chance to maintain the AVX state, that is,
we are able to filter 4 times init state reset out. But if HZ = 250, the context
switch is 1, we only have 1 time of chance to filter init state reset out.
> 
> Also, don't forget that we have context switches from the timer
> interrupt, but also from normal old operations that sleep.
> 
> Let's say our AVX-512 app was doing:
> 
> 	while (foo) {
> 		do_avx_512();
> 		read(pipe, buf, len);
> 		read(pipe, buf, len);
> 		read(pipe, buf, len);
> 	}
> 
> And all three pipe reads context-switched the task.  That loop could
> finish in way under 3HZ, but still end up in do_avx_512() each time with
> fpu...avx->state=0.

Yeah, we are trying to address a prediction according to the historical pattern,
so you always can make a pattern to beat the prediction pattern. But in practice,
I measured tensorflow with AVX512 enabled, linpack with AVX512, and a micro 
benchmark, the current 3 context switches decay works well enough.

> 
> BTW, I don't have a great solution for this.  I was just pointing out
> one of the pitfalls from using context switch counts so strictly.

I really don't think time-based is better than the count in this case. 

>>>> +/*
>>>>   * Highest level per task FPU state data structure that
>>>>   * contains the FPU register state plus various FPU
>>>>   * state fields:
>>>> @@ -303,6 +312,14 @@ struct fpu {
>>>>  	unsigned char			initialized;
>>>>  
>>>>  	/*
>>>> +	 * @avx_state:
>>>> +	 *
>>>> +	 * This data structure indicates whether this context
>>>> +	 * contains AVX states
>>>> +	 */
>>>
>>> Yeah, that's precisely what fpu->state.xsave.xfeatures does. :)
>>> I see, will refine in the next version
> 
> One other thought about the new 'avx_state':
> 
> fxregs_state (which is a part of the XSAVE state) has some padding and
> 'sw_reserved' areas.  You *might* be able to steal some space there.
> Not that this is a huge space eater, but why waste the space if we don't
> have to?
> 

IMHO, I prefer not adding any extra thing into a data structure associated
with a hardware table. Let me try to work out a new version to see if it can
satisfy you.

Thanks,
-Aubrey

