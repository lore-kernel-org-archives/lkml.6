Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C22FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0215205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xqjfh90J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0215205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG3RkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:40:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53634 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeG3RkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:40:17 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so17974323itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0J3EsMc98rUQMMpjnIyaaW4NPeVf7SvlkFodZGVqY8=;
        b=Xqjfh90J57UlVqzV5DyaBX7/2jwISB0zhVKiktXTB9xlp7GCOBdNFaz1Lp4PMxzrqW
         d1PxOeIxV8hRSULCx8bp6GLJ9VwO2FxpSJz8pDTzsrvG3dbE6V6maC8RxtSWvj5sDqsF
         HyXXTVLISTCA8u6VG0ObaXURtQo4VEobijrmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0J3EsMc98rUQMMpjnIyaaW4NPeVf7SvlkFodZGVqY8=;
        b=M16aNtDpUPNq3hdpJktuBnGquOAZ5JVoLwWj5vDurrkEGZmNHMDlMQK7ahOht1xKc8
         8QzIfrOwW5PwFcW42hv2j2yUhNxYPxjTcFMB41UKWSHwJ4zA/SFqqsmcGYE6CK6zGYP/
         VBER1BFaLL1uVbjeift0tVG1lyBbHvDScN8MkTpgn3pMXtq/nAmUu1MekzkI+ijD7tBZ
         C5T9WWX7Bd41UKEg52c+hONm8rKj94isfr2nRj/qL0m4uW7zLiQWLIcXPn0RO6fHmqFb
         8tpw+q4RsY8REnTWKPWhcpEcKyPtFxVg05JGzPw8yyCekSF7Zo3wcJFvC9CylzX8hqEI
         GH9w==
X-Gm-Message-State: AOUpUlElRxiE7gTJn+4KOnCTqISI400bFlER9TGoFmOCk2xF1G20ZHge
        63yF0JZ+/7+X57KJgakw2rOmTlJP6j+s1hcgXmgHAw==
X-Google-Smtp-Source: AAOMgpeHoKjQ5btTdw7MtvG+nAimmV8dHUwTnXASUYmzbOpbzgxZN05p+6AOXsyPB6WkmyUCvq53NHqq8bNdG2VbC5s=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr13892398itb.8.1532966679010;
 Mon, 30 Jul 2018 09:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org> <20180720123146.GL2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180720123146.GL2476@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Jul 2018 18:04:27 +0200
Message-ID: <CAKfTPtCZtgGWm6oCPaOrA5zydMtoMPi250n5OOz3LVanN6Ou7A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove #ifdefs from scale_rt_capacity
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, 20 Jul 2018 at 14:31, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 19, 2018 at 02:00:06PM +0200, Vincent Guittot wrote:
> > But the compiler is not able to optimize the sequence (at least with
> > aarch64 GCC 7.2.1)
> >       free *= (max - irq);
> >       free /= max;
> > when irq is fixed to 0
>
> So much for compilers.... I though those things were supposed to be
> 'clever'.
>
> > +#if defined(SMP) \
> > + && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))
>
> That's atrocious :-)
>
> Fixed it with the below.

Thanks for the fix


>
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -135,7 +135,7 @@ static void update_rq_clock_task(struct
>   * In theory, the compile should just see 0 here, and optimize out the call
>   * to sched_rt_avg_update. But I don't trust it...
>   */
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef HAVE_SCHED_AVG_IRQ
>         s64 steal = 0, irq_delta = 0;
>  #endif
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> @@ -177,7 +177,7 @@ static void update_rq_clock_task(struct
>
>         rq->clock_task += delta;
>
> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef HAVE_SCHED_AVG_IRQ
>         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>                 update_irq_load_avg(rq, irq_delta + steal);
>  #endif
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -856,6 +856,7 @@ struct rq {
>         struct sched_avg        avg_rt;
>         struct sched_avg        avg_dl;
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#define HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
>         u64                     idle_stamp;
> @@ -2212,8 +2213,7 @@ static inline unsigned long cpu_util_rt(
>  }
>  #endif
>
> -#if defined(SMP) \
> - && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))
> +#ifdef HAVE_SCHED_AVG_IRQ
>  static inline unsigned long cpu_util_irq(struct rq *rq)
>  {
>         return rq->avg_irq.util_avg;
