Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeBLRqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:46:16 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34261 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeBLRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:46:14 -0500
X-Google-Smtp-Source: AH8x226ThaTnQSccIc0Gd1VHe+5XnOvHI3JIt7i5PIwVMjBLsLMdYoMD+xX18TCcmcK9cfUQruNSkA==
Message-ID: <1518457571.5319.7.camel@redhat.com>
Subject: Re: [PATCH 2/5] drm: Allow determining if current task is output
 poll worker
From: Lyude Paul <lyude@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>, linux-kernel@vger.kernel.org,
        Ismo Toijala <ismo.toijala@gmail.com>, intel-gfx@lists.freedesktop.org,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Archit Taneja <architt@codeaurora.org>
Date: Mon, 12 Feb 2018 12:46:11 -0500
In-Reply-To: <7831d4f21dde8cd0b1659e393854598995dfb249.1518338788.git.lukas@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
         <7831d4f21dde8cd0b1659e393854598995dfb249.1518338788.git.lukas@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-11 at 10:38 +0100, Lukas Wunner wrote:
> Introduce a helper to determine if the current task is an output poll
> worker.
> 
> This allows us to fix a long-standing deadlock in several DRM drivers
> wherein the ->runtime_suspend callback waits for the output poll worker
> to finish and the worker in turn calls a ->detect callback which waits
> for runtime suspend to finish.  The ->detect callback is invoked from
> multiple call sites and waiting for runtime suspend to finish is the
> correct thing to do except if it's executing in the context of the
> worker.
> 
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 14 ++++++++++++++
>  include/drm/drm_crtc_helper.h      |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c
> b/drivers/gpu/drm/drm_probe_helper.c
> index 555fbe54d6e2..019881d15ce1 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -653,6 +653,20 @@ static void output_poll_execute(struct work_struct
> *work)
>  		schedule_delayed_work(delayed_work,
> DRM_OUTPUT_POLL_PERIOD);
>  }
>  
> +/**
> + * drm_kms_helper_is_poll_worker - is %current task an output poll worker?
> + *
> + * Determine if %current task is an output poll worker.  This can be used
> + * to select distinct code paths for output polling versus other contexts.
> + */
For this, it would be worth explicitly noting in the comments herethat this
should be called by DRM drivers in order to prevent racing with hotplug
polling workers, so that new drivers in the future can avoid implementing this
race condition in their driver.

> +bool drm_kms_helper_is_poll_worker(void)
> +{
> +	struct work_struct *work = current_work();
> +
> +	return work && work->func == output_poll_execute;
> +}
> +EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
> +
>  /**
>   * drm_kms_helper_poll_disable - disable output polling
>   * @dev: drm_device
> diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
> index 76e237bd989b..6914633037a5 100644
> --- a/include/drm/drm_crtc_helper.h
> +++ b/include/drm/drm_crtc_helper.h
> @@ -77,5 +77,6 @@ void drm_kms_helper_hotplug_event(struct drm_device *dev);
>  
>  void drm_kms_helper_poll_disable(struct drm_device *dev);
>  void drm_kms_helper_poll_enable(struct drm_device *dev);
> +bool drm_kms_helper_is_poll_worker(void);
>  
>  #endif
-- 
Cheers,
	Lyude Paul
