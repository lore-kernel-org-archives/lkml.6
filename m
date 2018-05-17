Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQBNa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:13:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39234 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeEQBNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:13:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Guenter Roeck <linux@roeck-us.net>
Cc: James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
References: <1526392247-25512-1-git-send-email-linux@roeck-us.net>
Date: Wed, 16 May 2018 20:13:10 -0500
In-Reply-To: <1526392247-25512-1-git-send-email-linux@roeck-us.net> (Guenter
        Roeck's message of "Tue, 15 May 2018 06:50:47 -0700")
Message-ID: <87k1s3jd95.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fJ7Tm-0000B8-G1;;;mid=<87k1s3jd95.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kcZIzeD/4OcMXj+PT8Qy42j9/8VCBv0k=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3966]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Guenter Roeck <linux@roeck-us.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 175 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (1.9%), b_tie_ro: 2.3 (1.3%), parse: 0.96 (0.5%),
        extract_message_metadata: 17 (9.8%), get_uri_detail_list: 1.45 (0.8%),
        tests_pri_-1000: 7 (4.2%), tests_pri_-950: 1.17 (0.7%), tests_pri_-900: 0.96
        (0.5%), tests_pri_-400: 17 (9.7%), check_bayes: 16 (9.2%), b_tokenize: 5
        (3.0%), b_tok_get_all: 5 (3.0%), b_comp_prob: 1.56 (0.9%), b_tok_touch_all:
        2.2 (1.3%), b_finish: 0.59 (0.3%), tests_pri_0: 119 (67.8%),
        check_dkim_signature: 0.48 (0.3%), check_dkim_adsp: 2.4 (1.4%),
        tests_pri_500: 6 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> Most mips builds fail with
>
> arch/mips/kernel/traps.c: In function ‘force_fcr31_sig’:
> arch/mips/kernel/traps.c:732:2: error:
> 	‘si_code’ may be used uninitialized in this function
>
> Fix the problem by initializing si_code with FPE_FLTUNK (undiagnosed
> floating point exception).
>
> Fixes: f43a54a0d916 ("signal/mips: Use force_sig_fault where appropriate")
> Cc: linux-mips@linux-mips.org
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.  Thank you.

Eric

> ---
> Feel free to merge into the patch introducing the problem.
>
>  arch/mips/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 66ec4b0b484d..d67fa74622ee 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -716,7 +716,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
>  void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>  		     struct task_struct *tsk)
>  {
> -	int si_code;
> +	int si_code = FPE_FLTUNK;
>  
>  	if (fcr31 & FPU_CSR_INV_X)
>  		si_code = FPE_FLTINV;
