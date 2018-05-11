Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeEKQXr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbeEKQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:23:24 -0400
Date: Fri, 11 May 2018 12:23:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Message-ID: <20180511122321.722a12cc@gandalf.local.home>
In-Reply-To: <20180511161746.GX26088@linux.vnet.ibm.com>
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
        <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
        <20180511161746.GX26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 09:17:46 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > >index ee8cf5fc..7432261 100644
> > >--- a/include/linux/rcupdate.h
> > >+++ b/include/linux/rcupdate.h
> > >@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> > >   */
> > >  #define cond_resched_tasks_rcu_qs() \
> > >  do { \
> > >-	if (!cond_resched()) \
> > >-		rcu_note_voluntary_context_switch_lite(current); \
> > >+	rcu_note_voluntary_context_switch_lite(current); \
> > >+	cond_resched(); \  
> 
> Ah, good point.
> 
> Peter, I have to ask...  Why is "cond_resched()" considered a preemption
> while "schedule()" is not?

I would argue that cond_resched() not be considered a preemption.
Although, it may be called a "preemption point". A place that can be
preempted, but may not be. Maybe that's the answer. schedule() will
always schedule (even though it may pick the same task to run, but
not guaranteed to), where as, cond_resched() will only schedule if the
conditions are right. And maybe that's not really a "voluntary
schedule", although I think that can be argued against.

-- Steve
