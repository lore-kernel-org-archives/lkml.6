Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933735AbeE2MYn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:24:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37623 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933444AbeE2MYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:24:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
References: <20180528215355.16119-1-christian@brauner.io>
        <20180528215355.16119-5-christian@brauner.io>
Date: Tue, 29 May 2018 07:24:26 -0500
In-Reply-To: <20180528215355.16119-5-christian@brauner.io> (Christian
        Brauner's message of "Mon, 28 May 2018 23:53:39 +0200")
Message-ID: <87r2lusl8l.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNdg8-0005bw-16;;;mid=<87r2lusl8l.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YpSCO9aypariz80s0miOhP5/PzKm10mU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 268 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.9%), b_tie_ro: 1.73 (0.6%), parse: 0.87 (0.3%),
        extract_message_metadata: 11 (4.0%), get_uri_detail_list: 1.79 (0.7%),
        tests_pri_-1000: 4.8 (1.8%), tests_pri_-950: 1.22 (0.5%), tests_pri_-900:
        0.97 (0.4%), tests_pri_-400: 23 (8.4%), check_bayes: 22 (8.1%), b_tokenize: 8
        (3.0%), b_tok_get_all: 6 (2.4%), b_comp_prob: 2.1 (0.8%), b_tok_touch_all:
        3.3 (1.2%), b_finish: 0.55 (0.2%), tests_pri_0: 217 (81.0%),
        check_dkim_signature: 0.57 (0.2%), check_dkim_adsp: 2.8 (1.0%),
        tests_pri_500: 4.1 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 04/20] signal: add copy_pending() helper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> Instead of using a goto for this let's add a simple helper copy_pending()
> which can be called in both places.

Ick no.  As far as I can see this just confuses the logic of the
collect_signal function.

Instead of having two cases with an optional
"sigdelset(&list->signal, sig)" if the signal is no longer in the queue,
you are moving the core work of collect_signal into another function.

At the very least this is going to make maintenance more difficult
as now the work of this function is split into two functions.

It most definitely would have made the bug fix to add resched_timer more
difficult.

Eric

> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v0->v1:
> * patch unchanged
> ---
>  kernel/signal.c | 54 +++++++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index bc750fb4ddcc..baae137455eb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -515,6 +515,19 @@ int unhandled_signal(struct task_struct *tsk, int sig)
>  	return !tsk->ptrace;
>  }
>  
> +static void copy_pending(siginfo_t *info, struct sigqueue *first,
> +			 bool *resched_timer)
> +{
> +	list_del_init(&first->list);
> +	copy_siginfo(info, &first->info);
> +
> +	*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
> +			 (info->si_code == SI_TIMER) &&
> +			 (info->si_sys_private);
> +
> +	__sigqueue_free(first);
> +}
> +
>  static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
>  			   bool *resched_timer)
>  {
> @@ -526,8 +539,10 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
>  	*/
>  	list_for_each_entry(q, &list->list, list) {
>  		if (q->info.si_signo == sig) {
> -			if (first)
> -				goto still_pending;
> +			if (first) {
> +				copy_pending(info, first, resched_timer);
> +				return;
> +			}
>  			first = q;
>  		}
>  	}
> @@ -535,29 +550,20 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
>  	sigdelset(&list->signal, sig);
>  
>  	if (first) {
> -still_pending:
> -		list_del_init(&first->list);
> -		copy_siginfo(info, &first->info);
> -
> -		*resched_timer =
> -			(first->flags & SIGQUEUE_PREALLOC) &&
> -			(info->si_code == SI_TIMER) &&
> -			(info->si_sys_private);
> -
> -		__sigqueue_free(first);
> -	} else {
> -		/*
> -		 * Ok, it wasn't in the queue.  This must be
> -		 * a fast-pathed signal or we must have been
> -		 * out of queue space.  So zero out the info.
> -		 */
> -		clear_siginfo(info);
> -		info->si_signo = sig;
> -		info->si_errno = 0;
> -		info->si_code = SI_USER;
> -		info->si_pid = 0;
> -		info->si_uid = 0;
> +		copy_pending(info, first, resched_timer);
> +		return;
>  	}
> +
> +	/*
> +	 * Ok, it wasn't in the queue. This must be a fast-pathed signal or we
> +	 * must have been out of queue space. So zero out the info.
> +	 */
> +	clear_siginfo(info);
> +	info->si_signo = sig;
> +	info->si_errno = 0;
> +	info->si_code = SI_USER;
> +	info->si_pid = 0;
> +	info->si_uid = 0;
>  }
>  
>  static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
