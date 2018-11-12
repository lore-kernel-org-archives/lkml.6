Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA58C223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA58C223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeKMBkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:40:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:11372 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeKMBkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:40:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 07:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="99609350"
Received: from cyortiz-mobl.amr.corp.intel.com (HELO [10.251.15.119]) ([10.251.15.119])
  by orsmga003.jf.intel.com with ESMTP; 12 Nov 2018 07:46:25 -0800
From:   Dave Hansen <dave.hansen@intel.com>
Subject: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <c6b674a9-4995-f391-772a-b256516daeab@intel.com>
 <ef034248-156f-7a66-e4f1-a717ce8705ee@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <b11a5599-fda4-8747-8878-e743b8a501e0@intel.com>
Date:   Mon, 12 Nov 2018 07:46:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ef034248-156f-7a66-e4f1-a717ce8705ee@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 9:38 PM, Li, Aubrey wrote:
> If there is a valid state in the AVX registers, we can say the tasks contains
> AVX instructions, can't we?

XRSTOR, for instance, can take XSAVE state out of the init state, but it
is not necessarily an AVX instruction.  In fact, we had a kernel bug
along the way that was accidentally doing this on systems without AVX.

>>> +#define	AVX_STATE_DECAY_COUNT	3
>>
>> How was this number chosen?  What does this mean?
>>
>> It appears that this is saying that after 3 non-AVX-512-using context
>> switches, the task is not considered to be using AVX512 any more.  That
>> seems a bit goofy because the context switch rate is highly dependent on
>> HZ, and on how often the task yields.
>>
>> Do we want this, or do we want something more time-based?
>>
> This counter is introduced here to solve the race of context switch and
> VZEROUPPER. 3 context switches mean the same thread is on-off CPU 3 times.
> Due to scheduling latency, 3 jiffies could only happen AVX task on-off just
> 1 time. So IMHO the context switches number is better here.

Imagine we have a HZ=1000 system where AVX_STATE_DECAY_COUNT=3.  That
means that a task can be marked as a non-AVX-512-user after not using it
for ~3 ms.  But, with HZ=250, that's ~12ms.

Also, don't forget that we have context switches from the timer
interrupt, but also from normal old operations that sleep.

Let's say our AVX-512 app was doing:

	while (foo) {
		do_avx_512();
		read(pipe, buf, len);
		read(pipe, buf, len);
		read(pipe, buf, len);
	}

And all three pipe reads context-switched the task.  That loop could
finish in way under 3HZ, but still end up in do_avx_512() each time with
fpu...avx->state=0.

BTW, I don't have a great solution for this.  I was just pointing out
one of the pitfalls from using context switch counts so strictly.

>> I'd really like if this looked like this:
>>
>> 	if (!have_avx_state_detect()) {
>> 		avx->state = 0;
>> 		return;
>> 	}
>>
>> Then, in have_avx_state_detect(), explain what XGETBV1 does.  BTW, I
>> don't think we *totally* need to duplicate the SDM definitions in kernel
>> code for each instruction.  It's fine to just say that it set 1 for
>> features not in the init state.
>>
> 
> Thomas suggested open this inline since this is only usage of xgetbv1. So I'll
> use static_cpu_has() here directly. Does it sound good?

Yeah, that's OK.  But, I'd still limit the comments to what it is doing
instead of defining the instruction.

>>> +	/*
>>> +	 * XINUSE is dynamic to track component state because VZEROUPPER
>>> +	 * happens on every function end and reset the bitmap to the
>>> +	 * initial configuration.
>>
>> This is confusing to me because VZEROUPPER is not apparently involved
>> here.  What is this trying to say?
>>
> VZERROUPPER instruction in the task resets the bitmap.

I think this is too much detail for a kernel comment.  Let's just say
that the task itself can get back to the 'init state'.

>>> +	 * State decay is introduced to solve the race condition between
>>> +	 * context switch and a function end. State is aggressively set
>>> +	 * once it's detected but need to be cleared by decay 3 context
>>> +	 * switches
>>> +	 */
>>
>> I'd probably say:
>>
>> 	AVX512-using processes frequently set AVX512 back to the init 	
>> 	state themselves.  Thus, this detection mechanism can miss.
>> 	The decay ensures that false-negatives do not immediately make
>> 	a task be considered as not using AVX512.
> 
> Thanks, will refine it in the next version.
> And yes, AVX512-using processoes set AVX512 back to the init state themselves
> by VZEROUPPER instructions.

... or XRSTOR, or an in-kernel XRSTOR from a signal entry.

The point is, I'd probably not actually mention VZEROUPPER.  It's
certainly the common way to init the state, but let's not the *only* way
we have to be concerned with.

>>> +	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {
>>
>> This is *just* an AVX512 state, right?  That isn't reflected in any
>> comments or naming.  Also, why just this state, and not any of the other
>> AVX512-related states?
> 
> Only this state causes significant frequency drop, other states not.

OK.  This is an extremely crucial bit of information to capture,
including the background.

>>> +/*
>>>   * Highest level per task FPU state data structure that
>>>   * contains the FPU register state plus various FPU
>>>   * state fields:
>>> @@ -303,6 +312,14 @@ struct fpu {
>>>  	unsigned char			initialized;
>>>  
>>>  	/*
>>> +	 * @avx_state:
>>> +	 *
>>> +	 * This data structure indicates whether this context
>>> +	 * contains AVX states
>>> +	 */
>>
>> Yeah, that's precisely what fpu->state.xsave.xfeatures does. :)
>> I see, will refine in the next version

One other thought about the new 'avx_state':

fxregs_state (which is a part of the XSAVE state) has some padding and
'sw_reserved' areas.  You *might* be able to steal some space there.
Not that this is a huge space eater, but why waste the space if we don't
have to?


