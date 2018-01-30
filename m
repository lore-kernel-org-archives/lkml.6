Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeA3Oyc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:54:32 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:39418 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeA3Oy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:54:29 -0500
X-Google-Smtp-Source: AH8x224OqHPDGXG5yUU8pPfLp1aQprZAVYxhCFT0KvCGAjr93tOY56CIRhC3Fn/TZ1zGxw2BwdY8ug/1ppwhSywxEzc=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Jan 2018 15:54:27 +0100
Message-ID: <CACRpkdaY3BnL+JwoGEZB+J+KwOOxrWArETaxShxdO3keyYY48g@mail.gmail.com>
Subject: [GIT PULL] GPIO bulk changed for the v4.16 kernel cycle
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UEsb8f015523

Hi Linus,

here is the GPIO big pull request for the v4.16 cycle. It is pretty
calm this time around I think. I even got time to get to things like
starting to clean up header includes.

The details are in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.16-1

for you to fetch changes up to d58f2bf261fdf3a3fc916c9999a686f959dcf6b6:

  gpio: Timestamp events in hardirq handler (2018-01-23 14:43:57 +0100)

----------------------------------------------------------------
The is the bulk of GPIO changes for the v4.16 kernel cycle.

Core changes:

- Disallow open drain and open source flags to be set
  simultaneously. This doesn't make electrical sense, and would
  the hardware actually respond to this setting, the result
  would be short circuit.

- ACPI GPIO has a new core infrastructure for handling quirks.
  The quirks are there to deal with broken ACPI tables centrally
  instead of pushing the work to individual drivers. In the world
  of BIOS writers, the ACPI tables are perfect. Until they find a
  mistake in it. When such a mistake is found, we can patch it
  with a quirk. It should never happen, the problem is that it
  happens. So we accomodate for it.

- Several documentation updates.

- Revert the patch setting up initial direction state from
  reading the device. This was causing bad things for drivers
  that can't read status on all its pins. It is only affecting
  debugfs information quality.

- Label descriptors with the device name if no explicit label is
  passed in.

- Pave the ground for transitioning SPI and regulators to use
  GPIO descriptors by implementing some quirks in the device tree
  GPIO parsing code.

New drivers:

- New driver for the Access PCIe IDIO 24 family.

Other:

- Major refactorings and improvements to the GPIO mockup driver
  used for test and verification.

- Moved the AXP209 driver over to pin control since it gained a
  pin control back-end. These patches will appear (with the same
  hashes) in the pin control pull request as well.

- Convert the onewire GPIO driver w1-gpio to use descriptors.
  This is merged here since the W1 maintainers send very few
  pull requests and he ACKed it.

- Start to clean up driver headers using <linux/gpio.h> to just
  use <linux/gpio/driver.h> as appropriate.

----------------------------------------------------------------
Adam Borowski (1):
      gpio: it87: fix mojibake in module metadata

Andrew Jeffery (2):
      gpio: gpiolib: Generalise state persistence beyond sleep
      gpio: aspeed: Add support for reset tolerance

Andy Shevchenko (7):
      gpio: max732x: Remove duplicate NULL check
      gpiolib: acpi: Assign polarity when call acpi_populate_gpio_lookup()
      gpiolib: acpi: Don't contaminate return parameter in case of error
      gpiolib: acpi: Move adev member to struct acpi_gpio_info
      gpiolib: acpi: Consolidate debug output in acpi_gpio_update_gpiod_flags()
      gpiolib: acpi: Add quirks field to struct acpi_gpio_mapping
      gpiolib: acpi: Introduce NO_RESTRICTION quirk

Arnd Bergmann (1):
      gpio: winbond: fix ISA_BUS_API dependency

Arvind Yadav (1):
      gpio: ftgpio010: Fix platform_get_irq's error checking

Bartosz Golaszewski (23):
      gpiolib: don't allow OPEN_DRAIN & OPEN_SOURCE flags simultaneously
      gpio: mockup: add missing prefixes
      gpio: mockup: parse the module params in init, not probe
      gpio: mockup: verify the number of GPIO chips requested
      gpio: mockup: rework device probing
      gpio: mockup: implement gpio_mockup_err()
      gpio: mockup: remove a stray tab
      gpio: mockup: merge gpio_mockup_add() into gpio_mockup_probe()
      gpio: mockup: pass the named_lines parameter over platform_data
      gpio: mockup: extend the debugfs layout
      gpio: mockup: change the type of value field in line state struct
      gpio: mockup: group code by logic
      gpio: mockup: fix debugfs handling
      gpio: mockup: verify that ngpio > 0
      gpio: mockup: tweak line breaks
      gpio: mockup: implement gpio_mockup_set_multiple()
      gpio: mockup: modify the return value check for devm_irq_sim_init()
      gpio: mockup: rename gpio_mockup_params_nr to gpio_mockup_num_ranges
      gpio: mockup: add helpers for accessing the gpio ranges
      MAINTAINERS: add myself as reviewer for gpio-mockup
      gpio: mockup: fix a return value check
      gpiolib: constify label in gpio_device
      gpiolib: use kstrdup_const() for gpio_device label

