Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCBC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA19920881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA19920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIMMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:15:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38357 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeIMMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:15:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5-v6so330260otl.5;
        Thu, 13 Sep 2018 00:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtFmj9djZDEqUBSs0R1oVCDr0VLzCsEd81o0wfGy7BM=;
        b=intnlRodeZr4myTe/I3Cs0dh4MKeJ2Mbhl/QiK1Rc/omjz7x2ZnCbkIBeI3oP4GjE5
         4NWmQErEql5ZLI73emSwj4N7oGV2V1U9DtJ36sH3aw7djyQNYGwqs8esZO7Vixouz22N
         XwWAq23zBAQpjx/bSw72ZJ+nsD5AWRU3x+FHoJ3x2thGo8amyAVwg5qHQVFO/T86xutb
         r5PIK+5rO3QjL6yvvXeyQvrBWoCu+vcPlf+ltDGz5Gn8Z9omv8EzSEmAscusqtjev9Ux
         rptd1RjCnhKnz+F9lZBiVm74ceo99vEJQVEPmM6wkJ1mcTN+OTho1JrER/4mdib4PbkP
         LH6w==
X-Gm-Message-State: APzg51AMt9ub2tEE5tqlVOnJOS34HrJ4nl5K8BhTOjIxc7Tw3jBpZK6R
        Q5zwY5HuypIITHNbQp87ih/qL5Q4lI8+5BvT0fg=
X-Google-Smtp-Source: ANB0VdY/zXz8WN5d3PV4SNODFJeDVcC+7F2U5gRow+UAgzTJUlYysHukjQD5aWykLghvWgUd5EPSfiwOO5t2bCc4+m8=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr422308otk.248.1536822421441;
 Thu, 13 Sep 2018 00:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180912161119.2692-1-vkuznets@redhat.com>
In-Reply-To: <20180912161119.2692-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Sep 2018 09:06:49 +0200
Message-ID: <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It is possible to observe hung_task complaints when system goes to
> suspend-to-idle state:
>
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>  sd 0:0:0:0: [sda] Synchronizing SCSI cache
>  INFO: task bash:1569 blocked for more than 120 seconds.
>        Not tainted 4.19.0-rc3_+ #687
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  bash            D    0  1569    604 0x00000000
>  Call Trace:
>   ? __schedule+0x1fe/0x7e0
>   schedule+0x28/0x80
>   suspend_devices_and_enter+0x4ac/0x750
>   pm_suspend+0x2c0/0x310

This actually is a good catch, but the problem is related to what
happens to the monotonic clock during suspend to idle.

The clock issue needs to be addressed anyway IMO and then this problem
will go away automatically.

> Register a PM notifier to disable the detector on suspend and re-enable
> back on wakeup.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> RFC: It really makes me wonder why nobody reported this before, makes
>  me think I'm missing something.
> ---
>  kernel/hung_task.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b9132d1269ef..d75f288c016f 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -15,6 +15,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/export.h>
>  #include <linux/sysctl.h>
> +#include <linux/suspend.h>
>  #include <linux/utsname.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> @@ -242,6 +243,24 @@ void reset_hung_task_detector(void)
>  }
>  EXPORT_SYMBOL_GPL(reset_hung_task_detector);
>
> +static bool hung_detector_suspended;
> +
> +static int hungtask_pm_notify(struct notifier_block *self,
> +                             unsigned long action, void *hcpu)
> +{
> +       switch (action) {
> +       case PM_SUSPEND_PREPARE:

You'd want PM_HIBERNATION_PREPARE here too I think.

> +               hung_detector_suspended = true;
> +               break;
> +       case PM_POST_SUSPEND:

And PM_POST_HIBERNATION here for consistency.

> +               hung_detector_suspended = false;
> +               break;
> +       default:
> +               break;
> +       }
> +       return NOTIFY_OK;
> +}
> +
>  /*
>   * kthread which checks for tasks stuck in D state
>   */
> @@ -261,7 +280,8 @@ static int watchdog(void *dummy)
>                 interval = min_t(unsigned long, interval, timeout);
>                 t = hung_timeout_jiffies(hung_last_checked, interval);
>                 if (t <= 0) {
> -                       if (!atomic_xchg(&reset_hung_task, 0))
> +                       if (!atomic_xchg(&reset_hung_task, 0) &&
> +                           !hung_detector_suspended)
>                                 check_hung_uninterruptible_tasks(timeout);
>                         hung_last_checked = jiffies;
>                         continue;
> @@ -275,6 +295,10 @@ static int watchdog(void *dummy)
>  static int __init hung_task_init(void)
>  {
>         atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +
> +       /* Disable hung task detector on suspend */
> +       pm_notifier(hungtask_pm_notify, 0);
> +
>         watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
>
>         return 0;
> --
> 2.14.4
>
