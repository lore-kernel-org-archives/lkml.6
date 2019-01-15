Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8627AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359F620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfAONSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:18:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:49248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbfAONSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:18:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 05:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="116907910"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 15 Jan 2019 05:18:06 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 15 Jan 2019 15:18:05 +0200
Date:   Tue, 15 Jan 2019 15:18:05 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Pass down rc in intel_encoder->compute_config()
Message-ID: <20190115131805.GH20097@intel.com>
References: <20190114222931.25711-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114222931.25711-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 05:29:31PM -0500, Lyude Paul wrote:
> Something that I completely missed when implementing the new MST VCPI
> atomic helpers is that with those helpers, there's technically a chance
> of us having to grab additional modeset locks in ->compute_config() and
> furthermore, that means we have the potential to hit a normal modeset
> deadlock. However, because ->compute_config() only returns a bool this
> means we can't return -EDEADLK when we need to drop locks and try again
> which means we end up just failing the atomic check permanently. Whoops.
> 
> So, fix this by modifying ->compute_config() to pass down an actual
> error code instead of a bool so that the atomic check can be restarted
> on modeset deadlocks.
> 
> Thanks to Ville Syrjälä for pointing this out!
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109320
> ---
>  drivers/gpu/drm/i915/icl_dsi.c       |  8 +++----
>  drivers/gpu/drm/i915/intel_crt.c     | 34 ++++++++++++++--------------
>  drivers/gpu/drm/i915/intel_ddi.c     |  6 ++---
>  drivers/gpu/drm/i915/intel_display.c | 11 +++++----
>  drivers/gpu/drm/i915/intel_dp.c      | 32 +++++++++++++-------------
>  drivers/gpu/drm/i915/intel_dp_mst.c  | 12 +++++-----
>  drivers/gpu/drm/i915/intel_drv.h     | 18 +++++++--------
>  drivers/gpu/drm/i915/intel_dvo.c     | 10 ++++----
>  drivers/gpu/drm/i915/intel_hdmi.c    | 12 +++++-----
>  drivers/gpu/drm/i915/intel_lvds.c    | 12 +++++-----
>  drivers/gpu/drm/i915/intel_sdvo.c    | 14 ++++++------
>  drivers/gpu/drm/i915/intel_tv.c      |  8 +++----
>  drivers/gpu/drm/i915/vlv_dsi.c       | 14 ++++++------
>  13 files changed, 97 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/icl_dsi.c b/drivers/gpu/drm/i915/icl_dsi.c
> index f3a5f03646ce..355b48d1c937 100644
> --- a/drivers/gpu/drm/i915/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/icl_dsi.c
> @@ -1188,9 +1188,9 @@ static void gen11_dsi_get_config(struct intel_encoder *encoder,
>  	pipe_config->output_types |= BIT(INTEL_OUTPUT_DSI);
>  }
>  
> -static bool gen11_dsi_compute_config(struct intel_encoder *encoder,
> -				     struct intel_crtc_state *pipe_config,
> -				     struct drm_connector_state *conn_state)
> +static int gen11_dsi_compute_config(struct intel_encoder *encoder,
> +				    struct intel_crtc_state *pipe_config,
> +				    struct drm_connector_state *conn_state)
>  {
>  	struct intel_dsi *intel_dsi = container_of(encoder, struct intel_dsi,
>  						   base);
> @@ -1215,7 +1215,7 @@ static bool gen11_dsi_compute_config(struct intel_encoder *encoder,
>  	pipe_config->clock_set = true;
>  	pipe_config->port_clock = intel_dsi_bitrate(intel_dsi) / 5;
>  
> -	return true;
> +	return 0;
>  }
>  
>  static u64 gen11_dsi_get_power_domains(struct intel_encoder *encoder,
> diff --git a/drivers/gpu/drm/i915/intel_crt.c b/drivers/gpu/drm/i915/intel_crt.c
> index 33bd2addcbdd..625794883433 100644
> --- a/drivers/gpu/drm/i915/intel_crt.c
> +++ b/drivers/gpu/drm/i915/intel_crt.c
> @@ -345,51 +345,51 @@ intel_crt_mode_valid(struct drm_connector *connector,
>  	return MODE_OK;
>  }
>  
> -static bool intel_crt_compute_config(struct intel_encoder *encoder,
> -				     struct intel_crtc_state *pipe_config,
> -				     struct drm_connector_state *conn_state)
> +static int intel_crt_compute_config(struct intel_encoder *encoder,
> +				    struct intel_crtc_state *pipe_config,
> +				    struct drm_connector_state *conn_state)
>  {
>  	struct drm_display_mode *adjusted_mode =
>  		&pipe_config->base.adjusted_mode;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;

Please add a newline here while at it.

> -	return true;
> +	return 0;
>  }
>  
> -static bool pch_crt_compute_config(struct intel_encoder *encoder,
> -				   struct intel_crtc_state *pipe_config,
> -				   struct drm_connector_state *conn_state)
> +static int pch_crt_compute_config(struct intel_encoder *encoder,
> +				  struct intel_crtc_state *pipe_config,
> +				  struct drm_connector_state *conn_state)
>  {
>  	struct drm_display_mode *adjusted_mode =
>  		&pipe_config->base.adjusted_mode;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->has_pch_encoder = true;
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
>  
> -	return true;
> +	return 0;
>  }
>  
> -static bool hsw_crt_compute_config(struct intel_encoder *encoder,
> -				   struct intel_crtc_state *pipe_config,
> -				   struct drm_connector_state *conn_state)
> +static int hsw_crt_compute_config(struct intel_encoder *encoder,
> +				  struct intel_crtc_state *pipe_config,
> +				  struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  	struct drm_display_mode *adjusted_mode =
>  		&pipe_config->base.adjusted_mode;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	/* HSW/BDW FDI limited to 4k */
>  	if (adjusted_mode->crtc_hdisplay > 4096 ||
>  	    adjusted_mode->crtc_hblank_start > 4096)
> -		return false;
> +		return -ENOSPC;

I'd go with -EINVAL here.

>  
>  	pipe_config->has_pch_encoder = true;
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
> @@ -398,7 +398,7 @@ static bool hsw_crt_compute_config(struct intel_encoder *encoder,
>  	if (HAS_PCH_LPT(dev_priv)) {
>  		if (pipe_config->bw_constrained && pipe_config->pipe_bpp < 24) {
>  			DRM_DEBUG_KMS("LPT only supports 24bpp\n");
> -			return false;
> +			return -EINVAL;
>  		}
>  
>  		pipe_config->pipe_bpp = 24;
> @@ -407,7 +407,7 @@ static bool hsw_crt_compute_config(struct intel_encoder *encoder,
>  	/* FDI must always be 2.7 GHz */
>  	pipe_config->port_clock = 135000 * 2;
>  
> -	return true;
> +	return 0;
>  }
>  
>  static bool intel_ironlake_crt_detect_hotplug(struct drm_connector *connector)
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> index 7f3cd055de50..ce44744a5f9d 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -3837,9 +3837,9 @@ intel_ddi_compute_output_type(struct intel_encoder *encoder,
>  	}
>  }
>  
> -static bool intel_ddi_compute_config(struct intel_encoder *encoder,
> -				     struct intel_crtc_state *pipe_config,
> -				     struct drm_connector_state *conn_state)
> +static int intel_ddi_compute_config(struct intel_encoder *encoder,
> +				    struct intel_crtc_state *pipe_config,
> +				    struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  	enum port port = encoder->port;

Hmm. At first glance I was rather confused that you didn't change
anything here, but indeed this guy already does what we want.

> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index ee85ca84d0f7..f6324fe74b19 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -11550,10 +11550,13 @@ intel_modeset_pipe_config(struct drm_crtc *crtc,
>  			continue;
>  
>  		encoder = to_intel_encoder(connector_state->best_encoder);
> -
> -		if (!(encoder->compute_config(encoder, pipe_config, connector_state))) {
> -			DRM_DEBUG_KMS("Encoder config failure\n");
> -			return -EINVAL;
> +		ret = encoder->compute_config(encoder, pipe_config,
> +					      connector_state);
> +		if (ret < 0) {
> +			if (ret != -EDEADLK)
> +				DRM_DEBUG_KMS("Encoder config failure: %d\n",
> +					      ret);
> +			return ret;
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 0a3ac98a779e..9e4c2c6bb1f0 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -1905,10 +1905,10 @@ static int intel_dp_dsc_compute_bpp(struct intel_dp *intel_dp, u8 dsc_max_bpc)
>  	return 0;
>  }
>  
> -static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
> -					struct intel_crtc_state *pipe_config,
> -					struct drm_connector_state *conn_state,
> -					struct link_config_limits *limits)
> +static int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
> +				       struct intel_crtc_state *pipe_config,
> +				       struct drm_connector_state *conn_state,
> +				       struct link_config_limits *limits)
>  {
>  	struct intel_digital_port *dig_port = dp_to_dig_port(intel_dp);
>  	struct drm_i915_private *dev_priv = to_i915(dig_port->base.base.dev);
> @@ -1917,7 +1917,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  	int pipe_bpp;
>  
>  	if (!intel_dp_supports_dsc(intel_dp, pipe_config))
> -		return false;
> +		return -EINVAL;
>  
>  	dsc_max_bpc = min_t(u8, DP_DSC_MAX_SUPPORTED_BPC,
>  			    conn_state->max_requested_bpc);
> @@ -1925,7 +1925,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  	pipe_bpp = intel_dp_dsc_compute_bpp(intel_dp, dsc_max_bpc);
>  	if (pipe_bpp < DP_DSC_MIN_SUPPORTED_BPC * 3) {
>  		DRM_DEBUG_KMS("No DSC support for less than 8bpc\n");
> -		return false;
> +		return -EINVAL;
>  	}
>  
>  	/*
> @@ -1959,7 +1959,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  						     adjusted_mode->crtc_hdisplay);
>  		if (!dsc_max_output_bpp || !dsc_dp_slice_count) {
>  			DRM_DEBUG_KMS("Compressed BPP/Slice Count not supported\n");
> -			return false;
> +			return -EINVAL;
>  		}
>  		pipe_config->dsc_params.compressed_bpp = min_t(u16,
>  							       dsc_max_output_bpp >> 4,
> @@ -1976,7 +1976,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  			pipe_config->dsc_params.dsc_split = true;
>  		} else {
>  			DRM_DEBUG_KMS("Cannot split stream to use 2 VDSC instances\n");
> -			return false;
> +			return -EINVAL;
>  		}
>  	}
>  	if (intel_dp_compute_dsc_params(intel_dp, pipe_config) < 0) {
> @@ -1984,7 +1984,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  			      "Compressed BPP = %d\n",
>  			      pipe_config->pipe_bpp,
>  			      pipe_config->dsc_params.compressed_bpp);
> -		return false;
> +		return -EINVAL;

Here we can propagate the return value from
intel_dp_compute_dsc_params() upwards.

>  	}
>  	pipe_config->dsc_params.compression_enable = true;
>  	DRM_DEBUG_KMS("DP DSC computed with Input Bpp = %d "
> @@ -1993,7 +1993,7 @@ static bool intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  		      pipe_config->dsc_params.compressed_bpp,
>  		      pipe_config->dsc_params.slice_count);
>  
> -	return true;
> +	return 0;
>  }
>  
>  static bool
> @@ -2094,7 +2094,7 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
>  	return true;
>  }

You changed intel_dp_dsc_compute_config() but didn't update the caller?
Probably best to change all the intel_dp_compute_link_config*() functions
to return an int as well for consistency.

>  
> -bool
> +int
>  intel_dp_compute_config(struct intel_encoder *encoder,
>  			struct intel_crtc_state *pipe_config,
>  			struct drm_connector_state *conn_state)
> @@ -2147,20 +2147,20 @@ intel_dp_compute_config(struct intel_encoder *encoder,

Oh wow. I just noticed that a1b2278e4dfc ("drm/i915: skylake panel fitting
using shared scalers") already assumed that .compute_config() returns
an int. That might even explain some oddball scaler fails people have
seen.

>  	}
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	if (HAS_GMCH_DISPLAY(dev_priv) &&
>  	    adjusted_mode->flags & DRM_MODE_FLAG_INTERLACE)
> -		return false;
> +		return -EINVAL;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLCLK)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->fec_enable = !intel_dp_is_edp(intel_dp) &&
>  				  intel_dp_supports_fec(intel_dp, pipe_config);
>  
>  	if (!intel_dp_compute_link_config(encoder, pipe_config, conn_state))
> -		return false;
> +		return -ENOSPC;
>  
>  	if (intel_conn_state->broadcast_rgb == INTEL_BROADCAST_RGB_AUTO) {
>  		/*
> @@ -2208,7 +2208,7 @@ intel_dp_compute_config(struct intel_encoder *encoder,
>  
>  	intel_psr_compute_config(intel_dp, pipe_config);
>  
> -	return true;
> +	return 0;
>  }
>  
>  void intel_dp_set_link_params(struct intel_dp *intel_dp,
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index 3f83429333c7..a19699023db1 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -29,9 +29,9 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  
> -static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
> -					struct intel_crtc_state *pipe_config,
> -					struct drm_connector_state *conn_state)
> +static int intel_dp_mst_compute_config(struct intel_encoder *encoder,
> +				       struct intel_crtc_state *pipe_config,
> +				       struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  	struct intel_dp_mst_encoder *intel_mst = enc_to_mst(&encoder->base);
> @@ -52,7 +52,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  					   DP_DPCD_QUIRK_CONSTANT_N);
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
>  	pipe_config->has_pch_encoder = false;
> @@ -89,7 +89,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  		if (slots < 0) {
>  			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
>  				      slots);
> -			return false;
> +			return slots;
>  		}
>  	}
>  
> @@ -107,7 +107,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  
>  	intel_ddi_compute_min_voltage_level(dev_priv, pipe_config);
>  
> -	return true;
> +	return 0;
>  }
>  
>  static int
> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
> index 7977843ce26a..e5a436c33307 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -225,9 +225,9 @@ struct intel_encoder {
>  	enum intel_output_type (*compute_output_type)(struct intel_encoder *,
>  						      struct intel_crtc_state *,
>  						      struct drm_connector_state *);
> -	bool (*compute_config)(struct intel_encoder *,
> -			       struct intel_crtc_state *,
> -			       struct drm_connector_state *);
> +	int (*compute_config)(struct intel_encoder *,
> +			      struct intel_crtc_state *,
> +			      struct drm_connector_state *);
>  	void (*pre_pll_enable)(struct intel_encoder *,
>  			       const struct intel_crtc_state *,
>  			       const struct drm_connector_state *);
> @@ -1816,9 +1816,9 @@ void intel_dp_sink_set_decompression_state(struct intel_dp *intel_dp,
>  void intel_dp_encoder_reset(struct drm_encoder *encoder);
>  void intel_dp_encoder_suspend(struct intel_encoder *intel_encoder);
>  void intel_dp_encoder_flush_work(struct drm_encoder *encoder);
> -bool intel_dp_compute_config(struct intel_encoder *encoder,
> -			     struct intel_crtc_state *pipe_config,
> -			     struct drm_connector_state *conn_state);
> +int intel_dp_compute_config(struct intel_encoder *encoder,
> +			    struct intel_crtc_state *pipe_config,
> +			    struct drm_connector_state *conn_state);
>  bool intel_dp_is_edp(struct intel_dp *intel_dp);
>  bool intel_dp_is_port_edp(struct drm_i915_private *dev_priv, enum port port);
>  enum irqreturn intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port,
> @@ -1978,9 +1978,9 @@ void intel_hdmi_init(struct drm_i915_private *dev_priv, i915_reg_t hdmi_reg,
>  void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
>  			       struct intel_connector *intel_connector);
>  struct intel_hdmi *enc_to_intel_hdmi(struct drm_encoder *encoder);
> -bool intel_hdmi_compute_config(struct intel_encoder *encoder,
> -			       struct intel_crtc_state *pipe_config,
> -			       struct drm_connector_state *conn_state);
> +int intel_hdmi_compute_config(struct intel_encoder *encoder,
> +			      struct intel_crtc_state *pipe_config,
> +			      struct drm_connector_state *conn_state);
>  bool intel_hdmi_handle_sink_scrambling(struct intel_encoder *encoder,
>  				       struct drm_connector *connector,
>  				       bool high_tmds_clock_ratio,
> diff --git a/drivers/gpu/drm/i915/intel_dvo.c b/drivers/gpu/drm/i915/intel_dvo.c
> index bc3c3cb57ec6..2ac488500ea5 100644
> --- a/drivers/gpu/drm/i915/intel_dvo.c
> +++ b/drivers/gpu/drm/i915/intel_dvo.c
> @@ -234,9 +234,9 @@ intel_dvo_mode_valid(struct drm_connector *connector,
>  	return intel_dvo->dev.dev_ops->mode_valid(&intel_dvo->dev, mode);
>  }
>  
> -static bool intel_dvo_compute_config(struct intel_encoder *encoder,
> -				     struct intel_crtc_state *pipe_config,
> -				     struct drm_connector_state *conn_state)
> +static int intel_dvo_compute_config(struct intel_encoder *encoder,
> +				    struct intel_crtc_state *pipe_config,
> +				    struct drm_connector_state *conn_state)
>  {
>  	struct intel_dvo *intel_dvo = enc_to_dvo(encoder);
>  	const struct drm_display_mode *fixed_mode =
> @@ -253,10 +253,10 @@ static bool intel_dvo_compute_config(struct intel_encoder *encoder,
>  		intel_fixed_panel_mode(fixed_mode, adjusted_mode);
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;

Please add a newline here while at it.

> -	return true;
> +	return 0;
>  }
>  
>  static void intel_dvo_pre_enable(struct intel_encoder *encoder,
> diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
> index 74f4021b760c..147a367c9abb 100644
> --- a/drivers/gpu/drm/i915/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/intel_hdmi.c
> @@ -1704,9 +1704,9 @@ intel_hdmi_ycbcr420_config(struct drm_connector *connector,
>  	return true;
>  }
>  
> -bool intel_hdmi_compute_config(struct intel_encoder *encoder,
> -			       struct intel_crtc_state *pipe_config,
> -			       struct drm_connector_state *conn_state)
> +int intel_hdmi_compute_config(struct intel_encoder *encoder,
> +			      struct intel_crtc_state *pipe_config,
> +			      struct drm_connector_state *conn_state)
>  {
>  	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(&encoder->base);
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
> @@ -1722,7 +1722,7 @@ bool intel_hdmi_compute_config(struct intel_encoder *encoder,
>  	bool force_dvi = intel_conn_state->force_audio == HDMI_AUDIO_OFF_DVI;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
>  	pipe_config->has_hdmi_sink = !force_dvi && intel_hdmi->has_hdmi_sink;
> @@ -1753,7 +1753,7 @@ bool intel_hdmi_compute_config(struct intel_encoder *encoder,
>  						&clock_12bpc, &clock_10bpc,
>  						&clock_8bpc)) {
>  			DRM_ERROR("Can't support YCBCR420 output\n");
> -			return false;
> +			return -EINVAL;
>  		}
>  	}
>  

Looks like you missed the if(hdmi_port_clock_valid()) branch here.

> @@ -1822,7 +1822,7 @@ bool intel_hdmi_compute_config(struct intel_encoder *encoder,
>  		}
>  	}
>  
> -	return true;
> +	return 0;
>  }
>  
>  static void
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index b01aacb5d73d..46a5dfd5cdf7 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -380,9 +380,9 @@ intel_lvds_mode_valid(struct drm_connector *connector,
>  	return MODE_OK;
>  }
>  
> -static bool intel_lvds_compute_config(struct intel_encoder *intel_encoder,
> -				      struct intel_crtc_state *pipe_config,
> -				      struct drm_connector_state *conn_state)
> +static int intel_lvds_compute_config(struct intel_encoder *intel_encoder,
> +				     struct intel_crtc_state *pipe_config,
> +				     struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(intel_encoder->base.dev);
>  	struct intel_lvds_encoder *lvds_encoder =
> @@ -396,7 +396,7 @@ static bool intel_lvds_compute_config(struct intel_encoder *intel_encoder,
>  	/* Should never happen!! */
>  	if (INTEL_GEN(dev_priv) < 4 && intel_crtc->pipe == 0) {
>  		DRM_ERROR("Can't support LVDS on pipe A\n");
> -		return false;
> +		return -EINVAL;
>  	}
>  
>  	if (lvds_encoder->a3_power == LVDS_A3_POWER_UP)
> @@ -422,7 +422,7 @@ static bool intel_lvds_compute_config(struct intel_encoder *intel_encoder,
>  			       adjusted_mode);
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	if (HAS_PCH_SPLIT(dev_priv)) {
>  		pipe_config->has_pch_encoder = true;
> @@ -441,7 +441,7 @@ static bool intel_lvds_compute_config(struct intel_encoder *intel_encoder,
>  	 * user's requested refresh rate.
>  	 */
>  
> -	return true;
> +	return 0;
>  }
>  
>  static enum drm_connector_status
> diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
> index 4db7aefa88f9..df2d830a7405 100644
> --- a/drivers/gpu/drm/i915/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/intel_sdvo.c
> @@ -1107,9 +1107,9 @@ static void i9xx_adjust_sdvo_tv_clock(struct intel_crtc_state *pipe_config)
>  	pipe_config->clock_set = true;
>  }
>  
> -static bool intel_sdvo_compute_config(struct intel_encoder *encoder,
> -				      struct intel_crtc_state *pipe_config,
> -				      struct drm_connector_state *conn_state)
> +static int intel_sdvo_compute_config(struct intel_encoder *encoder,
> +				     struct intel_crtc_state *pipe_config,
> +				     struct drm_connector_state *conn_state)
>  {
>  	struct intel_sdvo *intel_sdvo = to_sdvo(encoder);
>  	struct intel_sdvo_connector_state *intel_sdvo_state =
> @@ -1134,7 +1134,7 @@ static bool intel_sdvo_compute_config(struct intel_encoder *encoder,
>  	 */
>  	if (IS_TV(intel_sdvo_connector)) {
>  		if (!intel_sdvo_set_output_timings_from_mode(intel_sdvo, mode))
> -			return false;
> +			return -EINVAL;
>  
>  		(void) intel_sdvo_get_preferred_input_mode(intel_sdvo,
>  							   intel_sdvo_connector,
> @@ -1144,7 +1144,7 @@ static bool intel_sdvo_compute_config(struct intel_encoder *encoder,
>  	} else if (IS_LVDS(intel_sdvo_connector)) {
>  		if (!intel_sdvo_set_output_timings_from_mode(intel_sdvo,
>  							     intel_sdvo_connector->base.panel.fixed_mode))
> -			return false;
> +			return -EINVAL;
>  
>  		(void) intel_sdvo_get_preferred_input_mode(intel_sdvo,
>  							   intel_sdvo_connector,
> @@ -1153,7 +1153,7 @@ static bool intel_sdvo_compute_config(struct intel_encoder *encoder,
>  	}
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	/*
>  	 * Make the CRTC code factor in the SDVO pixel multiplier.  The
> @@ -1193,7 +1193,7 @@ static bool intel_sdvo_compute_config(struct intel_encoder *encoder,
>  	if (intel_sdvo_connector->is_hdmi)
>  		adjusted_mode->picture_aspect_ratio = conn_state->picture_aspect_ratio;
>  
> -	return true;
> +	return 0;
>  }
>  
>  #define UPDATE_PROPERTY(input, NAME) \
> diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
> index d7a414ce2774..bd5536f0ec92 100644
> --- a/drivers/gpu/drm/i915/intel_tv.c
> +++ b/drivers/gpu/drm/i915/intel_tv.c
> @@ -869,7 +869,7 @@ intel_tv_get_config(struct intel_encoder *encoder,
>  	pipe_config->base.adjusted_mode.crtc_clock = pipe_config->port_clock;
>  }
>  
> -static bool
> +static int
>  intel_tv_compute_config(struct intel_encoder *encoder,
>  			struct intel_crtc_state *pipe_config,
>  			struct drm_connector_state *conn_state)
> @@ -879,10 +879,10 @@ intel_tv_compute_config(struct intel_encoder *encoder,
>  		&pipe_config->base.adjusted_mode;
>  
>  	if (!tv_mode)
> -		return false;
> +		return -EINVAL;
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
>  	adjusted_mode->crtc_clock = tv_mode->clock;
> @@ -897,7 +897,7 @@ intel_tv_compute_config(struct intel_encoder *encoder,
>  	 * or whether userspace is doing something stupid.
>  	 */
>  
> -	return true;
> +	return 0;
>  }
>  
>  static void
> diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
> index d116fead8514..c247ce74b71a 100644
> --- a/drivers/gpu/drm/i915/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/vlv_dsi.c
> @@ -256,9 +256,9 @@ static void band_gap_reset(struct drm_i915_private *dev_priv)
>  	mutex_unlock(&dev_priv->sb_lock);
>  }
>  
> -static bool intel_dsi_compute_config(struct intel_encoder *encoder,
> -				     struct intel_crtc_state *pipe_config,
> -				     struct drm_connector_state *conn_state)
> +static int intel_dsi_compute_config(struct intel_encoder *encoder,
> +				    struct intel_crtc_state *pipe_config,
> +				    struct drm_connector_state *conn_state)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  	struct intel_dsi *intel_dsi = container_of(encoder, struct intel_dsi,
> @@ -284,7 +284,7 @@ static bool intel_dsi_compute_config(struct intel_encoder *encoder,
>  	}
>  
>  	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
> -		return false;
> +		return -EINVAL;
>  
>  	/* DSI uses short packets for sync events, so clear mode flags for DSI */
>  	adjusted_mode->flags = 0;
> @@ -302,16 +302,16 @@ static bool intel_dsi_compute_config(struct intel_encoder *encoder,
>  
>  		ret = bxt_dsi_pll_compute(encoder, pipe_config);
>  		if (ret)
> -			return false;
> +			return -EINVAL;
>  	} else {
>  		ret = vlv_dsi_pll_compute(encoder, pipe_config);
>  		if (ret)
> -			return false;
> +			return -EINVAL;
>  	}
>  
>  	pipe_config->clock_set = true;
>  
> -	return true;
> +	return 0;
>  }
>  
>  static bool glk_dsi_enable_io(struct intel_encoder *encoder)
> -- 
> 2.20.1

-- 
Ville Syrjälä
Intel
