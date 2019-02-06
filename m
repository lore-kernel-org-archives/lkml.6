Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7839F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfBFTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:32:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:63027 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:32:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 11:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="112930985"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 06 Feb 2019 11:32:45 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Feb 2019 21:32:45 +0200
Date:   Wed, 6 Feb 2019 21:32:45 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v3 2/3] drm/i915: Don't send MST hotplugs during resume
Message-ID: <20190206193245.GD20097@intel.com>
References: <20190129191001.442-1-lyude@redhat.com>
 <20190129191001.442-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129191001.442-3-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:10:00PM -0500, Lyude Paul wrote:
> We have a bad habit of calling drm_fb_helper_hotplug_event() far more
> then we actually need to. MST appears to be one of these cases, where we
> call drm_fb_helper_hotplug_event() if we fail to resume a connected MST
> topology in intel_dp_mst_resume(). We don't actually need to do this at
> all though since hotplug events are already sent from
> drm_dp_connector_destroy_work() every time connectors are unregistered
> from userspace's PoV. Additionally, extra calls to
> drm_fb_helper_hotplug_event() also just mean more of a chance of doing a
> connector probe somewhere we shouldn't.
> 
> So, don't send any hotplug events during resume if the MST topology
> fails to come up. Just rely on the DP MST helpers to send them for us.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
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

drm_dp_mst_topology_mgr_set_mst()
-> drm_dp_mst_topology_put_mstb()
   -> drm_dp_destroy_mst_branch_device()
      -> drm_dp_mst_topology_put_port()
         -> drm_dp_destroy_port()
	    -> drm_dp_destroy_connector_work()
	       -> drm_kms_helper_hotplug_event()

That of course requires that no one is hanging on to the
kref(s). The lifetime of the references isn't really clear
to me, but I'll take your word that it works.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +		}
>  	}
>  }
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
