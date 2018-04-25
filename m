Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDYHR1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:17:27 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53057 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDYHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:17:26 -0400
X-Google-Smtp-Source: AIpwx480nIERWJng79JdzVhOauGgx5sJIV+vpLWXpJafL4Y6ENyk5yn6tO5sHsOqGvNzkG3kRZYQ+Q==
Date: Wed, 25 Apr 2018 09:17:22 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180425071722.GN25142@phenom.ffwll.local>
Mail-Followup-To: Ayan Kumar Halder <ayan.halder@arm.com>,
        liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
 <1524593567-5559-6-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524593567-5559-6-git-send-email-ayan.halder@arm.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 07:12:47PM +0100, Ayan Kumar Halder wrote:
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

Afaiui we still haven't bottomed out on the discussion on v1. Did you get
hold of Rafael?
-Daniel

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
>  	return 0;
>  }
>  
> +static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
> +{
> +	if (!pm_runtime_status_suspended(dev)) {
> +		malidp_runtime_pm_suspend(dev);
> +		pm_runtime_set_suspended(dev);
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused malidp_pm_resume_early(struct device *dev)
> +{
> +	malidp_runtime_pm_resume(dev);
> +	pm_runtime_set_active(dev);
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops malidp_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
>  	SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
>  };
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
