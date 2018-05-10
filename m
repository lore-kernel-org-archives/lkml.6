Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeEJXhV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:37:21 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37138 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEJXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:37:19 -0400
X-Google-Smtp-Source: AB8JxZo69qpIKHkLa03cZhtdlGEKLcI2WFTb3XORMRqFKLH2FH2ZJ57JbfZMvr2kzEfghCYHAxyfhtwmivy0gs4oXIs=
MIME-Version: 1.0
In-Reply-To: <20180510233426.94514-1-rajatja@google.com>
References: <20180508230148.121852-1-rajatja@google.com> <20180510233426.94514-1-rajatja@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 10 May 2018 16:36:38 -0700
Message-ID: <CACK8Z6H_3VZFaUG02i5w_9GQnQRqto87X3YEg051xbtaXd5jqg@mail.gmail.com>
Subject: Re: [PATCH] PM / s2idle: Clear the events_check_enabled flag
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatxjain@gmail.com>
Cc: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore, sent by mistake.

On Thu, May 10, 2018 at 4:34 PM, Rajat Jain <rajatja@google.com> wrote:
> Problem: This flag does not get cleared currently in the suspend or
> resume path in the following cases:
>
> * In case some driver's suspend routine returns an error.
> * Successful s2idle case
> * etc?
>
> Why is this a problem: What happens is that the next suspend attempt
> could fail even though the user did not enable the flag by writing to
> /sys/power/wakeup_count. This is 1 use case how the issue can be seen
> (but similar use case with driver suspend failure can be thought of):
>
> 1. Read /sys/power/wakeup_count
> 2. echo count > /sys/power/wakeup_count
> 3. echo freeze > /sys/power/wakeup_count
> 4. Let the system suspend, and wakeup the system using some wake source
>    that calls pm_wakeup_event() e.g. power button or something.
> 5. Note that the combined wakeup count would be incremented due
>    to the pm_wakeup_event() in the resume path.
> 6. After resuming the events_check_enabled flag is still set.
>
> At this point if the user attempts to freeze again (without writing to
> /sys/power/wakeup_count), the suspend would fail even though there has
> been no wake event since the past resume.
>
> What this patch does:
>
> It moves the clearing of the flag to just before a resume is completed,
> so that it is always cleared for the corner cases mentioned above.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  kernel/power/suspend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index ccd2d20e6b06..0685c4499431 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -437,7 +437,6 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>                         error = suspend_ops->enter(state);
>                         trace_suspend_resume(TPS("machine_suspend"),
>                                 state, false);
> -                       events_check_enabled = false;
>                 } else if (*wakeup) {
>                         error = -EBUSY;
>                 }
> @@ -582,6 +581,7 @@ static int enter_state(suspend_state_t state)
>         pm_restore_gfp_mask();
>
>   Finish:
> +       events_check_enabled = false;
>         pm_pr_dbg("Finishing wakeup.\n");
>         suspend_finish();
>   Unlock:
> --
> 2.15.0.403.gc27cc4dac6-goog
>
