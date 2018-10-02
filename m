Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5274FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE4206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3dKMYqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BE4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJBNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:51:51 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40792 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:51:51 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so2274594iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNGs8ZxOtswDTv0FLWA43Rd4O4Ltf5vqGPG3TTYisD4=;
        b=J3dKMYqfmImPz5PgPx937Ab7J4rg88otgmLnnIenlb4o4hUwijXdiBCnRHOxcVFinb
         kbl1v7deHKdAbO3m4yUMVofHYRq33DT2zW8lO4SBTutbFGGCAy7gqaDjJoL9O71RSzyd
         KqW1E8xMTwYH2Gw4+5kPpZOQGFmGSWLdLW+wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNGs8ZxOtswDTv0FLWA43Rd4O4Ltf5vqGPG3TTYisD4=;
        b=Lu0k4NeaJl3lR9xE1iG5Ho0WZ6WQ2zUR9aN6hUz+2DUVdpPVpXu5tgKBjOMUtHOUd4
         o60f7hjx+hALizujdDtSVeZa8WxCByO526B/GxY/FATs5Vp/cmpsBPTHYqaludlbTgY0
         DTtnmSuifyrXlsoOGvjsV0Lod8Q/KtQ8tg1AMUifX8AXgDhPOPcwvzMw79gqFsD4Akyx
         lPQW3yjJSGk0L7bvfL6OR7AWoXrmUZIDYEwhC3WXzqTbFTAICsso+PIOGLKl6Me7fzMB
         59LBknKHLRSFW2dZo41K3/jk2xcm3Gyaiunjgcsxm3facEBmN/uWYGFfGufxvxIizesL
         +/DA==
X-Gm-Message-State: ABuFfogA1eMohS/FTOt8SEOB82AQGuyXuAdb8jnVl3yja+fGDnr6lG/F
        lqbwIvxbT/a5piMjBiFg4inOKMm331Db90pTwJjKBw==
X-Google-Smtp-Source: ACcGV61Qmv8k/4iugS78Ul0PZmpVt2ifrleeWC2mHaGI8H/h0jniMeWu9WMaaeubil4iHova29U5bkG0JIV+m2LVzD0=
X-Received: by 2002:a24:e00e:: with SMTP id c14-v6mr1076283ith.108.1538464204422;
 Tue, 02 Oct 2018 00:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <1537867062-27285-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1537867062-27285-1-git-send-email-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 2 Oct 2018 09:09:53 +0200
Message-ID: <CAKfTPtCgiEBhq49r=r88swExCJK80vYbbC+mr9KU+J-HsUsZOQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: fix warning and cleanup irq pelt config
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>, dou_liyang@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 at 11:17, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Create a config for enabling irq load tracking in the scheduler.
> irq load tracking is useful only when irq or paravirtual time is
> accounted but it's only possible with SMP for now.
>
> Also use __maybe_unused to remove the compilation warning in
> update_rq_clock_task() that has been introduced by:
>   commit 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")

Gentle ping.


>
> Reported-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  init/Kconfig         | 5 +++++
>  kernel/sched/core.c  | 7 +++----
>  kernel/sched/fair.c  | 2 +-
>  kernel/sched/pelt.c  | 2 +-
>  kernel/sched/pelt.h  | 2 +-
>  kernel/sched/sched.h | 5 ++---
>  6 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 1e234e2..317d5cc 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -415,6 +415,11 @@ config IRQ_TIME_ACCOUNTING
>
>           If in doubt, say N here.
>
> +config HAVE_SCHED_AVG_IRQ
> +       def_bool y
> +       depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
> +       depends on SMP
> +
>  config BSD_PROCESS_ACCT
>         bool "BSD Process Accounting"
>         depends on MULTIUSER
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc98..bf7b745 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -135,9 +135,8 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>   * In theory, the compile should just see 0 here, and optimize out the call
>   * to sched_rt_avg_update. But I don't trust it...
>   */
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -       s64 steal = 0, irq_delta = 0;
> -#endif
> +       s64 __maybe_unused steal = 0, irq_delta = 0;
> +
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>         irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
>
> @@ -177,7 +176,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>
>         rq->clock_task += delta;
>
> -#ifdef HAVE_SCHED_AVG_IRQ
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>                 update_irq_load_avg(rq, irq_delta + steal);
>  #endif
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6bd142d..2c05aac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7249,7 +7249,7 @@ static inline bool others_have_blocked(struct rq *rq)
>         if (READ_ONCE(rq->avg_dl.util_avg))
>                 return true;
>
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         if (READ_ONCE(rq->avg_irq.util_avg))
>                 return true;
>  #endif
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 35475c0..48a1264 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -358,7 +358,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>         return 0;
>  }
>
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  /*
>   * irq:
>   *
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index d2894db..7e56b48 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -6,7 +6,7 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
>  #else
>  static inline int
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3a4ef8f..f3477e0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -861,8 +861,7 @@ struct rq {
>
>         struct sched_avg        avg_rt;
>         struct sched_avg        avg_dl;
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -#define HAVE_SCHED_AVG_IRQ
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
>         u64                     idle_stamp;
> @@ -2222,7 +2221,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  }
>  #endif
>
> -#ifdef HAVE_SCHED_AVG_IRQ
> +#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  static inline unsigned long cpu_util_irq(struct rq *rq)
>  {
>         return rq->avg_irq.util_avg;
> --
> 2.7.4
>
