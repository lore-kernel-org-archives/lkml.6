Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA98C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735402082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiG2mHX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735402082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLKHqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:46:32 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38446 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:46:31 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so2250928ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AhxpeOqpWnyFViFDItH8CiCNbu5SMJal2oVMCV4pbg=;
        b=LiG2mHX5Od8Q/LQ4ZTjckNK+y1vp1KT0X/VnWm3eQUqkFwh7uONktYzWUvMNpvgYcc
         lhkLhdrz5E9MnrBDtgNQ5RdutMtMnbgTXcaeGr+Qmk4NNNHPIgVEE374EhgBz6yq0Q+C
         SB76923dmg5DDObTtp/pAX48r+Yr88PM6P9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AhxpeOqpWnyFViFDItH8CiCNbu5SMJal2oVMCV4pbg=;
        b=gcQyCATBnjv+t72NihZAUMp+KDuih68bBspqdl8B6mGHY7jNdlqlo2Y2xV/yvW500y
         iQ1qP6jsc2vUAvdbMzHWCPhvTaF9Mf1TT2rkFtM+DaujkTQhSKQsEXmMBiocyngbzYne
         5L9ryI9Kkfe4CN7MmS8f7X/IFoxuZz4UIkgfncr8ibLKsTeaZZkj0Nc6BoGcLQEJAfhU
         ABppG4/j1MhPodKXfhwHnIay3o7+Lt8VWlCJeJWRQTpPZ7xmsSov0ynXMQnWCJEFwxx8
         tbnmqyDdhrkPY2np9tJEz/c+Kty23WIu2qOdfJZIOaSOQOxx7FBUrYRx68Cq/oJFzERc
         LhTg==
X-Gm-Message-State: AA+aEWYDc3aIAhUOLJdablw0q1gnWrDcLOAoDiB7i4sZRJNAhNqY0saS
        f/Slth0qATyQS9sU0zs0qhXJXKzoHVOeTsd9eDeAgg==
X-Google-Smtp-Source: AFSGD/UCBO4f8xsA5OAm/jdeKmMBIQCtC7FPR0WfZFuvoi6uzIjRtO7vnKb5vsgch/VJdDNa6o6CeMd47C75kf/3prw=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr1319531itb.152.1544514390569;
 Mon, 10 Dec 2018 23:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20181210210139.3336002-1-arnd@arndb.de>
In-Reply-To: <20181210210139.3336002-1-arnd@arndb.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 Dec 2018 08:46:19 +0100
Message-ID: <CAKfTPtDPjqdRjRTt=DH2UwzfDXKDt8jNvxdC9Lsh20SvteMpSQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: move capacity_margin definition into #ifdef
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, smuchun@gmail.com,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 10 Dec 2018 at 22:01, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Marking the variable static showed that it's only used for
> SMP builds, as seen from this warning:
>
> kernel/sched/fair.c:119:21: error: 'capacity_margin' defined but not used [-Werror=unused-variable]
>  static unsigned int capacity_margin   = 1280;

Olof sent a similar patch 2 weeks ago: https://lkml.org/lkml/2018/11/26/115

Vincent
>
> This has apparently been true since the variable has first been
> introduced, but only now started causing a compile time warning.
>
> Fixes: ed8885a14433 ("sched/fair: Make some variables static")
> Fixes: 3273163c6775 ("sched/fair: Let asymmetric CPU configurations balance at wake-up")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/sched/fair.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e30dea59d215..27928809e6ed 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -110,14 +110,6 @@ int __weak arch_asym_cpu_priority(int cpu)
>  unsigned int sysctl_sched_cfs_bandwidth_slice          = 5000UL;
>  #endif
>
> -/*
> - * The margin used when comparing utilization with CPU capacity:
> - * util * margin < capacity * 1024
> - *
> - * (default: ~20%)
> - */
> -static unsigned int capacity_margin                    = 1280;
> -
>  static inline void update_load_add(struct load_weight *lw, unsigned long inc)
>  {
>         lw->weight += inc;
> @@ -3046,6 +3038,14 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  }
>
>  #ifdef CONFIG_SMP
> +/*
> + * The margin used when comparing utilization with CPU capacity:
> + * util * margin < capacity * 1024
> + *
> + * (default: ~20%)
> + */
> +static unsigned int capacity_margin                    = 1280;
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  /**
>   * update_tg_load_avg - update the tg's load avg
> --
> 2.20.0
>
