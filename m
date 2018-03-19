Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969653AbeCSVMd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:12:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:1223 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969549AbeCSVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:12:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,332,1517904000";
   d="scan'208";a="40345155"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC: "luto@kernel.org" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Topic: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Index: AQHTv61aFYaSukXqZEajMVMtZoAMNaPYYJOA//+n1Zw=
Date: Mon, 19 Mar 2018 21:12:17 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66AC322B@CRSMSX101.amr.corp.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>,<fa579920-fe34-80fb-4244-5b840b99e72c@linux.intel.com>
In-Reply-To: <fa579920-fe34-80fb-4244-5b840b99e72c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.41]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 01:05 PM, Dave Hansen wrote:
>> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
>> GS base is not the kernel's.
> Do you mean "SWAPGS is needed..."?
Yes, will change.

>> FSGSBASE instructions allow user to write any value on GS base;
>> even negative. Sign check on the current GS base is not
>> sufficient. Fortunately, reading GS base is fast. Kernel GS
>> base is also known from the offset table with the CPU number.
>>
>> GS-compatible RDPID macro is included.

> This description could use some work.  I think you're trying to say
> that, currently, userspace can't modify GS base and the kernel's
> conventions are that a negative GS base means it is a kernel value and a
> positive GS base means it is a user vale.  But, with your new patches,
> userspace can put arbitrary data in there, breaking the exising assumption.
> Correct?
Yes.

> This also needs to explain a bit of the theory about how we go finding
> the kernel GS base value.
> Also, this is expected to improve paranoid_entry speed, right?  The
> rdmsr goes away so this should be faster.  Should that be mentioned?
I'm a bit reluctant to claim any performance benefit here yet (without having any strong empirical evidence).

>> + * SWAPGS needs when it comes from user space.
> The grammar here needs some work.
>        "SWAPGS is needed when entering from userspace".
Okay

>>  To check where-it-from,
>> + * read GS base from RDMSR/MSR_GS_BASE and check if negative or not.
>> + * This works without FSGSBASE.
>> + * When FSGSBASE enabled, arbitrary GS base can be put by a user-level
>> + * task, which means negative value is possible. Direct comparison
>> + * between the current and kernel GS bases determines the necessity of
>> + * SWAPGS; do if and only if unmatched.
>> + *
>> + * Return: ebx=0: need SWAPGS on exit, ebx=1: otherwise
>>   */
> I don't think this really belongs in a comment above the function.  I'd
> just explain overall that we are trying to determine if we interrupted
> userspace or not.
I'd rather sync-up with you about comments before posting a revision.

>> +     movl    $1, %ebx
> I know it wasn't commented before, but please add a comment about what
> this is doing.
Okay, as long as this comment doesn't go too much.

>> +     /*
>> +      * Read current GS base with RDGSBASE. Kernel GS base is found
>> +      * by CPU number and its offset value.
>> +      */
>> +     ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase", \
>> +             "RDGSBASE %rdx", X86_FEATURE_FSGSBASE
>I'd rather this be:
>        ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase", "nop",\
>                X86_FEATURE_FSGSBASE
>        RDGSBASE           %rdx
>        READ_KERNEL_GSBASE %rax
>        /* See if the kernel GS_BASE value is in GS base register */
>        cmpq    %rdx, %rax
>        ...
>It's a lot more readable than what you have.
Yes, if it helps your readability.

>> +     jne     .Lparanoid_entry_swapgs
>> +     ret
>> +
>> +.Lparanoid_entry_no_fsgsbase:
>> +     /*
>> +      * A (slow) RDMSR is surefire without FSGSBASE.
>> I'd say:
>>        FSGSBASE is not in use, so depend on the kernel-enforced
>>        convention that a negative GS base indicates a kernel value.
Okay, as the detail comment at the entry should be moved like that.

>> +      * The READ_MSR_GSBASE macro scratches %ecx, %eax, and %edx.
> "clobbers" is the normal terminology for this, not "scratches".
Got it.

>> +.Lparanoid_entry_swapgs:
>> +     SWAPGS
>> +     xorl    %ebx, %ebx
>>       ret
>>  END(paranoid_entry)
> ^^ Please comment the xorl, especially now that it's farther away from
> the comment explaining what it is for.
Okay (but if not too much)

> +.macro READ_KERNEL_GSBASE_RDPID reg:req
> This needs some explanation.  Maybe:
> /*
>  * Fetch the per-cpu GSBASE value for this processor and
>  * put it in @reg.  We normally use %GS for accessing per-cpu
>  * data, but we are setting up %GS here and obviously can not
>  * use %GS itself to access per-cpu data.
>  */
Let me think.

>> +     /*
>> +      * processor id is written during vDSO (virtual dynamic shared object)
>> +      * initialization. 12 bits for the CPU and 8 bits for the node.
>> +      */
>> +     andq    $0xFFF, \reg
> This begs the question: when do we initialize the VDSO?  Is that before
> or after the first paranoid_entry interrupt?  Also, why the magic
> number?  Shouldn't this come out of a macro somewhere rather than having
> to hard-code and spell out the convention?
Hoped the comment to be explanatory; but, agree that the hard-code anyways is bad.

>> +.macro READ_KERNEL_GSBASE reg:req
>> +     ALTERNATIVE "READ_KERNEL_GSBASE_CPU_SEG_LIMIT \reg", \
>> +             "READ_KERNEL_GSBASE_RDPID \reg", X86_FEATURE_RDPID
>> +.endm
> Can I suggest a different indentation?
>        ALTERNATIVE \
>                "READ_KERNEL_GSBASE_CPU_SEG_LIMIT \reg", \
>                "READ_KERNEL_GSBASE_RDPID \reg",
>                X86_FEATURE_RDPID
Sure, you can.
