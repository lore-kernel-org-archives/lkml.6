Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEOX46 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:56:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34505 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOX44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:56:56 -0400
X-Google-Smtp-Source: AB8JxZrlovkEhBRrcKWQKf3EQwoVuZpxdj5aCLMU/YR0Wuk2QQWEyLvl920EISybOFBG5ZIV5pgAU9H0wW8x5c4y3SQ=
MIME-Version: 1.0
References: <20180515224559.199279-1-joel@joelfernandes.org> <20180515224559.199279-3-joel@joelfernandes.org>
In-Reply-To: <20180515224559.199279-3-joel@joelfernandes.org>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Tue, 15 May 2018 16:56:43 -0700
Message-ID: <CAEi0qN=DqhudAQ7mdwDPzJ9UX5PcxS9Srdi8=K64h7uv8yrxHQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] srcu: Add notrace variants of srcu_read_{lock,unlock}
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something is majorly messed up with my SMTP server. Only half of the patches
in this series were sent out and the ones that did go out were random.

I keeping getting this as replies for the one's that didn't go out:
https://support.google.com/mail/answer/6596?visit_id=1-636620224226493206-2884214369&rd=1

And its intermittent too.. I am going to spend a bit of time to figure out
why it happened so it doesn't happen again. Sorry about the noise.

Sigh,

- Joel

On Tue, May 15, 2018 at 3:47 PM Joel Fernandes (Google) <
joel@joelfernandes.org> wrote:

> From: Paul McKenney <paulmck@linux.vnet.ibm.com>

> This is needed for a future tracepoint patch that uses srcu, and to make
> sure it doesn't call into lockdep.

> tracepoint code already calls notrace variants for rcu_read_lock_sched
> so this patch does the same for srcu which will be used in a later
> patch. Keeps it consistent with rcu-sched.

> [Joel: Added commit message]

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Cc: kernel-team@android.com
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   include/linux/srcu.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 33c1c698df09..2ec618979b20 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -161,6 +161,16 @@ static inline int srcu_read_lock(struct srcu_struct
*sp) __acquires(sp)
>          return retval;
>   }

> +/* Used by tracing, cannot be traced and cannot invoke lockdep. */
> +static inline notrace int
> +srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
> +{
> +       int retval;
> +
> +       retval = __srcu_read_lock(sp);
> +       return retval;
> +}
> +
>   /**
>    * srcu_read_unlock - unregister a old reader from an SRCU-protected
structure.
>    * @sp: srcu_struct in which to unregister the old reader.
> @@ -175,6 +185,13 @@ static inline void srcu_read_unlock(struct
srcu_struct *sp, int idx)
>          __srcu_read_unlock(sp, idx);
>   }

> +/* Used by tracing, cannot be traced and cannot call lockdep. */
> +static inline notrace void
> +srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
> +{
> +       __srcu_read_unlock(sp, idx);
> +}
> +
>   /**
>    * smp_mb__after_srcu_read_unlock - ensure full ordering after
srcu_read_unlock
>    *
> --
> 2.17.0.441.gb46fe60e1d-goog
