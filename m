Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeEVLlN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:41:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36468 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeEVLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:41:07 -0400
X-Google-Smtp-Source: AB8JxZoVJa5oaqSpslJo+Ve9Htv16dWnZRGuYuWD8oneNok/FueN+oX4WlcdhJXyJnR2A4q4upq2G3+COBljEemJ/Es=
MIME-Version: 1.0
In-Reply-To: <6238546.EnOBWIOf9o@aspire.rjw.lan>
References: <6238546.EnOBWIOf9o@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 May 2018 13:41:06 +0200
Message-ID: <CAPDyKFonGtpv+oEW5bm1XAO7VNuqRR7ZQ7NT5ow3OuoQJQPwmg@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix direct_complete handling for devices with
 no callbacks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Martitz <kugel@rockbox.org>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 2018 at 13:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE
> driver flags) inadvertently prevented the power.direct_complete flag
> from being set for devices without PM callbacks and with disabled
> runtime PM which also prevents power.direct_complete from being set
> for their parents.  That led to problems including a resume crash on
> HP ZBook 14u.
>
> Restore the previous behavior by causing power.direct_complete to be
> set for those devices again, but do that in a more direct way to
> avoid overlooking that case in the future.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags)
> Reported-by: Thomas Martitz <kugel@rockbox.org>
> Tested-by: Thomas Martitz <kugel@rockbox.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It seems like the resume path of HP ZBook 14u is kind of fragile, in
case it *requires* dev->power.direct_complete to be set for devices
like these. And that makes me wonder, that perhaps we should try to
address that issue as well, no?

In either way:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1920,10 +1920,8 @@ static int device_prepare(struct device
>
>         dev->power.wakeup_path = false;
>
> -       if (dev->power.no_pm_callbacks) {
> -               ret = 1;        /* Let device go direct_complete */
> +       if (dev->power.no_pm_callbacks)
>                 goto unlock;
> -       }
>
>         if (dev->pm_domain)
>                 callback = dev->pm_domain->ops.prepare;
> @@ -1957,7 +1955,8 @@ unlock:
>          */
>         spin_lock_irq(&dev->power.lock);
>         dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
> -               pm_runtime_suspended(dev) && ret > 0 &&
> +               ((pm_runtime_suspended(dev) && ret > 0) ||
> +                dev->power.no_pm_callbacks) &&
>                 !dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
>         spin_unlock_irq(&dev->power.lock);
>         return 0;
>
