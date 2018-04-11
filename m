Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDKQMy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:12:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41948 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDKQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:12:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <87d0z6ttxe.fsf@xmission.com>
        <CALCETrVR1qHCndoaqXWosy8ckMTyT2RequQTgg0MZUw_sMPwwQ@mail.gmail.com>
Date: Wed, 11 Apr 2018 11:11:35 -0500
In-Reply-To: <CALCETrVR1qHCndoaqXWosy8ckMTyT2RequQTgg0MZUw_sMPwwQ@mail.gmail.com>
        (Andy Lutomirski's message of "Tue, 10 Apr 2018 21:09:11 -0700")
Message-ID: <87bmepn2o8.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1f6IMc-0006S6-PN;;;mid=<87bmepn2o8.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/MPm4C3hK/QZHFfQlqLjUi3stEXy9iD/k=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andy Lutomirski <luto@amacapital.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 383 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.67 (0.4%), parse: 0.93 (0.2%),
        extract_message_metadata: 14 (3.7%), get_uri_detail_list: 3.1 (0.8%),
        tests_pri_-1000: 6 (1.7%), tests_pri_-950: 1.11 (0.3%), tests_pri_-900: 0.93
        (0.2%), tests_pri_-400: 31 (8.2%), check_bayes: 30 (7.9%), b_tokenize: 9
        (2.4%), b_tok_get_all: 12 (3.1%), b_comp_prob: 2.8 (0.7%), b_tok_touch_all:
        3.7 (1.0%), b_finish: 0.62 (0.2%), tests_pri_0: 318 (83.1%),
        check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 2.7 (0.7%),
        tests_pri_500: 4.5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Q: Do si_time and si_utime need to be 64bit for y2038?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

I am looking at the siginfo si_utime and si_stime fields of type clock_t
on 32bit architectures except for x32 these are 32bit fields.  For y2038
do we want to extend these fields to 64bit like x32 does?  Or is it not
a problem for these fields to be 32bit?

I care right now because I am trying to figure out how
copy_siginfo_to_user32 and copy_siginfo_to_user need to evolve.

If we are going to extend existing architectures with 64bit variations
of si_utime and si_stime copy_siginfo_to_user and copy_siginfo_to_user32
needs an additional parameter describing which variant they should be
copying.

It looks like posix does not define si_stime and and si_utime so we only
have to be backwards compatible with ourselves for whatever that is
worth.

I am wondering if perhaps the general solution might be to just add
two extra fields si_stime64 and si_utime64 and always fill those in.

Arnd do you have any ideas?


Andy Lutomirski <luto@amacapital.net> writes:

>> On Apr 10, 2018, at 6:26 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>
>> Andy,
>>
>> I am looking at copy_siginfo_to_user32 and find it very unfortunate
>> that x86 with _sigchld_x32 needs to be the odd man out.  I am looking
>> at ways to simplify the special case.
>>
>> The core of the special case comes from:
>> exit_to_usermode_loop
>>  do_signal
>>    handle_signal
>>       setup_rt_frame
>>
>>
>> In setup_rt_frame the code looks at ksig to see which kind of signal
>> frame should be written for the signal.
>>
>> This leads to the one case in the kernel where copy_siginfo_to_user32
>> does not use is_ia32_syscall() or is_x32_syscall() to see which kind of
>> signal frame it needs to create.
>>
>> Andy, since you have been all over the entry point code in recent years
>> do you know if we allow tasks that can do both ia32 and x86_64 system
>> calls?  That seems to be what we the testing of ksig to see which kind
>> of signal frame to setup is all about.
>
> We do :(
>
>> If we don't allow mixed abi's on x86_64 then can I see if I have a ia32
>> task in setup_rt_frame by just calling is_ia32_syscall()?
>>
>> If we do allow mixed abi's do you know if it would be safe to
>> temporarily play with orig_ax or current_thread_info()->status?
>
> Maybe, but it’s a real minefield. I think the right fix is to use
> sa_flags's SA_X32_ABI bit instead for the sigchld bit.  In general,
> the is_..._syscall() helpers can't be expected to return anything
> valid in any context other than a syscall, and handle_signal() is not
> a syscall.
>
>>
>> My goal is to write two wrappers: copy_siginfo_to_user32_ia32, and
>> copy_siginfo_to_user32_x32 around the ordinary copy_siginfo_to_user32.
>> With only a runtime test to see which ABI we need to implement.
>>
>> Aka change:
>>>    case SIL_CHLD:
>>>        to->si_pid    = from->si_pid;
>>>        to->si_uid    = from->si_uid;
>>>        to->si_status = from->si_status;
>>> #ifdef CONFIG_X86_X32_ABI
>>>        if (x32_ABI) {
>>>            to->_sifields._sigchld_x32._utime = from->si_utime;
>>>            to->_sifields._sigchld_x32._stime = from->si_stime;
>>>        } else
>>> #endif
>>>        {
>>>            to->si_utime = from->si_utime;
>>>            to->si_stime = from->si_stime;
>>>        }
>>>        break;
>> to something like:
>>>    case SIL_CHLD:
>>>        to->si_pid    = from->si_pid;
>>>        to->si_uid    = from->si_uid;
>>>        to->si_status = from->si_status;
>>> #ifdef CONFIG_X86_X32_ABI
>>>        if (!is_ia32_syscall()) {
>>>            to->_sifields._sigchld_x32._utime = from->si_utime;
>>>            to->_sifields._sigchld_x32._stime = from->si_stime;
>>>        } else
>>> #endif
>>>        {
>>>            to->si_utime = from->si_utime;
>>>            to->si_stime = from->si_stime;
>>>        }
>>>        break;
>>
>
> Makes sense, but can you get to sa_flags in there instead?

Almost.  copy_siginfo_to_user32 is called in 3 places: setup_rt_frame32
(or whatever the arch names the function for setting up the 32bit signal
 frame), ptrace, and compat_binfmt_elf.
 
So except for ptrace and compat_binfmt_elf sa_flags are available so
that is a possibility.  And for those we can fake something up if
needed.

Stepping back it really looks like the question is really do
we want/need 64bit time in siginfo for 32bit architectures to
make the code y2038 safe?

If so passing an extra parameter to copy_siginfo_to_user32 and
copy_siginfo_to_user is a no-brainer.  If not we are at x86 and
in particular x32 is weird.  So I am asking Arnd above if he
has any idea which way things should evolve.

> FWIW, I have a branch here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=execve
>
> that contains a *massive* cleanup of some other x86 signal stuff.  I
> need to dust it off and test it better.

It looks interesting, and except for the last patch "Drop the separate
compat signal delivery code" looks orthogonal to what I am doing.

What I have seen other architectures do in that last case are instead of
#ifdefs to #define functions to their compat counterparts on 64bit.
Something like:
#define copy_siginfo_to_user copy_siginfo_to_user32

Eric
