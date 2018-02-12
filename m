Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935193AbeBLNR1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:17:27 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34734 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933170AbeBLNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:17:25 -0500
X-Google-Smtp-Source: AH8x226rFuitvqpkps8e45rUq/bwfqw64LfPiuO44oOgse07y+aTlLrgI8zCzupHJjQfUKjloNqzYg==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/21] regulator: switch core to GPIO descriptors
Date: Mon, 12 Feb 2018 14:16:56 +0100
Message-Id: <20180212131717.27193-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the regulator core mostly use GPIO descriptors
there are some rough edges we need to chisel down:

- The fixed regulator still passes a "ena_gpio" number
  from the global GPIO numberspace. This we want to get
  rid of. We do this by allowing drivers to pass in a
  descriptor instead, converting all drivers and platform
  data over and then only allowing that.

- The fixed regulator also has special platform data or
  device tree properties for handling polarity inversion
  or open drain. We have pulled these special semantics
  into gpiolib in
  commit a603a2b8d86ee93ee2107da8ca75fd854fd4ff32
  "gpio: of: Add special quirk to parse regulator flags"
  so we can now move all drivers over to using only
  descriptors for this as well.

- The GPIO regulator has a similar complicated relationship
  to the global GPIO numberspace. We have merged helpers
  and convert these users too.

Some drivers needed to get a GPIO from an opaque DT node
i.e. a DT node without a corresponding device. For this
case we have added devm_gpiod_get_from_of_node() in the
v4.16-rc1 kernel so we can proceed with the conversion.

I have tried to loop in maintainers of the board files
affected as much as I can. It is uncertain if they even
care in some cases, with some PalmPilot-PDA-type ARM
devices I'm really starting to wonder if they are really
maintained and tested anymore, but I've still done my
best to not accidentally break them.

The patches can also be grabbed from this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-regulator

I.e.
git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git gpio-descriptors-regulator

to test it with any pet system.

Some ACKs and Tested-by's would be nice! I really don't
want to break anything if I can avoid it.

All patches have been boiled through the zeroday build
system so at least everything builds, but runtime testing
is paramount.

Linus Walleij (21):
  regulator: core: Support passing an initialized GPIO enable descriptor
  regulator: fixed: Convert to use GPIO descriptor only
  regulator: gpio: Get enable GPIO using GPIO descriptor
  regulator: da9055: Pass descriptor instead of GPIO number
  regulator: arizona-ldo1: Look up a descriptor and pass to the core
  regulator: da9211: Pass descriptors instead of GPIO numbers
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

 .../bindings/regulator/fixed-regulator.txt         |  13 +-
 .../bindings/regulator/gpio-regulator.txt          |   4 +
 arch/arm/mach-imx/mach-mx21ads.c                   |  14 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |  12 +-
 arch/arm/mach-mmp/brownstone.c                     |  13 +-
 arch/arm/mach-omap1/board-ams-delta.c              |  15 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  17 +-
 arch/arm/mach-pxa/em-x270.c                        |   2 -
 arch/arm/mach-pxa/ezx.c                            |  34 ++--
 arch/arm/mach-pxa/hx4700.c                         |  23 ++-
 arch/arm/mach-pxa/magician.c                       |  25 ++-
 arch/arm/mach-pxa/raumfeld.c                       |  13 +-
 arch/arm/mach-pxa/zeus.c                           |  24 ++-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |  18 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   1 -
 arch/blackfin/mach-bf537/boards/stamp.c            |  15 +-
 arch/sh/boards/mach-ecovec24/setup.c               |  29 +++-
 .../intel-mid/device_libs/platform_bcm43xx.c       |  20 ++-
 drivers/mfd/wm8994-core.c                          |   9 -
 drivers/regulator/arizona-ldo1.c                   |  19 +-
 drivers/regulator/core.c                           |  33 +---
 drivers/regulator/da9055-regulator.c               |   5 +-
 drivers/regulator/da9211-regulator.c               |  23 ++-
 drivers/regulator/fixed-helper.c                   |   1 -
 drivers/regulator/fixed.c                          |  43 ++---
 drivers/regulator/gpio-regulator.c                 | 193 ++++++++-------------
 drivers/regulator/lm363x-regulator.c               |  20 +--
 drivers/regulator/lp8788-ldo.c                     |  32 ++--
 drivers/regulator/max77686-regulator.c             |  19 +-
 drivers/regulator/max8952.c                        |  18 +-
 drivers/regulator/max8973-regulator.c              |  54 +++---
 drivers/regulator/pfuze100-regulator.c             |   1 -
 drivers/regulator/s2mps11.c                        |  46 ++---
 drivers/regulator/s5m8767.c                        |  26 +--
 drivers/regulator/tps65090-regulator.c             |  50 +++---
 drivers/regulator/wm8994-regulator.c               |  19 +-
 include/linux/mfd/da9055/pdata.h                   |   5 +-
 include/linux/mfd/lp8788.h                         |  16 --
 include/linux/mfd/samsung/core.h                   |   4 +-
 include/linux/mfd/tps65090.h                       |   8 +-
 include/linux/mfd/wm8994/pdata.h                   |   3 -
 include/linux/regulator/arizona-ldo1.h             |   3 -
 include/linux/regulator/da9211.h                   |   4 +-
 include/linux/regulator/driver.h                   |  11 +-
 include/linux/regulator/fixed.h                    |  13 --
 include/linux/regulator/gpio-regulator.h           |  18 +-
 include/linux/regulator/max8952.h                  |   1 -
 48 files changed, 519 insertions(+), 471 deletions(-)

-- 
2.14.3
