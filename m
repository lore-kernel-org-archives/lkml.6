Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030868AbeEXQZZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:25:25 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42806 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030515AbeEXQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:25:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20180524143629.2ofsg7mhjixr5pnm@linutronix.de>
Date: Thu, 24 May 2018 11:25:14 -0500
In-Reply-To: <20180524143629.2ofsg7mhjixr5pnm@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 24 May 2018 16:36:30 +0200")
Message-ID: <87wovt3tsl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLt3K-0002PY-Ca;;;mid=<87wovt3tsl.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18qznuTPF2Iig+MAodK9IxCtuaN7FliHLY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 301 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.2 (1.1%), b_tie_ro: 2.2 (0.7%), parse: 1.32 (0.4%),
        extract_message_metadata: 21 (7.0%), get_uri_detail_list: 2.4 (0.8%),
        tests_pri_-1000: 11 (3.8%), tests_pri_-950: 1.68 (0.6%), tests_pri_-900: 1.33
        (0.4%), tests_pri_-400: 22 (7.3%), check_bayes: 21 (6.9%), b_tokenize: 8
        (2.6%), b_tok_get_all: 6 (1.9%), b_comp_prob: 2.4 (0.8%), b_tok_touch_all:
        2.7 (0.9%), b_finish: 0.72 (0.2%), tests_pri_0: 232 (76.9%),
        check_dkim_signature: 0.60 (0.2%), check_dkim_adsp: 3.3 (1.1%),
        tests_pri_500: 3.5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Revert ptrace preempt magic
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Upstream commit '53da1d9456fe7f8 fix ptrace slowness' is nothing more
> than a bandaid around the ptrace design trainwreck. It's not a
> correctness issue, it's merily a cosmetic bandaid.

This patch comes with no justification or reason to remove the
``cosmetic bandaid''.  The description in 53da1d9456fe ("fix ptrace
slowness") is quite persuasive that there is a real world issue.

So while this may be a good idea to remove this.  I don't see any
description of testing to indicate this won't cause uml to regresssion.
Nor do I see any compelling reason except code tidiness to remove this.

As such until adequate descriptions can be provideded.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/signal.c |    8 --------
>  1 file changed, 8 deletions(-)
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1876,15 +1876,7 @@ static void ptrace_stop(int exit_code, i
>  		if (gstop_done && ptrace_reparented(current))
>  			do_notify_parent_cldstop(current, false, why);
>  
> -		/*
> -		 * Don't want to allow preemption here, because
> -		 * sys_ptrace() needs this task to be inactive.
> -		 *
> -		 * XXX: implement read_unlock_no_resched().
> -		 */
> -		preempt_disable();
>  		read_unlock(&tasklist_lock);
> -		preempt_enable_no_resched();
>  		freezable_schedule();
>  	} else {
>  		/*
