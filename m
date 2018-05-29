Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbeE2MiR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:38:17 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:9424 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933565AbeE2MiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:38:11 -0400
Date: Tue, 29 May 2018 14:38:04 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
Subject: Re: [PATCH v1 05/20] signal: flatten do_send_sig_info()
Message-ID: <20180529123804.GA11221@mailbox.org>
References: <20180528215355.16119-1-christian@brauner.io>
 <20180528215355.16119-6-christian@brauner.io>
 <87fu2asl1w.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu2asl1w.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:28:27AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > Let's return early when lock_task_sighand() fails and move send_signal()
> > and unlock_task_sighand() out of the if block.
> 
> Introducing multiple exits into a function.  Ick.
> You do know that is what Dijkstra was arguing against in his paper
> "Goto Considered Harmful"
> 
> That introduces mutiple exits and makes the function harder to analyze.
> It is especially a pain as I have something in my queue that will
> shuffle things around and remove the possibility of lock_task_sighand
> failing.

I'm happy to drop this one if you have a fix for this in your tree
anyway.

Aside from that, I think it might make sense to route this patch series
through your tree though since you're doing the siginfo rework
currently.(?)

Christian

> 
> Eric
> 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v0->v1:
> > * patch unchanged
> > ---
> >  kernel/signal.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index baae137455eb..a628b56415e6 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1167,16 +1167,16 @@ specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
> >  }
> >  
> >  int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
> > -			bool group)
> > +		     bool group)
> >  {
> >  	unsigned long flags;
> >  	int ret = -ESRCH;
> >  
> > -	if (lock_task_sighand(p, &flags)) {
> > -		ret = send_signal(sig, info, p, group);
> > -		unlock_task_sighand(p, &flags);
> > -	}
> > +	if (!lock_task_sighand(p, &flags))
> > +		return ret;
> >  
> > +	ret = send_signal(sig, info, p, group);
> > +	unlock_task_sighand(p, &flags);
> >  	return ret;
> >  }
