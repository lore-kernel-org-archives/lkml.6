Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeCUWFr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:05:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54435 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbeCUWFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:05:46 -0400
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on
 paranoid_entry
To: Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <cc9b0ef1-79c6-7a21-dc70-6f922ec45db4@zytor.com>
Date: Wed, 21 Mar 2018 15:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/18 07:58, Andy Lutomirski wrote:
>> On Mar 19, 2018, at 10:49 AM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
>> GS base is not the kernel's.
>>
>> FSGSBASE instructions allow user to write any value on GS base;
>> even negative. Sign check on the current GS base is not
>> sufficient. Fortunately, reading GS base is fast. Kernel GS
>> base is also known from the offset table with the CPU number.
> 
> The original version of these patches (mine and Andi’s) didn’t have
> this comparison, didn’t need RDMSR, and didn’t allow malicious user
> programs to cause the kernel to run decently large chunks of code with
> the reverse of the expected GS convention. Why did you change it?
> 
> I really really don't like having a corner case like this that can and
> will be triggered by malicious user code but that is hard to write a
> self-test for because it involves guessing a 64-bit magic number.
> Untestable corner cases in the x86 entry code are bad.
> 

What corner case are you talking about?

If user GS_BASE and kernel GS_BASE happen to be identical, then SWAPGS
is a nop and it does not matter one iota which is is user space and
which is kernel space.  They are just numbers, and swapping one number
with itself doesn't do anything (in fact, opcode 0x90 was used for NOP
because it aliased to xchg [e]ax,[e]ax on pre-64-bit hardware.)

As far as running "decently large chunks" this is *exactly* the same
amount of code that is run on non-FSGSBASE hardware, so it Has To
Work[TM] anyway.  If anything this may help catch problems sooner.

This minimizes the difference between the FSGSBASE and non-FSGSBASE
flows, which I would consider a significant win.

	-hpa
