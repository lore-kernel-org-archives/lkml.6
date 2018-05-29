Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933999AbeE2MmI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:42:08 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18790 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933565AbeE2MmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:42:06 -0400
Date: Tue, 29 May 2018 14:41:59 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
Subject: Re: [PATCH v1 04/20] signal: add copy_pending() helper
Message-ID: <20180529124159.GB11221@mailbox.org>
References: <20180528215355.16119-1-christian@brauner.io>
 <20180528215355.16119-5-christian@brauner.io>
 <87r2lusl8l.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2lusl8l.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:24:26AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > Instead of using a goto for this let's add a simple helper copy_pending()
> > which can be called in both places.
> 
> Ick no.  As far as I can see this just confuses the logic of the
> collect_signal function.
> 
> Instead of having two cases with an optional
> "sigdelset(&list->signal, sig)" if the signal is no longer in the queue,
> you are moving the core work of collect_signal into another function.
> 
> At the very least this is going to make maintenance more difficult
> as now the work of this function is split into two functions.

I do disagree here tbh. The goto jump into it the if part of an if-else
seems pretty nasty.
I also don't know why this should be confusing the logic. There's a
single function that is called in two places and it is declared directly
atop it's only caller. Additionally, recognizing a single name of a
function as being the same in two places is way easier then recognizing
that a multi-line pattern is the same in two places.

Christian

> 
> It most definitely would have made the bug fix to add resched_timer more
> difficult.
> 
> Eric
> 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v0->v1:
> > * patch unchanged
> > ---
> >  kernel/signal.c | 54 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 30 insertions(+), 24 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index bc750fb4ddcc..baae137455eb 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -515,6 +515,19 @@ int unhandled_signal(struct task_struct *tsk, int sig)
> >  	return !tsk->ptrace;
> >  }
> >  
> > +static void copy_pending(siginfo_t *info, struct sigqueue *first,
> > +			 bool *resched_timer)
> > +{
> > +	list_del_init(&first->list);
> > +	copy_siginfo(info, &first->info);
> > +
> > +	*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
> > +			 (info->si_code == SI_TIMER) &&
> > +			 (info->si_sys_private);
> > +
> > +	__sigqueue_free(first);
> > +}
> > +
> >  static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
> >  			   bool *resched_timer)
> >  {
> > @@ -526,8 +539,10 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
> >  	*/
> >  	list_for_each_entry(q, &list->list, list) {
> >  		if (q->info.si_signo == sig) {
> > -			if (first)
> > -				goto still_pending;
> > +			if (first) {
> > +				copy_pending(info, first, resched_timer);
> > +				return;
> > +			}
> >  			first = q;
> >  		}
> >  	}
> > @@ -535,29 +550,20 @@ static void collect_signal(int sig, struct sigpending *list, siginfo_t *info,
> >  	sigdelset(&list->signal, sig);
> >  
> >  	if (first) {
> > -still_pending:
> > -		list_del_init(&first->list);
> > -		copy_siginfo(info, &first->info);
> > -
> > -		*resched_timer =
> > -			(first->flags & SIGQUEUE_PREALLOC) &&
> > -			(info->si_code == SI_TIMER) &&
> > -			(info->si_sys_private);
> > -
> > -		__sigqueue_free(first);
> > -	} else {
> > -		/*
> > -		 * Ok, it wasn't in the queue.  This must be
> > -		 * a fast-pathed signal or we must have been
> > -		 * out of queue space.  So zero out the info.
> > -		 */
> > -		clear_siginfo(info);
> > -		info->si_signo = sig;
> > -		info->si_errno = 0;
> > -		info->si_code = SI_USER;
> > -		info->si_pid = 0;
> > -		info->si_uid = 0;
> > +		copy_pending(info, first, resched_timer);
> > +		return;
> >  	}
> > +
> > +	/*
> > +	 * Ok, it wasn't in the queue. This must be a fast-pathed signal or we
> > +	 * must have been out of queue space. So zero out the info.
> > +	 */
> > +	clear_siginfo(info);
> > +	info->si_signo = sig;
> > +	info->si_errno = 0;
> > +	info->si_code = SI_USER;
> > +	info->si_pid = 0;
> > +	info->si_uid = 0;
> >  }
> >  
> >  static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
