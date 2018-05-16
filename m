Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeEPKi4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:38:56 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35115 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeEPKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:38:55 -0400
X-Google-Smtp-Source: AB8JxZrqDuDwXe0hfGXYpRlyK9bjDNSS6eQZz+h6cQTm1wNJSDtmbNeUWN7qNCB/0Vh3q2aP2CVz0mAWcHewerqV8ZE=
MIME-Version: 1.0
In-Reply-To: <1526400259-7573-6-git-send-email-ayan.halder@arm.com>
References: <1526400259-7573-1-git-send-email-ayan.halder@arm.com> <1526400259-7573-6-git-send-email-ayan.halder@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 May 2018 12:38:54 +0200
X-Google-Sender-Auth: 6WvFpTBQ6IbAiB549rT5doxsOzc
Message-ID: <CAJZ5v0juz3uWRPyhtd7EWSga4oM4PGaSyNzZVOnrXpgxJwyhCA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, Brian Starkey <brian.starkey@arm.com>,
        malidp@foss.arm.com, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 6:04 PM, Ayan Kumar Halder <ayan.halder@arm.com> wrote:
> malidp_pm_suspend_late checks if the runtime status is not suspended
> and if so, invokes malidp_runtime_pm_suspend which disables the
> display engine/core interrupts and the clocks. It sets the runtime status
> as suspended.
>
> The difference between suspend() and suspend_late() is as follows:-
> 1. suspend() makes the device quiescent. In our case, we invoke the DRM
> helper which disables the CRTC. This would have invoked runtime pm
> suspend but the system suspend process disables runtime pm.
> 2. suspend_late() It continues the suspend operations of the drm device
> which was started by suspend(). In our case, it performs the same functionality
> as runtime_suspend().
>
> The complimentary functions are resume() and resume_early(). In the case of
> resume_early(), we invoke malidp_runtime_pm_resume() which enables the clocks
> and the interrupts. It sets the runtime status as active. If the device was
> in runtime suspend mode before system suspend was called, pm_runtime_work()
> will put the device back in runtime suspended mode( after the complete system
> has been resumed).
>
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>
> ---
> Changes in v3:-
> - Rebased on top of earlier v3 patches,
>
> Changes in v2:-
> - Removed the change id and modified the commit message
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 82221ea..c53b46a 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -768,8 +768,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
>         return 0;
>  }
>
> +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
> +{
> +       if (!pm_runtime_status_suspended(dev)) {
> +               malidp_runtime_pm_suspend(dev);
> +               pm_runtime_set_suspended(dev);
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
> +{
> +       malidp_runtime_pm_resume(dev);
> +       pm_runtime_set_active(dev);
> +       return 0;
> +}
> +
>  static const struct dev_pm_ops malidp_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
>         SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
>  };
>
> --

AFAICS, this should work, so please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it if that helps.
