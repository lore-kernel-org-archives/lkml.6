Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeB1Kgw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:36:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeB1Kgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:36:48 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Cc: maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v5 0/6] add support for AXP813 ADC and battery power supply
Date: Wed, 28 Feb 2018 11:35:55 +0100
Message-Id: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP813 PMIC is relatively close to the already supported AXP20X and
AXP22X. It provides three different power outputs: battery, AC and USB, and
measures a few different things: temperature, power supply status, current
current and voltage supplied, maximum current limit, battery capacity, min
and max voltage limits.

One of its two GPIOs can be used as an ADC.

There are a few differences with AXP20X/AXP22X PMICs though:
  - a different constant charge current formula,
  - battery temperature, GPIO0 and battery voltages are the only voltages
  measurable,
  - all data are stored on 12 bits (AXP20X/AXP22X had one type of data that
  was stored on 13 bits),
  - different scales and offsets,
  - a different ADC rate formula and register,

This patch series adds support for the PMIC's ADC and battery power supply
in the existing drivers.

Make the axp20x MFD automatically probe the ADC driver, add the battery
power supply node in axp81x node and enable it for the TBS A711 since it
has a soldered battery.

I suggest patches:
  - 1,2,6 go through Lee's tree,
  - 3,4,5 go through Sebastian's tree,

v5:
  - added static in front of the axp_data struct in the battery driver to
  make sparse happy,
  - removed merged patches,

v4:
  - shortened one commit title as a workaround to Chen-Yu note,
  - added const to data structures as proposed by Chen-Yu,
  - added last patch for making sparse happy, on a proposal from Jonathan,
  - removed already applied patches (IIO ones),

v3:
  - merging dt-bindings patches for axp_adc as requested by Rob,
  - re-ordered constant in IIO driver as requested by Julian,
  - compatibles for ADC are now named after the first design that
  introduced the IP instead of wildcard as requested by Maxime,
  - renamed DT node name from axp-adc to adc as requested by Rob,
  - replaced enumeration of supported PMICs in battery power supply DT
  bindings documentation by "supported devices" as requested by Jonathan,
  - added a new patch for removing "axp-" from axp81x's pinctrl DT node,

v2:
  - introduce data structure instead of ID for variant specific code in
  battery driver,
  - add DT binding for ADC driver,
  - make mfd probe the ADC driver via DT as well so that its IIO channels
  can be consumed by other drivers via DT mapping,

Thanks,
Quentin

Quentin Schulz (6):
  mfd: axp20x: make AXP209/22x cells probe their ADC via DT
  mfd: axp20x: probe axp20x_adc driver for AXP813
  power: supply: axp20x_battery: use data struct for variant specific code
  dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
  power: supply: axp20x_battery: add support for AXP813
  mfd: axp20x: add battery power supply cell for AXP813

 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt |   8 ++--
 drivers/mfd/axp20x.c                                              |  13 +++++--
 drivers/power/supply/axp20x_battery.c                             | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 119 insertions(+), 36 deletions(-)

base-commit: 827ad482fda17d0de5df5116fda827cd3671e62e
-- 
git-series 0.9.1
