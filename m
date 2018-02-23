Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754998AbeBWUNV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:13:21 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33965 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbeBWUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:13:17 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20180219202826.19797-1-bp@alien8.de>
        <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
        <20180220192956.si2a6m3ckskexvte@treble>
        <20180220204435.GC24320@pd.tnic>
        <20180221091553.gxnvhbitiewo2mjc@gmail.com>
        <20180221175429.GC9989@pd.tnic>
        <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
        <20180222092327.GM25201@hirez.programming.kicks-ass.net>
        <CA+55aFxYNT-qPRk82xCApZrkBt6i4m=nOAfxmaLW-O6wgq1LTA@mail.gmail.com>
        <20180223152204.434g7mrvi6hjmmka@treble>
Date: Fri, 23 Feb 2018 14:12:46 -0600
In-Reply-To: <20180223152204.434g7mrvi6hjmmka@treble> (Josh Poimboeuf's
        message of "Fri, 23 Feb 2018 09:22:04 -0600")
Message-ID: <87woz331oh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1epJiU-0000nG-R4;;;mid=<87woz331oh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xpv4Th3ZPwwM4S2Mf2Wwpp/XvmsVWuOU=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Josh Poimboeuf <jpoimboe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 293 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.6 (1.2%), b_tie_ro: 2.5 (0.8%), parse: 1.11 (0.4%),
        extract_message_metadata: 5 (1.7%), get_uri_detail_list: 2.9 (1.0%),
        tests_pri_-1000: 5 (1.7%), tests_pri_-950: 1.47 (0.5%), tests_pri_-900: 1.28
        (0.4%), tests_pri_-400: 30 (10.3%), check_bayes: 29 (9.8%), b_tokenize: 10
        (3.5%), b_tok_get_all: 9 (3.2%), b_comp_prob: 3.7 (1.3%), b_tok_touch_all:
        2.7 (0.9%), b_finish: 0.69 (0.2%), tests_pri_0: 228 (77.6%),
        check_dkim_signature: 0.64 (0.2%), check_dkim_adsp: 2.9 (1.0%),
        tests_pri_500: 8 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code: section
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> On Thu, Feb 22, 2018 at 10:42:52AM -0800, Linus Torvalds wrote:
>> So what we could perhaps do is:
>> 
>>  - make console_verbose() actually reset things to at least LOGLEVEL_DEBUG
>> 
>>  - make sure the *default* loglevel  be LOGLEVEL_WARNING
>> 
>>  - now you can use pr_debug() in the oops code to print messages to
>> the log, but they won't be printed to the screen.
>> 
>> And people who really want everything can still set a loglevel that is
>> much higher, because "console_verbose" would only do that "at least"
>> thing.
>> 
>> That would seem like the best of both worlds, no?
>
> Maybe.
>
> Broadly speaking, I think our goal should be, in the worst case, to try
> to ensure that the essential data is captured.
>
> But the definitions of "worst case" and "essential data" can vary a lot,
> depending on both the user's setup and the nature of the bug.  We're not
> going to be able to get it right 100% of the time.
>
> You're assuming the worst case of
>
>   "an 80x25 screen is the only interface to the console".
>
> But there's another worst case of
>
>   "we had unlimited serial port logging, but didn't dump enough data".
>
> With your proposal, the latter might instead become:
>
>   "we had unlimited serial port logging, but didn't dump enough data
>    because the default loglevel was too low."
>
> I did a little analysis of panics reported on lkml via .jpg files
> (either attached or in a URL).  In the last two years I only found 11
> such reports.  (And only two of them were 25x80, the rest were at least
> 47 rows.)
>
> On the other hand, I found a *ton* of panics which were copy/pasted.  It
> was way too many to count, but a rough guess is about one per day.
>
> So ~1.5% of bugs are reported via cell phone camera (with only about
> 5-10% of *those* on a tiny 25x80 screen, with the rest having at least
> 47 rows).
>
> It's not very scientific, but it gives a general idea, I think.  The
> cell phone camera thing has become a pretty rare way to report bugs, and
> with the proliferation of virtualization and automated testing I would
> expect that trend to continue.
>
> So my worry with your proposal is that many (or most?) people won't
> change their default log level to DEBUG, and then all these nice
> additional bits of data we're adding won't ever get printed, making
> debug harder for the ~98.5% case of sane serial port logging.
>
> But then again, I don't have any better ideas...

Please also note there are serial ports and there are serials ports.
There are serial ports on virtual machines that don't have a speed.
Then there are serial ports on physical hardware some at 9600 baud,
and in all cases they are slow.  So on a physical serial port tersness
is a virtue (unless the machine is completely dead).

Then we have panics and the like that are reported by kdump.  Those
should be cut and pastable as well.  But require that someone has done
the work to set that up so that is a reliable path.

I know that in working on kexec-on-panic what I have found is the less
code in a critical path you have to run in a b0rken kernel the higher
your chance of that code running successfully.  I expect that applies
to the panic printer as much as anything else.

Eric
