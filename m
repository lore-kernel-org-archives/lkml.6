Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE0D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfBYOoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:44:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:45523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBYOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:44:17 -0500
Received: from homer.simpson.net ([185.221.150.179]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1h922b1zzs-011wZj; Mon, 25
 Feb 2019 15:43:37 +0100
Message-ID: <1551105815.6234.14.camel@gmx.de>
Subject: Re: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 25 Feb 2019 15:43:35 +0100
In-Reply-To: <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
         <20190218163137.cmor4ek3odus5m6j@linutronix.de>
         <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
         <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FEX4K+lV5wynRytXPi1uu3MonnmPc7aqD+2jJXT/JqCphagJh0z
 ZNNk3Dw+ijcARCTADJKv/KSclqk0fQhsNxrDS110tmrkE0PUNqRKyP5BDfu+gex6kAsYkcF
 OkDA9bNMb6TtmCa6mD4ZVNRYKU7eaoi6XfXLl62X8f014BGx9GZZiCu4u7q6UDLwpdQn18L
 ZZGznjPywXTz1wbVTlc/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PgQeBH52AoQ=:Squf32igUsUBXp33qqcMbB
 KOt9M1rnQmBlTgnwuwGIeV16CoTV6aAbbC5/3yBue2Y330DzYPv2v4Vq3N8HVY1/FEFmIbTLD
 KOv1ihxWb4i3kXtUnT9z+2ODHOJJclOUnSVeXL+cYWjKt9wLA7dT80VUSkUUtSdcx5GQMgWdG
 i3s8m9txKb0FV+6ovoxPVq2TMNfl0rkgVMwTYwL04lE+Qd7PHc20C6I4jH9D+5lEIbNhwtqbn
 IBQsC335n0jY8r6cdINFqzTm5r+D6QExuo4i418u+UdtyCijZ2bfIySQfcH9D/RXXm7hyjFw1
 K5KTtTZkvwnpsWEsehJoWfF3PSTrwIe8fkjuw4ZBqFuL17amkWCazQbFT4+Zz4Dp0oFxzXpAQ
 S9fKcGX8tdhy+LUIu5BZ8eqf8NW3OyQZDPhfLSNpEyLPMK9/QpJK5W6CrqwbZB9UvbVLKb8R0
 hq1ZfyPR9xfjVkAuW2XvwsUgvXrMLjXckPRvDeMR2IqL5FF9M4TyxbRhAm2NxI2pTPgu8bZg+
 w+vJd0ysdUiods7byU/fIpoBSAygVSWgmwegzkUhoa/b3zk12+OFOzy559C+8SEFyi0W1rxb4
 fOE9Q+QsCMheSETMIsjcdgr42R9oyg+SULy8ot+cfYoKy53b6Q2cx9j7Yv7SvHHByMh8KF4md
 v9TCT64UdVrUaAPlUwz3ZNIp35HKbl4mSWkEXMeziSLSxK5RonR/wsn8lmUiyjBR2oFEoYxHT
 0MH3NLDxW5YgzeYlsD1T3+dnSpaOAmxgw701k0ty6MRMKXSUhfgCDmOcx+7kV88ZbE2YFylak
 xYdBJTixIFg50TtHWC8Gqze7r4VXgjQytRuGaSyZ67ogIqCw+JXBuXX3cHCo7EtlA8vA90Yj+
 0RkaPzgd9r5iu1fAH9mOvSTL2dvzMGH4IVT/8ABl6dBpaj5FUQu3CeBYguZegF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

My box claims that this patch is busted.  It argues its case by IO
deadlocking any kernel this patch is applied to when spinning rust is
flogged, including virgin 4.19-rt14, said kernel becoming stable again
when I whack the accused.

On Tue, 2019-02-19 at 17:08 +0100, Sebastian Andrzej Siewior wrote:
> In cpu_chill() the state is set to TASK_UNINTERRUPTIBLE and a timer is
> programmed. On return the state is always TASK_RUNNING which means we
> lose the state if it was something other than RUNNING. Also
> set_current_state() sets ->task_state_change to within cpu_chill() which
> is not expected.
> 
> Save the task state on entry and restore it on return. Simply set the
> state in order to avoid updating ->task_state_change.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/hrtimer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 851b2134e77f4..6f2736ec4b8ef 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1902,15 +1902,18 @@ void cpu_chill(void)
>  {
>  	ktime_t chill_time;
>  	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
> +	long saved_state;
>  
> +	saved_state = current->state;
>  	chill_time = ktime_set(0, NSEC_PER_MSEC);
> -	set_current_state(TASK_UNINTERRUPTIBLE);
> +	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
>  	current->flags |= PF_NOFREEZE;
>  	sleeping_lock_inc();
>  	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
>  	sleeping_lock_dec();
>  	if (!freeze_flag)
>  		current->flags &= ~PF_NOFREEZE;
> +	__set_current_state_no_track(saved_state);
>  }
>  EXPORT_SYMBOL(cpu_chill);
>  #endif
