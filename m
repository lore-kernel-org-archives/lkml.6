Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeEOXTi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:19:38 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:38255 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeEOXTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:19:36 -0400
X-Google-Smtp-Source: AB8JxZpqmfceNygyYdQ+fPgEMkKd8NCtJJr67JOF11wt6Dc2url3P9sie+/UmX4dK3zcCUmH9509Qg==
Date: Tue, 15 May 2018 16:19:35 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] softirq: reorder trace_softirqs_on to prevent
 lockdep splat
Message-ID: <20180515231935.GA208042@joelaf.mtv.corp.google.com>
References: <20180515224559.199279-1-joel@joelfernandes.org>
 <20180515224559.199279-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515224559.199279-2-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch submission got completely screwed up, sorry, please ignore. I'll
repost soon. There's something messed up with my SMTP server too.

On Tue, May 15, 2018 at 03:45:54PM -0700, Joel Fernandes (Google) wrote:
> I'm able to reproduce a lockdep splat with config options:
> CONFIG_PROVE_LOCKING=y,
> CONFIG_DEBUG_LOCK_ALLOC=y and
> CONFIG_PREEMPTIRQ_EVENTS=y
> 
> $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> ---
>  kernel/softirq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 177de3640c78..8a040bcaa033 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	if (preempt_count() == cnt)
> +		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -	preempt_count_sub(cnt);
> +
> +	__preempt_count_sub(cnt);
>  }
>  
>  /*
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
