Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeBEQh4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:37:56 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:46109 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeBEQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:37:48 -0500
X-Google-Smtp-Source: AH8x226Nbud5tlAuZ3RQiUbZYA7NdyKFkXvvkhQbK7eZVpCMoW9gdukbwKInU1cHO/3YkaE5e/wlLap64gsPPwsiB9I=
MIME-Version: 1.0
In-Reply-To: <20180205163046.zeic6bqhkypbsutt@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205114250.zd3nbe5yl2mnd54m@gmail.com> <6CCF65EF-325A-4207-9C5E-2CD2D8E2A7E4@amacapital.net>
 <20180205163046.zeic6bqhkypbsutt@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 5 Feb 2018 16:37:26 +0000
Message-ID: <CALCETrVt3S5v_1QNYBQyMW-FZxhyQ3c6u6m=FPWKR7qaPs6q2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:30 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Lutomirski <luto@amacapital.net> wrote:
>
>>
>>
>> > On Feb 5, 2018, at 3:42 AM, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> >
>> > * Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> >> +    /*
>> >> +     * Sanitize extra registers of values that a speculation attack
>> >> +     * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
>> >> +     * the expectation is that %ebp will be clobbered before it
>> >> +     * could be used.
>> >> +     */
>> >> +    .macro CLEAR_EXTRA_REGS_NOSPEC
>> >> +    xorq %r15, %r15
>> >> +    xorq %r14, %r14
>> >> +    xorq %r13, %r13
>> >> +    xorq %r12, %r12
>> >> +    xorl %ebx, %ebx
>> >> +#ifndef CONFIG_FRAME_POINTER
>> >> +    xorl %ebp, %ebp
>> >> +#endif
>> >> +    .endm
>> >
>> > Yeah, so this series look pretty good to me, but there's one small detail: I think
>> > RBP should be cleared unconditionally here, even in the CONFIG_FRAME_POINTERS=y
>> > case, because:
>>
>> ENCODE_FRAME_POINTER should take care of rbp, though.
>
> AFAICS there's various entry paths where it's not used I think: for example the
> compat system calls in entry_64_compat.S don't seem to encode RBP in such a
> fashion (unless I missed some macro side effect).

Then that's a separate bug that should be fixed.  Josh?
