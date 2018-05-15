Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeEOAf6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:35:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34896 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeEOAf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:35:57 -0400
X-Google-Smtp-Source: AB8JxZokpxgScq53NeGmBnzueImG9mbrUNKMwZ90qnQvYQ5ynG6Vg/DN6zrWQ8hCGSfV4KE50q9KfA==
Date: Mon, 14 May 2018 17:35:55 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 2/8] rcu: Clarify usage of cond_resched for tasks-RCU
Message-ID: <20180515003555.GA209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-3-joel@joelfernandes.org>
 <20180514105454.45946ad3@gandalf.local.home>
 <20180514172205.GZ26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514172205.GZ26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:22:05AM -0700, Paul E. McKenney wrote:
> On Mon, May 14, 2018 at 10:54:54AM -0400, Steven Rostedt wrote:
> > On Sun, 13 May 2018 20:15:35 -0700
> > "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > 
> > > Recently we had a discussion about cond_resched unconditionally
> > > recording a voluntary context switch [1].
> > > 
> > > Lets add a comment clarifying that how this API is to be used.
> > > 
> > > [1] https://lkml.kernel.org/r/1526027434-21237-1-git-send-email-byungchul.park@lge.com
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  include/linux/rcupdate.h | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 743226176350..a9881007ece6 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -159,8 +159,12 @@ static inline void rcu_init_nohz(void) { }
> > >  	} while (0)
> > >  
> > >  /*
> > > - * Note a voluntary context switch for RCU-tasks benefit.  This is a
> > > - * macro rather than an inline function to avoid #include hell.
> > > + * Note an attempt to perform a voluntary context switch for RCU-tasks benefit.
> > > + *
> > > + * This is called even in situations where a context switch didn't really
> > > + * happen even though it was requested. The caller uses it to indicate
> > > + * traversal of an RCU-tasks quiescent state. This is a macro rather than an
> > > + * inline function to avoid #include hell.
> > 
> > I don't know. I just don't like the wording. It sounds too much like
> > it was written by someone that was confused for it being called when a
> > context switch didn't occur ;-)

True :)

> > 
> > What about something more like:
> > 
> > /*
> >  * This is called to denote a RCU-task quiescent state. It is placed at
> >  * voluntary preemption points, as RCU-task critical sections may not
> >  * perform voluntary preemption or scheduling calls. It does not matter
> >  * if the task is scheduled out or not, just that a voluntary preemption
> >  * may be done.
> >  */
> 
> s/RCU-task/RCU-tasks/ and I am good with this.

Ok. I like Steve's comment better too.

Btw, I see you just posted a change of the macro name from
rcu_note_voluntary_context_switch_lite to rcu_tasks_qs which actually in
itself is much more descriptive. Considering this, I feel the new name is
quite self-documenting in itself. So I am more inclined to drop this patch in
any series reposting, but let me know if you feel otherwise.

thanks,

- Joel
