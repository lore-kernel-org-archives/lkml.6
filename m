Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755784AbeDYP6y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:58:54 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38822 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbeDYP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:58:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Vincent Chen <deanbo422@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-9-ebiederm@xmission.com>
        <CAJsyPhy_GbfnzCNa_rJDMSRrUfVKOJKCVqrkWkDUmH6jPDGPhw@mail.gmail.com>
Date: Wed, 25 Apr 2018 10:57:22 -0500
In-Reply-To: <CAJsyPhy_GbfnzCNa_rJDMSRrUfVKOJKCVqrkWkDUmH6jPDGPhw@mail.gmail.com>
        (Vincent Chen's message of "Wed, 25 Apr 2018 19:29:34 +0800")
Message-ID: <87wowvuvml.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBMoh-0001hu-A0;;;mid=<87wowvuvml.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+fLW+msX5mTyw3kDXLhHn3tKBMtRUkoKk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Vincent Chen <deanbo422@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 263 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 5.0 (1.9%), b_tie_ro: 2.4 (0.9%), parse: 1.32 (0.5%),
        extract_message_metadata: 16 (6.1%), get_uri_detail_list: 3.1 (1.2%),
        tests_pri_-1000: 8 (3.0%), tests_pri_-950: 1.66 (0.6%), tests_pri_-900: 1.29
        (0.5%), tests_pri_-400: 26 (10.0%), check_bayes: 25 (9.5%), b_tokenize: 10
        (3.8%), b_tok_get_all: 7 (2.7%), b_comp_prob: 3.0 (1.1%), b_tok_touch_all:
        2.8 (1.1%), b_finish: 0.63 (0.2%), tests_pri_0: 192 (73.0%),
        check_dkim_signature: 0.60 (0.2%), check_dkim_adsp: 8 (2.9%), tests_pri_500:
        7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 09/22] signal/nds32: Use force_sig_fault where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Chen <deanbo422@gmail.com> writes:

> 2018-04-20 22:37 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
>> Filling in struct siginfo before calling force_sig_info a tedious and
>> error prone process, where once in a great while the wrong fields
>> are filled out, and siginfo has been inconsistently cleared.
>>
>> Simplify this process by using the helper force_sig_fault.  Which
>> takes as a parameters all of the information it needs, ensures
>> all of the fiddly bits of filling in struct siginfo are done properly
>> and then calls force_sig_info.
>>
>> In short about a 5 line reduction in code for every time force_sig_info
>> is called, which makes the calling function clearer.
>>
>> Cc: Greentime Hu <green.hu@gmail.com>
>> Cc: Vincent Chen <deanbo422@gmail.com>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/nds32/kernel/traps.c | 20 ++++----------------
>>  arch/nds32/mm/fault.c     | 19 +++++--------------
>>  2 files changed, 9 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
>> index 46911768f4b5..636d1c7aa895 100644
>> --- a/arch/nds32/kernel/traps.c
>> +++ b/arch/nds32/kernel/traps.c
>> @@ -222,20 +222,13 @@ void die_if_kernel(const char *str, struct pt_regs *regs, int err)
>>
>>  int bad_syscall(int n, struct pt_regs *regs)
>>  {
>> -       siginfo_t info;
>> -
>>         if (current->personality != PER_LINUX) {
>>                 send_sig(SIGSEGV, current, 1);
>>                 return regs->uregs[0];
>>         }
>>
>> -       clear_siginfo(&info);
>> -       info.si_signo = SIGILL;
>> -       info.si_errno = 0;
>> -       info.si_code = ILL_ILLTRP;
>> -       info.si_addr = (void __user *)instruction_pointer(regs) - 4;
>> -
>> -       force_sig_info(SIGILL, &info, current);
>> +       force_sig_fault(SIGILL, ILL_ILLTRP,
>> +                       (void __user *)instruction_pointer(regs) - 4, current);
>>         die_if_kernel("Oops - bad syscall", regs, n);
>>         return regs->uregs[0];
>>  }
>> @@ -288,16 +281,11 @@ void __init early_trap_init(void)
>>  void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>>                   int error_code, int si_code)
>>  {
>> -       struct siginfo info;
>> -
>>         tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
>>         tsk->thread.error_code = error_code;
>>
>> -       clear_siginfo(&info);
>> -       info.si_signo = SIGTRAP;
>> -       info.si_code = si_code;
>> -       info.si_addr = (void __user *)instruction_pointer(regs);
>> -       force_sig_info(SIGTRAP, &info, tsk);
>> +       force_sig_fault(SIGTRAP, si_code
>> +                       (void __user *)instruction_pointer(regs), tsk);
>>  }
>>
>
> I found a comma is missing after argument si_code.

Good catch.  Fixed.

Unfortunately the only compiler I have for nds32 is my eyeballs so
this slipped through.  Grr.


> Except the missing comma in send_sigtrap(), I think this patch for nds32 is OK.
>

I have corrected the change as you suggested and have added your Acked
by.

Eric
