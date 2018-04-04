Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDDLTd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:19:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42665 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDDLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:19:31 -0400
X-Google-Smtp-Source: AIpwx4+7cZAIK3vzzb0XDbooFLV9AIl2N92qEMiwEIzPM/yk3u4QtIvHTz1j3CEtGB0MR09QUGeAR/wOQTPAgYEh+Lk=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Apr 2018 13:19:29 +0200
Message-ID: <CACRpkdaKWTAz=VLz9W8wWwQEvOLLw4jPWcAKrjJ+KW5FK5ZvMw@mail.gmail.com>
Subject: [GIT PULL] Bulk GPIO changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34BLEnL010317

Hi Linus,

here is the major slew of GPIO changes for v4.17.

Some things to notice:

- I merged in v4.16-rc5 to get rid of a really nasty merge
  conflict that was making it hard to rebuild linux-next, and
  this happened due to a big fix in the Renesas R-Car driver
  collding with ongoing development.

- There is a series of ISA_BUS_API changes that ended up
  getting queued in my tree. Most of them have proper ACKs
  and they have been tested throughly in linux-next.
  These patches finally split ISA_BUS and ISA_BUS_API
  apart as I understand it, as there are devices using
  port-mapped I/O but not strictly speaking using any ISA
  bus. So the ISA_BUS and the ISA_BUS_API are two
  things. The most notable effect of ISA_BUS_API is that
  it compiles drivers/base/isa.c so that we get device driver
  core infrastructure for these devices. The ISA bus was merged
  in 2006 (a5117ba7da37) and was used for sound cards and
  watchdog, but only recently William started
  to use it for his industrial data acquisition cards and he's found
  a bit of problems that are now (hopefully) finally fixed up.
  Any questions: William Breathitt Gray is on the CC for this
  pull request to answer them.

Any other details are in the signed tag.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.17-1

for you to fetch changes up to 348f3cde84ab5b1f53cd3c0eaac1ca99a4dcb148:

  gpio: Add Spreadtrum PMIC EIC driver support (2018-03-27 15:51:22 +0200)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v4.17 kernel cycle:

New drivers:

- Nintendo Wii GameCube GPIO, known as "Hollywood"

- Raspberry Pi mailbox service GPIO expander

- Spreadtrum main SC9860 SoC and IEC GPIO controllers.

Improvements:

- Implemented .get_multiple() callback for most of the
  high-performance industrial GPIO cards for the ISA bus.

- ISA GPIO drivers now select the ISA_BUS_API instead of
  depending on it. This is merged with the same pattern
  for all the ISA drivers and some other Kconfig cleanups
  related to this.

Cleanup:

- Delete the TZ1090 GPIO drivers following the deletion of
  this SoC from the ARM tree.

- Move the documentation over to driver-api to conform with
  the rest of the kernel documentation build.

- Continue to make the GPIO drivers include only
  <linux/gpio/driver.h> and not the too broad <linux/gpio.h>
  that we want to get rid of.

- Managed to remove VLA allocation from two drivers pending
  more fixes in this area for the next merge window.

- Misc janitorial fixes.

----------------------------------------------------------------
Anders Roxell (1):
      tools/gpio/gpio-event-mon: fix warning

Arnd Bergmann (1):
      gpio: raspberrypi-ext: fix firmware dependency

Axel Lin (1):
      gpio: tegra: Convert to use DEFINE_SHOW_ATTRIBUTE macro

Baolin Wang (5):
      dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
      gpio: Add GPIO driver for Spreadtrum SC9860 platform
      dt-bindings: gpio: Add Spreadtrum EIC controller documentation
      gpio: Add Spreadtrum EIC driver support
      gpio: Add Spreadtrum PMIC EIC driver support

Bartosz Golaszewski (1):
      gpio: mockup: fix a potential crash when creating debugfs entries

Baruch Siach (3):
      soc: bcm2835: sync firmware properties with downstream
      dt-bindings: gpio: add raspberry pi GPIO expander binding
      gpio: raspberrypi-exp: explain Kconfig dependency

Dave Stevenson (1):
      gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service

David Lechner (1):
      gpio: davinci: add support for pinmux gpio ranges

H. Nikolaus Schaller (1):
      gpio: pca953x: add compatibility for pcal6524 and pcal9555a

Hien Dang (1):
      gpio: gpio-rcar: Support S2RAM

James Hogan (1):
      gpio: Drop TZ1090 drivers

Jonathan Neuschäfer (10):
      dt-bindings: gpio: Add binding for Wii GPIO controller
      gpio: Add GPIO driver for Nintendo Wii
      MAINTAINERS: GPIO: Add Documentation/driver-api/gpio/
      Documentation: driver-api: Move gpio.rst to gpio/index.rst
      Documentation: gpio: Move introduction to driver-api
      Documentation: gpio: Move driver documentation to driver-api
      Documentation: gpio: Move legacy documentation to driver-api
      Documentation: gpio: Move gpiod_* consumer documentation to driver-api
      Documentation: gpio: Move GPIO mapping documentation to driver-api
      Documentation: gpio: Move drivers-on-gpio.txt to driver-api

