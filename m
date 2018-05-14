Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeENOzB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENOy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:57 -0400
Date: Mon, 14 May 2018 10:54:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 2/8] rcu: Clarify usage of cond_resched for
 tasks-RCU
Message-ID: <20180514105454.45946ad3@gandalf.local.home>
In-Reply-To: <20180514031541.67247-3-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
        <20180514031541.67247-3-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018 20:15:35 -0700
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Recently we had a discussion about cond_resched unconditionally
> recording a voluntary context switch [1].
> 
> Lets add a comment clarifying that how this API is to be used.
> 
> [1] https://lkml.kernel.org/r/1526027434-21237-1-git-send-email-byungchul.park@lge.com
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcupdate.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 743226176350..a9881007ece6 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -159,8 +159,12 @@ static inline void rcu_init_nohz(void) { }
>  	} while (0)
>  
>  /*
> - * Note a voluntary context switch for RCU-tasks benefit.  This is a
> - * macro rather than an inline function to avoid #include hell.
> + * Note an attempt to perform a voluntary context switch for RCU-tasks benefit.
> + *
> + * This is called even in situations where a context switch didn't really
> + * happen even though it was requested. The caller uses it to indicate
> + * traversal of an RCU-tasks quiescent state. This is a macro rather than an
> + * inline function to avoid #include hell.

I don't know. I just don't like the wording. It sounds too much like
it was written by someone that was confused for it being called when a
context switch didn't occur ;-)

What about something more like:

/*
 * This is called to denote a RCU-task quiescent state. It is placed at
 * voluntary preemption points, as RCU-task critical sections may not
 * perform voluntary preemption or scheduling calls. It does not matter
 * if the task is scheduled out or not, just that a voluntary preemption
 * may be done.
 */

>   */
>  #ifdef CONFIG_TASKS_RCU
>  #define rcu_note_voluntary_context_switch_lite(t) \
> @@ -187,7 +191,8 @@ static inline void exit_tasks_rcu_finish(void) { }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU */
>  
>  /**
> - * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
> + * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU.
> + * The quiescent state report is made even if cond_resched() did nothing.

Same thing here.

 * The quiescent state report does not depend on cond_resched() scheduling.

-- Steve


>   *
>   * This macro resembles cond_resched(), except that it is defined to
>   * report potential quiescent states to RCU-tasks even if the cond_resched()
