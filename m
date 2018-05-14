Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeENIGt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:06:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42343 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeENIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:06:47 -0400
X-Google-Smtp-Source: AB8JxZpZ8E/FLh7V/SeTA6kph9njxYiB7FLhyZSK8X9Cz+v0Y96PzHK+H/YbQoW+Ab+WXFdLiVDzNg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/19 v3] Refactor fixed and GPIO regulators
Date: Mon, 14 May 2018 10:06:21 +0200
Message-Id: <20180514080640.12515-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pulls the fixed and GPIO regulators into the gpiolib
descriptor framework, at least more than what is currently
the case.

This is also available as a git branch:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
for-regulator-4.18

Charles Keepax (1):
  ARM: s3c64xx: Tidy up handling of regulator GPIO lookups

Linus Walleij (18):
  regulator: fixed: Convert to use GPIO descriptor only
  regulator: gpio: Get enable GPIO using GPIO descriptor
  regulator: arizona-ldo1: Look up a descriptor and pass to the core
  regulator: max8973: Pass descriptor instead of GPIO number
  regulator: max77686: Pass descriptor instead of GPIO number
  regulator: lm363x: Pass descriptor instead of GPIO number
  regulator: lp8788-ldo: Pass descriptor instead of GPIO number
  regulator: max8952: Pass descriptor instead of GPIO number
  regulator: pfuze100: Delete reference to ena_gpio
  regulator: s2mps11: Pass descriptor instead of GPIO number
  regulator: s5m8767: Pass descriptor instead of GPIO number
  regulator: tps65090: Pass descriptor instead of GPIO number
  regulator: wm8994: Pass descriptor instead of GPIO number
  regulator: core: Only support passing enable GPIO descriptors
  regulator: fixed/gpio: Pull inversion/OD into gpiolib
  regulator: fixed/gpio: Update device tree bindings
  regulator: gpio: Convert to fully use descriptors
  regulator: gpio: Simplify probe path

 .../bindings/regulator/fixed-regulator.txt    |  13 +-
 .../bindings/regulator/gpio-regulator.txt     |   4 +
 arch/arm/mach-imx/mach-mx21ads.c              |  14 +-
 arch/arm/mach-imx/mach-mx27ads.c              |  12 +-
 arch/arm/mach-mmp/brownstone.c                |  13 +-
 arch/arm/mach-omap1/board-ams-delta.c         |  15 +-
 arch/arm/mach-omap2/pdata-quirks.c            |  17 +-
 arch/arm/mach-pxa/em-x270.c                   |   2 -
 arch/arm/mach-pxa/ezx.c                       |  34 ++--
 arch/arm/mach-pxa/hx4700.c                    |  23 ++-
 arch/arm/mach-pxa/magician.c                  |  25 ++-
 arch/arm/mach-pxa/raumfeld.c                  |  13 +-
 arch/arm/mach-pxa/zeus.c                      |  24 ++-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |  55 ++++-
 arch/arm/mach-s3c64xx/mach-crag6410.c         |   1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |   1 -
 arch/arm/mach-sa1100/assabet.c                |  22 +-
 arch/arm/mach-sa1100/generic.c                |   5 +-
 arch/arm/mach-sa1100/generic.h                |   3 +-
 arch/arm/mach-sa1100/shannon.c                |   4 +-
 arch/sh/boards/mach-ecovec24/setup.c          |  24 ++-
 .../intel-mid/device_libs/platform_bcm43xx.c  |  18 +-
 drivers/mfd/wm8994-core.c                     |   9 -
 drivers/regulator/arizona-ldo1.c              |  19 +-
 drivers/regulator/core.c                      |  40 +---
 drivers/regulator/da9055-regulator.c          |   1 -
 drivers/regulator/fixed-helper.c              |   1 -
 drivers/regulator/fixed.c                     |  43 ++--
 drivers/regulator/gpio-regulator.c            | 192 +++++++-----------
 drivers/regulator/lm363x-regulator.c          |  20 +-
 drivers/regulator/lp8788-ldo.c                |  32 +--
 drivers/regulator/max77686-regulator.c        |  19 +-
 drivers/regulator/max8952.c                   |  18 +-
 drivers/regulator/max8973-regulator.c         |  54 ++---
 drivers/regulator/pfuze100-regulator.c        |   1 -
 drivers/regulator/s2mps11.c                   |  46 ++---
 drivers/regulator/s5m8767.c                   |  26 ++-
 drivers/regulator/tps65090-regulator.c        |  50 +++--
 drivers/regulator/wm8994-regulator.c          |  19 +-
 include/linux/mfd/lp8788.h                    |  16 --
 include/linux/mfd/samsung/core.h              |   4 +-
 include/linux/mfd/tps65090.h                  |   8 +-
 include/linux/mfd/wm8994/pdata.h              |   3 -
 include/linux/regulator/arizona-ldo1.h        |   3 -
 include/linux/regulator/driver.h              |  10 +-
 include/linux/regulator/fixed.h               |  13 --
 include/linux/regulator/gpio-regulator.h      |  18 +-
 include/linux/regulator/max8952.h             |   1 -
 48 files changed, 527 insertions(+), 481 deletions(-)

-- 
2.17.0