Laura Abbott (2):
      gpio: Remove VLA from MAX3191X driver
      gpio: Remove VLA from xra1403 driver

Linus Walleij (20):
      gpio: ftgpio010: Fix some more registers
      gpio: include consumer header in gpiolib.h
      gpio: dwapb: Use "stride" rather than "size" for register distance
      gpio: dwapb: Call directly into the gpiochip to read value
      gpio: mockup: Update Bamvors mail address
      Merge tag 'v4.16-rc5' into devel
      gpio: dln2: Include proper header
      gpio: ge: Drop of_gpio.h include
      gpio: em: Use the right include
      gpio: ftgpio010: Drop of_gpio.h include
      gpio: grgpio: Include the right header
      gpio: htc-gpio: Include the right header
      gpio: ich: Include the right header
      gpio: ich: Use BIT() macro
      gpio: it87: Include the right header
      gpio: janz-ttl: Include the right header
      gpio: janz-ttl: Use BIT() macro
      gpio: kempld: Include the right header
      gpio: ks8695: Include the right header
      Merge branch 'gpio-reserved-ranges' into devel

Maciej S. Szmigiero (1):
      Revert "gpio: winbond: fix ISA_BUS_API dependency"

Markus Elfring (8):
      gpio-wm831x: Use seq_putc() in wm831x_gpio_dbg_show()
      gpio: timberdale: Delete an error message
      gpio: timberdale: Improve a size determination
      gpio: omap: Delete an error message
      gpio: omap: Improve a size determination
      gpio-ml-ioh: Delete an error message
      gpio: merrifield: Delete an error message
      gpio-intel-mid: Delete an error message

Phil Edworthy (1):
      gpio: dwapb: Add support for a bus clock

Rajmohan Mani (1):
      gpio: tps68470: Update to SPDX license identifier

Stephen Boyd (5):
      dt-bindings: gpio: Add a gpio-reserved-ranges property
      gpiolib: Extract mask allocation into subroutine
      gpiolib: Change bitmap allocation to kmalloc_array
      gpiolib: Support 'gpio-reserved-ranges' property
      pinctrl: qcom: Don't allow protected pins to be requested

Wang Dongsheng (1):
      gpiolib: friendly debug information for consumer

Wei Yongjun (1):
      gpio: ath79: Fix potential NULL dereference in ath79_gpio_probe()