Christophe Leroy (4):
      gpio: sysfs: change 'value' attribute to prealloc
      gpio: sysfs: correct error handling on 'value' attribute read.
      gpio: sysfs: don't use sprintf() for 'value' attribute
      gpio: sysfs: avoid using kstrtol() in 'value' attribute write

Colin Ian King (2):
      gpio: gpio-stmpe: make various char arrays static const, shrinks
object size
      gpiolib: remove redundant initialization of pointer desc

Geert Uytterhoeven (1):
      dt-bindings: gpio: rcar: Correct SoC family name for R8A7778

Grygorii Strashko (1):
      gpio: omap: initialize gpioirq chip as part of gpiochip_add_data

Jesse Chan (2):
      gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE

Joel Stanley (1):
      tools/gpio: Fix build error with musl libc

Jonathan Neuschäfer (2):
      tools/gpio: Don't use u_int32_t
      gpiolib: Fix typo in comment ("piochip_add_data")

Linus Walleij (31):
      Merge branch 'ib-gpio-acpi-quirks' into devel
      gpio: Clarify that <linux/gpio.h> is legacy
      Merge branch 'ib-move-axp209' into devel
      w1: w1-gpio: Convert to use GPIO descriptors
      Revert "pinctrl: qcom: disable GPIO groups with no pins"
      gpio: omap: Give unique labels to each GPIO bank/chip
      gpio: label descriptors using the device name
      gpio: of: Support SPI nonstandard GPIO properties
      gpio: of: Support regulator nonstandard GPIO properties
      gpio: Break out code to get a descriptor from a DT node
      gpio: Export devm_gpiod_get_from_of_node() for consumers
      gpio: of: Add special quirk to parse regulator flags
      gpio: 74x174: Include proper headers
      gpio: adp5520: Include proper header
      gpio: adp5588: Include proper header
      gpio: altera: Include GPIO driver header
      gpio: amd8111: Include proper header
      gpio: arizona: Include proper header
      gpio: bcm-kona: Include proper header
      gpio: bt8xx: Include proper header
      gpio: crystalcove: Include proper header
      gpio: cs5535: Include proper header
      gpio: da905x: Include proper header
      gpio: davinci: Include proper header
      gpio: No NULL owner
      gpio: of: Fix NPE from OF flags
      gpio: Documentation update
      Merge branch 'gpio-drivers-only-driver-h' into devel
      gpio: Fix a documentation spelling mistake
      gpio: Fix kernel stack leak to userspace
      gpio: Timestamp events in hardirq handler

Maciej S. Szmigiero (1):
      gpio: winbond: Add driver

Markus Elfring (4):
      gpio: stmpe: Use seq_putc() in stmpe_dbg_show()
      gpio: stmpe: Improve a size determination in stmpe_gpio_probe()
      gpio: stmpe: Move an assignment in stmpe_gpio_probe()
      gpio: stmpe: Delete an unnecessary variable initialisation in
stmpe_gpio_probe()

Patrice Chotard (1):
      gpio: stmpe: i2c transfer are forbiden in atomic context

Pravin Shedge (1):
      drivers: gpio: remove duplicate includes

Quentin Schulz (8):
      gpio: axp209: switch unsigned variables to unsigned int
      pinctrl: move gpio-axp209 to pinctrl
      pinctrl: axp209: add pinctrl features
      dt-bindings: gpio: gpio-axp209: add pinctrl features
      pinctrl: axp209: rename everything from gpio to pctl
      pinctrl: axp209: add programmable gpio_status_offset
      pinctrl: axp209: add programmable ADC muxing value
      pinctrl: axp209: add support for AXP813 GPIOs

Rasmus Villemoes (1):
      gpio: reduce descriptor validation code size

Stephen Boyd (1):
      gpiolib: Export gpiochip_irqchip_irq_valid() to drivers

Timur Tabi (2):
      Revert "gpio: set up initial state from .get_direction()"
      pinctrl: qcom: disable GPIO groups with no pins

