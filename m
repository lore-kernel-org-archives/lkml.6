Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13B221852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxBtgmJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeLTOeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:34:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54983 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732776AbeLTOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:34:03 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so2263831ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpjnLvfPesi+n8ZtrEozXE0ZVqAvThnxzlXWBx6UzfQ=;
        b=OxBtgmJ4i/P9SVpfAI08Ki9+cPgEoGot0IDl/XmC3S9So2dlbOSPAJ9OaT2AWU+xnY
         sgNEmfdRDO/DtAF2sORe6BQaaiNYIbNOn6wjvCP9GcL7CsdXzPcdXoDZR6x5An1FNfVV
         oCQjCvBba2fW2d3ZKrNWD6kXQFMJBpv0KuLWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpjnLvfPesi+n8ZtrEozXE0ZVqAvThnxzlXWBx6UzfQ=;
        b=uXRm4xE3xOeLKTvzlLbeSSONvYFunR42J24yQLTj37cXlnC+u4/jqU9hQ2UVNQjHAG
         wU4cDeBPTt/kYAPGwb4zohsKBbwO21H+jg4hJDTN35iIrW6NLL7MKXSrCKN7b73qiEb4
         /hDSMNifIPrg/wAdsrM3W8nD3nEzh2Zxja3T6c4bsM+YQ+a49kUTSnv/Agrsb/MRnSuv
         bxTZ5zVzTdxACwrC6yAd1syvHFS9X8Fn4p2wLw7WxRSlzTko1cBw8g52w69Zm5oS41i4
         3M53czwu1eHrSoaDhfRGj07cpPyYG5+Lz3qpLknorLy5BRK1IzKVKftlLrKWp1fRtf+6
         9+UQ==
X-Gm-Message-State: AA+aEWZRzj+fx+y7PEbYdabDP2LDr1VVRn48c+Mc9Zn7fUqcIK6I+ioF
        DXWPofFGhIdiiClhfIOyuVseJwleCHSn61ipQch+bA==
X-Google-Smtp-Source: AFSGD/UnkLJSCHr4Qb5ptNp2e/bP/0glP0uVF33W3NfYhnarfWcZOUYdZwHne5tYiTzAmTxZPF875xJT0uN1NiTXZDI=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr9600130itk.114.1545316442128;
 Thu, 20 Dec 2018 06:34:02 -0800 (PST)
MIME-Version: 1.0
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-3-git-send-email-vincent.guittot@linaro.org> <edd9f36f-7826-11db-94ff-1604a4be11d0@arm.com>
In-Reply-To: <edd9f36f-7826-11db-94ff-1604a4be11d0@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Dec 2018 15:33:51 +0100
Message-ID: <CAKfTPtCxCpHJwsfJQht4ux-Fqm9u27vZQM4ExkLFLdWGS=JvAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: trigger asym_packing during idle load balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 12:19, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 20/12/2018 07:55, Vincent Guittot wrote:
> > newly idle load balance is not always triggered when a cpu becomes idle.
> > This prevent the scheduler to get a chance to migrate task for asym packing.
> > Enable active migration because of asym packing during idle load balance too.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9b31247..487c73e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8853,7 +8853,7 @@ static int need_active_balance(struct lb_env *env)
> >  {
> >       struct sched_domain *sd = env->sd;
> >
> > -     if (env->idle == CPU_NEWLY_IDLE) {
> > +     if (env->idle != CPU_NOT_IDLE) {
> >
> >               /*
> >                * ASYM_PACKING needs to force migrate tasks from busy but
> >
>
> Regarding just extending the condition to include idle balance:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
>
> As in the previous thread, I'll still argue that if you want to *reliably*
> exploit newidle balances to do asym packing active balancing, you should
> add some logic to raise rq->rd->overload when we notice some asym packing
> could be done, so that it can be leveraged by a higher-priority CPU doing
> a newidle balance.

The source cpu with the task is never overloaded.
We need to start the load balance to know that it's worth migrating the task.

>
> Otherwise the few newidle asym-packing active balances you'll get will be
> due to somewhat random luck because we happened to set that overload flag
> at some point.
