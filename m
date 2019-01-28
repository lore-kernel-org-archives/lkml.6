Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBBF21773
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1Mot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:44:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:36642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Mot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:44:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 04:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="138469864"
Received: from ideak-desk.fi.intel.com ([10.237.72.62])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2019 04:44:45 -0800
Date:   Mon, 28 Jan 2019 14:44:45 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, Todd Previte <tprevite@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Don't send MST hotplugs until
 after resume
Message-ID: <20190128124445.GG12107@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20190126012436.31382-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126012436.31382-1-lyude@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 08:24:35PM -0500, Lyude Paul wrote:
> Turns out we are sending a lot more hotplug events then we need, and
> this is causing some pretty serious issues. Currently, we call
> intel_dp_mst_resume() in i915_drm_resume() well before we have any sort
> of hotplugging setup.

We call hpd_irq_setup() before calling intel_dp_mst_resume(). The only
purpose of that part (lifted out from intel_hpd_init()) is to provide
the short HPD interrupt functionality MST AUX transfers need.

But you are right in that - as a side-effect - we'll also enable generic
hotplug functionality that is independent of the above MST requirement.
Doing that kind of generic hotplug processing before
intel_display_resume() is probably not a good idea, it can interfere at
least with the mode restore in __intel_display_resume().

> This is a pretty big problem, because in practice it will generally
> result in throwing the power domain refcounts out of wack.
> 
> For instance: On my T480s, removing a previously connected topology
> before the system finishes resuming causes
> drm_kms_helper_hotplug_event() to be called before HPD is setup again,
> which causes us to do a connector reprobe, which then causes
> intel_dp_detect() to be called on all DP devices -including- the eDP
> display. From there, intel_dp_detect() is run on the eDP display which
> triggers DPCD transactions. Those DPCD transactions then cause us to
> call edp_panel_vdd_on(), which then causes us to grab an additional
> wakeref to the relevant power wells (PORT_DDI_A_IO on this machine).
> From there, this wakeref is never released which then causes the next
> suspend/resume cycle to entirely fail due to the hardware not being
> powered off correctly.
> 
> This sucks really badly, and I don't see any decent way to actually fix
> this in intel_dp_detect() easily. Additionally, I don't even think it'd
> be worth the time now since we're not expecting to handle any kind of
> connector reprobing at the point in which we call intel_dp_mst_resume(),
> but we also can't move intel_dp_mst_resume() any higher in the resume
> process since MST topologies need to be resumed before
> intel_display_resume() is called.
> 
> However, there's a light at the end of the tunnel! After reading through
> a lot of code dozens of times, it occurred to me that we -never-
> actually need to send hotplug events when calling
> drm_dp_mst_topology_mgr_set_mst() since we send hotplug events in
> drm_dp_destroy_connector_work(). Imagine that!
> 
> So, since we only seem to call intel_dp_mst_check_status() to disable
> MST on the encoder in question and then send a hotplug, get rid of this
> and instead just disable MST mode when a hub fails in
> intel_dp_mst_resume(). From there, drm_dp_destroy_connector_work() will
> eventually send the hotplug event.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 0e32b39ceed6 ("drm/i915: add DP 1.2 MST support (v0.7)")
> Cc: Todd Previte <tprevite@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.17+

Not knowing enough about the MST code, but we do need to prevent
generic hotplug processing at this point:

Acked-by: Imre Deak <imre.deak@intel.com>


> ---
>  drivers/gpu/drm/i915/intel_dp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 681e88405ada..c2399acf177b 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -7096,7 +7096,10 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
>  			continue;
>  
>  		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
> -		if (ret)
> -			intel_dp_check_mst_status(intel_dp);
> +		if (ret) {
> +			intel_dp->is_mst = false;
> +			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
> +							false);
> +		}
>  	}
>  }
> -- 
> 2.20.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
