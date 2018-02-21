Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBUVAl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:00:41 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48270 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeBUU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:59:39 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com,
        anthony.yznaga@oracle.com, rob.gardner@oracle.com, mingo@kernel.org,
        jane.chu@oracle.com, vegard.nossum@oracle.com,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
        <cover.1519227112.git.khalid.aziz@oracle.com>
        <15cfb4f72990919ff6fa16414eee7e4d1a5c7430.1519227112.git.khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 14:59:11 -0600
In-Reply-To: <15cfb4f72990919ff6fa16414eee7e4d1a5c7430.1519227112.git.khalid.aziz@oracle.com>
        (Khalid Aziz's message of "Wed, 21 Feb 2018 10:15:53 -0700")
Message-ID: <87zi42dppc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eobUI-0002Nk-7q;;;mid=<87zi42dppc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1l1XZbfK2lTVhRfxUSrQwBXpF9NlAouQ=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Khalid Aziz <khalid.aziz@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 315 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (0.8%), b_tie_ro: 1.70 (0.5%), parse: 0.94 (0.3%),
        extract_message_metadata: 18 (5.6%), get_uri_detail_list: 2.5 (0.8%),
        tests_pri_-1000: 9 (2.8%), tests_pri_-950: 1.19 (0.4%), tests_pri_-900: 1.04
        (0.3%), tests_pri_-400: 26 (8.1%), check_bayes: 24 (7.8%), b_tokenize: 10
        (3.0%), b_tok_get_all: 7 (2.3%), b_comp_prob: 2.1 (0.7%), b_tok_touch_all:
        3.9 (1.2%), b_finish: 0.62 (0.2%), tests_pri_0: 250 (79.4%),
        check_dkim_signature: 0.53 (0.2%), check_dkim_adsp: 2.5 (0.8%),
        tests_pri_500: 4.5 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v12 11/11] sparc64: Update signal delivery to use new helper functions
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> Commit f8ec66014ffd ("signal: Add send_sig_fault and force_sig_fault")
> added new helper functions to streamline signal delivery. This patch
> updates signal delivery for new/updated handlers for ADI related
> exceptions to use the helper function.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
> v12:
> 	- new patch
>
>  arch/sparc/kernel/traps_64.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
> index f36a40217f6c..462a21abd105 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> @@ -362,7 +362,6 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
>  {
>  	unsigned short type = (type_ctx >> 16);
>  	unsigned short ctx  = (type_ctx & 0xffff);
> -	siginfo_t info;
>  
>  	if (notify_die(DIE_TRAP, "data access exception", regs,
>  		       0, 0x8, SIGTRAP) == NOTIFY_STOP)
> @@ -406,24 +405,18 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
>  	 * kerbel by HV as data access exception with fault type set to
>  	 * HV_FAULT_TYPE_INV_ASI.
>  	 */
> -	info.si_errno = 0;
> -	info.si_addr = (void __user *) addr;
> -	info.si_trapno = 0;
>  	switch (type) {
>  	case HV_FAULT_TYPE_INV_ASI:
> -		info.si_signo = SIGILL;
> -		info.si_code = ILL_ILLADR;
> -		force_sig_info(SIGILL, &info, current);
> +		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0,
> +				current);
>  		break;
>  	case HV_FAULT_TYPE_MCD_DIS:
> -		info.si_signo = SIGSEGV;
> -		info.si_code = SEGV_ACCADI;
> -		force_sig_info(SIGSEGV, &info, current);
> +		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0,
> +				current);
>  		break;
>  	default:
> -		info.si_signo = SIGSEGV;
> -		info.si_code = SEGV_MAPERR;
> -		force_sig_info(SIGSEGV, &info, current);
> +		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0,
> +				current);
>  		break;
>  	}
>  }
> @@ -2073,8 +2066,6 @@ static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
>   */
>  void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
>  {
> -	siginfo_t info;
> -
>  	if (notify_die(DIE_TRAP, "MCD error", regs, 0, 0x34,
>  		       SIGSEGV) == NOTIFY_STOP)
>  		return;
> @@ -2110,12 +2101,8 @@ void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
>  	/* Send SIGSEGV to the userspace process with the right signal
>  	 * code
>  	 */
> -	info.si_signo = SIGSEGV;
> -	info.si_errno = 0;
> -	info.si_code = SEGV_ADIDERR;
> -	info.si_addr = (void __user *)ent.err_raddr;
> -	info.si_trapno = 0;
> -	force_sig_info(SIGSEGV, &info, current);
> +	force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr,
> +			0, current);
>  }
>  
>  /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
> @@ -2748,8 +2735,6 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
>  void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
>  				      unsigned long context)
>  {
> -	siginfo_t info;
> -
>  	if (notify_die(DIE_TRAP, "memory corruption precise exception", regs,
>  		       0, 0x8, SIGSEGV) == NOTIFY_STOP)
>  		return;
> @@ -2784,12 +2769,7 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
>  		regs->tpc &= 0xffffffff;
>  		regs->tnpc &= 0xffffffff;
>  	}
> -	info.si_signo = SIGSEGV;
> -	info.si_code = SEGV_ADIPERR;
> -	info.si_errno = 0;
> -	info.si_addr = (void __user *) addr;
> -	info.si_trapno = 0;
> -	force_sig_info(SIGSEGV, &info, current);
> +	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0, current);
>  }
>  
>  void do_privop(struct pt_regs *regs)
