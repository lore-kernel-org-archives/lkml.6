Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB5C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12CE2414E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12CE2414E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeGENdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:33:24 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41220 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753401AbeGENdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:18 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id E3B37CD4A;
        Thu,  5 Jul 2018 16:33:16 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 03/34] media: v4l: Add new 10-bit packed grayscale format
Date:   Thu,  5 Jul 2018 16:32:34 +0300
Message-Id: <1530797585-8555-4-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new format will be called V4L2_PIX_FMT_Y10P.
It is similar to the V4L2_PIX_FMT_SBGGR10P family formats
but V4L2_PIX_FMT_Y10P is a grayscale format.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 Documentation/media/uapi/v4l/pixfmt-y10p.rst | 33 ++++++++++++++++++++++++++++
 Documentation/media/uapi/v4l/yuv-formats.rst |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c         |  1 +
 include/uapi/linux/videodev2.h               |  1 +
 4 files changed, 36 insertions(+)
 create mode 100644 Documentation/media/uapi/v4l/pixfmt-y10p.rst

diff --git a/Documentation/media/uapi/v4l/pixfmt-y10p.rst b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
new file mode 100644
index 0000000..13b5713
--- /dev/null
+++ b/Documentation/media/uapi/v4l/pixfmt-y10p.rst
@@ -0,0 +1,33 @@
+.. -*- coding: utf-8; mode: rst -*-
+
+.. _V4L2-PIX-FMT-Y10P:
+
+******************************
+V4L2_PIX_FMT_Y10P ('Y10P')
+******************************
+
+Grey-scale image as a MIPI RAW10 packed array
+
+
+Description
+===========
+
+This is a packed grey-scale image format with a depth of 10 bits per
+pixel. Every four consecutive pixels are packed into 5 bytes. Each of
+the first 4 bytes contain the 8 high order bits of the pixels, and
+the 5th byte contains the 2 least significants bits of each pixel,
+in the same order.
+
+**Bit-packed representation.**
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths: 8 8 8 8 64
+
+    * - Y'\ :sub:`00[9:2]`
+      - Y'\ :sub:`01[9:2]`
+      - Y'\ :sub:`02[9:2]`
+      - Y'\ :sub:`03[9:2]`
+      - Y'\ :sub:`03[1:0]`\ (bits 7--6) Y'\ :sub:`02[1:0]`\ (bits 5--4)
+	Y'\ :sub:`01[1:0]`\ (bits 3--2) Y'\ :sub:`00[1:0]`\ (bits 1--0)
diff --git a/Documentation/media/uapi/v4l/yuv-formats.rst b/Documentation/media/uapi/v4l/yuv-formats.rst
index 3334ea4..9ab0592 100644
--- a/Documentation/media/uapi/v4l/yuv-formats.rst
+++ b/Documentation/media/uapi/v4l/yuv-formats.rst
@@ -29,6 +29,7 @@ to brightness information.
     pixfmt-y10
     pixfmt-y12
     pixfmt-y10b
+    pixfmt-y10p
     pixfmt-y16
     pixfmt-y16-be
     pixfmt-y8i
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0167056..2e3b1f0 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1184,6 +1184,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
 	case V4L2_PIX_FMT_Y10BPACK:	descr = "10-bit Greyscale (Packed)"; break;
+	case V4L2_PIX_FMT_Y10P:		descr = "10-bit Greyscale (MIPI Packed)"; break;
 	case V4L2_PIX_FMT_Y8I:		descr = "Interleaved 8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12I:		descr = "Interleaved 12-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Z16:		descr = "16-bit Depth"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index a15e03b..fc177d8 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -522,6 +522,7 @@ struct v4l2_pix_format {
 
 /* Grey bit-packed formats */
 #define V4L2_PIX_FMT_Y10BPACK    v4l2_fourcc('Y', '1', '0', 'B') /* 10  Greyscale bit-packed */
+#define V4L2_PIX_FMT_Y10P    v4l2_fourcc('Y', '1', '0', 'P') /* 10  Greyscale, MIPI RAW10 packed */
 
 /* Palette formats */
 #define V4L2_PIX_FMT_PAL8    v4l2_fourcc('P', 'A', 'L', '8') /*  8  8-bit palette */
-- 
2.7.4

