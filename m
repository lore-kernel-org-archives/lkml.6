Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8FAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481420842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og/ksjGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C481420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeIZOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:25:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36415 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:25:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id p89-v6so8159423ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3yqeNtqP1Hs2mUeKB85OX+9+mIhvvp1W4nizwhzafY=;
        b=Og/ksjGmpLChfRs3zu9nyAvlcwgpkOIix6UoM6nKVRoVuYHXyvxiB096L+yIOL5Gpm
         pxP/f1kuUqKz7JZ+bjOzEJITzaT484CzAPb5NpV5eDD0repdIKbHml0GpGOBADsuaYlk
         ivUHsVGx5v6FyAJ8S5EUVQdcFLjqFhnEcfmnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3yqeNtqP1Hs2mUeKB85OX+9+mIhvvp1W4nizwhzafY=;
        b=nzU4dXWl549gt/0x2UFgXIxJscJMzOYHNxrzUQ0Fo2W6XhbsGm8LxAJf676E2S22yC
         Qb5sCsQC1pTUYfkW7CvJ/YgO2QsER4iKpjVS3Beg+tUII1kLoogzAwYY4Y5IX5cI763q
         S+SYisCOHUspWfydcqB+KVwzjYCKLnxcoFyHRguLF2RerPqToVFsAgz4GAlMZoqsGj/h
         naTU5sxJaREqfukPE4/6rMrawlkdipb6UYbb7tYNaUr0PFuuBMPwSE3r67wrpeqNTRAY
         anYe7nIbxPAbUdX7UvGmHn0guPsSL6QlMTGadklm8ruJA9Gh/QULjLBEoR735ITsRQ9A
         fmFQ==
X-Gm-Message-State: ABuFfoicWyMWhQz8zcrid2HZS6pXMWzbqBlsIooWfpRFg/g5nse852hk
        HMn2qJmKVMd8aROpeP/pe0U2JNqxf8qPRVfRJhgyjw==
X-Google-Smtp-Source: ACcGV61m563peC0YwKKJcycHt7NCQ3QkJjXLJ6sgOXcs+GmkE+JZU6KVzlOOpGZk2IxyeOkwRexPEkieu3qLxuDqXTc=
X-Received: by 2002:a2e:2bd5:: with SMTP id r82-v6mr3327462ljr.63.1537949617054;
 Wed, 26 Sep 2018 01:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
In-Reply-To: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Sep 2018 10:13:25 +0200
Message-ID: <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 at 19:38, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> When load_balance() fails to move some load because of task affinity,
> we end up increasing sd->balance_interval to delay the next periodic
> balance in the hopes that next time we look, that annoying pinned
> task(s) will be gone.

It's not about hope but to minimize useless periodic load balance as
there is no possibility to balance anything

>
> However, idle_balance() pays no attention to sd->balance_interval, yet
> it will still lead to an increase in balance_interval in case of
> pinned tasks.

I would say that this makes sense as there is no way to pull the
pinned task on this rq so running periodic load balance (busy or idle)
is a waste of time  and resources

>
> If we're going through several newidle balances (e.g. we have a
> periodic task), this can lead to a huge increase of the

This only happen when overload is set which means that there are tasks
on another CPU but this one can't pull one of them.

Can you give us details about the use case that you care about ?

Also, If the interval reaches a value that becomes a problem for you
why don't you reduce the max_interval with sysfs ? This max interval
can be reach in several other occasions

> balance_interval in a very small amount of time.
>
> To prevent that, don't increase the balance interval when going
> through a newidle balance.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6bd142d..620910d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8782,13 +8782,22 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>         sd->nr_balance_failed = 0;
>
>  out_one_pinned:
> +       ld_moved = 0;
> +
> +       /*
> +        * idle_balance() disregards balance intervals, so we could repeatedly
> +        * reach this code, which would lead to balance_interval skyrocketting
> +        * in a short amount of time. Skip the balance_interval increase logic
> +        * to avoid that.
> +        */
> +       if (env.idle == CPU_NEWLY_IDLE)
> +               goto out;
> +
>         /* tune up the balancing interval */
> -       if (((env.flags & LBF_ALL_PINNED) &&
> -                       sd->balance_interval < MAX_PINNED_INTERVAL) ||
> -                       (sd->balance_interval < sd->max_interval))
> +       if ((env.flags & LBF_ALL_PINNED &&
> +            sd->balance_interval < MAX_PINNED_INTERVAL) ||
> +           (sd->balance_interval < sd->max_interval))

This looks like a code cleanup that is not related to the subject

>                 sd->balance_interval *= 2;
> -
> -       ld_moved = 0;
>  out:
>         return ld_moved;
>  }
> --
> 2.7.4
>
