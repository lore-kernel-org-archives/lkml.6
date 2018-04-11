Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeDKWFc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 18:05:32 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46744 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeDKWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 18:05:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <87d0z6ttxe.fsf@xmission.com>
        <CALCETrVR1qHCndoaqXWosy8ckMTyT2RequQTgg0MZUw_sMPwwQ@mail.gmail.com>
        <87bmepn2o8.fsf_-_@xmission.com>
        <CAK8P3a2HaYDOnWYb5cagJeHKmeoWAz1MGzGfGwbeymEqDpvWzw@mail.gmail.com>
Date: Wed, 11 Apr 2018 17:03:58 -0500
In-Reply-To: <CAK8P3a2HaYDOnWYb5cagJeHKmeoWAz1MGzGfGwbeymEqDpvWzw@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 11 Apr 2018 22:13:52 +0200")
Message-ID: <87r2nlh035.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6Nrd-0001Ma-T7;;;mid=<87r2nlh035.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zI31jUMWUs0YMkjMulMt7jIFsQa2Skd8=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15026 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.78 (0.0%), parse: 0.85 (0.0%),
        extract_message_metadata: 14 (0.1%), get_uri_detail_list: 3.0 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.19 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 28 (0.2%), check_bayes: 27 (0.2%), b_tokenize:
        10 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 3.2 (0.0%), b_tok_touch_all:
        2.6 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 278 (1.9%),
        check_dkim_signature: 0.52 (0.0%), check_dkim_adsp: 4.6 (0.0%),
        tests_pri_500: 14695 (97.8%), poll_dns_idle: 14685 (97.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: Q: Do si_time and si_utime need to be 64bit for y2038?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Apr 11, 2018 at 6:11 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Arnd,
>>
>> I am looking at the siginfo si_utime and si_stime fields of type clock_t
>> on 32bit architectures except for x32 these are 32bit fields.  For y2038
>> do we want to extend these fields to 64bit like x32 does?  Or is it not
>> a problem for these fields to be 32bit?
>
> Short answer: I think we're fine without changing it, at least for y2038.
Short acknowledgement: I am going to assume this isn't a generic
32bit/64bit problem that merits a general solution.

>> I care right now because I am trying to figure out how
>> copy_siginfo_to_user32 and copy_siginfo_to_user need to evolve.
>>
>> If we are going to extend existing architectures with 64bit variations
>> of si_utime and si_stime copy_siginfo_to_user and copy_siginfo_to_user32
>> needs an additional parameter describing which variant they should be
>> copying.
>>
>> It looks like posix does not define si_stime and and si_utime so we only
>> have to be backwards compatible with ourselves for whatever that is
>> worth.
>>
>> I am wondering if perhaps the general solution might be to just add
>> two extra fields si_stime64 and si_utime64 and always fill those in.
>>
>> Arnd do you have any ideas?
>
> There are generally four areas to be aware of with the data structure
> changes required for y2038:
>
> 1. Stuff that overflows in the next few decades (either 2038 or some other
>     year). si_utime/si_stime counts relative times, so there is no overflow
>     happening at a particular date that we have to be aware of. However,
>     it does overflow when a 32-bit process runs for more than
>     (LONG_MAX / USER_HZ) seconds, which is about 248 days.
>     When you have a large SMP system with 256 CPUs and run a single
>     task across all of them, the overflow happens within one day of runtime.
>     This is a rare use case for 32-bit tasks, but it is an actual limitation
>     that we may want to fix regardless of the y2038 changes.
>
> 2. Types that don't overflow in a particular interface (because they count
>     relative times) but do overflow in others. We have a problem in
>     wait4()/waidid() and getrusage() here, since those use 'struct timeval'
>     to count process times. Those can count up to 68 years of process
>     times (97 days on a 256-core machine running one task), so we
>     probably don't care about the overflow, but POSIX requires the
>     use of timeval [1] and we have to redefine that structure with an
>     incompatible layout.
>     We do have a choice between either keeping the existing structure
>     and letting the libc translate the 32-bit time_t to a 64-bit time_t,
>     or adding replacement syscalls for both getrusage() and waitid().
>     IIRC we don't need a new wait4(), since that can be implemented
>     using waitid.
>     clock_t is used in exactly two places: struct siginfo and struct tms,
>     so if we change one of the two, we also have to change the other.

Good point.

> 3. In some cases, two structures are almost identical between 32-bit
>     and 64-bit architectures. Using the exact same layout simplifies the
>     compat syscall handling. I think in x32, this was a factor as it means
>     that e.g. times() is shared between x32 and x86-64.

Sort of.  You can get to the ordinary times system call but the x32
system call table has a pointer to compat_times that uses defines
compat_clock_t to be an s32.  Meanwhile x32 makes uses
__kernel_si_clock_t in struct siginfo which is defined as long long.

I don't have a clue what x32 libcs do with that combination.

> 4. If we change an interface, we may want to improve it in more than
>    one way, like we did with stat()->stat64()->statx() or time()->
>    gettimeofday()->clock_gettime()->clock_gettime64().
>    If we introduce a larger range for the 32-bit siginfo and tms
>    structures, we could also consider extending the resolution to
>    nanoseconds. I wouldn't follow rusage's timeval but use
>    timespec64 (__kernel_timespec as seen from user space).
>    64-bit nanoseconds are another option, but that again
>    overflows after 584 CPU-years or 52 days on a 4096-core
>    system.

Enhancing the interface makes sense.

Playing around with debian's code search it does not look like anything
really uses si_utime and si_stime from struct siginfo except for
libraries that make the values accessible to other layers.

QT looks does something with them from the return of waitid but the
kernel does not populate those fields for waitid.  So bug.

I suspect the best enhancement would be to simply deprecate the use of
si_stime si_utime, probably by always setting them to 0.

times() on the other hand is used quite widely.  So it still may be
worth enhancing that side of the interface for 32bit processes someday.
Although it sounds like the truly problematic cases are all on 64bit
machines so we may not care.

Eric
