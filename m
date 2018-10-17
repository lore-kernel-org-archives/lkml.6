Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB99ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695302151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695302151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQP1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:27:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40673 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeJQP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:27:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so25193942ota.7;
        Wed, 17 Oct 2018 00:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqmsMVNo0twCcj0fFEXS/qA3tiQNjli7UOaEwVtH0Y0=;
        b=MRYRz9ghXlx2y1L/SVJvvCV14+VvvNZx3h+D/eszTC0f3PfMjq2um4q/Z6yqle8AtO
         VY+s8b124+IjCqOSdZyPdwdQ9deKVtrMrnWA3GcnBoHQO0L+18h8h0ZNzS/MkMAxaHD7
         OMQK8DZXwEG10GXoqLd592Rg2ZDeLtWblBBZlNNXBYTuBlvJI3lidmuteRX2ZnqAThNE
         CyRfq5xVtU/e0WSKc927K4AuKzVgnexShmjz3XP3kem4WWna5NjwxllJgKH9hl5/wFcS
         YlOjTDUQ0f4oVcnij8R5oJfkrlJUfxin5iHv2rC3mQNxsz8+8SRcezFMdwx5d5geieqv
         FpFA==
X-Gm-Message-State: ABuFfogujUbKv1OQgWcYa234MTQnNxooYFJ2OulXsLPLg/wFeZ1X85EX
        WLesXmvURLx7G+p4dW79xEZw8+kRdEGxQwhJ8SA=
X-Google-Smtp-Source: ACcGV61siK7CFNkZZS9yYbNdL5mGuBGcOhhoDIzBsrwWDIuv0Q5KqFLfcROo7dLvlpzep01mlLvJaTgHOX/j+wowJic=
X-Received: by 2002:a9d:5549:: with SMTP id h9mr3216711oti.244.1539761579845;
 Wed, 17 Oct 2018 00:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181016165513.7133-1-vkuznets@redhat.com>
In-Reply-To: <20181016165513.7133-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Oct 2018 09:32:48 +0200
Message-ID: <CAJZ5v0iiaShTFSvaFaGyzTHaQsPHtHqou=BxDTOsJ1VEAyrfnQ@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/hung_task.c: disable on suspend
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:55 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It is possible to observe hung_task complaints when system goes to
> suspend-to-idle state:
>
>  # echo freeze > /sys/power/state
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
>
> Register a PM notifier to disable the detector on suspend and re-enable
> back on wakeup.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
> - Resurrect 'v1' as zeroing timeouts can be racy [Rafael J. Wysocki]
> ---
>  kernel/hung_task.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b9132d1269ef..41955c5d8427 100644
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
> @@ -242,6 +243,26 @@ void reset_hung_task_detector(void)
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
> +       case PM_HIBERNATION_PREPARE:

Please add PM_RESTORE_PREPARE here ->

> +               hung_detector_suspended = true;
> +               break;
> +       case PM_POST_SUSPEND:
> +       case PM_POST_HIBERNATION:

-> and PM_POST_RESTORE here for completeness.

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
> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
>                 interval = min_t(unsigned long, interval, timeout);
>                 t = hung_timeout_jiffies(hung_last_checked, interval);
>                 if (t <= 0) {
> -                       if (!atomic_xchg(&reset_hung_task, 0))
> +                       if (!atomic_xchg(&reset_hung_task, 0) &&
> +                           !hung_detector_suspended)
>                                 check_hung_uninterruptible_tasks(timeout);
>                         hung_last_checked = jiffies;
>                         continue;
> @@ -275,6 +297,10 @@ static int watchdog(void *dummy)
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

Apart from the above it is fine by me.

This is the minimum fix for the issue at hand AFAICS.

Thanks,
Rafael
