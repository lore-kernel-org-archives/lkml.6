Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6EBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565C2405B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565C2405B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeGEQXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbeGEQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:23:03 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A60B21A3A;
        Thu,  5 Jul 2018 16:23:02 +0000 (UTC)
Date:   Thu, 5 Jul 2018 12:23:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Message-ID: <20180705122300.42164577@gandalf.local.home>
In-Reply-To: <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
        <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added Peter ]

On Thu, 5 Jul 2018 17:50:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> migrate_disable() does nothing !SMP && !RT. This is bad for two reasons:
> - The futex code relies on the fact migrate_disable() is part of spin_lock().
>   There is a workaround for the !in_atomic() case in migrate_disable() which
>   work-arounds the different ordering (non-atomic lock and atomic unlock).

But isn't it only part of spin_lock() in the RT case?

> 
> - we have a few instances where preempt_disable() is replaced with
>   migrate_disable().

What? Really? I thought we only replace preempt_disable() with a
local_lock(). Which gives annotation to why a preempt_disable() exists.
And on non-RT, local_lock() is preempt_disable().

> 
> For both cases it is bad if migrate_disable() ends up as barrier() instead of
> preempt_disable(). Let migrate_disable() fallback to preempt_disable().
> 

I still don't understand exactly what is "bad" about it.

IIRC, I remember Peter not wanting any open coded "migrate_disable"
calls. It was to be for internal use cases only, and specifically, only
for RT.

Personally, I think making migrate_disable() into preempt_disable() on
NON_RT is incorrect too.

-- Steve



> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 4 ++--
>  kernel/sched/core.c     | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 043e431a7e8e..d46688d521e6 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
>  }
>  
>  #else
> -#define migrate_disable()		barrier()
> -#define migrate_enable()		barrier()
> +#define migrate_disable()		preempt_disable()
> +#define migrate_enable()		preempt_enable()
>  static inline int __migrate_disabled(struct task_struct *p)
>  {
>  	return 0;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ac3fb8495bd5..626a62218518 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7326,6 +7326,7 @@ void migrate_disable(void)
>  #endif
>  
>  	p->migrate_disable++;
> +	preempt_disable();
>  }
>  EXPORT_SYMBOL(migrate_disable);
>  
> @@ -7349,6 +7350,7 @@ void migrate_enable(void)
>  
>  	WARN_ON_ONCE(p->migrate_disable <= 0);
>  	p->migrate_disable--;
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL(migrate_enable);
>  #endif

