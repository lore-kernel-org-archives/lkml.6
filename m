Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A011420854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OrbmEFC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A011420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeGRLci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:32:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37942 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeGRLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:32:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so2025012pff.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8qyrEcnmpWDkswfN7k+NOB6p7yAz0IPNqALXbEKn5hI=;
        b=OrbmEFC9hxlC3PSUdHjONg7SGHymTVltzFfcgOaGanl6kePRVq/XkcW7GyYInM6R7q
         5NLMKLZSLlxw8VnmrBkcStPR3OzFwO+Jlwl+uCtPTmpnOOXZ5p0IEkbmfMcGnN0/4Ywa
         z9n9HAcsL1AXDtDk3qQWZ/ivTlr8jC8eonFGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8qyrEcnmpWDkswfN7k+NOB6p7yAz0IPNqALXbEKn5hI=;
        b=AJInfh90Dd295t7mX5u4CwZ4eSZluK9zvVDGg+UuLkzB9ak6vn4yq53ZdeLNwOB4hk
         yyzncJTHBj7a+PkQJE/IUcHlPM9KZZDY2a74sFqbn7xi+aqjxNBYAT+/wng+Ji4wygLf
         4y7YzEx5z/739NNZVdo0VQbXcpT8O0CfRUvaMDtvWK34rEyG0kqlUgcOsG+8RuHPvEJc
         nUoTA6SjTPys9OpEKwAKms8Ij9EZWEwwFdDloNv90uIxF8Vcey33w8gL3wxv+4mQcNOo
         5ffLAjRCUVzIfOQI5ZiuVUhyAma5LBW4j74QyioXardqvw8HBmcdenFr+5urqI9g3f2W
         D65Q==
X-Gm-Message-State: AOUpUlFHUr0uUG0SXLgne0ouGealaWMdElINyjhvbRjpxgw0w4h5vCDJ
        oi2q2ZxdbGl4oZZyvu1TKcsEGw==
X-Google-Smtp-Source: AAOMgpcn/7IaXzyTKyKznEl3Grf+Ac6ffhgZOQnHPrTdlZ/SiUL2TVemjtjnRkKQR3mEXGfR8bxpMQ==
X-Received: by 2002:a63:40c7:: with SMTP id n190-v6mr5322536pga.116.1531911317953;
        Wed, 18 Jul 2018 03:55:17 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:17 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: [PATCH v3 00/18] arm64: allwinner: Add A64 DE2 HDMI support
Date:   Wed, 18 Jul 2018 16:24:40 +0530
Message-Id: <20180718105458.22304-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.

A64 behaviour similar to Allwinner A83T where
Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
Mixer1 => TCON1 => HDMI
as per Display System Block Diagram from Allwinner_A64_User_Manual_V1.1.pdf

This is third patch-set followed with previous RFC[1], first and second
series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
rest will add eventually.

This series fixed previous version comments
- Rebasing on linux-next
- sqash all pipeline components in one patch
- Enable all pipeline components in board dts
- about documenting fallback compatibles
- adding new compatible for mixer1

Log:
[    1.450984] Jagan: sun8i_mixer_probe
[    1.464981] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
[    1.472572] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
[    1.480676] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regulator.10
[    1.488738] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
[    1.498879] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
[    1.507372] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
[    1.514778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.521398] [drm] No driver support for vblank timestamp query.
[    1.684611] random: fast init done
[    2.011575] Console: switching to colour frame buffer device 180x56
[    2.049858] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
[    2.057268] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0

Note:
Pine64 boards are unable to get edid by default like other A64 boards,
but forcing 'video=HDMI-A-1:1920x1080@60D' kernel command line can
create edid with display on penel

[3] https://lkml.org/lkml/2018/5/18/461
[2] https://lkml.org/lkml/2018/4/30/288
[1] https://lkml.org/lkml/2018/4/24/547

Icenowy Zheng (1):
  drm: sun4i: add support for HVCC regulator for DWC HDMI glue

Jagan Teki (17):
  clk: sunxi-ng: a64: Add minimal rate for video PLLs
  drm/sun4i: Add support for A64 mixer1
  dt-bindings: display: Add compatible for A64 DE2 tcon1 blocks
  drm/sun4i: Add support for A64 display engine
  dt-bindings: display: Add compatible for A64 HDMI
  dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
  arm64: dts: allwinner: a64: Add tcon1 HDMI pipeline
  clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
  arm64: defconfig: Enable CONFIG_DRM_SUN4I
  drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
  drm/sun4i: Enable DesignWare HDMI for SUN50I
  arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output
  arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
  arm64: dts: allwinner: a64: orangepi-win: Enable HDMI output
  arm64: dts: allwinner: a64: a64-olinuxino: Enable HDMI output
  arm64: dts: allwinner: a64: pine64: Enable HDMI output
  arm64: dts: allwinner: a64: sopine: Enable HDMI output

 .../bindings/display/sunxi/sun4i-drm.txt      |   4 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  34 ++++++
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  34 ++++++
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |  34 ++++++
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |  34 ++++++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  34 ++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  34 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 110 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/sunxi-ng/Kconfig                  |   2 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |  46 ++++----
 drivers/gpu/drm/sun4i/Kconfig                 |   3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  14 +++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |   2 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  12 ++
 include/dt-bindings/clock/sun50i-a64-ccu.h    |   2 +
 17 files changed, 378 insertions(+), 23 deletions(-)

-- 
2.17.1

