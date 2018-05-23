Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeEWSFn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:05:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37619 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933706AbeEWSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:05:36 -0400
X-Google-Smtp-Source: AB8JxZoTlMyeAf7+JQ0JBxt6RqM+fmRnlhKIz//4fpP90a+ejNdfdLVYokIG2E+Di1zUT5IKwyP+uxlxhUAScfQbz78=
MIME-Version: 1.0
In-Reply-To: <20180523113321.20404-1-mlichvar@redhat.com>
References: <20180523113321.20404-1-mlichvar@redhat.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 23 May 2018 11:05:34 -0700
Message-ID: <CALAqxLVeOiLu+QAi6A_PGkvi9nxJXvy357kqYDATDnZO69WFqw@mail.gmail.com>
Subject: Re: [PATCH RFC] timekeeping: Update multiplier when NTP frequency is
 set directly
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 4:33 AM, Miroslav Lichvar <mlichvar@redhat.com> wrote:
> When the NTP frequency is set directly from userspace using the
> ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
> timekeeper's multiplier instead of waiting for the next tick.
>
> This removes a hidden non-deterministic delay in setting of the
> frequency and allows an extremely tight control of the system clock
> with update rates close to or even exceeding the kernel HZ.

Thanks for the patch!

I feel like we tried this years back, but had to revert it. But its
been awhile. Am I confusing things?


> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 49cbceef5deb..6922dae7317c 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2047,10 +2047,6 @@ void update_wall_time(void)
>                                    tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
>  #endif
>
> -       /* Check if there's really nothing to do */
> -       if (offset < real_tk->cycle_interval)
> -               goto out;
> -

Apologies again, as I don't have a lot of context here these days, but
 this could mean we end up doing unnecessary work on every
update_wall_time, no?

Would a "force" flag be better to pass to update_wall_time() to only
avoid the short-cut in the non-adjtimex case?

thanks
-john