Vasyl Gomonovych (1):
      gpio: fix aspeed_gpio_banks array size check

Vladimir Zapolskiy (3):
      gpiolib: don't dereference a desc before validation
      gpiolib: remove a redundant check in gpiod_to_chip()
      gpiolib: add desc validation to gpiod_set_transitory()

Wei Yongjun (1):
      gpio: thunderx: fix error return code in thunderx_gpio_probe()

William Breathitt Gray (1):
      gpio: Add GPIO support for the ACCES PCIe-IDIO-24 family

Wolfram Sang (2):
      gpio: correct docs about return value of gpiod_get_direction
      Documentation: gpio: correct return value of gpiod_get_direction

 .../devicetree/bindings/gpio/gpio-axp209.txt       |  49 +-
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   2 +-
 Documentation/gpio/board.txt                       |  14 +-
 Documentation/gpio/consumer.txt                    | 107 +--
 Documentation/gpio/driver.txt                      |   4 +
 Documentation/gpio/sysfs.txt                       |  11 +
 Documentation/w1/masters/w1-gpio                   |  17 +-
 MAINTAINERS                                        |   7 +
 arch/arm/mach-ixp4xx/vulcan-setup.c                |  13 +-
 arch/arm/mach-pxa/raumfeld.c                       |  16 +-
 drivers/gpio/Kconfig                               |  32 +-
 drivers/gpio/Makefile                              |   3 +-
 drivers/gpio/devres.c                              |  42 ++
 drivers/gpio/gpio-74x164.c                         |   5 +-
 drivers/gpio/gpio-adp5520.c                        |   3 +-
 drivers/gpio/gpio-adp5588.c                        |   2 +-
 drivers/gpio/gpio-altera.c                         |   3 +-
 drivers/gpio/gpio-amd8111.c                        |   2 +-
 drivers/gpio/gpio-arizona.c                        |   2 +-
 drivers/gpio/gpio-aspeed.c                         |  41 +-
 drivers/gpio/gpio-ath79.c                          |   3 +
 drivers/gpio/gpio-axp209.c                         | 188 ------
 drivers/gpio/gpio-bcm-kona.c                       |   8 +-
 drivers/gpio/gpio-brcmstb.c                        |   1 -
 drivers/gpio/gpio-bt8xx.c                          |   2 +-
 drivers/gpio/gpio-crystalcove.c                    |   2 +-
 drivers/gpio/gpio-cs5535.c                         |   2 +-
 drivers/gpio/gpio-da9052.c                         |   2 +-
 drivers/gpio/gpio-da9055.c                         |   2 +-
 drivers/gpio/gpio-davinci.c                        |   2 +-
 drivers/gpio/gpio-ftgpio010.c                      |   4 +-
 drivers/gpio/gpio-iop.c                            |   4 +
 drivers/gpio/gpio-it87.c                           |   2 +-
 drivers/gpio/gpio-max732x.c                        |   6 +-
 drivers/gpio/gpio-mockup.c                         | 288 ++++----
 drivers/gpio/gpio-omap.c                           |  39 +-
 drivers/gpio/gpio-pcie-idio-24.c                   | 447 +++++++++++++
 drivers/gpio/gpio-stmpe.c                          |  54 +-
 drivers/gpio/gpio-thunderx.c                       |   4 +-
 drivers/gpio/gpio-winbond.c                        | 732 +++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c                        |  57 +-
 drivers/gpio/gpiolib-of.c                          | 119 +++-
 drivers/gpio/gpiolib-sysfs.c                       |  33 +-
 drivers/gpio/gpiolib.c                             | 330 +++++++---
 drivers/gpio/gpiolib.h                             |  18 +-
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-axp209.c                   | 476 ++++++++++++++
 drivers/w1/masters/w1-gpio.c                       | 149 ++---
 include/dt-bindings/gpio/gpio.h                    |   6 +-
 include/linux/acpi.h                               |   5 +
 include/linux/device.h                             |   3 +
 include/linux/gpio.h                               |  10 +
 include/linux/gpio/consumer.h                      |  25 +
 include/linux/gpio/driver.h                        |   3 +
 include/linux/gpio/machine.h                       |   4 +-
 include/linux/of_gpio.h                            |   2 +-
 include/linux/pinctrl/pinconf-generic.h            |   2 +
 include/linux/w1-gpio.h                            |   9 +-
 tools/gpio/gpio-event-mon.c                        |  10 +-
 60 files changed, 2743 insertions(+), 696 deletions(-)
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/gpio/gpio-pcie-idio-24.c
 create mode 100644 drivers/gpio/gpio-winbond.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c
