Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeBPWLj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:11:39 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33634 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeBPWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:11:38 -0500
X-Google-Smtp-Source: AH8x2245TKt1wdySa2rAzU6z6eg/AYnzfC1CtIp79YRln95GNXpCh2ppjmjHy4YPaLa0a9s8u4wLyg==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAJwJo6ZxnuG9PyP2H_gGq_gTRhE7kzWk1OEtGwQ9dk+Px8aWGQ@mail.gmail.com>
Date: Fri, 16 Feb 2018 14:11:32 -0800
Cc: Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <5220B2CE-5E06-4D86-B072-AB7727D54F6E@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com>
 <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
 <20180216071139.GC32767@uranus>
 <CAJwJo6ZxnuG9PyP2H_gGq_gTRhE7kzWk1OEtGwQ9dk+Px8aWGQ@mail.gmail.com>
To: Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GMBjlw023978

Dmitry Safonov <0x7f454c46@gmail.com> wrote:

> 2018-02-16 7:11 GMT+00:00 Cyrill Gorcunov <gorcunov@gmail.com>:
>> On Thu, Feb 15, 2018 at 11:29:42PM +0000, Andy Lutomirski wrote:
>> ...
>>>>>> +bool pti_handle_segment_not_present(long error_code)
>>>>>> +{
>>>>>> +       if (!static_cpu_has(X86_FEATURE_PTI))
>>>>>> +               return false;
>>>>>> +
>>>>>> +       if ((unsigned short)error_code != GDT_ENTRY_DEFAULT_USER_CS << 3)
>>>>>> +               return false;
>>>>>> +
>>>>>> +       pti_reenable();
>>>>>> +       return true;
>>>>>> +}
>>>>> 
>>>>> Please don't.  You're trying to emulate the old behavior here, but
>>>>> you're emulating it wrong.  In particular, you won't trap on LAR.
>>>> 
>>>> Yes, I thought I’ll manage to address LAR, but failed. I thought you said
>>>> this is not a “show-stopper”. I’ll adapt your approach of using prctl, although
>>>> it really limits the benefit of this mechanism.
>>> 
>>> It's possible we could get away with adding the prctl but making the
>>> default be that only the bitness that matches the program being run is
>>> allowed.  After all, it's possible that CRIU is literally the only
>>> program that switches bitness using the GDT.  (DOSEMU2 definitely does
>>> cross-bitness stuff, but it uses the LDT as far as I know.)  And I've
>>> never been entirely sure that CRIU fully counts toward the Linux
>>> "don't break ABI" guarantee.
>>> 
>>> Linus, how would you feel about, by default, preventing 64-bit
>>> programs from long-jumping to __USER32_CS and vice versa?  I think it
>>> has some value as a hardening measure.  I've certainly engaged in some
>>> exploit shenanigans myself that took advantage of the ability to long
>>> jump/ret to change bitness at will.  This wouldn't affect users of
>>> modify_ldt() -- 64-bit programs could still create and use their own
>>> private 32-bit segments with modify_ldt(), and seccomp can (and
>>> should!) prevent that in sandboxed programs.
>>> 
>>> In general, I prefer an approach where everything is explicit to an
>>> approach where we almost, but not quite, emulate the weird historical
>>> behavior.
>>> 
>>> Pavel and Cyrill, how annoying would it be if CRIU had to do an extra
>>> arch_prctl() to enable its cross-bitness shenanigans when
>>> checkpointing and restoring a 32-bit program?
>> 
>> I think this should not be a problem for criu (CC'ing Dima, who has
>> been working on compat mode support in criu). As far as I remember
>> we initiate restoring of 32 bit tasks in native 64 bit mode (well,
>> ia32e to be precise :) mode and then, once everything is ready,
>> we changing the mode by doing a return to __USER32_CS descriptor.
>> So this won't be painful to add additional prctl call here.
> 
> Yeah, restoring will still be easy..
> But checkpointing will be harder if we can't switch to 64-bit mode.
> ATM we have one 64-bit parasite binary, which does all seizing job
> for both 64 and 32 bit binaries.
> So, if you can't switch back to 64-bit from 32-bit mode, we'll need
> to keep two parasites.

I can allow to switch back and forth by dynamically enabling/disabling PTI.
Andy, Dave, do you think it makes it a viable option? Should I respin
another version of the patch-set?