William Breathitt Gray (12):
      iio: Change ISA_BUS_API dependency to selection
      watchdog: Change ISA_BUS_API dependency to selection
      gpio: Change ISA_BUS_API dependency to selection
      isa: Remove ISA_BUS_API selection for ISA_BUS
      pc104: Add EXPERT dependency for PC104 Kconfig option
      gpio: 104-idio-16: Implement get_multiple callback
      gpio: pci-idio-16: Implement get_multiple callback
      gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks
      gpio: 104-dio-48e: Implement get_multiple callback
      gpio: 104-idi-48: Implement get_multiple callback
      gpio: gpio-mm: Implement get_multiple callback
      gpio: ws16c48: Implement get_multiple callback

 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |  97 ++++
 .../devicetree/bindings/gpio/gpio-pca953x.txt      |   2 +
 .../devicetree/bindings/gpio/gpio-sprd.txt         |  28 +
 .../devicetree/bindings/gpio/gpio-tz1090-pdc.txt   |  45 --
 .../devicetree/bindings/gpio/gpio-tz1090.txt       |  88 ---
 Documentation/devicetree/bindings/gpio/gpio.txt    |   7 +-
 .../bindings/gpio/nintendo,hollywood-gpio.txt      |  27 +
 .../bindings/gpio/raspberrypi,firmware-gpio.txt    |  30 +
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |   9 +-
 .../{gpio/board.txt => driver-api/gpio/board.rst}  |  39 +-
 .../consumer.txt => driver-api/gpio/consumer.rst}  |  85 +--
 .../driver.txt => driver-api/gpio/driver.rst}      |  80 +--
 .../gpio/drivers-on-gpio.rst}                      |   1 +
 .../driver-api/{gpio.rst => gpio/index.rst}        |  21 +-
 .../{gpio/gpio.txt => driver-api/gpio/intro.rst}   |   9 +-
 .../gpio-legacy.txt => driver-api/gpio/legacy.rst} |  68 ++-
 Documentation/driver-api/index.rst                 |   2 +-
 Documentation/gpio/00-INDEX                        |  13 -
 Documentation/gpio/sysfs.txt                       |   5 +-
 MAINTAINERS                                        |   3 +-
 arch/x86/Kconfig                                   |  10 +-
 drivers/gpio/Kconfig                               |  75 ++-
 drivers/gpio/Makefile                              |   7 +-
 drivers/gpio/gpio-104-dio-48e.c                    |  47 ++
 drivers/gpio/gpio-104-idi-48.c                     |  47 ++
 drivers/gpio/gpio-104-idio-16.c                    |  15 +
 drivers/gpio/gpio-ath79.c                          |   2 +
 drivers/gpio/gpio-davinci.c                        |   6 +
 drivers/gpio/gpio-dln2.c                           |   7 +-
 drivers/gpio/gpio-dwapb.c                          |  81 ++-
 drivers/gpio/gpio-eic-sprd.c                       | 606 +++++++++++++++++++++
 drivers/gpio/gpio-em.c                             |   2 +-
 drivers/gpio/gpio-ftgpio010.c                      |   7 +-
 drivers/gpio/gpio-ge.c                             |   1 -
 drivers/gpio/gpio-gpio-mm.c                        |  47 ++
 drivers/gpio/gpio-grgpio.c                         |   3 +-
 drivers/gpio/gpio-hlwd.c                           | 115 ++++
 drivers/gpio/gpio-htc-egpio.c                      |   1 +
 drivers/gpio/gpio-ich.c                            |  21 +-
 drivers/gpio/gpio-intel-mid.c                      |   4 +-
 drivers/gpio/gpio-it87.c                           |   2 +-
 drivers/gpio/gpio-janz-ttl.c                       |  15 +-
 drivers/gpio/gpio-kempld.c                         |   2 +-
 drivers/gpio/gpio-ks8695.c                         |   2 +-
 drivers/gpio/gpio-max3191x.c                       |   7 +-
 drivers/gpio/gpio-merrifield.c                     |   4 +-
 drivers/gpio/gpio-ml-ioh.c                         |   1 -
 drivers/gpio/gpio-mockup.c                         |   6 +-
 drivers/gpio/gpio-omap.c                           |   6 +-
 drivers/gpio/gpio-pca953x.c                        |   4 +
 drivers/gpio/gpio-pci-idio-16.c                    |  50 ++
 drivers/gpio/gpio-pcie-idio-24.c                   | 117 ++++
 drivers/gpio/gpio-pmic-eic-sprd.c                  | 330 +++++++++++
 drivers/gpio/gpio-raspberrypi-exp.c                | 252 +++++++++
 drivers/gpio/gpio-rcar.c                           |  60 +-
 drivers/gpio/gpio-sprd.c                           | 290 ++++++++++
 drivers/gpio/gpio-tegra.c                          |  16 +-
 drivers/gpio/gpio-timberdale.c                     |   7 +-
 drivers/gpio/gpio-tps68470.c                       |  10 +-
 drivers/gpio/gpio-tz1090-pdc.c                     | 231 --------
 drivers/gpio/gpio-tz1090.c                         | 602 --------------------
 drivers/gpio/gpio-wm831x.c                         |   2 +-
 drivers/gpio/gpio-ws16c48.c                        |  47 ++
 drivers/gpio/gpio-xra1403.c                        |   8 +-
 drivers/gpio/gpiolib-of.c                          |  24 +
 drivers/gpio/gpiolib.c                             |  68 ++-
 drivers/gpio/gpiolib.h                             |   2 +-
 drivers/iio/adc/Kconfig                            |   3 +-
 drivers/iio/counter/Kconfig                        |   3 +-
 drivers/iio/dac/Kconfig                            |   3 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  65 ++-
 drivers/watchdog/Kconfig                           |   3 +-
 include/linux/gpio/driver.h                        |  16 +
 include/linux/platform_data/gpio-htc-egpio.h       |   2 -
 include/soc/bcm2835/raspberrypi-firmware.h         |  18 +
 init/Kconfig                                       |   2 +-
 tools/gpio/gpio-event-mon.c                        |   2 +-
 77 files changed, 2771 insertions(+), 1274 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-tz1090.txt
 create mode 100644
Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
 create mode 100644
Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
 rename Documentation/{gpio/board.txt => driver-api/gpio/board.rst} (88%)
 rename Documentation/{gpio/consumer.txt => driver-api/gpio/consumer.rst} (89%)
 rename Documentation/{gpio/driver.txt => driver-api/gpio/driver.rst} (93%)
 rename Documentation/{gpio/drivers-on-gpio.txt =>
driver-api/gpio/drivers-on-gpio.rst} (99%)
 rename Documentation/driver-api/{gpio.rst => gpio/index.rst} (74%)
 rename Documentation/{gpio/gpio.txt => driver-api/gpio/intro.rst} (96%)
 rename Documentation/{gpio/gpio-legacy.txt => driver-api/gpio/legacy.rst} (96%)
 create mode 100644 drivers/gpio/gpio-eic-sprd.c
 create mode 100644 drivers/gpio/gpio-hlwd.c
 create mode 100644 drivers/gpio/gpio-pmic-eic-sprd.c
 create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c
 create mode 100644 drivers/gpio/gpio-sprd.c
 delete mode 100644 drivers/gpio/gpio-tz1090-pdc.c
 delete mode 100644 drivers/gpio/gpio-tz1090.c
