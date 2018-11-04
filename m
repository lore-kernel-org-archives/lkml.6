Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F3C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00E720854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00E720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbeKEDn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:29 -0500
Received: from mailoutvs36.siol.net ([185.57.226.227]:47047 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731376AbeKEDn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 798DD521233;
        Sun,  4 Nov 2018 19:27:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WE7iX061fDpk; Sun,  4 Nov 2018 19:27:31 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DA7B6520FA2;
        Sun,  4 Nov 2018 19:27:30 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 30F3B521256;
        Sun,  4 Nov 2018 19:27:27 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Date:   Sun,  4 Nov 2018 19:26:37 +0100
Message-Id: <20181104182705.18047-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
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

H6 is also the first SoC which supports IOMMU, but support for it is
not yet added.

This series is based on linux-next at next-20181102.

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

Changes from v2:
- Collected tags
- Removed patch which renames all DE2 macros
- Converted bool struct members in header files to unsigned int bitfield.
  This issue was reported by checkpatch.pl --strict.
- Fixed code style in tcon top driver and removed unnecessary initializat=
ion
- Moved set_rate quirk check in dw-hdmi driver to more appropriate place
- Fixed compatible for H6 DE3 bus compatible

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

Jernej Skrabec (23):
  clk: sunxi-ng: Adjust MP clock parent rate when allowed
  clk: sunxi-ng: Use u64 for calculation of NM rate
  clk: sunxi-ng: h6: Set video PLLs limits
  dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
  clk: sunxi-ng: Add support for H6 DE3 clocks
  dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
  drm/sun4i: Add compatible for H6 display engine
  drm/sun4i: Rework DE2 register defines
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
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 201 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  71 ++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h          |   4 +-
 drivers/clk/sunxi-ng/ccu_mp.c                 |  64 +++++-
 drivers/clk/sunxi-ng/ccu_nm.c                 |  18 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  83 ++++++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  45 +++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  14 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 201 ++++++++++++++++--
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  57 ++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  80 +++++--
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  52 ++++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  47 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h        |  37 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c       |  47 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h       |  28 +--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  55 +++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h        |  25 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c       |  70 ++++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h       |  68 +++---
 include/dt-bindings/clock/sun8i-de2.h         |   3 +
 include/dt-bindings/reset/sun8i-de2.h         |   1 +
 29 files changed, 1120 insertions(+), 226 deletions(-)

--=20
2.19.1

