Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeCVBhz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbeCVBhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:37:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B42183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELsS6SnMY5G//bbAnk74YbokoUdyz7ylUw1fcbb4PHhBU4+/dMGdL1nAZ3YP5tgxXy6Apd+D7HoiIh6N4SzNdME=
MIME-Version: 1.0
In-Reply-To: <cc9b0ef1-79c6-7a21-dc70-6f922ec45db4@zytor.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com> <cc9b0ef1-79c6-7a21-dc70-6f922ec45db4@zytor.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 01:37:31 +0000
X-Gmail-Original-Message-ID: <CALCETrXVDt62mCun6fP9Ac0ZMELRSi9yefqUyhrDBG92UeS3_Q@mail.gmail.com>
Message-ID: <CALCETrXVDt62mCun6fP9Ac0ZMELRSi9yefqUyhrDBG92UeS3_Q@mail.gmail.com>
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on paranoid_entry
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 10:03 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 03/20/18 07:58, Andy Lutomirski wrote:
>>> On Mar 19, 2018, at 10:49 AM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>>
>>> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
>>> GS base is not the kernel's.
>>>
>>> FSGSBASE instructions allow user to write any value on GS base;
>>> even negative. Sign check on the current GS base is not
>>> sufficient. Fortunately, reading GS base is fast. Kernel GS
>>> base is also known from the offset table with the CPU number.
>>
>> The original version of these patches (mine and Andi’s) didn’t have
>> this comparison, didn’t need RDMSR, and didn’t allow malicious user
>> programs to cause the kernel to run decently large chunks of code with
>> the reverse of the expected GS convention. Why did you change it?
>>
>> I really really don't like having a corner case like this that can and
>> will be triggered by malicious user code but that is hard to write a
>> self-test for because it involves guessing a 64-bit magic number.
>> Untestable corner cases in the x86 entry code are bad.
>>
>
> What corner case are you talking about?
>
> If user GS_BASE and kernel GS_BASE happen to be identical, then SWAPGS
> is a nop and it does not matter one iota which is is user space and
> which is kernel space.  They are just numbers, and swapping one number
> with itself doesn't do anything (in fact, opcode 0x90 was used for NOP
> because it aliased to xchg [e]ax,[e]ax on pre-64-bit hardware.)
>

On current kernels, MSR_GS_BASE points to kernel percpu data and
MSR_KERNEL_GS_BASE is the user's GSBASE value.  If you *write* to
MSR_KERNEL_GS_BASE, you modify the user's value.

With Andi's/my patches, it works exactly the same way on !FSGSBASE
and, if FSGSBASE is on, then, when we're in a paranoid entry,
MSR_GS_BASE is the live kernel value, the value upon return is stashed
in an entry asm register, and MSR_KERNEL_GS_BASE is whatever it was
before we entered.  Sure, it's more complicated, but if something
starts writing to MSR_KERNEL_GS_BASE in the context of a paranoid
entry, the behavior will at least be consistently screwy.

With these patches, MSR_GS_BASE points to the kernel percpu data and
MSR_KERNEL_GS_BASE is the user's value, but writing to
MSR_KERNEL_GS_BASE will change the *kernel* value if we happen to be
in a paranoid context while running malicious user code.  But only
when running malicious user code.

In the absence of some compelling reason why #3 is better than #2, I
don't like it.

If you want to argue for using rdpid or lsl to find the kernel gs base
and then load it unconditionally with wrgsbase, I'd be fine with that.
But this compare-and-swapgs just seems unnecessarily subject to
manipulation.
