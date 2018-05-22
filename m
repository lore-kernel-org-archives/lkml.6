Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeEVPxP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeEVPxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:53:14 -0400
Date: Tue, 22 May 2018 11:53:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH RT] sched: let softirq_count() return !0 if inside
 local_bh_disable()ed section
Message-ID: <20180522115311.0fee528a@gandalf.local.home>
In-Reply-To: <20180517102214.orea3ol6dj7wvpf5@linutronix.de>
References: <20180517102214.orea3ol6dj7wvpf5@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 12:22:14 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I don't see a reason why softirq_count() shouldn't reflect the fact that
> we are within a local_bh_disable() section. I *think* it was done
> primary because in RT the softirq is slightly different (and
> preemptible) and it broke some of RCU's assumptions.
> I don't see any fallout with this change. Furthermore, all checks like
> "WARN_ON(!softirq_count())" will work and we can drop the workaround we
> currently have in the queue.

Looks to keep the paradigm closer to vanilla Linux to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 0591df500e9d..d8c05a2626ca 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -91,7 +91,7 @@
>  # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
>  # define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
>  #else
> -# define softirq_count()	(0UL)
> +# define softirq_count()	(current->softirq_nestcnt)
>  extern int in_serving_softirq(void);
>  #endif
>  
