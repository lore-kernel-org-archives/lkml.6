Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503EF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503EF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGRK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:59:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:35977 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeGRK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:59:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 03:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,369,1526367600"; 
   d="scan'208";a="57446251"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 18 Jul 2018 03:21:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:21:52 +0300
Date:   Wed, 18 Jul 2018 13:21:52 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Ayan Kumar Halder <ayan.halder@arm.com>, airlied@linux.ie,
        liviu.dudau@arm.com, dri-devel@lists.freedesktop.org,
        peter.ujfalusi@ti.com, laurent.pinchart@ideasonboard.com,
        afd@ti.com, maxime.ripard@bootlin.com,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        tomi.valkeinen@ti.com, malidp@foss.arm.com,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        nd@arm.com, linux-arm-kernel@lists.infradead.org, sre@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/fourcc: Add is_yuv field to drm_format_info to
 denote if the format is yuv
Message-ID: <20180718102152.GV5565@intel.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <20180718091202.GA27151@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718091202.GA27151@DESKTOP-E1NTVVP.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:12:02AM +0100, Brian Starkey wrote:
> Hi Ayan,
> 
> On Tue, Jul 17, 2018 at 06:13:42PM +0100, Ayan Kumar Halder wrote:
> >A lot of drivers duplicate the function to check if a format is yuv or not.
> >If we add a field (to denote whether the format is yuv or not) in the
> >drm_format_info table, all the drivers can use this field and it will
> >prevent duplication of similar logic.
> 
> This looks like a good idea to me.
> 
> I wonder if the two "has_alpha" and "is_yuv" bools should be bitfields
> to reduce the footprint (not sure what the general DRM attitude to
> bitfields is), but either way:

There are quite a few of these so tighter packing (of the other fields
as well perhaps) might be a decent idea.

For the series (except for the omapdrm patch which I'll leave for Tomi):
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> 
> >
> >Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> >---
> > drivers/gpu/drm/drm_fourcc.c | 42 +++++++++++++++++++++---------------------
> > include/drm/drm_fourcc.h     |  2 ++
> > 2 files changed, 23 insertions(+), 21 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> >index 5ca6395..35c1e27 100644
> >--- a/drivers/gpu/drm/drm_fourcc.c
> >+++ b/drivers/gpu/drm/drm_fourcc.c
> >@@ -152,27 +152,27 @@ const struct drm_format_info *__drm_format_info(u32 format)
> > 		{ .format = DRM_FORMAT_XBGR8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > 		{ .format = DRM_FORMAT_RGBX8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > 		{ .format = DRM_FORMAT_BGRX8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >-		{ .format = DRM_FORMAT_YUV410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4 },
> >-		{ .format = DRM_FORMAT_YVU410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4 },
> >-		{ .format = DRM_FORMAT_YUV411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YVU411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YUV420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2 },
> >-		{ .format = DRM_FORMAT_YVU420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2 },
> >-		{ .format = DRM_FORMAT_YUV422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
> >-		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
> >-		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_NV61,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_NV24,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_NV42,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YUYV,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_YVYU,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
> >-		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >+		{ .format = DRM_FORMAT_YUV410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVU410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YUV411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVU411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YUV420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVU420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YUV422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV61,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV24,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_NV42,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YUYV,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_YVYU,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
> >+		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
> > 	};
> >
> > 	unsigned int i;
> >diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> >index 3e86408..f9c1584 100644
> >--- a/include/drm/drm_fourcc.h
> >+++ b/include/drm/drm_fourcc.h
> >@@ -39,6 +39,7 @@ struct drm_mode_fb_cmd2;
> >  * @hsub: Horizontal chroma subsampling factor
> >  * @vsub: Vertical chroma subsampling factor
> >  * @has_alpha: Does the format embeds an alpha component?
> >+ * @is_yuv: Is it a YUV format?
> >  */
> > struct drm_format_info {
> > 	u32 format;
> >@@ -48,6 +49,7 @@ struct drm_format_info {
> > 	u8 hsub;
> > 	u8 vsub;
> > 	bool has_alpha;
> >+	bool is_yuv;
> > };
> >
> > /**
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
