Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C59C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA521928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbeLUTXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:63723 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391681AbeLUTXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 11:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="261381996"
Received: from dk-thinkpad-x260.jf.intel.com ([10.54.75.55])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2018 11:23:08 -0800
Message-ID: <147663805b9a1ba7aa3bf4686090af27fbaad040.camel@intel.com>
Subject: Re: [PATCH] drm/i915/psr: simplify enable_psr handling
From:   Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reply-To: dhinakaran.pandiyan@intel.com
To:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jon Flatley <jflat@google.com>
Date:   Fri, 21 Dec 2018 11:23:07 -0800
In-Reply-To: <20181221172305.195943-1-zwisler@google.com>
References: <20181221172305.195943-1-zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 10:23 -0700, Ross Zwisler wrote:
> The following commit:
> 
> commit 2bdd045e3a30 ("drm/i915/psr: Check if VBT says PSR can be
> enabled.")
> 
> added some code with no usable functionality.  Regardless of how the
> psr
> default is set up in the BDB_DRIVER_FEATURES section, if the
> enable_psr
> module parameter isn't specified it defaults to 0.
Right, that was intentional and the commit message even makes a note of
it 
" Note: The feature currently remains disabled by default for all
platforms irrespective of what VBT says."


Anyway, we've enabled the feature by default now and the current code
should take into account the VBT flag if the module parameter is left
to a default value. Please check git://anongit.freedesktop.org/drm-tip
drm-tip.

-DK
> 
> Remove this dead code, simplify the way that enable_psr is handled
> and
> update the module parameter string to match the actual functionality.
> 
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h    | 1 -
>  drivers/gpu/drm/i915/i915_params.c | 4 +---
>  drivers/gpu/drm/i915/i915_params.h | 2 +-
>  drivers/gpu/drm/i915/intel_bios.c  | 1 -
>  drivers/gpu/drm/i915/intel_psr.c   | 7 -------
>  5 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.h
> b/drivers/gpu/drm/i915/i915_drv.h
> index 872a2e159a5f9..b4c50ba0b22a6 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -1115,7 +1115,6 @@ struct intel_vbt_data {
>  	} edp;
>  
>  	struct {
> -		bool enable;
>  		bool full_link;
>  		bool require_aux_wakeup;
>  		int idle_frames;
> diff --git a/drivers/gpu/drm/i915/i915_params.c
> b/drivers/gpu/drm/i915/i915_params.c
> index 295e981e4a398..80ce8758c3c69 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -87,9 +87,7 @@ i915_param_named_unsafe(enable_ppgtt, int, 0400,
>  	"(-1=auto [default], 0=disabled, 1=aliasing, 2=full, 3=full
> with extended address space)");
>  
>  i915_param_named_unsafe(enable_psr, int, 0600,
> -	"Enable PSR "
> -	"(0=disabled, 1=enabled) "
> -	"Default: -1 (use per-chip default)");
> +	"Enable PSR (default: false)");
>  
>  i915_param_named_unsafe(alpha_support, bool, 0400,
>  	"Enable alpha quality driver support for latest hardware. "
> diff --git a/drivers/gpu/drm/i915/i915_params.h
> b/drivers/gpu/drm/i915/i915_params.h
> index 6c4d4a21474b5..144572f17a83d 100644
> --- a/drivers/gpu/drm/i915/i915_params.h
> +++ b/drivers/gpu/drm/i915/i915_params.h
> @@ -42,7 +42,7 @@ struct drm_printer;
>  	param(int, enable_dc, -1) \
>  	param(int, enable_fbc, -1) \
>  	param(int, enable_ppgtt, -1) \
> -	param(int, enable_psr, -1) \
> +	param(int, enable_psr, 0) \
>  	param(int, disable_power_well, -1) \
>  	param(int, enable_ips, 1) \
>  	param(int, invert_brightness, 0) \
> diff --git a/drivers/gpu/drm/i915/intel_bios.c
> b/drivers/gpu/drm/i915/intel_bios.c
> index 1faa494e2bc91..d676d483d5cf1 100644
> --- a/drivers/gpu/drm/i915/intel_bios.c
> +++ b/drivers/gpu/drm/i915/intel_bios.c
> @@ -551,7 +551,6 @@ parse_driver_features(struct drm_i915_private
> *dev_priv,
>  	 */
>  	if (!driver->drrs_enabled)
>  		dev_priv->vbt.drrs_type = DRRS_NOT_SUPPORTED;
> -	dev_priv->vbt.psr.enable = driver->psr_enabled;
>  }
>  
>  static void
> diff --git a/drivers/gpu/drm/i915/intel_psr.c
> b/drivers/gpu/drm/i915/intel_psr.c
> index b6838b525502e..26e7eb318cf07 100644
> --- a/drivers/gpu/drm/i915/intel_psr.c
> +++ b/drivers/gpu/drm/i915/intel_psr.c
> @@ -1065,13 +1065,6 @@ void intel_psr_init(struct drm_i915_private
> *dev_priv)
>  	if (!dev_priv->psr.sink_support)
>  		return;
>  
> -	if (i915_modparams.enable_psr == -1) {
> -		i915_modparams.enable_psr = dev_priv->vbt.psr.enable;
> -
> -		/* Per platform default: all disabled. */
> -		i915_modparams.enable_psr = 0;
> -	}
> -
>  	/* Set link_standby x link_off defaults */
>  	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv))
>  		/* HSW and BDW require workarounds that we don't
> implement. */

