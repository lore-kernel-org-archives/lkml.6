Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D2820893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH1LxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:53:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34771 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbeH1LxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:53:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3805A207EB; Tue, 28 Aug 2018 10:02:53 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id C316620618;
        Tue, 28 Aug 2018 10:02:52 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 0/2] HEVC/H.265 stateless support for V4L2 and Cedrus
Date:   Tue, 28 Aug 2018 10:02:38 +0200
Message-Id: <20180828080240.10982-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the required bits for supporting HEVC/H.265 both in the
V4L2 framework and the Cedrus VPU driver that concerns Allwinner
devices.

A specific pixel format is introduced for the HEVC slice format and
controls are provided to pass the bitstream metadata to the decoder.
Some bitstream extensions are knowingly not supported at this point.

Since this is the first proposal for stateless HEVC/H.265 support in
V4L2, reviews and comments about the controls definitions are
particularly welcome.

On the Cedrus side, the H.265 implementation covers frame pictures
with both uni-directional and bi-direction prediction modes (P/B
slices). Field pictures (interleaved), scaling lists and 10-bit output
are not supported at this point.

This series is based upon the following series:
* Cedrus driver for the Allwinner Video Engine, using media requests
* media: cedrus: Add H264 decoding support

Cheers!

Paul Kocialkowski (2):
  media: v4l: Add definitions for the HEVC slice format and controls
  media: cedrus: Add HEVC/H.265 decoding support

 .../media/uapi/v4l/extended-controls.rst      | 416 ++++++++++++++
 .../media/uapi/v4l/pixfmt-compressed.rst      |  15 +
 .../media/uapi/v4l/vidioc-queryctrl.rst       |  18 +
 .../media/videodev2.h.rst.exceptions          |   3 +
 drivers/media/v4l2-core/v4l2-ctrls.c          |  26 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  19 +
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  20 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |   9 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 540 ++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   4 +
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 290 ++++++++++
 .../staging/media/sunxi/cedrus/cedrus_video.c |  13 +
 include/media/v4l2-ctrls.h                    |   6 +
 include/uapi/linux/v4l2-controls.h            | 155 +++++
 include/uapi/linux/videodev2.h                |   7 +
 17 files changed, 1542 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_h265.c

-- 
2.18.0

