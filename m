Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbeDZP5Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:57:24 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:41674 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756615AbeDZP5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:57:22 -0400
Date: Thu, 26 Apr 2018 11:57:14 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] 4.17-rc2: Could not determine valid watermarks for
 inherited state
Message-ID: <20180426155714.z24rryrhpvhqt33i@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <20180423152713.2rrwwye3wfstbv5v@codemonkey.org.uk>
 <20180426131045.GH23723@intel.com>
 <20180426142719.fzivt2e6kialcbp4@codemonkey.org.uk>
 <20180426145614.GP23723@intel.com>
 <20180426151641.GQ23723@intel.com>
 <20180426152513.GR23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426152513.GR23723@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:25:13PM +0300, Ville Syrjälä wrote:
 > On Thu, Apr 26, 2018 at 06:16:41PM +0300, Ville Syrjälä wrote:
 > > On Thu, Apr 26, 2018 at 05:56:14PM +0300, Ville Syrjälä wrote:
 > > > On Thu, Apr 26, 2018 at 10:27:19AM -0400, Dave Jones wrote:
 > > > > [    1.176131] [drm:i9xx_get_initial_plane_config] pipe A/primary A with fb: size=800x600@32, offset=0, pitch 3200, size 0x1d4c00
 > > > > [    1.176161] [drm:i915_gem_object_create_stolen_for_preallocated] creating preallocated stolen object: stolen_offset=0x0000000000000000, gtt_offset=0x0000000000000000, size=0x00000000001d5000
 > > > > [    1.176312] [drm:intel_alloc_initial_plane_obj.isra.127] initial plane fb obj         (ptrval)
 > > > > [    1.176351] [drm:intel_modeset_init] pipe A active planes 0x1
 > > > > [    1.176456] [drm:drm_atomic_helper_check_plane_state] Plane must cover entire CRTC
 > > > > [    1.176481] [drm:drm_rect_debug_print] dst: 800x600+0+0
 > > > > [    1.176494] [drm:drm_rect_debug_print] clip: 1366x768+0+0
 > > > 
 > > > OK, so that's the problem right there. The fb we took over from the
 > > > BIOS was 800x600, but now we're trying to set up a 1366x768 mode.
 > > > 
 > > > We seem to be missing checks to make sure the initial fb is actually
 > > > big enough for the mode we're currently using :(
 > > 
 > Hmm. Or maybe we should just stick to the pipe src size.
 > 
 > I'm curious whether this fixes the problem?
 > 
 > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
 > index 0f8c7389e87d..30824beedef7 100644
 > --- a/drivers/gpu/drm/i915/intel_display.c
 > +++ b/drivers/gpu/drm/i915/intel_display.c
 > @@ -15284,6 +15284,8 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
 >  		memset(&crtc->base.mode, 0, sizeof(crtc->base.mode));
 >  		if (crtc_state->base.active) {
 >  			intel_mode_from_pipe_config(&crtc->base.mode, crtc_state);
 > +			crtc->base.mode.hdisplay = crtc_state->pipe_src_w;
 > +			crtc->base.mode.vdisplay = crtc_state->pipe_src_h;
 >  			intel_mode_from_pipe_config(&crtc_state->base.adjusted_mode, crtc_state);
 >  			WARN_ON(drm_atomic_set_mode_for_crtc(crtc->base.state, &crtc->base.mode));
 > 

It does!

Feel free to throw a Tested-by: Dave Jones <davej@codemonkey.org.uk> in there.

	Dave
