Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeEWNSK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:18:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:40188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbeEWNSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:18:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="43289575"
Date: Wed, 23 May 2018 16:18:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Vito Caputo <vcaputo@pengaru.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, daniel.vetter@ffwll.ch
Subject: Re: [REGRESSION] v4.17-rc4: xgalaga fails to start in fullscreen
 (default) mode
Message-ID: <20180523131805.GK23723@intel.com>
References: <20180521195320.6stbpnebgjowxwjp@shells.gnugeneration.com>
 <20180521215718.7zwhhdanpnibp6la@shells.gnugeneration.com>
 <20180523094919.s47ldq33hhbnodu2@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523094919.s47ldq33hhbnodu2@shells.gnugeneration.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:49:19AM -0700, Vito Caputo wrote:
> On Mon, May 21, 2018 at 02:57:18PM -0700, Vito Caputo wrote:
> > On Mon, May 21, 2018 at 12:53:20PM -0700, Vito Caputo wrote:
> > > Hello all,
> > > 
> > > 4.17-rc4 (my latest kernel ATM) consistently fails to start xgalaga
> > > without -window.  I will try find time to build the latest rc this
> > > evening.
> > > 
> > > > ~$ xgalaga
> > > > X Error of failed request:  BadValue (integer parameter out of range for operation)
> > > >   Major opcode of failed request:  152 (XFree86-VidModeExtension)
> > > >   Minor opcode of failed request:  10 (XF86VidModeSwitchToMode)
> > > >   Value in failed request:  0x120004e
> > > >   Serial number of failed request:  199
> > > >   Current serial number in output stream:  203
> > > 
> > > Haven't dug into this much yet, only did a perfunctory check by booting into a
> > > few older kernels (4.11, 4.12, 4.16) and the problem is absent on all of them.
> > > It appears to be a 4.17-specific regression right now.
> > > 
> > > Also observed, though this is surely a different regression, the game
> > > ran like molasses with -window, showing some prominent kworkers in top:
> > > 
> > >   692 vc        20   0  312852  45884  20556 R  32.0  1.2   0:08.69 Xorg           
> > >   102 root      20   0       0      0      0 R  11.2  0.0   0:01.43 kworker/1:3    
> > >    94 root      20   0       0      0      0 I   8.9  0.0   0:00.83 kworker/0:2    
> > >   696 vc        20   0   39948   4124   2912 S   1.0  0.1   0:05.57 vwm            
> > >   902 vc        30  10   46372   4144   3500 S   0.7  0.1   0:00.08 xgalaga        
> > >   891 vc        30  10   44924   3868   3156 R   0.3  0.1   0:00.09 top            
> > >   903 vc        30  10    4180   1184   1100 S   0.3  0.0   0:00.01 xgal.sndsrv.oss
> > > 
> > > The windowed performance issue was observed on the older kernels tested
> > > as well, though 4.11 felt better and didn't have the busy kworkers.
> > > 
> > > I have not attempted to play xgalaga for ages, but it used to be perfectly
> > > playable on this machine in windowed mode when I last did.
> > > 
> > > Machine is the venerable Thinkpad X61s, 1.8Ghz, Debian 9, config attached.
> > > 
> > 
> > Just built and booted v4.17-rc6, still broken.
> 
> Bisected to:
> 
> e995ca0b8139c5f6807095464e969931b443f55a is the first bad commit
> commit e995ca0b8139c5f6807095464e969931b443f55a
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Date:   Tue Nov 14 20:32:58 2017 +0200
> 
>     drm/i915: Provide a device level .mode_valid() hook
>     
>     We never support certain mode flags etc. Reject those early on in the
>     mode_config.mode_valid() hook. That allows us to remove some duplicated
>     checks from the connector .mode_valid() hooks, and it guarantees that
>     we never see those flags even from user mode as the
>     mode_config.mode_valid() hooks gets executed for those as well.
>     
>     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20171114183258.16976-11-ville.syrjala@linux.intel.com
>     Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hmm. I guess xgalaga passes some garbage in via xf86vidmode which
the ddx doesn't validate before passing it on to the kernel. So far
I can't reproduce the problem here unfortnately.

Can you try the following patch and reproduce the problem with
drm.debug=0xe passed to the kernel so that we can seewhat the bad
modeline looks like?

>From c8b4eaaf3ee8e796dbbb4a5080c1aec2b435d110 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Wed, 23 May 2018 16:12:08 +0300
Subject: [PATCH] drm/modes: Dump the rejected user mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Print put the modeline When we reject a user mode.

Cc: Vito Caputo <vcaputo@pengaru.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_modes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index c78ca0e84ffd..ca50b12d9701 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1739,8 +1739,11 @@ int drm_mode_convert_umode(struct drm_device *dev,
 	}
 
 	out->status = drm_mode_validate_driver(dev, out);
-	if (out->status != MODE_OK)
+	if (out->status != MODE_OK) {
+		DRM_DEBUG_KMS("Bad user mode:\n");
+		drm_mode_debug_printmodeline(out);
 		return -EINVAL;
+	}
 
 	drm_mode_set_crtcinfo(out, CRTC_INTERLACE_HALVE_V);
 
-- 
2.16.1

-- 
Ville Syrjälä
Intel
