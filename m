Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeBPXq6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:46:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:51140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbeBPXq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:46:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,522,1511856000";
   d="scan'208";a="204946236"
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: David Woodhouse <dwmw2@infradead.org>, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <c77b3da9-136d-9988-119f-e94c86fd34a3@linux.intel.com>
 <1518808600.7876.49.camel@infradead.org>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <66f94cb1-8160-56e0-680c-2e847ae05893@linux.intel.com>
Date: Fri, 16 Feb 2018 15:46:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1518808600.7876.49.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 11:16 AM, David Woodhouse wrote:
> On Fri, 2018-02-16 at 10:44 -0800, Tim Chen wrote:
>>
>> I encountered hang on a machine but not others when using the above
>> macro.  It is probably an alignment thing with ALTERNATIVE as the
>> problem went
>> away after I made the change below:
>>
>> Tim
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h
>> b/arch/x86/include/asm/nospec-branch.h
>> index 8f2ff74..0f65bd2 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -148,6 +148,7 @@ extern char __indirect_thunk_end[];
>>  
>>  #define alternative_msr_write(_msr, _val, _feature)            \
>>         asm volatile(ALTERNATIVE("",                            \
>> +                               ".align 16\n\t"                \
>>                                 "movl %[msr], %%ecx\n\t"       \
>>                                 "movl %[val], %%eax\n\t"       \
>>                                 "movl $0, %%edx\n\t"           \
> 
> That's weird. Note that .align in an altinstr section isn't actually
> going to do what you'd expect; the oldinstr and altinstr sections
> aren't necessarily aligned the same, so however many NOPs it inserts
> into the alternative, might be deliberately *misaligning* it in the
> code that actually gets executed.
> 
> Are you sure you're not running a kernel where the alternatives code
> would turn that alternative which *starts* with a NOP, into *all* NOPs?
> 

I rebuild the kernel again without the align. I'm no longer
seeing the issue again on that machine that had an issue earlier.  
So let's ignore this for now as I can't reproduce the problem.

It should be other issues causing the hang I saw earlier.

Thanks.

Tim
