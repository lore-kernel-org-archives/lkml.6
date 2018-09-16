Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A02ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51282086B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51282086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeIPJ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 05:56:27 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56508 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeIPJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 05:56:27 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id D310A663B5;
        Sun, 16 Sep 2018 04:34:48 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 0/4] Fix A64/R40 HDMI PHY device tree binding
Date:   Sun, 16 Sep 2018 12:34:05 +0800
Message-Id: <20180916043409.62374-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding support for A64 HDMI PHY in 4.19, we assumed that the two
PLL-VIDEOs can both feed the HDMI PHY clock. However experiments show
that the mux bit discovered in R40 blob is not applicable on A64. This
is not discovered, as normally with a single display pipeline only
PLL-VIDEO0 will be used.

In this patchset the second PLL is dropped, and a binding specially for
R40 HDMI PHY is added (which seems to have the mux).

PATCH 1 is dropping second PLL for A64 HDMI PHY, and PATCH 2 to 4
are adding R40 HDMI PHY binding, as R40 behaves differently with A64
with this.

This patchset targets v4.19 fixes tree, because the binding is
introduced in v4.19, and if we don't fix it there a wrong binding will
be left in a stable version released. A64 display pipeline support is
not yet in v4.19, but R40 support is in it.

Icenowy Zheng (4):
  drm: sun4i: drop second PLL from A64 HDMI PHY
  dt-bindings: sun4i-drm: add compatible for R40 HDMI PHY
  drm/sun4i: add support for R40 HDMI PHY
  ARM: sun8i: dts: drop A64 HDMI PHY fallback compatible from R40 DT

 .../devicetree/bindings/display/sunxi/sun4i-drm.txt |  5 +++--
 arch/arm/boot/dts/sun8i-r40.dtsi                    |  3 +--
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c              | 13 ++++++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.18.0

