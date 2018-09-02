Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18253C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB57F2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB57F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeIBLlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:41:51 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:54389 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbeIBLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:41:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E684F520286;
        Sun,  2 Sep 2018 09:26:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c1khIFjiZFZ6; Sun,  2 Sep 2018 09:26:58 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 26A0952037D;
        Sun,  2 Sep 2018 09:26:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3829D520286;
        Sun,  2 Sep 2018 09:26:56 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 00/27] Allwinner H6 DE3 and HDMI support
Date:   Sun,  2 Sep 2018 09:26:16 +0200
Message-Id: <20180902072643.4917-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Display Engine 3.0 and HDMI 2.0a, which
can be found on H6 SoC.

Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
displaying and processing 10-bit and AFBC formats, which are not yet
supported by this series.

This series is based on linux-next at next-20180828, which has working
R40 display pipeline support. I'll rebase series on later linux-next, if
needed, once R40 display pipeline support is reintroduced.

I suggest all patches go through allwinner tree, except DRM patches,
which should go through drm-misc tree.

Last detail, PineH64 model A schematic has DDC_EN signal, which enables
DDC voltage level shifter. TL Lim, PINE64 founder, said that this
signal is not actually present on PineH64 model A board. It is, however
present on PineH64 model B engineering samples, but it will be removed
in production version. Because of that, I didn't include any code for
it.

Please take a look.

Best regards,
Jernej

Icenowy Zheng (7):
  dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
  arm64: allwinner: h6: add system controller device tree node
  dt-bindings: bus: add H6 DE3 bus binding
  dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
  drm: sun4i: add quirks for TCON TOP
  dt-bindings: display: sun4i-drm: document H6 TCON TOP
  drm: sun4i: add support for H6 TCON TOP

Jernej Skrabec (20):
  clk: sunxi-ng: Adjust MP clock parent rate when allowed
  clk: sunxi-ng: Use u64 for calculation of NM rate
  clk: sunxi-ng: h6: Set video PLLs limits
  dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
  clk: sunxi-ng: Add support for H6 DE3 clocks
  dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
  drm/sun4i: Add compatible for H6 display engine
  drm/sun4i: Rework DE2 register defines
  drm/sun4i: Add basic support for DE3
  drm/sun4i: Add support for H6 DE3 mixer 0
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
  drm/sun4i: Not all DW HDMI controllers has scrambled addresses
  drm/sun4i: dw-hdmi: Make mode_valid function configurable
  drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
  drm/sun4i: Add support for H6 DW HDMI controller
  drm/sun4i: Add support for Synopsys HDMI PHY
  drm/sun4i: Add support for H6 HDMI PHY
  drm/sun4i: Initialize registers in tcon-top driver
  arm64: dts: sun50i: h6: Add HDMI pipeline
  arm64: dts: sun50i: h6: Enable HDMI output on Pine H64 board

 .../bindings/bus/sun50i-de2-bus.txt           |   9 +-
 .../devicetree/bindings/clock/sun8i-de2.txt   |   5 +-
 .../bindings/display/sunxi/sun4i-drm.txt      |  30 ++-
 .../devicetree/bindings/sram/sunxi-sram.txt   |   4 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  25 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 224 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  65 +++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h          |   1 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |  64 ++++-
 drivers/clk/sunxi-ng/ccu_nm.c                 |  18 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  96 +++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  45 +++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  14 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 178 +++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  44 +++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  61 +++--
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  58 ++++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  47 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h        |  37 +--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c       |  45 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h       |  28 +--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  55 +++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h        |  25 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c       |  85 +++++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h       |  68 ++++--
 include/dt-bindings/clock/sun8i-de2.h         |   3 +
 include/dt-bindings/reset/sun8i-de2.h         |   1 +
 30 files changed, 1127 insertions(+), 214 deletions(-)

-- 
2.18.0

