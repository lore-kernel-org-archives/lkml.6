Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E3C67869
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAF92084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAF92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJGQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:01 -0400
Received: from mailoutvs24.siol.net ([185.57.226.215]:39545 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbeJGQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 55F7E520B92;
        Sun,  7 Oct 2018 11:39:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mg1qRiN1NEQy; Sun,  7 Oct 2018 11:39:14 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AF003520BB3;
        Sun,  7 Oct 2018 11:39:14 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B99FD520B92;
        Sun,  7 Oct 2018 11:39:12 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 00/29] Allwinner H6 DE3 and HDMI support
Date:   Sun,  7 Oct 2018 11:38:36 +0200
Message-Id: <20181007093905.11253-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Changes from v1:
- Collected tags
- Reworked some commit messages and titles
- Remove two patches which were already merged
- Added new patches (10, 11, 12, 21)
- Lowered max. supported HDMI pixel clock to 594 MHz
- Reordered compatibles and quirks by family name
- Fixed kbuild test robot warnings
- renamed CLK_NUMBER to CLK_NUMBER_WITHOUT_ROT and introduced
  CLK_NUMBER_WITH_ROT
- removed "inline" from functions in c file
- used regmap_bulk_write() for writing DE3 CSC table
- DE3 specific macros have "DE3_" prefix now
- reworked DE2/3 mixer registers initialization
- removed writing to edge detection registers because
  functionality is not used

Icenowy Zheng (5):
  dt-bindings: bus: add H6 DE3 bus binding
  dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
  drm: sun4i: add quirks for TCON TOP
  dt-bindings: display: sun4i-drm: document H6 TCON TOP
  drm: sun4i: add support for H6 TCON TOP

Jernej Skrabec (24):
  clk: sunxi-ng: Adjust MP clock parent rate when allowed
  clk: sunxi-ng: Use u64 for calculation of NM rate
  clk: sunxi-ng: h6: Set video PLLs limits
  dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
  clk: sunxi-ng: Add support for H6 DE3 clocks
  dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
  drm/sun4i: Add compatible for H6 display engine
  drm/sun4i: Rework DE2 register defines
  drm/sun4i: Rename DE2 registers related macros
  drm/sun4i: Fix DE2 mixer size
  drm/sun4i: Disable unused DE2 sub-engines
  drm/sun4i: Add basic support for DE3
  drm/sun4i: Add support for H6 DE3 mixer 0
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
  drm/sun4i: Not all DW HDMI controllers has scrambled addresses
  drm/sun4i: dw-hdmi: Make mode_valid function configurable
  drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
  drm/sun4i: Add support for H6 DW HDMI controller
  drm/sun4i: dw-hdmi-phy: Reorder quirks by family
  drm/sun4i: Add support for Synopsys HDMI PHY
  drm/sun4i: Add support for H6 HDMI PHY
  drm/sun4i: Initialize registers in tcon-top driver
  arm64: dts: allwinner: h6: Add HDMI pipeline
  arm64: dts: allwinner: h6: Enable HDMI output on Pine H64 board

 .../bindings/bus/sun50i-de2-bus.txt           |   9 +-
 .../devicetree/bindings/clock/sun8i-de2.txt   |   5 +-
 .../bindings/display/sunxi/sun4i-drm.txt      |  30 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  25 +++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 201 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  71 +++++-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h          |   4 +-
 drivers/clk/sunxi-ng/ccu_mp.c                 |  64 +++++-
 drivers/clk/sunxi-ng/ccu_nm.c                 |  18 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  89 +++++++-
 drivers/gpu/drm/sun4i/sun8i_csc.h             |   6 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  46 +++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  14 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 201 +++++++++++++++--
 drivers/gpu/drm/sun4i/sun8i_mixer.c           | 147 ++++++++-----
 drivers/gpu/drm/sun4i/sun8i_mixer.h           | 205 +++++++++++-------
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  58 ++++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  81 ++++---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h        |  49 +++--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c       |  67 +++---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h       |  50 ++---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  91 +++++---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h        |  35 +--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c       | 101 +++++----
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h       |  90 +++++---
 include/dt-bindings/clock/sun8i-de2.h         |   3 +
 include/dt-bindings/reset/sun8i-de2.h         |   1 +
 30 files changed, 1333 insertions(+), 434 deletions(-)

--=20
2.19.0

