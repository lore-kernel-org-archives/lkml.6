Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeBLNn4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:43:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751385AbeBLNny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:43:54 -0500
Subject: Re: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS
 macro
To: David Laight <David.Laight@ACULAB.COM>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-tip-commits@vger.kernel.org"
        <linux-tip-commits@vger.kernel.org>
References: <20180211104949.12992-5-linux@dominikbrodowski.net>
 <tip-7b7b09f110f06f3c006e9b3f4590f7d9ba91345b@git.kernel.org>
 <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
 <1b5552f1231b4c9b867a17d0c5c594bb@AcuMS.aculab.com>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <6217451a-21ea-5fc3-54f7-1e333452dcda@redhat.com>
Date: Mon, 12 Feb 2018 14:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1b5552f1231b4c9b867a17d0c5c594bb@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 02:36 PM, David Laight wrote:
> From: Denys Vlasenko
>> Sent: 12 February 2018 13:29
> ...
>>>
>>> x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
>>>
>>> Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
>>> SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
>>> This macro uses PUSH instead of MOV and should therefore be faster, at
>>> least on newer CPUs.
> ...
>>> Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
>>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>> ---
>>>    arch/x86/entry/calling.h  | 36 ++++++++++++++++++++++++++++++++++++
>>>    arch/x86/entry/entry_64.S |  6 ++----
>>>    2 files changed, 38 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
>>> index a05cbb8..57b1b87 100644
>>> --- a/arch/x86/entry/calling.h
>>> +++ b/arch/x86/entry/calling.h
>>> @@ -137,6 +137,42 @@ For 32-bit we have the following conventions - kernel is built with
>>>    	UNWIND_HINT_REGS offset=\offset
>>>    	.endm
>>>
>>> +	.macro PUSH_AND_CLEAR_REGS
>>> +	/*
>>> +	 * Push registers and sanitize registers of values that a
>>> +	 * speculation attack might otherwise want to exploit. The
>>> +	 * lower registers are likely clobbered well before they
>>> +	 * could be put to use in a speculative execution gadget.
>>> +	 * Interleave XOR with PUSH for better uop scheduling:
>>> +	 */
>>> +	pushq   %rdi		/* pt_regs->di */
>>> +	pushq   %rsi		/* pt_regs->si */
>>> +	pushq   %rdx		/* pt_regs->dx */
>>> +	pushq   %rcx		/* pt_regs->cx */
>>> +	pushq   %rax		/* pt_regs->ax */
>>> +	pushq   %r8		/* pt_regs->r8 */
>>> +	xorq    %r8, %r8	/* nospec   r8 */
>>
>> xorq's are slower than xorl's on Silvermont/Knights Landing.
>> I propose using xorl instead.
> 
> Does using movq to copy the first zero to the other registers make
> the code any faster?
> 
> ISTR mov reg-reg is often implemented as a register rename rather than an
> alu operation.

xorl is implemented in register rename as well. Just, for some reason,
xorq did not get the same treatment on those CPUs.
