Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC85C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085DB20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBFTd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:33:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:12669 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBFTd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:33:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 11:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="144729719"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 06 Feb 2019 11:33:22 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Feb 2019 21:33:20 +0200
Date:   Wed, 6 Feb 2019 21:33:20 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v3 3/3] drm/i915: Don't send hotplug in
 intel_dp_check_mst_status()
Message-ID: <20190206193320.GE20097@intel.com>
References: <20190129191001.442-1-lyude@redhat.com>
 <20190129191001.442-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129191001.442-4-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:10:01PM -0500, Lyude Paul wrote:
> This hotplug also isn't needed: drm_dp_mst_topology_mgr_set_mst()
> already sends a hotplug on its own from drm_dp_destroy_connector_work()
> after destroying connectors in the MST topology.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/intel_dp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index c2399acf177b..f9113c0cdfcd 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -4608,12 +4608,10 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
>  
>  			return ret;
>  		} else {
> -			struct intel_digital_port *intel_dig_port = dp_to_dig_port(intel_dp);
>  			DRM_DEBUG_KMS("failed to get ESI - device may have failed\n");
>  			intel_dp->is_mst = false;
> -			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr, intel_dp->is_mst);
> -			/* send a hotplug event */
> -			drm_kms_helper_hotplug_event(intel_dig_port->base.base.dev);
> +			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
> +							intel_dp->is_mst);
>  		}
>  	}
>  	return -EINVAL;
> -- 
> 2.20.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
