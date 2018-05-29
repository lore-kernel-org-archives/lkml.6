Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeE2M27 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:28:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37967 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933447AbeE2M25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:28:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
References: <20180528215355.16119-1-christian@brauner.io>
        <20180528215355.16119-6-christian@brauner.io>
Date: Tue, 29 May 2018 07:28:27 -0500
In-Reply-To: <20180528215355.16119-6-christian@brauner.io> (Christian
        Brauner's message of "Mon, 28 May 2018 23:53:40 +0200")
Message-ID: <87fu2asl1w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNdk0-00065g-Qw;;;mid=<87fu2asl1w.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rWL+cBIzAE70U9HA23cemha2vHPXwRAo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.2 (0.0%), parse: 0.99 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.15 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.13 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.81 (0.0%), b_tok_touch_all:
        3.6 (0.0%), b_finish: 0.65 (0.0%), tests_pri_0: 141 (0.9%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14837 (98.8%), poll_dns_idle: 14829 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v1 05/20] signal: flatten do_send_sig_info()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> Let's return early when lock_task_sighand() fails and move send_signal()
> and unlock_task_sighand() out of the if block.

Introducing multiple exits into a function.  Ick.
You do know that is what Dijkstra was arguing against in his paper
"Goto Considered Harmful"

That introduces mutiple exits and makes the function harder to analyze.
It is especially a pain as I have something in my queue that will
shuffle things around and remove the possibility of lock_task_sighand
failing.

Eric

> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> * patch unchanged
> ---
>  kernel/signal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index baae137455eb..a628b56415e6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1167,16 +1167,16 @@ specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
>  }
>  
>  int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
> -			bool group)
> +		     bool group)
>  {
>  	unsigned long flags;
>  	int ret = -ESRCH;
>  
> -	if (lock_task_sighand(p, &flags)) {
> -		ret = send_signal(sig, info, p, group);
> -		unlock_task_sighand(p, &flags);
> -	}
> +	if (!lock_task_sighand(p, &flags))
> +		return ret;
>  
> +	ret = send_signal(sig, info, p, group);
> +	unlock_task_sighand(p, &flags);
>  	return ret;
>  }
