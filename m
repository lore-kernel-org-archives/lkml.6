Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965615AbeE2RmJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:42:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40210 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965376AbeE2RmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:42:08 -0400
X-Google-Smtp-Source: ADUXVKKqhI9OHHg2HE990EqLZs+LHovxluOHK7A38p0MWWQsEZahtltYd7U38aga3HWuNCLznuUixrLaKFD8NgAMWew=
MIME-Version: 1.0
In-Reply-To: <20180529105343.26870-1-mlichvar@redhat.com>
References: <20180529105343.26870-1-mlichvar@redhat.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 29 May 2018 10:42:05 -0700
Message-ID: <CALAqxLWV2d6yTeAK7j31Nvu33TqLmPLNDvzzSu0TSnDEUhVc1A@mail.gmail.com>
Subject: Re: [PATCHv1] timekeeping: Update multiplier when NTP frequency is
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

On Tue, May 29, 2018 at 3:53 AM, Miroslav Lichvar <mlichvar@redhat.com> wrote:
> When the NTP frequency is set directly from userspace using the
> ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
> timekeeper's multiplier instead of waiting for the next tick.
>
> This removes a hidden non-deterministic delay in setting of the
> frequency and allows an extremely tight control of the system clock
> with update rates close to or even exceeding the kernel HZ.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>
> Notes:
>     RFC->v1:
>     - added a new parameter to force the update of the timekeeper to the current
>       NTP tick length only from adjtimex()
>     - added timekeeping_advance() to keep the parameter local to timekeeping.c
>
>  kernel/time/timekeeping.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 49cbceef5deb..5524c07d43e3 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2021,11 +2021,11 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
>         return offset;
>  }
>
> -/**
> - * update_wall_time - Uses the current clocksource to increment the wall time
> - *
> +/*
> + * timekeeping_advance - Updates the timekeeper to the current time and
> + * current NTP tick length
>   */
> -void update_wall_time(void)
> +static void timekeeping_advance(bool force_update)

This is kind of a nit, but mind switching out bool for an enum?  Using
something like TK_ADV_NORMAL and TK_ADV_FORCE?

> +void update_wall_time(void)
> +{
> +       timekeeping_advance(false);
> +}

The enum makes usage like timekeeping_advance(false) a little less
opaque to the reader ("Wait, don't advance? Let me go look at the
function").

We got bitten by this earlier when we had the old
"timekeeping_update(tk, true, false, true)" usage.

thanks
-john
