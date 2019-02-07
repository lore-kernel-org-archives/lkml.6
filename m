Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7837BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420E821904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBGNrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:47:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfBGNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:47:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77871EBD;
        Thu,  7 Feb 2019 05:47:37 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3573F3F675;
        Thu,  7 Feb 2019 05:47:33 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
 <20190206150524.GA28892@lst.de>
 <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
 <20190207125159.GA19818@lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <9bfb0506-5e8e-98d8-1946-9b6eaa4084b9@arm.com>
Date:   Thu, 7 Feb 2019 13:47:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207125159.GA19818@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2019 12:51, Torsten Duwe wrote:
> On Thu, Feb 07, 2019 at 10:33:50AM +0000, Julien Thierry wrote:
>>
>>
>> On 06/02/2019 15:05, Torsten Duwe wrote:
>>> On Wed, Feb 06, 2019 at 08:59:44AM +0000, Julien Thierry wrote:
>>>> Hi Torsten,
>>>>
>>>> On 18/01/2019 16:39, Torsten Duwe wrote:
>>>>
>>>>> --- a/arch/arm64/kernel/ftrace.c
>>>>> +++ b/arch/arm64/kernel/ftrace.c
>>>>> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>>>>>  	return ftrace_modify_code(pc, old, new, true);
>>>>>  }
>>>>>  
>>>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>>>> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>>>>> +			unsigned long addr)
>>>>> +{
>>>>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>>>>> +	u32 old, new;
>>>>> +
>>>>> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
>>>>> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
>>>>> +
>>>>> +	return ftrace_modify_code(pc, old, new, true);
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  /*
>>>>>   * Turn off the call to ftrace_caller() in instrumented function
>>>>>   */
>>>>>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>>>>  		    unsigned long addr)
>>>>>  {
>>>>> -	unsigned long pc = rec->ip;
>>>>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>>>>
>>>> Sorry to come back on this patch again, but I was looking at the ftrace
>>>> code a bit, and I see that when processing the ftrace call locations,
>>>> ftrace calls ftrace_call_adjust() on every ip registered as mcount
>>>> caller (or in our case patchable entries). This ftrace_call_adjust() is
>>>> arch specific, so I was thinking we could place the offset in here once
>>>> and for all so we don't have to worry about it in the future.
>>>
>>> Now that you mention it - yes indeed that's the correct facility to fix
>>> the deviating address, as Steve has also confirmed. I had totally forgotten
>>> about this hook.
>>>
>>>> Also, I'm unsure whether it would be safe, but we could patch the "mov
>>>> x9, lr" there as well. In theory, this would be called at init time
>>>> (before secondary CPUs are brought up) and when loading a module (so I'd
>>>> expect no-one is executing that code *yet*.
>>>>
>>>> If this is possible, I think it would make things a bit cleaner.
>>>
>>> This is in fact very tempting, but it will introduce a nasty side effect
>>> to ftrace_call_adjust. Is there any obvious documentation that specifies
>>> guarantees about ftrace_call_adjust being called exactly once for each site?
>>>
>>
>> I don't see really much documentation on that function. As far as I can
>> tell it is only called once for each site (and if it didn't, we'd always
>> be placing the same instruction, but I agree it wouldn't be nice). It
>> could depend on how far you can expand the notion of "adjusting" :) .
> 
> I've been thinking this over and I'm considering to make an ftrace_modify_code
> with verify and warn_once if it fails. Then read the insn back and bug_on
> should it not be the lr saver. Any objections?
> 

Hmmm, I'm not really convinced the read back + bug part would really be
useful right after patching this instruction in. ftrace_modify_code()
should already return an error if the instruction patching failed.

A real issue would be if ftrace_call_adjust() would be called on a
location where we shouldn't patch the instruction (i.e. a location that
is not the first instruction of a patchable entry). But to me, it
doesn't look like this function is intended to be called on something
else than the "mcount callsites" (which in our case is that first
patchable instruction).

Cheers,

-- 
Julien Thierry
