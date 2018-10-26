Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369AE20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jP95xZZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369AE20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJZXVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:21:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42090 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeJZXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:21:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so635061pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZqm0CFEdgNM2tKHjKivQNx4i6KhyKtyrSoJgQ5hCEE=;
        b=jP95xZZarKPxRpcTk4yOQdHhh67H3biXbiHdakPyEF9FUDJlTSCMnO0xUYhEyW1TkN
         OV2Iag5L9QtyFR2U3nFaC+SzME8X1lihgttwy1Q8Uq27FIr6KQHi+0Pt8xRJHSbF9Fda
         GdyDSWFclhbRhzqTwa56E/bRXuJ6B+2do8XZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZqm0CFEdgNM2tKHjKivQNx4i6KhyKtyrSoJgQ5hCEE=;
        b=deRgguYlOwy60ctuonPS9l/1ht6+z2q0ixhx+0IJSGAU1v3lSmlAn/DGQG137ZeKMk
         Rq5FwCFPj1tmrNNrxff03vqvWTFrlhM2+Y6/2qSPERF9D+iaDh6Z3NID9KXr2IbTntEr
         1XwO+NiAbRa6O15+xZfFUbZZEvNk68JNDsTlIqvGWMcOiqM8+V3f+B3t+YmmB/ivd7aL
         +w6eqaJVL74+bfpokIvOjRUaRi6SjIUyATjhHJP3hzG7GzVe9Stc8puGmewvw5dv4iFK
         WI2j28Z7DZn7EQYq95GK/X+HGVthsA8N4dz4vLX0FANsgXQqhDJOCSoITfCDeONcWEaa
         G3FA==
X-Gm-Message-State: AGRZ1gIZCdi3xdWhQuPg/5QzC9RVzKsLPXefmuET5cj9PvSmuxnwYMcH
        Mdj3Pq6CqAK0ElbqAKyLCkOVJQ==
X-Google-Smtp-Source: AJdET5e09G5gEekKHPpWwXEsKeq6RP2nzY9YZ94thvyr9Xp6iJ8drFkIPbwp/kbr+AukXMI/VITHJw==
X-Received: by 2002:a63:224f:: with SMTP id t15mr3730017pgm.69.1540565052740;
        Fri, 26 Oct 2018 07:44:12 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:12 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 00/25] drm/sun4i: Allwinner A64 MIPI-DSI support 
Date:   Fri, 26 Oct 2018 20:13:19 +0530
Message-Id: <20181026144344.27778-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed the issues related to work DSI on 2-lane panel
which is reported on previous version[1].

Few comments from previous version still in discussion, but I just
send this version just to group all working changes together.
anyway I will fix in this in next version if any.

PLL_MIPI min rate is still weird, I tried many possible dclock rate
from panel driver to satisfy manual suggested min rate 500MHz but
none working so eventually moved 300MHz. any inputs on this area
are welcome.

All these changes are tested in 2-lane, 4-lane MIPI-DSI panels.

If anyone wants to test, use this repo [2] with WIP-A64-DSI branch.

Any inputs,
Jagan.

[2] https://github.com/amarula/linux-amarula
[1] https://patchwork.kernel.org/cover/10653275/

Jagan Teki (25):
  clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: Add check for maximum rate to NKM PLLs
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
  drm/sun4i: sun6i_mipi_dsi: Increase hfp packet overhead
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB
    bridge
  drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  dt-bindings: panel: Add Techstar TS8550B MIPI DSI panel
  drm/panel: Add Techstar TS8550B MIPI-DSI LCD panel
  clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
  arm64: dts: allwinner: a64: Add DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  arm64: dts: allwinner: a64-amarula-relic: Enable Techstar TS8550B
    MIPI-DSI panel

 .../display/panel/bananapi,s070wv20-ct16.txt  |  31 +-
 .../display/panel/techstar,ts8550b.txt        |  20 +
 .../bindings/display/sunxi/sun6i-dsi.txt      |   3 +-
 .../allwinner/sun50i-a64-amarula-relic.dts    |  46 +++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  42 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                |  14 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  18 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 336 +++++++++++++++++
 .../gpu/drm/panel/panel-techstar-ts8550b.c    | 346 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 122 ++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   8 +
 15 files changed, 1009 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
 create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c

-- 
2.18.0.321.gffc6fa0e3

