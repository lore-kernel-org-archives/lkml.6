Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDXPaK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:30:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50532 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDXPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:30:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        albert@sifive.com, linux-riscv@lists.infradead.org
References: <mhng-77d5b15b-866b-464a-a256-6c7b84726ce3@palmer-si-x1c4>
Date: Tue, 24 Apr 2018 10:28:39 -0500
In-Reply-To: <mhng-77d5b15b-866b-464a-a256-6c7b84726ce3@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Mon, 23 Apr 2018 12:11:23 -0700 (PDT)")
Message-ID: <87r2n4ei8o.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fAztM-0004fF-3Z;;;mid=<87r2n4ei8o.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TF6d5vcevz9g4XF/hyxGqgTDwSP4/TyM=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Palmer Dabbelt <palmer@sifive.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 215 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (1.1%), b_tie_ro: 1.66 (0.8%), parse: 0.70 (0.3%),
        extract_message_metadata: 15 (7.0%), get_uri_detail_list: 1.72 (0.8%),
        tests_pri_-1000: 9 (4.1%), tests_pri_-950: 1.25 (0.6%), tests_pri_-900: 0.97
        (0.5%), tests_pri_-400: 22 (10.4%), check_bayes: 21 (9.9%), b_tokenize: 6
        (3.0%), b_tok_get_all: 7 (3.0%), b_comp_prob: 2.1 (1.0%), b_tok_touch_all:
        2.7 (1.3%), b_finish: 0.57 (0.3%), tests_pri_0: 157 (72.9%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 2.5 (1.2%),
        tests_pri_500: 4.0 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 14/22] signal/riscv: Use force_sig_fault where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> writes:

> On Fri, 20 Apr 2018 07:38:03 PDT (-0700), ebiederm@xmission.com wrote:
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
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Albert Ou <albert@sifive.com>
>> Cc: linux-riscv@lists.infradead.org
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/riscv/kernel/traps.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 48aa6471cede..3087940008f4 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -66,14 +66,7 @@ void die(struct pt_regs *regs, const char *str)
>>  static inline void do_trap_siginfo(int signo, int code,
>>  	unsigned long addr, struct task_struct *tsk)
>>  {
>> -	siginfo_t info;
>> -
>> -	clear_siginfo(&info);
>> -	info.si_signo = signo;
>> -	info.si_errno = 0;
>> -	info.si_code = code;
>> -	info.si_addr = (void __user *)addr;
>> -	force_sig_info(signo, &info, tsk);
>> +	force_sig_fault(signo, code, (void __user *)addr, tsk);
>>  }
>>
>>  void do_trap(struct pt_regs *regs, int signo, int code,
>
> If I understand this correctly, any change in behavior this causes would have
> been a bug on our end not filling out siginfo correctly?  In that case then feel
> free to add an

If this change above causes any user visible changes it is a bug.
As Christoph rightly pointed out force_sig_fault is simply the arch
generic version of do_trap_siginfo. 

Eric
