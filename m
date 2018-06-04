Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeFDNR4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:17:56 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43433 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeFDNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:17:54 -0400
X-Google-Smtp-Source: ADUXVKIqpN/kHmTxbj+8IKx1DRFCsH233WUXj+WDYVs/QfzmmqPwM9JgqzKXWYdU0vhlKP0/5SEVZw==
Date: Mon, 4 Jun 2018 16:17:44 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v5 0/4] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC driver
Message-ID: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
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

Changelog v5
- dropped regulator patches which are already applied to Mark's tree
Based on feedback from Rob Herring and Stephen Boyd
- mfd bindings:	explain why this can be interrupt-controller
- mfd bindings:	describe interrupts better
- mfd bindings:	require one cell interrupt specifier
- mfd bindings:	use generic node names in example
- mfd driver:	ack masked interrupt once at init
- clk bindings:	use generic node names in example
- clk driver:	use devm
- clk driver:	use of_clk_add_hw_provider
- clk driver:	change severity of print and how prints are emitted at
		probe error path.
- clk driver:	dropped forward declared functions
- clk configs:	drop unnecessary dependencies
- clk driver:	other styling issues
- mfd/clk DT:	drop clk node.

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
Patches 2 and 3

This patch series is based on for-mfd-next

---

Matti Vaittinen (4):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Add driver for BD71837 PMIC clock

 .../bindings/clock/rohm,bd71837-clock.txt          |  38 +++
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  76 ++++++
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-bd71837.c                          | 146 +++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 223 ++++++++++++++++
 include/linux/mfd/bd71837.h                        | 288 +++++++++++++++++++++
 9 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/clk/clk-bd71837.c
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3
