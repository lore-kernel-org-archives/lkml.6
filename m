Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F059C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A720661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHWSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:54:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeHWSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:54:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2328615B2;
        Thu, 23 Aug 2018 08:23:57 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7A03F2EA;
        Thu, 23 Aug 2018 08:23:54 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@fooishbar.org, airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org
Cc:     linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
Subject: [RFC PATCH v2 2/3] drm/fourcc: Add remaining fourccs for Mali
Date:   Thu, 23 Aug 2018 16:23:42 +0100
Message-Id: <20180823152343.6474-3-brian.starkey@arm.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180823152343.6474-1-brian.starkey@arm.com>
References: <20180823152343.6474-1-brian.starkey@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we look to enable AFBC using DRM format modifiers, we run into
problems which we've historically handled via vendor-private details
(i.e. gralloc, on Android).

The AFBC modifiers can be found in [3].

AFBC (as an encoding) is fully flexible, and for example YUV data can
be encoded into 1, 2 or 3 encoded "planes", much like the linear
equivalents. Component order is also meaningful, as AFBC doesn't
necessarily care about what each "channel" of the data it encodes
contains. Therefore ABGR8888 and RGBA8888 can be encoded in AFBC with
different representations. Similarly, 'X' components may be encoded
into AFBC streams in cases where a decoder expects to decode a 4th
component.

In addition, AFBC is a licensable IP, meaning that to support the
ecosystem we need to ensure that _all_ AFBC users are able to describe
the encodings that they need. This is much better achieved by
preserving meaning in the fourcc codes when they are combined with an
AFBC modifier.

In essence, we want to use the modifier to describe the parameters of
the AFBC encode/decode, and use the fourcc code to describe the data
being encoded/decoded.

To do anything different would be to introduce redundancy - we would
need to duplicate in the modifier information which is _already_
conveyed clearly and non-ambigiously by a fourcc code.

I hope that for RGB this is non-controversial.
(BGRA8888 + MODIFIER_AFBC) is a different format from
(RGBA8888 + MODIFIER_AFBC).

Possibly more controversial is that (XBGR8888 + MODIFIER_AFBC)
is different from (BGR888 + MODIFIER_AFBC). I understand that in some
schemes it is not the case - but in AFBC it is so.

Where we run into problems is where there are not already fourcc codes
which represent the data which the AFBC encoder/decoder is processing.
To that end, we want to introduce new fourcc codes to describe the
data being encoded/decoded, in the places where none of the existing
fourcc codes are applicable.

Where we don't support an equivalent non-compressed layout, or where
no "obvious" linear layout exists, we are proposing adding fourcc
codes which have no associated linear layout - because any layout we
proposed would be completely arbitrary.

Some formats are following the naming conventions from [2].

The summary of the new formats is:
 DRM_FORMAT_VUY888 - Packed 8-bit YUV 444. Y followed by U then V.
 DRM_FORMAT_VUY101010 - Packed 10-bit YUV 444. Y followed by U then
                        V. No defined linear encoding.
 DRM_FORMAT_Y210 - Packed 10-bit YUV 422. Y followed by U (then Y)
                   then V. 10-bit samples in 16-bit words.
 DRM_FORMAT_Y410 - Packed 10-bit YUV 444, with 2-bit alpha.
 DRM_FORMAT_P210 - Semi-planar 10-bit YUV 422. Y plane, followed by
                   interleaved U-then-V plane. 10-bit samples in
                   16-bit words.
 DRM_FORMAT_YUV420_8BIT - Packed 8-bit YUV 420. Y followed by U then
                          V. No defined linear encoding
 DRM_FORMAT_YUV420_10BIT - Packed 10-bit YUV 420. Y followed by U
                           then V. No defined linear encoding

Please also note that in the absence of AFBC, we would still need to
add Y410, Y210 and P210.

Full rationale follows:

YUV 444 8-bit, 1-plane
----------------------
 The currently defined AYUV format encodes a 4th alpha component,
 which makes it unsuitable for representing a 3-component YUV 444
 AFBC stream.

 The proposed[1] XYUV format which is supported by Mali-DP in linear
 layout is also unsuitable, because the component order is the
 opposite of the AFBC version, and it encodes a 4th 'X' component.

 DRM_FORMAT_VUY888 is the "obvious" format for a 3-component, packed,
 YUV 444 8-bit format, with the component order which our HW expects to
 encode/decode. It conforms to the same naming convention as the
 existing packed YUV 444 format.
 The naming here is meant to be consistent with DRM_FORMAT_AYUV and
 DRM_FORMAT_XYUV[1]

