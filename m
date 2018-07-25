Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99258C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B5B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B5B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeGYLPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:15:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57755 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbeGYLPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:15:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3EFE20908; Wed, 25 Jul 2018 12:04:30 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6C7362072C;
        Wed, 25 Jul 2018 12:04:20 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 0/8] Cedrus driver for the Allwinner Video Engine, using media requests
Date:   Wed, 25 Jul 2018 12:02:48 +0200
Message-Id: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth iteration of the updated Cedrus driver,
that supports the Video Engine found in most Allwinner SoCs, starting
with the A10. It was tested on the A13, A20, A33 and H3.

The initial version of this driver[0] was originally written and
submitted by Florent Revest using a previous version of the request API
that is necessary to provide coherency between controls and the buffers
they apply to.

The driver was adapted to use the latest version of the media request
API[1], as submitted by Hand Verkuil. Media request API support is a
hard requirement for the Cedrus driver.

The driver itself currently only supports MPEG2 and more codecs will be
added to the driver eventually. The output frames provided by the
Video Engine are in a multi-planar 32x32-tiled YUV format, with a plane
for luminance (Y) and a plane for chrominance (UV). A specific format is
introduced in the V4L2 API to describe it.

This implementation is based on the significant work that was conducted
by various members of the linux-sunxi community for understanding and
documenting the Video Engine's innards.

In addition to the media requests API, the following series are required
for Cedrus:
* vicodec: the Virtual Codec driver
* allwinner: a64: add SRAM controller / system control
* SRAM patches from the Cedrus VPU driver series version 5

Changes since v5:
* Added MPEG2 quantization matrices definitions and support;
* Cleaned up registers definitions;
* Moved the driver to staging as requested;
* Removed label and newline in device-tree sources;
* Made it possible to build the driver for COMPILE_TEST;
* Fixed various strict checkpatch warnings;
* Used v4l2_m2m_register_media_controller and MEDIA_ENT_F_PROC_VIDEO_DECODER;
* Moved capabilities to compatible-specific variants;
* Removed overkill buffer checks in device_run;
* Renamed from Sunxi-Cedrus to Cedrus.

Changes since v4:
* updated to version 16 of the media requests API;
* added support for VPU-based untiling (starting with the A33);
* added support for the H3, with SRAM support;
* reworked SRAM support and associated compatibles;
* improved failure paths;
* added some MPEG2 input data validation;
* reworked video/format functions to handle multiple formats;
* removed in-driver buffer queues;
* used a threaded irq instead of a workqueue;
* merged various improvements and cleanups from Maxime;
* renamed MPEG2_SLICE_HEADER to MPEG2_SLICE_PARAMS;
* added prefixes to MPEG2 picture coding types;
* used single-buffer allocations to ensure contiguous planes

Changes since v3:
* updated to version 15 of the media request API;
* got rid of untested MPEG1 support;
* added definitons for picture coding types;
* added documentation about MPEG2 slice header fields;
* added documentation about MPEG2 slice format;
* added documentation about the MB32 NV12 format;
* added MPEG2 slice header validation;
* removed the assigned-clocks property;
* reworked and fixed error paths;
* harmonized debug prints, with v4l2 helpers when applicable;
* checked the series through checkpatch;
* switched to SPDX license headers;
* renamed MPEG2 frame header to slice header for consistency and clarity;
* removed A20 SRAM compatible from the driver's list.

Changes since v2:
* updated to version 13 of the media request API;
* integrated various changes from Maxime Ripard;
* reworked memory reservation to use CMA, dynamic allocation and allow
  DMABUF;
* removed reserved memory binding since the CMA pool is the default one
  (and allow ENODEV in the driver, for that use case);
* added SRAM controller support for the SRAM region used by the VE;
* updated the device-tree bindings the for SRAM region;
* added per-platform bindings;
* added A13 support;
* renamed VE node name and label;
* fixed Florent's authorship for the MPEG2 headers;
* added a MAINTAINERS entry.

