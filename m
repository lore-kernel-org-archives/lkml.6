Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D7C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934C3214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934C3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeKLPaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:30:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:6218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbeKLPaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:30:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 21:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="107456850"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2018 21:38:40 -0800
Subject: Re: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
 <c6b674a9-4995-f391-772a-b256516daeab@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ef034248-156f-7a66-e4f1-a717ce8705ee@linux.intel.com>
Date:   Mon, 12 Nov 2018 13:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <c6b674a9-4995-f391-772a-b256516daeab@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for your comments!

On 2018/11/12 10:32, Dave Hansen wrote:
> On 11/7/18 9:16 AM, Aubrey Li wrote:
>> XSAVES and its variants use init optimization to reduce the amount of
>> data that they save to memory during context switch. Init optimization
>> uses the state component bitmap to denote if a component is in its init
>> configuration. We use this information to detect if a task contains AVX
>> instructions.
> 
> I'm a little uncomfortable with changelogs like this.  Someone might
> read this and think that this patch precisely detects AVX instructions.
>  It would be great is we could make this more precise to say that this
> patch detects if there is valid state in the AVX registers, *not* if the
> task contains or uses AVX instructions.

Our intention is to figure out if the task contains AVX instructions, this
kind of task causes frequency drop and need attention when dispatched.

If there is a valid state in the AVX registers, we can say the tasks contains
AVX instructions, can't we?

>>  
>> +#define	AVX_STATE_DECAY_COUNT	3
> 
> How was this number chosen?  What does this mean?
> 
> It appears that this is saying that after 3 non-AVX-512-using context
> switches, the task is not considered to be using AVX512 any more.  That
> seems a bit goofy because the context switch rate is highly dependent on
> HZ, and on how often the task yields.
> 
> Do we want this, or do we want something more time-based?
>
This counter is introduced here to solve the race of context switch and
VZEROUPPER. 3 context switches mean the same thread is on-off CPU 3 times.
Due to scheduling latency, 3 jiffies could only happen AVX task on-off just
1 time. So IMHO the context switches number is better here.

> 
>> +/*
>> + * This function is called during context switch to update AVX component state
>> + */
>> +static inline void update_avx_state(struct avx_state *avx)
>> +{
>> +	/*
>> +	 * Check if XGETBV with ECX = 1 supported. XGETBV with ECX = 1
>> +	 * returns the logical-AND of XCR0 and XINUSE. XINUSE is a bitmap
>> +	 * by which the processor tracks the status of various components.
>> +	 */
>> +	if (!use_xgetbv1()) {
>> +		avx->state = 0;
>> +		return;
>> +	}
> 
> This is a place where we have conflated the implementation in the CPU
> and the logical operation that we are performing.
> 
> In this case, it appears that we want to know whether AVX state
> detection is available, but we're doing that with a function that's
> apparently asking if the kernel is using XGETBV1.
> 
> I'd really like if this looked like this:
> 
> 	if (!have_avx_state_detect()) {
> 		avx->state = 0;
> 		return;
> 	}
> 
> Then, in have_avx_state_detect(), explain what XGETBV1 does.  BTW, I
> don't think we *totally* need to duplicate the SDM definitions in kernel
> code for each instruction.  It's fine to just say that it set 1 for
> features not in the init state.
> 

Thomas suggested open this inline since this is only usage of xgetbv1. So I'll
use static_cpu_has() here directly. Does it sound good?

>> +	/*
>> +	 * XINUSE is dynamic to track component state because VZEROUPPER
>> +	 * happens on every function end and reset the bitmap to the
>> +	 * initial configuration.
> 
> This is confusing to me because VZEROUPPER is not apparently involved
> here.  What is this trying to say?
> 
VZERROUPPER instruction in the task resets the bitmap.


>> +	 * State decay is introduced to solve the race condition between
>> +	 * context switch and a function end. State is aggressively set
>> +	 * once it's detected but need to be cleared by decay 3 context
>> +	 * switches
>> +	 */
> 
> I'd probably say:
> 
> 	AVX512-using processes frequently set AVX512 back to the init 	
> 	state themselves.  Thus, this detection mechanism can miss.
> 	The decay ensures that false-negatives do not immediately make
> 	a task be considered as not using AVX512.

Thanks, will refine it in the next version.
And yes, AVX512-using processoes set AVX512 back to the init state themselves
by VZEROUPPER instructions.

> 
>> +	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {
> 
> This is *just* an AVX512 state, right?  That isn't reflected in any
> comments or naming.  Also, why just this state, and not any of the other
> AVX512-related states?

Only this state causes significant frequency drop, other states not.
> 
> This is also precisely the kind of thing that would be nice to wrap up
> in a tiny helper.
> 
> 	if (avx512_in_use())
> 
> is much more self-documenting, for instance.

Thanks, will refine it in the next version.

> 
>> +		avx->state = 1;
> 
> I'm not a huge fan of this naming.  Could this be:
> 
> 		avx->had_avx_512_state = true;
> 
>> +		avx->decay_count = AVX_STATE_DECAY_COUNT;
>> +	} else {
>> +		if (avx->decay_count)
>> +			avx->decay_count--;
>> +		else
>> +			avx->state = 0;
>> +	}
>> +}
> 
> This all needs a bunch more commenting.  The state transitions are not
> horribly clear.

Thanks, will refine it in next version.
> 
>>  /*
>>   * This function is called only during boot time when x86 caps are not set
>>   * up and alternative can not be used yet.
>> @@ -411,6 +481,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>>  {
>>  	if (likely(use_xsave())) {
>>  		copy_xregs_to_kernel(&	);
>> +		update_avx_state(&fpu->avx);
>>  		return 1;
>>  	}
> 
> I'm not sure why update_avx_state() goes to the trouble of calling
> XGETBV1.  I believe the exact same state is captured in the 'xfeatures'
> field in the XSAVE buffer after copy_xregs_to_kernel().  Why bother
> calling the instruction when you can get the data from memory?

Thanks to point this out, I'll check this.
> 
>>  /*
>> + * This is per task AVX state data structure that indicates
>> + * whether the task uses AVX instructions.
>> + */
> 
> Here's another spot that doesn't precisely capture how his detection
> mechanism works.
> 
>> +struct avx_state {
>> +	unsigned int			state;
> 
> Isn't state a 0/1 thing?
> 
>> +	unsigned int			decay_count;
>> +};
> 
> Doesn't this max out at 3?
> 
> Seems like we're storing about three bits of data in 64 bits of space.
> Not a huge deal, but I think we can do better?
> 
> Also, do we really even need 'state'?
> 
> When would its value be different than
> 
> 	fpu->state.xsave.xfeatures & XFEATURE_MASK_Hi16_ZMM

okay, will refine in the next version

> 
>> +/*
>>   * Highest level per task FPU state data structure that
>>   * contains the FPU register state plus various FPU
>>   * state fields:
>> @@ -303,6 +312,14 @@ struct fpu {
>>  	unsigned char			initialized;
>>  
>>  	/*
>> +	 * @avx_state:
>> +	 *
>> +	 * This data structure indicates whether this context
>> +	 * contains AVX states
>> +	 */
> 
> Yeah, that's precisely what fpu->state.xsave.xfeatures does. :)
> I see, will refine in the next version

Thanks,
-Aubrey