YUV 444 10-bit, 1-plane
-----------------------
 There is no currently-defined YUV 444 10-bit format in
 drm_fourcc.h, irrespective of number of planes.

 The proposed[1] XVYU2101010 format which is supported by Mali-DP in
 linear layout uses the wrong component order, and also encodes a 4th
 'X' component, which doesn't match the AFBC version of YUV 444
 10-bit which we support.

 DRM_FORMAT_Y410 is the same layout as XVYU2101010, but with 2 bits of
 alpha.  This format is supported with linear layout by Mali GPUs. The
 naming follows[2].

 There is no "obvious" linear encoding for a 3-component 10:10:10
 packed format, and so DRM_FORMAT_VUY101010 defines a component
 order, but not a bit encoding. Again, the naming is meant to be
 consistent with DRM_FORMAT_AYUV.

YUV 422 8-bit, 1-plane
----------------------
 The existing DRM_FORMAT_YUYV (and the other component orders) are
 single-planar YUV 422 8-bit formats. Following the convention of
 the component orders of the RGB formats, YUYV has the correct
 component order for our AFBC encoding (Y followed by U followed by
 V). We can use YUYV for AFBC YUV 422 8-bit.

YUV 422 10-bit, 1-plane
-----------------------
 There is no currently-defined YUV 422 10-bit format in drm_fourcc.h

 DRM_FORMAT_Y210 is analogous to YUYV, but with 10-bits per sample
 packed into the upper 10-bits of 16-bit samples. This format is
 supported in both linear and AFBC by Mali GPUs.

YUV 422 10-bit, 2-plane
-----------------------
 The recently defined DRM_FORMAT_P010 format is a 10-bit semi-planar
 YUV 420 format, which has the correct component ordering for an AFBC
 2-plane YUV 420 buffer. The linear layout contains meaningless padding
 bits, which will not be encoded in an AFBC stream.

YUV 420 8-bit, 1-plane
----------------------
 There is no currently defined single-planar YUV 420, 8-bit format
 in drm_fourcc.h. There's differing opinions on whether using the
 existing fourcc-implied n_planes where possible is a good idea or
 not when using modifiers.

 For me, it's much more "obvious" to use NV12 for 2-plane AFBC and
 YUV420 for 3-plane AFBC. This keeps the aforementioned separation
 between the AFBC codec settings (in the modifier) and the pixel data
 format (in the fourcc). With different vendors using AFBC, this helps
 to ensure that there is no confusion in interoperation. It also
 ensures that the AFBC modifiers describe AFBC itself (which is a
 licensable component), and not implementation details which are not
 defined by AFBC.

 The proposed[1] X0L0 format which Mali-DP supports with Linear layout
 is unsuitable, as it contains a 4th 'X' component, and our AFBC
 decoder expects only 3 components.

 To that end, we propose a new YUV 420 8-bit format. There is no
 "obvious" linear encoding for a 3-component 8:8:8, 420, packed format,
 and so DRM_FORMAT_YUV420_8BIT defines a component order, but not a
 bit encoding. I'm happy to hear different naming suggestions.

YUV 420 8-bit, 2-, 3-plane
--------------------------
 These already exist, we can use NV12 and YUV420.

YUV 420 10-bit, 1-plane
-----------------------
 As above, no current definition exists, and X0L2 encodes a 4th 'X'
 channel.

 Analogous to DRM_FORMAT_YUV420_8BIT, we define DRM_FORMAT_YUV420_10BIT.

[1] https://lists.freedesktop.org/archives/dri-devel/2018-July/184598.html
[2] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16-bit-yuv-video-formats
[3] https://patchwork.kernel.org/patch/10509875/

Changes since RFC v1:
 - Fix confusing subsampling vs bit-depth X:X:X notation in
   descriptions (danvet)
 - Rename DRM_FORMAT_AVYU1101010 to DRM_FORMAT_Y410 (Lisa Wu)
 - Add drm_format_info structures for the new formats, using the
   new 'bpp' field for those with non-integer bytes-per-pixel
 - Rebase, including Juha-Pekka Heikkila's format definitions

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c      |  7 +++++++
 drivers/gpu/drm/drm_framebuffer.c | 33 +++++++++++++++++++++++++++++----
 include/uapi/drm/drm_fourcc.h     | 14 ++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index bb28919c32f3..f830acc3c3f0 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -172,16 +172,23 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YVYU,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
 		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
 		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
