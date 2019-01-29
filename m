Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0720C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C54C2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfA2LuF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:05 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:58339 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731557AbfA2LuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:01 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15388704-1500050 
        for multiple; Tue, 29 Jan 2019 11:49:46 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190128205603.16372-2-lyude@redhat.com>
Cc:     Todd Previte <tprevite@gmail.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>
References: <20190128205603.16372-1-lyude@redhat.com>
 <20190128205603.16372-2-lyude@redhat.com>
Message-ID: <154876258326.22998.16834385719676742479@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH v2 1/3] drm/i915: Block fbdev HPD processing during
 suspend
Date:   Tue, 29 Jan 2019 11:49:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lyude Paul (2019-01-28 20:56:01)
> When resuming, we check whether or not any previously connected
> MST topologies are still present and if so, attempt to resume them. If
> this fails, we disable said MST topologies and fire off a hotplug event
> so that userspace knows to reprobe.
> 
> However, sending a hotplug event involves calling
> drm_fb_helper_hotplug_event(), which in turn results in fbcon doing a
> connector reprobe in the caller's thread - something we can't do at the
> point in which i915 calls drm_dp_mst_topology_mgr_resume() since
> hotplugging hasn't been fully initialized yet.
> 
> This currently causes some rather subtle but fatal issues. For example,
> on my T480s the laptop dock connected to it usually disappears during a
> suspend cycle, and comes back up a short while after the system has been
> resumed. This guarantees pretty much every suspend and resume cycle,
> drm_dp_mst_topology_mgr_set_mst(mgr, false); will be caused and in turn,
> a connector hotplug will occur. Now it's Rute Goldberg time: when the
> connector hotplug occurs, i915 reprobes /all/ of the connectors,
> including eDP. However, eDP probing requires that we power on the panel
> VDD which in turn, grabs a wakeref to the appropriate power domain on
> the GPU (on my T480s, this is the PORT_DDI_A_IO domain). This is where
> things start breaking, since this all happens before
> intel_power_domains_enable() is called we end up leaking the wakeref
> that was acquired and never releasing it later. Come next suspend/resume
> cycle, this causes us to fail to shut down the GPU properly, which
> causes it not to resume properly and die a horrible complicated death.
> 
> (as a note: this only happens when there's both an eDP panel and MST
> topology connected which is removed mid-suspend. One or the other seems
> to always be OK).
> 
> We could try to fix the VDD wakeref leak, but this doesn't seem like
> it's worth it at all since we aren't able to handle hotplug detection
> while resuming anyway. So, let's go with a more robust solution inspired
> by nouveau: block fbdev from handling hotplug events until we resume
> fbdev. This allows us to still send sysfs hotplug events to be handled
> later by user space while we're resuming, while also preventing us from
> actually processing any hotplug events we receive until it's safe.
> 
> This fixes the wakeref leak observed on the T480s and as such, also
> fixes suspend/resume with MST topologies connected on this machine.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 0e32b39ceed6 ("drm/i915: add DP 1.2 MST support (v0.7)")
> Cc: Todd Previte <tprevite@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.17+
> ---
>  drivers/gpu/drm/i915/intel_drv.h   | 10 ++++++++++
>  drivers/gpu/drm/i915/intel_fbdev.c | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
> index 85b913ea6e80..c8549588b2ce 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -213,6 +213,16 @@ struct intel_fbdev {
>         unsigned long vma_flags;
>         async_cookie_t cookie;
>         int preferred_bpp;
> +
> +       /* Whether or not fbdev hpd processing is temporarily suspended */
> +       bool hpd_suspended : 1;
> +       /* Set when a hotplug was received while HPD processing was
> +        * suspended
> +        */
> +       bool hpd_waiting : 1;
> +
> +       /* Protects hpd_suspended */
> +       struct mutex hpd_lock;
>  };
>  
>  struct intel_encoder {
> diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
> index 8cf3efe88f02..3a6c0bebaaf9 100644
> --- a/drivers/gpu/drm/i915/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/intel_fbdev.c
> @@ -681,6 +681,7 @@ int intel_fbdev_init(struct drm_device *dev)
>         if (ifbdev == NULL)
>                 return -ENOMEM;
>  
> +       mutex_init(&ifbdev->hpd_lock);
>         drm_fb_helper_prepare(dev, &ifbdev->helper, &intel_fb_helper_funcs);
>  
>         if (!intel_fbdev_init_bios(dev, ifbdev))
> @@ -754,6 +755,23 @@ void intel_fbdev_fini(struct drm_i915_private *dev_priv)
>         intel_fbdev_destroy(ifbdev);
>  }
>  
> +/* Suspends/resumes fbdev processing of incoming HPD events. When resuming HPD
> + * processing, fbdev will perform a full connector reprobe if a hotplug event
> + * was received while HPD was suspended.
> + */
> +static void intel_fbdev_hpd_set_suspend(struct intel_fbdev *ifbdev, int state)
> +{
> +       mutex_lock(&ifbdev->hpd_lock);
> +       ifbdev->hpd_suspended = state == FBINFO_STATE_SUSPENDED;
> +       if (ifbdev->hpd_waiting) {
> +               ifbdev->hpd_waiting = false;
> +
> +               DRM_DEBUG_KMS("Handling delayed fbcon HPD event\n");
> +               drm_fb_helper_hotplug_event(&ifbdev->helper);

Even when set_suspend(true) ?

Then on resume, we don't care as another hotplug is generated. Calling
the hotplug_even from under the mutex feels like unnecessary lock
spreading.

> +       }
> +       mutex_unlock(&ifbdev->hpd_lock);

I am thinking along the lines of:

bool send_event = false;

mutex_lock(&hpd_lock);
ifbdev->hpd_suspended = state == SUSPENDED;
send_event = !hpd_suspended && hpd_waiting;
hpd_waiting = false;
mutex_unlock(&hpd_lock)

if (send_event) {
	DRM_DEBUG_KMS("Handling delayed fbcon HPD event\n");
	drm_fb_helper_hotplug_event(&ifbdev->helper);
}

>  void intel_fbdev_output_poll_changed(struct drm_device *dev)
> @@ -812,8 +833,15 @@ void intel_fbdev_output_poll_changed(struct drm_device *dev)
>                 return;
>  
>         intel_fbdev_sync(ifbdev);
> -       if (ifbdev->vma || ifbdev->helper.deferred_setup)
> +
> +       mutex_lock(&ifbdev->hpd_lock);
> +       if (ifbdev->hpd_suspended) {
> +               DRM_DEBUG_KMS("fbdev HPD event deferred until resume\n");
> +               ifbdev->hpd_waiting = true;
> +       } else if (ifbdev->vma || ifbdev->helper.deferred_setup) {
>                 drm_fb_helper_hotplug_event(&ifbdev->helper);
> +       }

Seems ripe for simplification. We can always just set hpd_waiting as it
will be reset over suspend, so then we just need a way of tidying up the
"am I ready to send" check.
-Chris
