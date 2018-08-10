Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A0C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC593223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC593223E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeHJRak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:30:40 -0400
Received: from foss.arm.com ([217.140.101.70]:38860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbeHJRak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:30:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B63057A9;
        Fri, 10 Aug 2018 08:00:25 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.cambridge.arm.com (DESKTOP-E1NTVVP.cambridge.arm.com [10.1.37.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DFE3F6C4;
        Fri, 10 Aug 2018 08:00:22 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     alexandru-cosmin.gheorghe@arm.com, ayan.halder@arm.com,
        james.qian.wang@arm.com, daniel@fooishbar.org, daniel@ffwll.ch,
        krh@bitplanet.net, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        raymond.smith@arm.com, david.garbett@arm.com, lisa.wu@arm.com,
        matt.szczesiak@arm.com, charles.xu@arm.com
Subject: [RFC PATCH] drm/fourcc: Add remaining fourccs for Mali
Date:   Fri, 10 Aug 2018 16:00:17 +0100
Message-Id: <20180810150017.19364-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC adds the remaining fourcc codes which are needed to cover all
currently supported formats in Mali IPs.

There was quite a lengthy discussion on IRC about it - please treat this
as RFC and read the commentary below!

This patch is on-top of
https://lists.freedesktop.org/archives/dri-devel/2018-July/184598.html,
but note I have changed the fourcc code for XVYU2101010 to be more
consistent. We can of course update the previous patch after we have
resolved this discussion.

---

As we look to enable AFBC using DRM format modifiers, we run into
problems which we've historically handled via vendor-private details
(i.e. gralloc, on Android).

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
 DRM_FORMAT_VUY888 - Packed 8-bit YUV 4:4:4. Y followed by U then V.
 DRM_FORMAT_VUY101010 - Packed 10-bit YUV 4:4:4. Y followed by U then
                        V. No defined linear encoding.
 DRM_FORMAT_Y210 - Packed 10-bit YUV 4:2:2. Y followed by U (then Y)
                   then V. 10-bit samples in 16-bit words.
 DRM_FORMAT_P210 - Semi-planar 10-bit YUV 4:2:2. Y plane, followed by
                   interleaved U-then-V plane. 10-bit samples in
                   16-bit words.
 DRM_FORMAT_YUV420_8BIT - Packed 8-bit YUV 4:2:0. Y followed by U then
                          V. No defined linear encoding
 DRM_FORMAT_YUV420_10BIT - Packed 10-bit YUV 4:2:0. Y followed by U
                           then V. No defined linear encoding
 DRM_FORMAT_P010 - Semi-planar 10-bit YUV 4:2:0. Y plane, followed by
                   interleaved U-then-V plane. Added in [1].

Please also note that in the absence of AFBC, we would still need to
add Y210, P210 and P010.

Full rationale follows:

YUV 4:4:4 8-bit, 1-plane - New format
-------------------------------------
 The currently defined AYUV format encodes a 4th alpha component,
 which makes it unsuitable for representing a 3-component YUV 4:4:4
 AFBC stream.

 The proposed[1] XYUV format which is supported by Mali-DP in linear
 layout is also unsuitable, because the component order is the
 opposite of the AFBC version, and it encodes a 4th 'X' component.

 DRM_FORMAT_VUY888 is the "obvious" format for a 3-component, packed,
 YUV 444 8-bit format, with the component order which our HW expects to
 encode/decode. It conforms to the same naming convention as the
 existing packed YUV 4:4:4 format.
 The naming here is meant to be consistent with DRM_FORMAT_AYUV and
 DRM_FORMAT_XYUV[1]

YUV 4:4:4 10-bit, 1-plane - New format
--------------------------------------
 There is no currently-defined YUV 4:4:4 10-bit format in
 drm_fourcc.h, irrespective of number of planes.

 The proposed[1] XVYU2101010 format which is supported by Mali-DP in
 linear layout uses the wrong component order, and also encodes a 4th
 'X' component, which doesn't match the AFBC version of YUV 4:4:4
 10-bit which we support.

 There is no "obvious" linear encoding for a 3-component 10:10:10
 packed format, and so DRM_FORMAT_VUY101010 defines a component
 order, but not a bit encoding. Again, the naming is meant to be
 consistent with DRM_FORMAT_AYUV.

YUV 4:2:2 8-bit, 1-plane
------------------------
 The existing DRM_FORMAT_YUYV (and the other component orders) are
 single-planar YUV 4:2:2 8-bit formats. Following the convention of
 the component orders of the RGB formats, YUYV has the correct
 component order for our AFBC encoding (Y followed by U followed by
 V). We can use YUYV for AFBC YUV 4:2:2 8-bit.

YUV 4:2:2 10-bit, 1-plane - New format
--------------------------------------
 There is no currently-defined YUV 4:2:2 10-bit format in drm_fourcc.h

 DRM_FORMAT_Y210 is analogous to YUYV, but with 10-bits per sample
 packed into the upper 10-bits of 16-bit samples. This format is
 supported in both linear and AFBC by Mali GPUs.

YUV 4:2:2 10-bit, 2-plane - New format
--------------------------------------
 There is no currently-defined YUV 4:2:2 10-bit format in drm_fourcc.h

 DRM_FORMAT_P210 is analogous to NV16, but with 10-bits per sample
 packed into the upper 10-bits of 16-bit samples. This format is
 supported in both Linear and AFBC by Mali GPUs.

YUV 4:2:0 8-bit, 1-plane - New format
-------------------------------------
 There is no currently defined single-planar YUV 4:2:0, 8-bit format
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

 To that end, we propose a new YUV 4:2:0 8-bit format. There is no
 "obvious" linear encoding for a 3-component 8:8:8, 4:2:0, packed format,
 and so DRM_FORMAT_YUV420_8BIT defines a component order, but not a
 bit encoding. I'm happy to hear different naming suggestions.

YUV 4:2:0 8-bit, 2-, 3-plane
----------------------------
 These already exist, we can use NV12 and YUV420.

YUV 4:2:0 10-bit, 1-plane - New format
-------------------------------------
 As above, no current definition exists, and X0L2 encodes a 4th 'X'
 channel.

 Analogous to DRM_FORMAT_YUV420_8BIT, we define DRM_FORMAT_YUV420_10BIT.

YUV 4:2:0 10-bit, 2-plane - New format
--------------------------------------
 The proposed[1] (and relatively common) P010 is a 2-plane, 10-bit YUV
 format, which has the correct component order for our AFBC encoding.

Thanks and best regards,
-Brian

[1] https://lists.freedesktop.org/archives/dri-devel/2018-July/184598.html
[2] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16-bit-yuv-video-formats

 include/uapi/drm/drm_fourcc.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 213357940424..a44bbb032171 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -110,11 +110,14 @@ extern "C" {
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_UYVY		fourcc_code('U', 'Y', 'V', 'Y') /* [31:0] Y1:Cr0:Y0:Cb0 8:8:8:8 little endian */
 #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian */
+#define DRM_FORMAT_Y210		fourcc_code('Y', '2', '1', '0') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian */
 
 /* packed YCbCr444 */
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr 8:8:8:8 little endian */
 #define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
-#define DRM_FORMAT_XVYU2101010	fourcc_code('V', 'U', '3', '0') /* [31:0] X:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
+#define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_VUY101010    fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
 
 /*
  * packed YCbCr420 2x2 tiled formats
@@ -131,6 +134,15 @@ extern "C" {
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
@@ -164,6 +176,7 @@ extern "C" {
  * Y plane: [63:0] Y3:0:Y2:0:Y1:0:Y0:0, 10:6:10:6:10:6:10:6
  * CrCb plane: [63:0] Cr2:0:Cb2:0:Cr0:0:Cb0:0, 10:6:10:6:10:6:10:6
  */
+#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane */
 #define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled Cr:Cb plane */
 
 /*
-- 
2.17.1

