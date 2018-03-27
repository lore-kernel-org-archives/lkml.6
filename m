Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeC0I3J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:29:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35723 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0I3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:29:07 -0400
X-Google-Smtp-Source: AG47ELvJ/whqo0GQo+2hbh32CufyTAEnSdNf9QddGSG0PALXQ0vYfvVfMAu3VcQS53EJpa7cy/3tWQ==
Date: Tue, 27 Mar 2018 10:29:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH 8/8] drm/arm/malidp: Added the late system pm functions
Message-ID: <20180327082903.GS14155@phenom.ffwll.local>
Mail-Followup-To: Ayan Kumar Halder <ayan.halder@arm.com>,
        liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
 <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522083800-30100-9-git-send-email-ayan.halder@arm.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 06:03:20PM +0100, Ayan Kumar Halder wrote:
> malidp_pm_suspend_late checks if the runtime status is not suspended
> and if so, invokes malidp_runtime_pm_suspend which disables the
> display engine/core interrupts and the clocks. It sets the runtime status
> as suspended. Subsequently, malidp_pm_resume_early will invoke
> malidp_runtime_pm_resume which enables the clocks and the interrupts
> (previously disabled) and sets the runtime status as active.
> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Change-Id: I5f8c3d28f076314a1c9da2a46760a9c37039ccda

Why exactly do you need late/early hooks? If you have dependencies with
other devices, pls consider adding device_links instead. This here
shouldn't be necessary.
-Daniel
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index bd44a6d..f6124d8 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
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
