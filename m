Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeELR0v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 13:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeELR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 13:26:50 -0400
Date: Sat, 12 May 2018 13:26:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Message-ID: <20180512132647.2923f7cf@gandalf.local.home>
In-Reply-To: <20180512144119.GJ26088@linux.vnet.ibm.com>
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
        <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
        <20180511161746.GX26088@linux.vnet.ibm.com>
        <20180511224138.GA89902@joelaf.mtv.corp.google.com>
        <20180512050824.GF26088@linux.vnet.ibm.com>
        <20180512063037.GC192642@joelaf.mtv.corp.google.com>
        <20180512144119.GJ26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 07:41:19 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Don't get me wrong, this discussion was quite useful to me.  We probably
> need to at least change the comments, and perhaps the code as well.  But
> I agree that we need input from Peter and Steven to make much more forward
> progress.

It's the weekend so I skimmed more than read this thread, but I will
just add this.

The table Joel posted is interesting, and perhaps we should keep things
consistent with that. But that said, with respect to task-RCU, as
nothing on a trampoline should ever call cond_resched() (and perhaps I
should add code in lockdep that verifies this), we just want a
quiescent state that tells us that the task has left the trampoline. A
cond_resched() should be one of those points that does.

It really has nothing to do with scheduling or preemption. The issue is
that if a task is on a trampoline and gets preempted, there's no
knowing when it is off that trampoline where we can free it. We need to
have places in the kernel that we know is a quiescent state to move
task-RCU forward. cond_resched() seems to be one of them. schedule
itself can not be, because it can be called from an interrupt preempting
a task while it is on the trampoline.

-- Steve
