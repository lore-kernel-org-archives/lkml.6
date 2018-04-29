Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeD2Eqj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 00:46:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53907 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeD2Eqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 00:46:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
        <20180428091823.h3iajtxkqdwdcpst@gmail.com>
        <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
        <20180428175043.y35czmhcursyrzsy@gmail.com>
Date: Sat, 28 Apr 2018 23:46:06 -0500
In-Reply-To: <20180428175043.y35czmhcursyrzsy@gmail.com> (Ingo Molnar's
        message of "Sat, 28 Apr 2018 19:50:43 +0200")
Message-ID: <87muxmboxd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fCeDy-0008Mm-OS;;;mid=<87muxmboxd.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+WBleNzYwqgS1BRd+R0FI4W+rgS+6nA6M=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15027 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.6 (0.0%), b_tie_ro: 2.5 (0.0%), parse: 1.12 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 2.1 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.24 (0.0%), tests_pri_-900:
        1.06 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.2 (0.0%), b_tok_touch_all:
        2.8 (0.0%), b_finish: 0.66 (0.0%), tests_pri_0: 152 (1.0%),
        check_dkim_signature: 0.62 (0.0%), check_dkim_adsp: 2.7 (0.0%),
        tests_pri_500: 14828 (98.7%), poll_dns_idle: 14820 (98.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFD] x86: The future of MPX
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Sat, Apr 28, 2018 at 2:18 AM Ingo Molnar <mingo@kernel.org> wrote:
>> 
>> > I just tried the MPX testcases with the latest kernel:
>> 
>> >   deimos:~/tip/tools/testing/selftests/x86> ./mpx-mini-test_64
>> 
>> They need to be run as root. They try to access
>> 
>>      /sys/kernel/debug/tracing/set_ftrace_pid
>>      /sys/kernel/debug/tracing/trace
>> 
>> and that's root-only.
>
> Indeed - but note that they are crashing as root as well here:
>
>   root@deimos:/home/mingo/tip/tools/testing/selftests/x86# ./mpx-mini-test_64 
>   [...]
>   Aborted (core dumped)
>
> ... because I don't even have /sys/kernel/debug/tracing/set_ftrace_pid... :-/
>
> That's despite having ftrace enabled.
>
> After some digging I found out that 'set_ftrace_pid' is dependent on 
> CONFIG_FUNCTION_TRACING=y (not just CONFIG_TRACING=y), which I didn't
> have enabled on this kernel.
>
> After enabling it I got the 64-bit testcase to work:
>
>   #
>   ...
>   ./mpx-mini-test_64 completed successfully
>
> But the 32-bit testcase is erroring out:
>
>   root@deimos:/home/mingo/tip/tools/testing/selftests/x86# ./mpx-mini-test_32 
>   XSAVE is supported by HW & OS
>   XSAVE processor supported state mask: 0x21f
>   XSAVE OS supported state mask: 0x21f
>    BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
>     BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
>   executing unmaptest
>   mpx dig (  1) complete, SUCCESS (       0 /    0)
>   #BR status == 2, missing bounds table,kernel should have handled!!
>
> v4.17-rc2 based kernel, so it should have the latest MPX code.

If you remove this which tree will this be going into?

I have some refactoring and cleanups of the x86 siginfo code I am
hoping to get in later this development cycle and part of that was
refactoring the mpx code so it works more like everything else.

If the codes away I can just that part of the patchset.

Eric
