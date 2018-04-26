Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeDZPZS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:25:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:25954 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754556AbeDZPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:25:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="35476489"
Date: Thu, 26 Apr 2018 18:25:13 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] 4.17-rc2: Could not determine valid watermarks for
 inherited state
Message-ID: <20180426152513.GR23723@intel.com>
References: <20180423152713.2rrwwye3wfstbv5v@codemonkey.org.uk>
 <20180426131045.GH23723@intel.com>
 <20180426142719.fzivt2e6kialcbp4@codemonkey.org.uk>
 <20180426145614.GP23723@intel.com>
 <20180426151641.GQ23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426151641.GQ23723@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:16:41PM +0300, Ville Syrjälä wrote:
> On Thu, Apr 26, 2018 at 05:56:14PM +0300, Ville Syrjälä wrote:
> > On Thu, Apr 26, 2018 at 10:27:19AM -0400, Dave Jones wrote:
> > > [    1.176131] [drm:i9xx_get_initial_plane_config] pipe A/primary A with fb: size=800x600@32, offset=0, pitch 3200, size 0x1d4c00
> > > [    1.176161] [drm:i915_gem_object_create_stolen_for_preallocated] creating preallocated stolen object: stolen_offset=0x0000000000000000, gtt_offset=0x0000000000000000, size=0x00000000001d5000
> > > [    1.176312] [drm:intel_alloc_initial_plane_obj.isra.127] initial plane fb obj         (ptrval)
> > > [    1.176351] [drm:intel_modeset_init] pipe A active planes 0x1
> > > [    1.176456] [drm:drm_atomic_helper_check_plane_state] Plane must cover entire CRTC
> > > [    1.176481] [drm:drm_rect_debug_print] dst: 800x600+0+0
> > > [    1.176494] [drm:drm_rect_debug_print] clip: 1366x768+0+0
> > 
> > OK, so that's the problem right there. The fb we took over from the
> > BIOS was 800x600, but now we're trying to set up a 1366x768 mode.
> > 
> > We seem to be missing checks to make sure the initial fb is actually
> > big enough for the mode we're currently using :(
> 
> Actually we do read out the pipe src size as 800x600 initially, which
> make sense. And we even stuff that into the mode.h/vdisplay, so up to
> that point everything is pretty much correct. It goes wrong is when
> intel_modeset_readout_hw_state() calls intel_mode_from_pipe_config()
> as that will override the h/vdisplay with the actual crtc timings
> instead of the pipe src size.
> 
> So I suppose we should be able to just add the sanity checks for the
> fb vs. h/vdisplay, and at least we should get past this error. A
> slightly bigger mystery is what will happen later when our pipe src
> size doesn't actually agree with the h/vdisplay. The first modeset
> will correct it, but we might want some kind of extra sanitize step
> for fastboot type of stuff.

Hmm. Or maybe we should just stick to the pipe src size.

I'm curious whether this fixes the problem?

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 0f8c7389e87d..30824beedef7 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -15284,6 +15284,8 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
 		memset(&crtc->base.mode, 0, sizeof(crtc->base.mode));
 		if (crtc_state->base.active) {
 			intel_mode_from_pipe_config(&crtc->base.mode, crtc_state);
+			crtc->base.mode.hdisplay = crtc_state->pipe_src_w;
+			crtc->base.mode.vdisplay = crtc_state->pipe_src_h;
 			intel_mode_from_pipe_config(&crtc_state->base.adjusted_mode, crtc_state);
 			WARN_ON(drm_atomic_set_mode_for_crtc(crtc->base.state, &crtc->base.mode));

-- 
Ville Syrjälä
Intel
