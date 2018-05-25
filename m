Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967198AbeEYQIL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:08:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:25866 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966599AbeEYQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:08:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="52181250"
Date: Fri, 25 May 2018 19:08:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Brian Starkey <brian.starkey@arm.com>
Cc: Ayan Kumar Halder <ayan.halder@arm.com>, airlied@linux.ie,
        alexandru-cosmin.gheorghe@arm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, liviu.dudau@arm.com, nd@arm.com
Subject: Re: [PATCH] drm: check_pixel_format() should return true if no
 modifiers are passed for a supported pixel format
Message-ID: <20180525160805.GG23723@intel.com>
References: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
 <20180525154859.GB1139@e107564-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525154859.GB1139@e107564-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:48:59PM +0100, Brian Starkey wrote:
> Hi Ayan,
> 
> On Fri, May 25, 2018 at 04:35:41PM +0100, Ayan Kumar Halder wrote:
> >If a plane supports a pixel format and the framebuffer does not pass any
> >modifiers, then drm_plane_check_pixel_format() should always return true
> >for the given format regardless of whether the plane supports any
> >modifiers or not.
> >
> >Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >---
> > drivers/gpu/drm/drm_plane.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> >index 6d2a6e4..873c084 100644
> >--- a/drivers/gpu/drm/drm_plane.c
> >+++ b/drivers/gpu/drm/drm_plane.c
> >@@ -564,6 +564,9 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
> > 	if (!plane->modifier_count)
> > 		return 0;
> >
> >+	if (modifier == DRM_FORMAT_MOD_NONE)
> >+		return 0;
> >+
> 
> There can be drivers which have formats which are only supported when
> a modifier is used - so I don't think this check is right to have in
> the core.
> 
> Drivers need to check if they support the format with no modifier
> (same as DRM_FORMAT_MOD_LINEAR) in their format_mod_supported()
> callback.

BTW I tried to make the core hide the "did the request have modifiers
or not" difference as much as possible, and to validate that there is
at least one plane that can use the created fb:
https://patchwork.freedesktop.org/series/39814/

Not sure we ever figured out a good solution in the end, but at least
Eric's approach in https://patchwork.freedesktop.org/series/40133/
would avoid some of the problems I was having in my attempts. I guess 
I should try to revisit that patchset and see if I can make it less
objectionable this time around.

> 
> Thanks,
> -Brian
> 
> > 	for (i = 0; i < plane->modifier_count; i++) {
> > 		if (modifier == plane->modifiers[i])
> > 			break;
> >-- 
> >2.7.4
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
