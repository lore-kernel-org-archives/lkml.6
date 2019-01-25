Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CCAC282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7532085A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAYDYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:24:09 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59250 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfAYDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:18 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 149355FCC3; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] ARM: sun8i: a23: Enable display pipeline
Date:   Fri, 25 Jan 2019 11:23:03 +0800
Message-Id: <20190125032314.20915-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series enables the display pipeline on the Allwinner A23 SoC.
A few fixes are included for corner cases when the frontend isn't
enabled.

The A23 display pipeline is very much the same as the A33, except
that the A23 does not have the SAT IP block embedded within the
display backend.

MIPI DSI is not covered as I do not have a device that uses it.

Patch 1 fixes the pll-mipi clock on the A23.

Patch 2 adds compatible strings for the various hardware blocks
of the A23 display pipeline.

Patch 3 through 5 fix some issues in our DRM plane support, namely
declaring support for formats when we shouldn't.

Patch 6 adds support for the A23 display pipeline to the driver.

Patch 7 is a small cleanup before moving the display pipeline device
nodes.

Patch 8 moves the display nodes from the A33-specific dtsi file to
the A23-A33 shared dtsi file. Note that the MIPI DSI device nodes are
not moved.

Patch 9 adds compatible strings to the display nodes in the A23-specific
dtsi file.

Patch 10 enables the display pipeline for the shared A23/A33 Q8 tablet
dtsi file. The compatible string should be filled in by the tablet dts
files.

Patch 11 fills in the compatible string for the standard A23 Q8 tablet.
Note the compatible string is not for the specific model used in the
tablet, as it varies between production runs. Rather it is just one that
works.

Please have a look. Patch 3 might be worth applying as a fix, but might
not be worth the trouble. It could just as easily be applied for -next
and then backported.

Also, the fixes tags are no longer line wrapped, unlike patches I've
sent in the past.


Regards
ChenYu

Chen-Yu Tsai (11):
  clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when ungating it
  dt-bindings: display: sun4i-drm: Add compatible strings for A23
    display
  drm/sun4i: backend: Remove BGRX8888 from list of supported formats
  drm/sun4i: layer: Assign backend pointer before calling DRM helpers
  drm/sun4i: layer: support just backend formats when frontend is
    unavailable
  drm/sun4i: Add support for A23 display pipeline
  ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by
    address
  ARM: dts: sun8i-a33: Move display pipeline nodes to a23/a33 common
    dtsi
  ARM: dts: sun8i-a23: Add compatible strings to display pipeline device
    nodes
  ARM: dts: sun8i-q8-common: Enable display pipeline with RGB LCD panel
  ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel

 .../bindings/display/sunxi/sun4i-drm.txt      |   5 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          | 175 ++++++++++++++--
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts     |   4 +
 arch/arm/boot/dts/sun8i-a23.dtsi              |  20 ++
 arch/arm/boot/dts/sun8i-a33.dtsi              | 194 ++++--------------
 arch/arm/boot/dts/sun8i-q8-common.dtsi        |  37 ++++
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |   5 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   2 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |   4 +
 drivers/gpu/drm/sun4i/sun4i_layer.c           |  37 +++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c             |   1 +
 13 files changed, 310 insertions(+), 177 deletions(-)

-- 
2.20.1

