Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495572098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495572098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJRPd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:33:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49488 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbeJRPd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:33:29 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 93DFE15D251;
        Thu, 18 Oct 2018 07:33:44 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
Date:   Thu, 18 Oct 2018 15:33:18 +0800
Message-Id: <20181018073327.64942-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
TERES-I.

It reuses some definitions from the ANX78xx driver that already exists
in the kernel tree, but the driver code itself is rewritten, because the
big difference between ANX6345 and ANX78xx.

This patchset also enables the bridge on Pinebook and TERES-I, and a
temporary workaround patch (do not merge) for the dot clock accuracy
problem of sun4i-drm.

This patchset assumes some fixes ([1], [2] and [3]) are already
applied, without them the patchset cannot be tested on the A64 devices
mentioned above.

[1] https://patchwork.kernel.org/patch/10628827/
[2] https://patchwork.kernel.org/patch/10628825/
[3] https://patchwork.kernel.org/patch/10646791/

Chen-Yu Tsai (1):
  [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to dot clock frequency
    check

Icenowy Zheng (8):
  drm/bridge: move ANA78xx driver to analogix subdirectory
  drm/bridge: split some definitions of ANX78xx to dedicated headers
  drm/bridge: extract some Analogix I2C DP common code
  dt-bindings: Add ANX6345 DP/eDP transmitter binding
  drm/bridge: Add Analogix anx6345 support
  arm64: allwinner: a64: add pinmux for RGB666 LCD
  arm64: allwinner: a64: enable ANX6345 bridge on Pinebook
  arm64: allwinner: a64: enable ANX6345 bridge on TERES-I

 .../bindings/display/bridge/anx6345.txt       |  39 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  43 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  40 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
 drivers/gpu/drm/bridge/Kconfig                |  10 -
 drivers/gpu/drm/bridge/Makefile               |   4 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.h     | 719 ---------------
 drivers/gpu/drm/bridge/analogix/Kconfig       |  25 +
 drivers/gpu/drm/bridge/analogix/Makefile      |   4 +
 .../drm/bridge/analogix/analogix-anx6345.c    | 862 ++++++++++++++++++
 .../bridge/{ => analogix}/analogix-anx78xx.c  | 146 +--
 .../drm/bridge/analogix/analogix-anx78xx.h    | 265 ++++++
 .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++
 .../drm/bridge/analogix/analogix-i2c-dptx.h   | 258 ++++++
 .../bridge/analogix/analogix-i2c-txcommon.h   | 240 +++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c             |   5 +-
 16 files changed, 1956 insertions(+), 882 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
 delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
 rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h

-- 
2.18.1

