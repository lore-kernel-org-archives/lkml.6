Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfBFJbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:31:07 -0500
Received: from foss.arm.com ([217.140.101.70]:50264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfBFJbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:31:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0DF1A78;
        Wed,  6 Feb 2019 01:31:05 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24503F719;
        Wed,  6 Feb 2019 01:31:02 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
From:   Julien Thierry <julien.thierry@arm.com>
To:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
Message-ID: <22289b8e-bfdf-37cb-0234-2233a528ef61@arm.com>
Date:   Wed, 6 Feb 2019 09:30:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2019 08:59, Julien Thierry wrote:
> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
>> Once gcc8 adds 2 NOPs at the beginning of each function, replace the
>> first NOP thus generated with a quick LR saver (move it to scratch reg
>> x9), so the 2nd replacement insn, the call to ftrace, does not clobber
>> the value. Ftrace will then generate the standard stack frames.
>>
>> Note that patchable-function-entry in GCC disables IPA-RA, which means
>> ABI register calling conventions are obeyed *and* scratch registers
>> such as x9 are available.
>>
>> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
>> after ftrace_trampoline, and double the size of this special section.
>>
>> Signed-off-by: Torsten Duwe <duwe@suse.de>
>>
>> ---
>>
>> Mark, if you see your ftrace entry macro code being represented correctly
>> here, please add your sign-off, As I've initially copied it from your mail.
>>
>> ---
>>  arch/arm64/include/asm/ftrace.h  |   17 ++++-
>>  arch/arm64/include/asm/module.h  |    3 
>>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>>  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
>>  arch/arm64/kernel/module-plts.c  |    3 
>>  arch/arm64/kernel/module.c       |    2 
>>  6 files changed, 227 insertions(+), 37 deletions(-)
> 
> [...]
> 
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
>>  	return ftrace_modify_code(pc, old, new, true);
>>  }
>>  
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>> +			unsigned long addr)
>> +{
>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>> +	u32 old, new;
>> +
>> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
>> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
>> +
>> +	return ftrace_modify_code(pc, old, new, true);
>> +}
>> +#endif
>> +
>>  /*
>>   * Turn off the call to ftrace_caller() in instrumented function
>>   */
>>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>  		    unsigned long addr)
>>  {
>> -	unsigned long pc = rec->ip;
>> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> 
> Sorry to come back on this patch again, but I was looking at the ftrace
> code a bit, and I see that when processing the ftrace call locations,
> ftrace calls ftrace_call_adjust() on every ip registered as mcount
> caller (or in our case patchable entries). This ftrace_call_adjust() is
> arch specific, so I was thinking we could place the offset in here once
> and for all so we don't have to worry about it in the future.
> 
> Also, I'm unsure whether it would be safe, but we could patch the "mov
> x9, lr" there as well. In theory, this would be called at init time
> (before secondary CPUs are brought up) and when loading a module (so I'd
> expect no-one is executing that code *yet*.
> 

And if the above works, we could also define CC_HAVE_NOP_MCOUNT (when we
have the patchable entry) and then we just not have to worry about the
initial ftrace_make_nop() with MCOUNT_ADDR.

-- 
Julien Thierry
