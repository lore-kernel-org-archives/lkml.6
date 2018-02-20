Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeBTXKO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:10:14 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:38051 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBTXKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:10:11 -0500
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH v4 00/16] R-Car DU: Convert LVDS code to bridge driver
Date: Wed, 21 Feb 2018 01:10:30 +0200
Message-Id: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series addresses a design mistake that dates back from the initial
DU support. Support for the LVDS encoders, which are IP cores separate from
the DU, was bundled in the DU driver. Worse, both the DU and LVDS were
described through a single DT node.

To fix the, patches 01/16 and 02/16 define new DT bindings for the LVDS
encoders, and deprecate their description inside the DU bindings. To retain
backward compatibility with existing DT, patches 03/16 to 08/16 then patch the
device tree at runtime to convert the legacy bindings to the new ones.

With the DT side addressed, patch 09/16 converts the LVDS support code to a
separate bridge driver. Patches 11/16 to 16/16 then update all the device tree
sources to the new DU and LVDS encoders bindings.

I decided to go for live DT patching in patch 08/16 because implementing
support for both the legacy and new bindings in the driver would have been
very intrusive, and prevented further cleanups. This version relies more
heavily on overlays to avoid touching the internals of the OF core compared to
v2, even if manual fixes to the device tree are still needed.

Compared to v3, this series uses the OF changeset API to update properties
instead of accessing the internals of the property structure. This removes the
local implementation of functions to look up nodes by path and update
properties. In order to do this, I pulled in Pantelis' patch series titled
"[PATCH v2 0/5] of: dynamic: Changesets helpers & fixes" at Rob's request, and
rebased it while taking two small review comments into account.

Rob, I'd like this series to be merged in v4.17. As the changeset helpers are
now a dependency, I'd need you to merge them early (ideally on top of
v4.16-rc1) and provide a stable branch, or get your ack to merge them through
Dave's tree if they don't conflict with what you have and will queue for
v4.17.

This version also drops the small fix to the Porter board device tree that has
been queued for v4.17 already.

Compared to v2, the biggest change is in patch 03/16. Following Rob's and
Frank's reviews it was clear that modifying the unflattened DT structure of
the overlay before applying it wasn't popular. I have thus decided to use one
overlay source per SoC to move as much of the DT changes to the overlay as
possible, and only perform manual modifications (that are still needed as some
of the information is board-specific) on the system DT after applying the
overlay. As a result the overlay is parsed and applied without being modified.

Compared to v1, this series update the r8a7792 and r8a7794 device tree sources
and incorporate review feedback as described by the changelogs of individual
patches.


Laurent Pinchart (11):
  dt-bindings: display: renesas: Add R-Car LVDS encoder DT bindings
  dt-bindings: display: renesas: Deprecate LVDS support in the DU
    bindings
  drm: rcar-du: Fix legacy DT to create LVDS encoder nodes
  drm: rcar-du: Convert LVDS encoder code to bridge driver
  ARM: dts: r8a7790: Convert to new LVDS DT bindings
  ARM: dts: r8a7791: Convert to new LVDS DT bindings
  ARM: dts: r8a7792: Convert to new DU DT bindings
  ARM: dts: r8a7793: Convert to new LVDS DT bindings
  ARM: dts: r8a7794: Convert to new DU DT bindings
  arm64: dts: renesas: r8a7795: Convert to new LVDS DT bindings
  arm64: dts: renesas: r8a7796: Convert to new LVDS DT bindings

Pantelis Antoniou (5):
  of: dynamic: Add __of_node_dupv()
  of: changesets: Introduce changeset helper methods
  of: changeset: Add of_changeset_node_move method
  of: unittest: changeset helpers
  i2c: demux: Use changeset helpers for clarity

 .../bindings/display/bridge/renesas,lvds.txt       |  56 +++
 .../devicetree/bindings/display/renesas,du.txt     |  31 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/r8a7790-lager.dts                |  22 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  64 ++-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  10 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |  16 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  36 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |   1 -
 arch/arm/boot/dts/r8a7793-gose.dts                 |  10 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  37 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |   1 -
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   3 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |   3 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   3 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   3 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  36 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |   3 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  36 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |   6 +-
 drivers/gpu/drm/rcar-du/Makefile                   |  10 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  21 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   5 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          | 175 +------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |  12 -
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |  14 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |  93 ----
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |  24 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c          | 238 ----------
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h          |  64 ---
 drivers/gpu/drm/rcar-du/rcar_du_of.c               | 307 ++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_of.h               |  20 +
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts    |  81 ++++
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts    |  55 +++
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts    |  55 +++
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts    |  55 +++
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts    |  55 +++
 drivers/gpu/drm/rcar-du/rcar_lvds.c                | 524 +++++++++++++++++++++
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |  12 +-
 drivers/of/dynamic.c                               | 317 ++++++++++++-
 drivers/of/unittest.c                              |  54 +++
 include/linux/of.h                                 | 337 +++++++++++++
 43 files changed, 2199 insertions(+), 710 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
 delete mode 100644 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_lvds.c

-- 
Regards,

Laurent Pinchart
