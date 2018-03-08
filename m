Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755927AbeCHPY1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:24:27 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32769 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCHPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:24:25 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm: Add LVDS decoder bridge
Date: Thu,  8 Mar 2018 16:24:00 +0100
Message-Id: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this small series add a driver for transparent LVDS decoders, as
Thine THC63LVD1024 device.

The R-Car Gen3 V3M Eagle board feature such a converter, that has been so far
not described as part of the display output pipeline. Now that a driver has
been added, the Eagle DTS file has been updated to include the transparent
decoder chip.

So far so good, but currently the current DRM Bridge API do not provide support
to query a mode from another bridge as it is possible to do on panel devices.
In our case the LVDS decoder is connected to the output of R-Car DU lvds encoder
(drivers/gpu/drm/rcar-du/rcar_lvds.c). As its 'mode_set' function shows, LVDS
modes cannot be propagated from bridge to another bridge, but are instead
inferred from the bus_format field of the panel's connector.

It is my intention to propose an API extension to allow formats to be propagated
through bridges, but knowing the DRM/KMS subsystem very superficially I would
appreciate any pointer from more experienced developers.

For Renesas side:
The series is based on Laurent's drm/next/du branch with patches on top for:
- Sergei: Enable PFC, I2c, GPIOs for r8a77970
- Sergei: Add support for r8a77970 in DU and add display device nodes in
  r8a77970 DTSI
- Niklas: Connect DU LVDS output to HDMI bridge adv7511w in Eagle DTS
- Sergei: fix video output on R8A77970

A base branch with these patches applied is available at
git://jmondi.org/linux v3m/v4.16-rc3/base

Tested on Eagle board, making sure DU probes and testing all available output
modes (of which only a few are actually working, I suspect due to faulty mode
propagation through DRM bridges).

Thanks
   j

Jacopo Mondi (3):
  dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
  drm: bridge: Add LVDS decoder driver
  arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  59 +++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 ++-
 drivers/gpu/drm/bridge/Kconfig                     |   8 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/lvds-decoder.c              | 239 +++++++++++++++++++++
 5 files changed, 336 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c

--
2.7.4
