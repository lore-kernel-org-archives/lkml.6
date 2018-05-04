Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDQ7T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:59:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50919 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeEDQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:59:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de>
Date: Fri, 04 May 2018 11:59:08 -0500
In-Reply-To: <20180504144014.5378-1-bigeasy@linutronix.de> (Sebastian Andrzej
        Siewior's message of "Fri, 4 May 2018 16:40:14 +0200")
Message-ID: <87fu37e4rn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEe39-0004h0-TM;;;mid=<87fu37e4rn.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19M85MQ8erHr64wlDIMAmAufgGwCfDhBh8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 580 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.5%), parse: 1.77 (0.3%),
        extract_message_metadata: 29 (5.0%), get_uri_detail_list: 3.3 (0.6%),
        tests_pri_-1000: 12 (2.1%), tests_pri_-950: 2.4 (0.4%), tests_pri_-900: 1.95
        (0.3%), tests_pri_-400: 33 (5.7%), check_bayes: 31 (5.3%), b_tokenize: 12
        (2.1%), b_tok_get_all: 7 (1.2%), b_comp_prob: 4.2 (0.7%), b_tok_touch_all:
        2.7 (0.5%), b_finish: 0.95 (0.2%), tests_pri_0: 471 (81.2%),
        check_dkim_signature: 1.09 (0.2%), check_dkim_adsp: 5.0 (0.9%),
        tests_pri_500: 10 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
>
> Commit a841796f11c9 ("signal: align __lock_task_sighand() irq disabling and
> RCU") introduced a rcu read side critical section with interrupts
> disabled. The changelog suggested that a better long-term fix would be "to
> make rt_mutex_unlock() disable irqs when acquiring the rt_mutex structure's
> ->wait_lock".
>
> This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
> wait_lock irq safe") for different reason.

Which tree has this change been made in?  I am not finding the commit
you mention above in Linus's tree.

> Therefore revert commit a841796f11c9 ("signal: align >
> __lock_task_sighand() irq disabling and RCU") as the interrupt disable
> dance is not longer required.

Which tree is change aimed at?

Eric

> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/signal.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c6e4c83dc090..16b87c54d027 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1244,19 +1244,12 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  {
>  	struct sighand_struct *sighand;
>  
> +	rcu_read_lock();
>  	for (;;) {
> -		/*
> -		 * Disable interrupts early to avoid deadlocks.
> -		 * See rcu_read_unlock() comment header for details.
> -		 */
> -		local_irq_save(*flags);
> -		rcu_read_lock();
>  		sighand = rcu_dereference(tsk->sighand);
> -		if (unlikely(sighand == NULL)) {
> -			rcu_read_unlock();
> -			local_irq_restore(*flags);
> +		if (unlikely(sighand == NULL))
>  			break;
> -		}
> +
>  		/*
>  		 * This sighand can be already freed and even reused, but
>  		 * we rely on SLAB_TYPESAFE_BY_RCU and sighand_ctor() which
> @@ -1268,15 +1261,12 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  		 * __exit_signal(). In the latter case the next iteration
>  		 * must see ->sighand == NULL.
>  		 */
> -		spin_lock(&sighand->siglock);
> -		if (likely(sighand == tsk->sighand)) {
> -			rcu_read_unlock();
> +		spin_lock_irqsave(&sighand->siglock, *flags);
> +		if (likely(sighand == tsk->sighand))
>  			break;
> -		}
> -		spin_unlock(&sighand->siglock);
> -		rcu_read_unlock();
> -		local_irq_restore(*flags);
> +		spin_unlock_irqrestore(&sighand->siglock, *flags);
>  	}
> +	rcu_read_unlock();
>  
>  	return sighand;
>  }
