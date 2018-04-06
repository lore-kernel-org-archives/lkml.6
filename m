Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDFMm2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:42:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37789 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDFMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:42:26 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Fri,  6 Apr 2018 14:41:55 +0200
Message-Id: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    this new version moves the driver and its bindings to use semi-standard
names for powerdown and output enable GPIOs, as result of the discussion with
Laurent, Vladimir and Rob. I kept the actual pin names in the bindings
description for reference, even if there are no huge ambiguities on which
chip pin is actually an enable and which one a power down.

I have reworked the regulator management, making the 'vcc' supply the only
requested one, and all other optional supplies have been removed as suggested
by Laurent. It is unlikely a dedicated regulator is to be installed for each
power supply, and in case some HW design requires this, it's an easy add to be
implemented in future.

Contrary to what discussed on v6, the 'vcc' supply is still described
as optional in dt bindings, and the driver is now using
'regulator_get(NORMAL_GET)' in place of the _optional() version that was used
before. With the 'NORMAL_GET' version the regulator core provides a dummy
regulator in case an actual one is not available. This simplifies integration
in designs where the chip power supplies are directly connected to some power
rail. At the same time it makes easier to forget to add a regulator if there's
actually one there, and someone could find herself wondering why the chip does
not work even if probe completes properly.

I removed the Eagle display enablement patch from the series, I'll send it
separately squashed on top of Niklas' series that addresses the issue.

Thanks
   j

v6 -> v7:
- Use semi-standard names for powerdown and output enable GPIOs as suggested
  by Rob and Vladimir
- Use 'regulator_get()' not the optional version, and list only 'vcc' as
  requested supply
- Addressed Laurent's review comments and removed Eagle display enablement patch
  to be sent separately

v5 -> v6:
- Drop check for CONFIG_OF as it is a Kconfig dependency
- Add Niklas Reviewed-by tags
- List [3/3] depenencies below commit message to ease integration

v4 -> v5:
- Fix punctuation in bindings documentation
- Add small statement to bindings document to clarify the chip has no
  control bus
- Print regulator name in enable/disable routines error path
- Add Andrzej Reviewed-by tag

v3 -> v4:
- Rename permutations of "pdwn" to just "pdwn" everywhere in the series
- Improve power enable/disable routines as suggested by Andrzej and Sergei
- Change "pdwn" gpio initialization to use the logical output level
- Change Kconfig description

v2 -> v3:
- Drop support for "lvds-decoder" and make the driver THC63LVD1024 specific
-- Rework bindings to describe multiple input/output ports
-- Rename driver and remove "lvds-decoder" references
-- Rework Eagle DTS to use new bindings

v1 -> v2:
- Drop support for THC63LVD1024

Jacopo Mondi (2):
  dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
  drm: bridge: Add thc63lvd1024 LVDS decoder driver

 .../bindings/display/bridge/thine,thc63lvd1024.txt |  60 ++++++
 drivers/gpu/drm/bridge/Kconfig                     |   6 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              | 212 +++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

--
2.7.4
