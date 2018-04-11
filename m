Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeDKEJe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:09:34 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:40160 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeDKEJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:09:32 -0400
X-Google-Smtp-Source: AIpwx4/1RDCH3FUOp2sDUGWap+AA+nTOEyGQ9vBCq8CD/Yz20yKAZ6JQ2EWYIQiANDM0un60CQx7v1TRU8FNYji84PA=
MIME-Version: 1.0
In-Reply-To: <87d0z6ttxe.fsf@xmission.com>
References: <87d0z6ttxe.fsf@xmission.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 10 Apr 2018 21:09:11 -0700
Message-ID: <CALCETrVR1qHCndoaqXWosy8ckMTyT2RequQTgg0MZUw_sMPwwQ@mail.gmail.com>
Subject: Re: Q: Can we get rid of __copy_siginfo_to_user32?
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B49g1B028391

> On Apr 10, 2018, at 6:26 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Andy,
>
> I am looking at copy_siginfo_to_user32 and find it very unfortunate
> that x86 with _sigchld_x32 needs to be the odd man out.  I am looking
> at ways to simplify the special case.
>
> The core of the special case comes from:
> exit_to_usermode_loop
>  do_signal
>    handle_signal
>       setup_rt_frame
>
>
> In setup_rt_frame the code looks at ksig to see which kind of signal
> frame should be written for the signal.
>
> This leads to the one case in the kernel where copy_siginfo_to_user32
> does not use is_ia32_syscall() or is_x32_syscall() to see which kind of
> signal frame it needs to create.
>
> Andy, since you have been all over the entry point code in recent years
> do you know if we allow tasks that can do both ia32 and x86_64 system
> calls?  That seems to be what we the testing of ksig to see which kind
> of signal frame to setup is all about.

We do :(

> If we don't allow mixed abi's on x86_64 then can I see if I have a ia32
> task in setup_rt_frame by just calling is_ia32_syscall()?
>
> If we do allow mixed abi's do you know if it would be safe to
> temporarily play with orig_ax or current_thread_info()->status?

Maybe, but it’s a real minefield. I think the right fix is to use
sa_flags's SA_X32_ABI bit instead for the sigchld bit.  In general,
the is_..._syscall() helpers can't be expected to return anything
valid in any context other than a syscall, and handle_signal() is not
a syscall.

>
> My goal is to write two wrappers: copy_siginfo_to_user32_ia32, and
> copy_siginfo_to_user32_x32 around the ordinary copy_siginfo_to_user32.
> With only a runtime test to see which ABI we need to implement.
>
> Aka change:
>>    case SIL_CHLD:
>>        to->si_pid    = from->si_pid;
>>        to->si_uid    = from->si_uid;
>>        to->si_status = from->si_status;
>> #ifdef CONFIG_X86_X32_ABI
>>        if (x32_ABI) {
>>            to->_sifields._sigchld_x32._utime = from->si_utime;
>>            to->_sifields._sigchld_x32._stime = from->si_stime;
>>        } else
>> #endif
>>        {
>>            to->si_utime = from->si_utime;
>>            to->si_stime = from->si_stime;
>>        }
>>        break;
> to something like:
>>    case SIL_CHLD:
>>        to->si_pid    = from->si_pid;
>>        to->si_uid    = from->si_uid;
>>        to->si_status = from->si_status;
>> #ifdef CONFIG_X86_X32_ABI
>>        if (!is_ia32_syscall()) {
>>            to->_sifields._sigchld_x32._utime = from->si_utime;
>>            to->_sifields._sigchld_x32._stime = from->si_stime;
>>        } else
>> #endif
>>        {
>>            to->si_utime = from->si_utime;
>>            to->si_stime = from->si_stime;
>>        }
>>        break;
>

Makes sense, but can you get to sa_flags in there instead?

FWIW, I have a branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=execve

that contains a *massive* cleanup of some other x86 signal stuff.  I
need to dust it off and test it better.
