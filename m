Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032874AbeBONp7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:45:59 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35712 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031445AbeBONp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:45:57 -0500
X-Google-Smtp-Source: AH8x22657qBHVL1oVv6Utxc0GmXP9ZJR3IC+2EPDLWD49OGEmsiv+2qD0OpJuyzdgaqzRVAfIWiEQqY6u3D7klfApak=
MIME-Version: 1.0
In-Reply-To: <CALCETrXB+520uESCFVX2rH7NKkmr20+8YmmBONWUBmB1Cq97mQ@mail.gmail.com>
References: <20180214182113.27247-1-linux@dominikbrodowski.net>
 <20180214182113.27247-3-linux@dominikbrodowski.net> <CALCETrXvD7ZwtXnABT3XW7as4ogdSiyBsRUTY3t_LWtm7KiZeA@mail.gmail.com>
 <CAMzpN2iA6N7hq8zYBAiMq48emWnidDHvnOPg3h5pYGtBOZOm6Q@mail.gmail.com> <CALCETrXB+520uESCFVX2rH7NKkmr20+8YmmBONWUBmB1Cq97mQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 15 Feb 2018 08:45:56 -0500
Message-ID: <CAMzpN2j6E5o-eJtSTZtngn_m8_dAQ7=Wqg_SnHnUao1JhA11AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/entry/64: move ENTER_IRQ_STACK from interrupt
 macro to helper function
To: Andy Lutomirski <luto@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:11 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Feb 15, 2018 at 12:48 AM, Brian Gerst <brgerst@gmail.com> wrote:
>> On Wed, Feb 14, 2018 at 7:17 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On Wed, Feb 14, 2018 at 6:21 PM, Dominik Brodowski
>>> <linux@dominikbrodowski.net> wrote:
>>>> Moving the switch to IRQ stack from the interrupt macro to the helper
>>>> function requires some trickery: All ENTER_IRQ_STACK really cares about
>>>> is where the "original" stack -- meaning the GP registers etc. -- is
>>>> stored. Therefore, we need to offset the stored RSP value by 8 whenever
>>>> ENTER_IRQ_STACK is called from within a function. In such cases, and
>>>> after switching to the IRQ stack, we need to push the "original" return
>>>> address (i.e. the return address from the call to the interrupt entry
>>>> function) to the IRQ stack.
>>>>
>>>> This trickery allows us to carve another 1k from the text size:
>>>>
>>>>    text    data     bss     dec     hex filename
>>>>   17905       0       0   17905    45f1 entry_64.o-orig
>>>>   16897       0       0   16897    4201 entry_64.o
>>>>
>>>> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>>>> ---
>>>>  arch/x86/entry/entry_64.S | 53 +++++++++++++++++++++++++++++++----------------
>>>>  1 file changed, 35 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>>> index de8a0da0d347..3046b12a1acb 100644
>>>> --- a/arch/x86/entry/entry_64.S
>>>> +++ b/arch/x86/entry/entry_64.S
>>>> @@ -449,10 +449,18 @@ END(irq_entries_start)
>>>>   *
>>>>   * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
>>>>   */
>>>> -.macro ENTER_IRQ_STACK regs=1 old_rsp
>>>> +.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
>>>>         DEBUG_ENTRY_ASSERT_IRQS_OFF
>>>>         movq    %rsp, \old_rsp
>>>>
>>>> +       .if \save_ret
>>>> +       /*
>>>> +        * If save_ret is set, the original stack contains one additional
>>>> +        * entry -- the return address.
>>>> +        */
>>>> +       addq    $8, \old_rsp
>>>> +       .endif
>>>> +
>>>
>>> This is a bit alarming in that you now have live data below RSP.  For
>>> x86_32, this would be a big no-no due to NMI.  For x86_64, it might
>>> still be bad if there are code paths where NMI is switched to non-IST
>>> temporarily, which was the case at some point and might still be the
>>> case.  (I think it is.)  Remember that the x86_64 *kernel* ABI has no
>>> red zone.
>>>
>>> It also means that, if you manage to hit vmalloc_fault() in here when
>>> you touch the IRQ stack, you're dead.  IOW you hit:
>>>
>>>         movq    \old_rsp, PER_CPU_VAR(irq_stack_union + IRQ_STACK_SIZE - 8)
>>>
>>> which gets #PF and eats your return pointer.  Debugging this will be
>>> quite nasty because you'll only hit it on really huge systems after a
>>> thread gets migrated, and even then only if you get unlucky on your
>>> stack alignment.
>>>
>>> So can you find another way to do this?
>>
>> It's adding 8 to the temp register, not %rsp.
>
> Duh.

Even if you get a #PF when writing to the IRQ stack (which should
never happen in the first place since per-cpu memory is mapped at boot
time), RSP would still be below the return address and the fault won't
overwrite it.

That said, the word it writes to the top of the IRQ stack is
vulnerable for a short window between when it switches RSP to the IRQ
stack and when it pushes old_rsp.  That would only affect the unwinder
during a NMI in that window though since it pushes old_rsp again.  So
I'd say commit 29955909 doesn't work exactly as advertised.  But that
has nothing to do with this patch.

--
Brian Gerst