Changes since v1:
* use the latest version of the request API for Hans Verkuil;
* added media controller support and dependency
* renamed v4l2 format to the more explicit V4L2_PIX_FMT_MB32_NV12;
* reworked bindings documentation;
* moved driver to drivers/media/platforms/sunxi/cedrus to pair with
  incoming CSI support ;
* added a workqueue and lists to schedule buffer completion, since it
  cannot be done in interrupt context;
* split mpeg2 support into a setup and a trigger function to avoid race
  condition;
* split video-related ops to a dedicated sunxi_cedrus_video file;
* cleaned up the included headers for each file;
* used device PFN offset instead of subtracting PHYS_BASE;
* used reset_control_reset instead of assert+deassert;
* put the device in reset when removing driver;
* changed dt bindings to use the last 96 Mib of the first 256 MiB of
  DRAM;
* made it clear in the mpeg frame header structure that forward and
  backward indexes are used as reference frames for motion vectors;
* lots of small cosmetic and consistency changes, including naming
  harmonization and headers text rework.

Cheers!

[0]: https://patchwork.kernel.org/patch/9299073/
[1]: https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=reqv16

Paul Kocialkowski (8):
  media: v4l: Add definitions for MPEG2 slice format and metadata
  media: v4l: Add definition for Allwinner's MB32-tiled NV12 format
  dt-bindings: media: Document bindings for the Cedrus VPU driver
  media: platform: Add Cedrus VPU decoder driver
  ARM: dts: sun5i: Add Video Engine and reserved memory nodes
  ARM: dts: sun7i-a20: Add Video Engine and reserved memory nodes
  ARM: dts: sun8i-a33: Add Video Engine and reserved memory nodes
  ARM: dts: sun8i-h3: Add Video Engine and reserved memory nodes

 .../devicetree/bindings/media/cedrus.txt      |  54 ++
 .../media/uapi/v4l/extended-controls.rst      | 122 ++++
 .../media/uapi/v4l/pixfmt-compressed.rst      |   5 +
 .../media/uapi/v4l/pixfmt-reserved.rst        |  15 +-
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/sun5i.dtsi                  |  26 +
 arch/arm/boot/dts/sun7i-a20.dtsi              |  26 +
 arch/arm/boot/dts/sun8i-a33.dtsi              |  26 +
 arch/arm/boot/dts/sun8i-h3.dtsi               |  25 +
 drivers/media/v4l2-core/v4l2-ctrls.c          |  54 ++
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 drivers/staging/media/Kconfig                 |   2 +
 drivers/staging/media/Makefile                |   1 +
 drivers/staging/media/sunxi/Kconfig           |  15 +
 drivers/staging/media/sunxi/Makefile          |   1 +
 drivers/staging/media/sunxi/cedrus/Kconfig    |  14 +
 drivers/staging/media/sunxi/cedrus/Makefile   |   3 +
 drivers/staging/media/sunxi/cedrus/cedrus.c   | 419 +++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h   | 166 +++++
 .../staging/media/sunxi/cedrus/cedrus_dec.c   | 114 ++++
 .../staging/media/sunxi/cedrus/cedrus_dec.h   |  27 +
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 319 ++++++++++
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |  29 +
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 240 ++++++++
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 235 ++++++++
 .../staging/media/sunxi/cedrus/cedrus_video.c | 566 ++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_video.h |  31 +
 include/media/v4l2-ctrls.h                    |  18 +-
 include/uapi/linux/v4l2-controls.h            |  43 ++
 include/uapi/linux/videodev2.h                |   6 +
 30 files changed, 2603 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/cedrus.txt
 create mode 100644 drivers/staging/media/sunxi/Kconfig
 create mode 100644 drivers/staging/media/sunxi/Makefile
 create mode 100644 drivers/staging/media/sunxi/cedrus/Kconfig
 create mode 100644 drivers/staging/media/sunxi/cedrus/Makefile
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus.c
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus.h
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_dec.c
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_dec.h
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_hw.c
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_hw.h
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_regs.h
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_video.c
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_video.h

-- 
2.18.0

