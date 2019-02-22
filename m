Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3744D2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550831773;
	bh=W7ngDEhpJslUHui2aEIu5kwwruY5rJux8qFNl5k6B0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sslv9hV75bU5TxFSJcI2AngAcqwHtrtjLt2Rron9lPtl8LvSQ6kocxk+jnxwM7J0o
	 kqJ2aey08QhkuOER9+bqD3WIXtO+lfLkbZKG29LA5jWPY2BL1ldzWrKcDXZlTN/1dC
	 ZCAXiw4xaqPIxrVwY7c0Ipwrtv8Dl1B1k62YGDx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBVKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:36:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46446 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfBVKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:36:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so1424734otl.13;
        Fri, 22 Feb 2019 02:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT4YK6Dl9fu+Gj5FYWy2t/QO4E1mlOkdFBA1dEPiFPM=;
        b=sQb2FEbhjqzl+nI/xww6ekYQ0bO7LSOddLSlKQNFFZOa+KFcLGPOnq4Rgy/5ws2Blg
         OoLYJ6HzhH3ZgLSvU7cA+y6yB+tzHyZALx4aB7A7gUeK+mEum/qNkWKgFibfXPPaF7jB
         wtCv4U0TZq7RxdzSBJxQ4qycZ2JqhF/MuWKrtjYFh3gdGmkoPOaLYKFy5tSz5werWLeT
         NdPhdB7nzImNdDP92ej9+j2EZ2m5jjXlqePsmouaCTB5tOxX5TTw8WkwXCFHqfhtT9c9
         IVMm5NmA64sXwwXi3KBWpo8qKVzfxjDZTzJkfTvmgBxASy8DMmLFpP+qct1yz3j1hGPL
         DPvg==
X-Gm-Message-State: AHQUAuba4+92czKI49Twdqyf9UX80ZnfOVf8E4ra1QVK0MoqrBBzfqH2
        ax5b5lYtVM2/FDAyZA16QmoB+33Kc5gd7DhKIY0lUuGz
X-Google-Smtp-Source: AHgI3IbjLSg7/ODT/P7jR9VVWiCCxt9oZW1N8Z0qB5qP4hOBJA0ktMxBlNlWCT7aCesbStwX50S+FObY35w60Y2dCiU=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr2095986otl.244.1550831769449;
 Fri, 22 Feb 2019 02:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com> <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org>
In-Reply-To: <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Feb 2019 11:35:58 +0100
Message-ID: <CAJZ5v0ishtmAJ4vyosedTY6ZY+RcenpP_yzwVAgGybONGU6Zsw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 6:40 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/02/2019 17:18, Rafael J. Wysocki wrote:
> > On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Predicting the next event on the current CPU is implemented in the
> >> idle state selection function, thus the selection logic and the
> >> prediction are tied together and it is hard to decorrelate both.
> >>
> >> The following change introduces the cpuidle function to give the
> >> opportunity to the governor to store the guess estimate of the
> >> different source of wakeup and then reuse them in the selection
> >> process. Consequently we end up with two separate operations clearly
> >> identified.
> >>
> >> As the next events are stored in the cpuidle device structure it is
> >> easy to propagate them in the different governor callbacks.
> >
> > Can you explain a bit how you would use this new callback in a governor?
>
> Sure.
>
> Today we have the selection and the prediction tied together. The
> prediction is modulated with some inputs coming from the governor's
> policy (eg. performance multiplier).
>
> It is hard to know if the prediction is correct or not, hard to know the
> duration of the computation for the next event and hard to know if the
> idle state selection succeeded because of a good prediction or a good
> governor policy.
>
> I propose to provide the callback where we fill the guess estimated next
> events on the system, so we can trace them and benchmark the computation
> time.
>
> The selection of the idle state becomes an separate action where we can
> apply any specific governor heuristic or policy.
>
> By separating the selection and the prediction, we can identify where
> the weakness is in our test scenario: the prediction or the governor
> selection policy.

I'm not quite convinced about the idea that the "prediction" and
"selection" parts can be entirely separate.

Besides, this new callback doesn't return anything, it goes before
->select and the latter is invoked unconditionally anyway.  That's
extra overhead (even if small) for no real gain.  I don't see why it
is better to do the split in the core rather than in the governor
itself.  You can always design a governor ->select() to call two
separate functions, one after another, internally, so why to do that
in the core and inflict that particular design choice on everybody?

For example, there's no "predict" part running before the "select" one
in the TEO governor at all.  There is something like that in menu, but
splitting it off would be rather artificial IMO.

Next, the cpuidle_predict structure.  I'm not even sure why it is there at all.

Presumably, the purpose of it is to pass some data from ->predict to
->select, but why does it have to be there in struct cpuidle_device?
The governor appears to be the only user of it anyway, so wouldn't it
be better to store that information in the governor's internal data
structures if really needed?

Moreover, why does it include the next_hrtimer and next_timer fields?
It looks like you'd need to do some nohz code surgery to separate the
two and would that be useful even?  And even so, these values need not
be predicted.  It is known when the next timer event is going to
occur, both with and without the scheduler tick included, and that's
why there is tick_nohz_get_sleep_length().

If you want to do a similar thing for non-timer interrupts in order to
use the IRQ stats, you can simply provide a function similar to
tick_nohz_get_sleep_length() for that, but that's available already,
isn't it?

Also, I'm not really sure what next_resched is and how exactly it is
going to be computed.

Thanks,
Rafael
