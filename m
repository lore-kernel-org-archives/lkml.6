Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966607AbeEYPtE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:49:04 -0400
Received: from foss.arm.com ([217.140.101.70]:35612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeEYPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:49:03 -0400
Date: Fri, 25 May 2018 16:48:59 +0100
From: Brian Starkey <brian.starkey@arm.com>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: liviu.dudau@arm.com, alexandru-cosmin.gheorghe@arm.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm: check_pixel_format() should return true if no
 modifiers are passed for a supported pixel format
Message-ID: <20180525154859.GB1139@e107564-lin.cambridge.arm.com>
References: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On Fri, May 25, 2018 at 04:35:41PM +0100, Ayan Kumar Halder wrote:
>If a plane supports a pixel format and the framebuffer does not pass any
>modifiers, then drm_plane_check_pixel_format() should always return true
>for the given format regardless of whether the plane supports any
>modifiers or not.
>
>Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>---
> drivers/gpu/drm/drm_plane.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
>index 6d2a6e4..873c084 100644
>--- a/drivers/gpu/drm/drm_plane.c
>+++ b/drivers/gpu/drm/drm_plane.c
>@@ -564,6 +564,9 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
> 	if (!plane->modifier_count)
> 		return 0;
>
>+	if (modifier == DRM_FORMAT_MOD_NONE)
>+		return 0;
>+

There can be drivers which have formats which are only supported when
a modifier is used - so I don't think this check is right to have in
the core.

Drivers need to check if they support the format with no modifier
(same as DRM_FORMAT_MOD_LINEAR) in their format_mod_supported()
callback.

Thanks,
-Brian

> 	for (i = 0; i < plane->modifier_count; i++) {
> 		if (modifier == plane->modifiers[i])
> 			break;
>-- 
>2.7.4
>
