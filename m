Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968710AbeE3Il2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:41:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45603 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964976AbeE3IlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:41:25 -0400
X-Google-Smtp-Source: ADUXVKJDHYMfJFLC6Gy3oW0f56gtvOuqapsGgb1YKeKTQ0x/vjWShV2FCqC+NV2vJO434Et3eOg80A==
Date: Wed, 30 May 2018 11:41:13 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v4 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC driver
Message-ID: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDO’s to provide all the power rails required by the
SoC and the commonly used peripherals.

The driver aims to not limit the usage of PMIC. Thus the buck and LDO
naming is generic and not tied to any specific purposes. However there
is following limitations which make it mostly suitable for use cases
where the processor where PMIC driver is running is powered by the PMIC:

- The PMIC is not re-initialized if it resets. PMIC may reset as a
  result of voltage monitoring (over/under voltage) or due to reset
  request. Driver is only initializing PMIC at probe. This is not
  problem as long as processor controlling PMIC is powered by PMIC.

- The PMIC internal state machine is ignored by driver. Driver assumes
  the PMIC is wired so that it is always in "run" state when controlled
  by the driver.

Changelog v4
- remove mutex from regulator state check as core prevents simultaneous
  accesses
- allow voltage change for bucks 1 to 4 when regulator is enabled
- fix indentiation problems
- properly correct SPDX comments

Changelog v3
- kill unused variable
- kill unused definitions
- use REGMAP_IRQ_REG

Changelog v2
Based on feedback from Mark Brown
- Squashed code and buildfile changes to same patch
- Fixed some styling issues
- Changed SPDX comments to CPP style
- Error out if voltage is changed when regulator is enabled instead of
  Disabling the regulator for duration of change
- Use devm_regulator_register
- Remove compatible usage from regulators - use parent dev for config
- Add a note about using regulator-boot-on for BUCK6 and 7
- fixed warnings from kbuild test robot

patch 1: 
        MFD driver and definitions bringing interrupt support and
        enabling clk and regulator subsystems.
Patches 2, 3 and 4:
        device tree binding documents.
Patch 5:
        clock subsystem and support for gated clock.
Patch 6:
        regulator driver supporting 8 bucks and 7 LDOs.

This patch series is based on for-mfd-next

---

Matti Vaittinen (6):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  regulator: bd71837: Devicetree bindings for BD71837 regulators
  clk: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Add driver for BD71837 PMIC clock
  regulator: bd71837: BD71837 PMIC regulator driver

 .../bindings/clock/rohm,bd71837-clock.txt          |  37 ++
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  52 ++
 .../bindings/regulator/rohm,bd71837-regulator.txt  | 126 ++++
 drivers/clk/Kconfig                                |   9 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-bd71837.c                          | 151 +++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 222 +++++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd71837-regulator.c              | 640 +++++++++++++++++++++
 include/linux/mfd/bd71837.h                        | 288 ++++++++++
 13 files changed, 1552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
 create mode 100644 drivers/clk/clk-bd71837.c
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3
