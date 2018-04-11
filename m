Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDKB1i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:27:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46698 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDKB1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:27:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 20:26:21 -0500
Message-ID: <87d0z6ttxe.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f64Xv-0007w0-7I;;;mid=<87d0z6ttxe.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185UVL1FyLwIesn2KX7xu4snBNssnS2/Uw=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1910]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andy Lutomirski <luto@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 175 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.5%), b_tie_ro: 1.88 (1.1%), parse: 0.75 (0.4%),
        extract_message_metadata: 2.8 (1.6%), get_uri_detail_list: 1.28 (0.7%),
        tests_pri_-1000: 3.6 (2.0%), tests_pri_-950: 1.14 (0.7%), tests_pri_-900:
        0.89 (0.5%), tests_pri_-400: 16 (9.1%), check_bayes: 15 (8.6%), b_tokenize: 5
        (2.9%), b_tok_get_all: 4.9 (2.8%), b_comp_prob: 1.60 (0.9%), b_tok_touch_all:
        1.82 (1.0%), b_finish: 0.58 (0.3%), tests_pri_0: 130 (74.6%),
        check_dkim_signature: 0.53 (0.3%), check_dkim_adsp: 3.3 (1.9%),
        tests_pri_500: 9 (5.1%), rewrite_mail: 0.00 (0.0%)
Subject: Q: Can we get rid of __copy_siginfo_to_user32?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy,

I am looking at copy_siginfo_to_user32 and find it very unfortunate
that x86 with _sigchld_x32 needs to be the odd man out.  I am looking
at ways to simplify the special case.

The core of the special case comes from:
exit_to_usermode_loop
  do_signal
    handle_signal
       setup_rt_frame


In setup_rt_frame the code looks at ksig to see which kind of signal
frame should be written for the signal.

This leads to the one case in the kernel where copy_siginfo_to_user32
does not use is_ia32_syscall() or is_x32_syscall() to see which kind of
signal frame it needs to create.

Andy, since you have been all over the entry point code in recent years
do you know if we allow tasks that can do both ia32 and x86_64 system
calls?  That seems to be what we the testing of ksig to see which kind
of signal frame to setup is all about.

If we don't allow mixed abi's on x86_64 then can I see if I have a ia32
task in setup_rt_frame by just calling is_ia32_syscall()?

If we do allow mixed abi's do you know if it would be safe to
temporarily play with orig_ax or current_thread_info()->status?

My goal is to write two wrappers: copy_siginfo_to_user32_ia32, and
copy_siginfo_to_user32_x32 around the ordinary copy_siginfo_to_user32.
With only a runtime test to see which ABI we need to implement.

Aka change:
> 	case SIL_CHLD:
> 		to->si_pid    = from->si_pid;
> 		to->si_uid    = from->si_uid;
> 		to->si_status = from->si_status;
> #ifdef CONFIG_X86_X32_ABI
> 		if (x32_ABI) {
> 			to->_sifields._sigchld_x32._utime = from->si_utime;
> 			to->_sifields._sigchld_x32._stime = from->si_stime;
> 		} else
> #endif
> 		{
> 			to->si_utime = from->si_utime;
> 			to->si_stime = from->si_stime;
> 		}
> 		break;
to something like:                
> 	case SIL_CHLD:
> 		to->si_pid    = from->si_pid;
> 		to->si_uid    = from->si_uid;
> 		to->si_status = from->si_status;
> #ifdef CONFIG_X86_X32_ABI
> 		if (!is_ia32_syscall()) {
> 			to->_sifields._sigchld_x32._utime = from->si_utime;
> 			to->_sifields._sigchld_x32._stime = from->si_stime;
> 		} else
> #endif
> 		{
> 			to->si_utime = from->si_utime;
> 			to->si_stime = from->si_stime;
> 		}
> 		break;

I just don't understand the introdcacies of the ia32 and x32 emulation
to really guess which test I need to substitute in there.  So any help
or ideas would really be appreciated.

Eric
