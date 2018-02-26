Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeBZE5x (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbeBZE5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:57:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE4D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sun, 25 Feb 2018 23:57:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Message-ID: <20180225235748.4ce882e5@vmware.local.home>
In-Reply-To: <20180225181730.GA3963@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
        <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180224151240.0d63a059@vmware.local.home>
        <20180225174927.GC2855@linux.vnet.ibm.com>
        <20180225181730.GA3963@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2018 10:17:30 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> And probably not.  You are probably running CONFIG_PREEMPT=y (otherwise
> RCU-tasks is trivial), so cond_resched() is a complete no-op:
> 
> static inline int _cond_resched(void) { return 0; }
> 
> I could make this call rcu_all_qs(), but I would not expect Peter Zijlstra
> to be at all happy with that sort of change.
> 
> And the people who asked for the cond_resched() work probably aren't
> going to be happy with the resumed proliferation of cond_resched_rcu_qs().
> 
> Hmmm...  Grasping at straws...  Could we make cond_resched() be something
> like a tracepoint and instrument them with cond_resched_rcu_qs() if the
> current RCU-tasks grace period ran for more that (say) a minute of its
> ten-minute stall-warning span?
> 

Instead of monkeying with cond_resched(), since this is "special" code,
why don't I just have that code call it directly?

	cond_resched();
	rcu_note_voluntary_context_switch(current);

-- Steve