+		{ .format = DRM_FORMAT_Y210,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1 },
 		{ .format = DRM_FORMAT_XYUV8888,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_VUY888,		.depth = 0,  .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_XVYU2101010,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_Y410,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_Y0L0,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 2, .has_alpha = true },
 		{ .format = DRM_FORMAT_X0L0,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 2 },
 		{ .format = DRM_FORMAT_Y0L2,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 2, .has_alpha = true },
 		{ .format = DRM_FORMAT_X0L2,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 2 },
 		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_P210,		.depth = 0,  .num_planes = 2, .cpp = { 2, 4, 0 }, .hsub = 2, .vsub = 1 },
 		{ .format = DRM_FORMAT_P010,		.depth = 0,  .num_planes = 2, .cpp = { 2, 4, 0 }, .hsub = 2, .vsub = 2 },
 		{ .format = DRM_FORMAT_P012,		.depth = 0,  .num_planes = 2, .cpp = { 2, 4, 0 }, .hsub = 2, .vsub = 2 },
 		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2, .cpp = { 2, 4, 0 }, .hsub = 2, .vsub = 2 },
+		{ .format = DRM_FORMAT_VUY101010,	.depth = 0,  .num_planes = 1, .cpp = { 0, 0, 0 }, .bpp = { 30, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_YUV420_8BIT,	.depth = 0,  .num_planes = 1, .cpp = { 0, 0, 0 }, .bpp = { 12, 0, 0 }, .hsub = 2, .vsub = 2 },
+		{ .format = DRM_FORMAT_YUV420_10BIT,	.depth = 0,  .num_planes = 1, .cpp = { 0, 0, 0 }, .bpp = { 15, 0, 0 }, .hsub = 2, .vsub = 2 },
 	};
 
 	unsigned int i;
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 7e00360ff70d..6654ff7cb41e 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -152,6 +152,18 @@ static int fb_plane_height(int height,
 	return DIV_ROUND_UP(height, format->vsub);
 }
 
+static bool format_is_non_linear_only(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_VUY101010:
+	case DRM_FORMAT_YUV420_8BIT:
+	case DRM_FORMAT_YUV420_10BIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int framebuffer_check(struct drm_device *dev,
 			     const struct drm_mode_fb_cmd2 *r)
 {
@@ -209,10 +221,23 @@ static int framebuffer_check(struct drm_device *dev,
 			return -EINVAL;
 		}
 
-		if (r->flags & DRM_MODE_FB_MODIFIERS &&
-		    r->modifier[i] != r->modifier[0]) {
-			DRM_DEBUG_KMS("bad fb modifier %llu for plane %d\n",
-				      r->modifier[i], i);
+		if (r->flags & DRM_MODE_FB_MODIFIERS) {
+			if (r->modifier[i] != r->modifier[0]) {
+				DRM_DEBUG_KMS("bad fb modifier %llu for plane %d\n",
+					      r->modifier[i], i);
+				return -EINVAL;
+			}
+		}
+
+		if ((!(r->flags & DRM_MODE_FB_MODIFIERS) ||
+		    r->modifier[i] == DRM_FORMAT_MOD_LINEAR) &&
+		    format_is_non_linear_only(r->pixel_format)) {
+			struct drm_format_name_buf format_name;
+
+			DRM_DEBUG_KMS("format %s cannot be linear\n",
+				      drm_get_format_name(r->pixel_format,
+							  &format_name));
+
 			return -EINVAL;
 		}
 
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3bef399ffd8c..41f4610e471c 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -146,11 +146,15 @@ extern "C" {
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_UYVY		fourcc_code('U', 'Y', 'V', 'Y') /* [31:0] Y1:Cr0:Y0:Cb0 8:8:8:8 little endian */
 #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian */
+#define DRM_FORMAT_Y210		fourcc_code('Y', '2', '1', '0') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian */
 
 /* packed YCbCr444 */
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr 8:8:8:8 little endian */
 #define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
 #define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_Y410 	fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_VUY101010    fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
 
 /*
  * packed YCbCr420 2x2 tiled formats
@@ -167,6 +171,15 @@ extern "C" {
 /* [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
 #define DRM_FORMAT_X0L2		fourcc_code('X', '0', 'L', '2')
 
+/*
+ * 1-plane YUV 4:2:0
+ * In these formats, the component ordering is specified (Y, followed by U
+ * then V), but the exact Linear layout is undefined.
+ * These formats can only be used with a non-Linear modifier.
+ */
+#define DRM_FORMAT_YUV420_8BIT	fourcc_code('Y', 'U', '0', '8')
+#define DRM_FORMAT_YUV420_10BIT	fourcc_code('Y', 'U', '1', '0')
+
 /*
  * 2 plane RGB + A
  * index 0 = RGB plane, same format as the corresponding non _A8 format has
@@ -201,6 +214,7 @@ extern "C" {
  * component xxx msb Y [xxx:16-xxx]
  * index 1 = Cr:Cb plane, [31:0] Cr:Cb little endian [xxx:16-xxx:xxx:16-xxx]
  */
+#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane, 10 bit per channel */
 #define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled Cr:Cb plane, 10 bit per channel */
 #define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampled Cr:Cb plane, 12 bit per channel */
 #define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane, 16 bit per channel */
-- 
2.16.1

