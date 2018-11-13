Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B145C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B3A223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QQXN1x0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B3A223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeKMVO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:14:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40378 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeKMVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:14:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so400550pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJB0n3gQwy6xHbCkGXRBikQwutdPB9G3sVatWmPhcwE=;
        b=QQXN1x0pHxd0DKDX86dDy+3J2kBLwJdiihOqfqb52iuFl/iAjSqVNuK1/f86qdltat
         zP4LXnKL2RF/xIB/u1Pewx1tAVMNJ2wCjBpvjP+YbSEWPg6Dt0T0Ky8s3GX8e1H0JCZ4
         QqUK99sF4LID8nq9iwz9I3JA5VVSnj+hb/ZD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJB0n3gQwy6xHbCkGXRBikQwutdPB9G3sVatWmPhcwE=;
        b=hmPN0INC0jsr0Cj1RuUkVoKFWVi3VNH0gfE6tYXO5saEOzS/40sT4qL8DGndSefCL+
         raSzcuSTZne7xxYDhaSbyC4i7fe+LkHb+NoukDoOOBOViG7uYD9HGSzff01qGjycZ0eg
         b6wxgQTJK5G8T513gChn0835cDYNQR0kw03njqd2MxuWkrbYuVM5GZsQrbUdVc7AT88l
         g3ILXpu1LHkny95YzhTVTQ4W6E4o1dhlsfTWOct3HEPaIj4hXyfThha80SVkGHGOqrQf
         z31THcbSBCNJcSiBtL7ehMlGbwtnE9AXsXZ51SHpONpesU8naiggUW5zRQQPqgiz0wbK
         Nwpw==
X-Gm-Message-State: AGRZ1gJJYC889pOs3Pgze+ap1kbFBjn6IWKfqVy6xf/RS/4EQnkxMvDi
        fDh0E1D+LZoSKLNleqQGIJG0nw==
X-Google-Smtp-Source: AJdET5fU+wulaC0lWBLUxvpvq0Do/hWbaa70sc3XBpxP0z+4W49I93CADkHUiM0c2YCH2wRRdTDMqg==
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr4655542plp.126.1542107810372;
        Tue, 13 Nov 2018 03:16:50 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:16:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 00/26] drm/sun4i: Allwinner A64 MIPI-DSI support 
Date:   Tue, 13 Nov 2018 16:46:07 +0530
Message-Id: <20181113111633.20189-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed the issues related to work DSI on 2-lane panel
which is reported on previous version[1].

This supposed to be a clean series, where it support Allwinner A64 MIPI-DSI
support for 4-lane, 2-lane DSI panels.

This series fixed all previous series comments along with checkpatch
warnings/error.

Changes for v4:
- droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
  nkm min, max rate patches
- create two patches for "Add Allwinner A64 MIPI DSI support"
  one for has_mod_clk quirk and other one for A64 support
- use existing driver code construct for hblk computation
- dropped "Increase hfp packet overhead" patch [2], though BSP added
  this but we have no issues as of now.
  (no issues on panel side w/o this change)
- create separate function for vblk computation 
- enable vcc-dsi regulator in dsi_runtime_resume
- collect Rob, Acked-by
- update MAINTAINERS file for panel drivers
- cleanup commit messages
- fixed checkpatch warnings/errors

[2] https://patchwork.kernel.org/patch/10657541/
[1] https://patchwork.kernel.org/patch/10657619/

Jagan Teki (26):
  clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: Add check for maximum rate to NKM PLLs
  drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  dt-bindings: panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB
    bridge
  drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  dt-bindings: panel: Add Techstar TS8550B MIPI-DSI panel
  drm/panel: Add Techstar TS8550B MIPI-DSI LCD panel
  clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
  arm64: dts: allwinner: a64: Add DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  arm64: dts: allwinner: a64-amarula-relic: Enable Techstar TS8550B
    MIPI-DSI panel

 .../display/panel/bananapi,s070wv20-ct16.txt  |  31 +-
 .../display/panel/techstar,ts8550b.txt        |  22 ++
 .../bindings/display/sunxi/sun6i-dsi.txt      |   5 +
 MAINTAINERS                                   |  12 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |  46 +++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  42 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                |   6 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  18 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 298 ++++++++++++++++
 .../gpu/drm/panel/panel-techstar-ts8550b.c    | 324 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 125 +++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   8 +
 16 files changed, 961 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
 create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c

-- 
2.18.0.321.gffc6fa0e3

