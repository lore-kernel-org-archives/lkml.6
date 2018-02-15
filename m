Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166085AbeBOSIu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:08:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:54428 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163994AbeBOSIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:08:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="18780963"
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
To: Nadav Amit <namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
 <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
 <E2528628-52A6-444F-BE02-0C69D5E52726@vmware.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <7b48990b-0a56-a26d-5d98-fe305331caec@linux.intel.com>
Date: Thu, 15 Feb 2018 10:08:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <E2528628-52A6-444F-BE02-0C69D5E52726@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 09:47 AM, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>> index c67ef3fb4f35..979c7ec6baab 100644
>>> --- a/arch/x86/mm/tlb.c
>>> +++ b/arch/x86/mm/tlb.c
>>> @@ -74,7 +74,8 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
>>> 		return;
>>> 	}
>>>
>>> -	if (this_cpu_read(cpu_tlbstate.invalidate_other))
>>> +	if (this_cpu_read(cpu_tlbstate.invalidate_other) &&
>>> +	    !mm_pti_disable(next))
>>> 		clear_asid_other();
>>
>> This isn't obviously correct.  Don't we still need to invalidate other
>> user asids?
> 
> I forgot to regard this question: When you reenable PTI (after switching back
> to 64-bit process), you flush the global pages, so no kernel mappings for the
> 32-bit process are left.

Can you please write up a proper description for this?  It's horribly
complicated, intertwined with global pages, and sets up a dependency
that *ALL* TLB entries invalidated via __flush_tlb_one_kernel() must be
_PAGE_GLOBAL.

How about you actually clear cpu_tlbstate.invalidate_other when you do
the CR4.PGE switching?  That seems a much more direct way and is much
more self-documenting.

That brings up another point: these patches rather ignore cpu_tlbstate.
That leads to confusing code (this) and the double-flushing on context
switch I brought up earlier.  Was this intentional, or is it something
you can reconsider going forward?
