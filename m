Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA7A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHWSyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:54:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeHWSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:54:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E481650;
        Thu, 23 Aug 2018 08:23:59 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61AC73F2EA;
        Thu, 23 Aug 2018 08:23:57 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@fooishbar.org, airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org
Cc:     linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
Subject: [RFC PATCH v2 3/3] drm/afbc: Add AFBC modifier usage documentation
Date:   Thu, 23 Aug 2018 16:23:43 +0100
Message-Id: <20180823152343.6474-4-brian.starkey@arm.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180823152343.6474-1-brian.starkey@arm.com>
References: <20180823152343.6474-1-brian.starkey@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFBC is a flexible, proprietary, lossless compression protocol and
format, with a number of defined DRM format modifiers. To facilitate
consistency and compatibility between different AFBC producers and
consumers, document the expectations for usage of the AFBC DRM format
modifiers in a new .rst chapter.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 Documentation/gpu/afbc.rst    | 226 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/gpu/drivers.rst |   1 +
 MAINTAINERS                   |   1 +
 include/uapi/drm/drm_fourcc.h |   3 +
 4 files changed, 231 insertions(+)
 create mode 100644 Documentation/gpu/afbc.rst

diff --git a/Documentation/gpu/afbc.rst b/Documentation/gpu/afbc.rst
new file mode 100644
index 000000000000..58d2b6b5d48b
--- /dev/null
+++ b/Documentation/gpu/afbc.rst
@@ -0,0 +1,226 @@
+===================================
+ Arm Framebuffer Compression (AFBC)
+===================================
+
+AFBC is a proprietary lossless image compression protocol and format.
+It provides fine-grained random access and minimizes the amount of
+data transferred between IP blocks.
+
+AFBC can be enabled on drivers which support it via use of the AFBC
+format modifiers defined in drm_fourcc.h. See DRM_FORMAT_MOD_ARM_AFBC(*).
+
+All users of the AFBC modifiers must follow the usage guidelines laid
+out in this document, to ensure compatibility across different AFBC
+producers and consumers.
+
+Components and Ordering
+=======================
+
+AFBC streams can contain several components - where a component
+corresponds to a color channel (i.e. R, G, B, X, A, Y, Cb, Cr).
+The assignment of input/output color channels must be consistent
+between the encoder and the decoder for correct operation, otherwise
+the consumer will interpret the decoded data incorrectly.
+
+Furthermore, when the lossless colorspace transform is used
+(AFBC_FORMAT_MOD_YTR, which should be enabled for RGB buffers for
+maximum compression efficiency), the component order must be:
+
+ * Component 0: R
+ * Component 1: G
+ * Component 2: B
+
+The component ordering is communicated via the fourcc code in the
+fourcc:modifier pair. In general, component '0' is considered to
+reside in the least-significant bits of the corresponding linear
+format. For example, COMP(bits):
+
+ * DRM_FORMAT_ABGR8888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+   * Component 3: A(8)
+
+ * DRM_FORMAT_BGR888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+
+ * DRM_FORMAT_YUYV
+
+   * Component 0: Y(8)
+   * Component 1: Cb(8, 2x1 subsampled)
+   * Component 2: Cr(8, 2x1 subsampled)
+
+In AFBC, 'X' components are not treated any differently from any other
+component. Therefore, an AFBC buffer with fourcc DRM_FORMAT_XBGR8888
+encodes with 4 components, like so:
+
+ * DRM_FORMAT_XBGR8888
+
+   * Component 0: R(8)
+   * Component 1: G(8)
+   * Component 2: B(8)
+   * Component 3: X(8)
+
+Please note, however, that the inclusion of a "wasted" 'X' channel is
+bad for compression efficiency, and so it's recommended to avoid
+formats containing 'X' bits. If a fourth component is
+required/expected by the encoder/decoder, then it is recommended to
+instead use an equivalent format with alpha, setting all alpha bits to
+'1'. If there is no requirement for a fourth component, then a format
+which doesn't include alpha can be used, e.g. DRM_FORMAT_BGR888.
+
+Number of Planes
+================
+
+Formats which are typically multi-planar in linear layouts (e.g. YUV
+420), can be encoded into one, or multiple, AFBC planes. As with
+component order, the encoder and decoder must agree about the number
+of planes in order to correctly decode the buffer. The fourcc code is
+used to determine the number of encoded planes in an AFBC buffer,
+matching the number of planes for the linear (unmodified) format.
+Within each plane, the component ordering also follows the fourcc
+code:
+
+For example:
+
+ * DRM_FORMAT_YUYV: nplanes = 1
+
+   * Plane 0:
+
+     * Component 0: Y(8)
+     * Component 1: Cb(8, 2x1 subsampled)
+     * Component 2: Cr(8, 2x1 subsampled)
+
+ * DRM_FORMAT_NV12: nplanes = 2
+
+   * Plane 0:
+
+     * Component 0: Y(8)
+
+   * Plane 1:
+
+     * Component 0: Cb(8, 2x1 subsampled)
+     * Component 1: Cr(8, 2x1 subsampled)
+
+Cross-device interoperability
+=============================
+
+For maximum compatibility across devices, the table below defines
+canonical formats for use between AFBC-enabled devices. Formats which
+are listed here must be used exactly as specified when using the AFBC
+modifiers. Formats which are not listed should be avoided.
+
+.. flat-table:: AFBC formats
+
+   * - Fourcc code
+     - Description
+     - Planes/Components
+
+   * - DRM_FORMAT_ABGR2101010
+     - 10-bit per component RGB, with 2-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(10)
+              * Component 1: G(10)
+              * Component 2: B(10)
+              * Component 3: A(2)
+
+   * - DRM_FORMAT_ABGR8888
+     - 8-bit per component RGB, with 8-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(8)
+              * Component 1: G(8)
+              * Component 2: B(8)
+              * Component 3: A(8)
+
+   * - DRM_FORMAT_BGR888
+     - 8-bit per component RGB
+     - Plane 0: 3 components
+              * Component 0: R(8)
+              * Component 1: G(8)
+              * Component 2: B(8)
+
+   * - DRM_FORMAT_BGR565
+     - 5/6-bit per component RGB
+     - Plane 0: 3 components
+              * Component 0: R(5)
+              * Component 1: G(6)
+              * Component 2: B(5)
+
+   * - DRM_FORMAT_ABGR1555
+     - 5-bit per component RGB, with 1-bit alpha
+     - Plane 0: 4 components
+              * Component 0: R(5)
+              * Component 1: G(5)
+              * Component 2: B(5)
+              * Component 3: A(1)
+
+   * - DRM_FORMAT_VUY888
+     - 8-bit per component YCbCr 444, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8)
+              * Component 2: Cr(8)
+
+   * - DRM_FORMAT_VUY101010
+     - 10-bit per component YCbCr 444, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10)
+              * Component 2: Cr(10)
+
+   * - DRM_FORMAT_YUYV
+     - 8-bit per component YCbCr 422, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8, 2x1 subsampled)
+              * Component 2: Cr(8, 2x1 subsampled)
+
+   * - DRM_FORMAT_Y210
+     - 10-bit per component YCbCr 422, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10, 2x1 subsampled)
+              * Component 2: Cr(10, 2x1 subsampled)
+
+   * - DRM_FORMAT_YUV420_8BIT
+     - 8-bit per component YCbCr 420, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(8)
+              * Component 1: Cb(8, 2x2 subsampled)
+              * Component 2: Cr(8, 2x2 subsampled)
+
+   * - DRM_FORMAT_YUV420_10BIT
+     - 10-bit per component YCbCr 420, single plane
+     - Plane 0: 3 components
+              * Component 0: Y(10)
+              * Component 1: Cb(10, 2x2 subsampled)
+              * Component 2: Cr(10, 2x2 subsampled)
+
+   * - DRM_FORMAT_NV12
+     - 8-bit per component YCbCr 420, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(8)
+       Plane 1: 2 components
+              * Component 0: Cb(8, 2x2 subsampled)
+              * Component 1: Cr(8, 2x2 subsampled)
+
+   * - DRM_FORMAT_P010
+     - 10-bit per component YCbCr 420, two plane
+     - Plane 0: 1 component
+              * Component 0: Y(10)
+       Plane 1: 2 components
+              * Component 0: Cb(10, 2x2 subsampled)
+              * Component 1: Cr(10, 2x2 subsampled)
+
+   * - DRM_FORMAT_YUV420
+     - 8-bit per component YCbCr 420, three plane
+     - Plane 0: 1 component
+              * Component 0: Y(8)
+       Plane 1: 1 component
+              * Component 0: Cb(8, 2x2 subsampled)
+       Plane 2: 1 component
+              * Component 0: Cr(8, 2x2 subsampled)
diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index d3ab6abae838..304691cb90e8 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -13,6 +13,7 @@ GPU Driver Documentation
    vc4
    bridge/dw-hdmi
    xen-front
+   afbc
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 4af7f6119530..8fb92f162ae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,6 +1036,7 @@ M:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 F:	drivers/gpu/drm/arm/
 F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+F:	Documentation/gpu/afbc.rst
 
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 41f4610e471c..4ef685a02adc 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -494,6 +494,9 @@ extern "C" {
  * AFBC has several features which may be supported and/or used, which are
  * represented using bits in the modifier. Not all combinations are valid,
  * and different devices or use-cases may support different combinations.
+ *
+ * Further information on the use of AFBC modifiers can be found in
+ * Documentation/gpu/afbc.rst
  */
 #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
 
-- 
2.16.1

