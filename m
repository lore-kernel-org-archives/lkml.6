Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeECSkD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:40:03 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35809 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeECSj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:39:58 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/7] Allwinner H6 R_{PIO,INTC,I2C} support
Date: Fri,  4 May 2018 02:38:40 +0800
Message-Id: <20180503183847.11046-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Allwinner H6's R_{PIO,INTC,I2C}
peripherals. They are in the "CPUS" power domain, powered by VDD-CPUS
rather than VDD-SYS.

R_PIO controls the PL/PM GPIO banks, R_INTC controls NMI, and R_I2C
controls the I2C at PL0/1.

A PCF8563 RTC is attached on R_I2C on Pine H64, which is added to the
device tree. An AXP805 (a variation of AXP806 with different default
value customization) is attached on the bus too, however as its driver
currently lacks self-work mode support, it will be activated in another
patchset.

In order to support R_{PIO,I2C}, a PRCM CCU driver is introduced. As the
PRCM clock part is totally different with older SoCs (from A31 to H5),
the driver for H6 is a new one, not reusing the old code.

Icenowy Zheng (7):
  clk: sunxi-ng: add support for H6 PRCM CCU
  arm64: allwinner: h6: add PRCM CCU device node
  pinctrl: sunxi: add support for H6 R_PIO pin controller
  arm64: allwinner: h6: add node for R_PIO pin controller
  arm64: allwinner: h6: add R_INTC interrupt controller
  arm64: allwinner: h6: add R_I2C controller
  arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   3 +-
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  52 ++++++
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             | 207 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h             |  19 ++
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        | 128 +++++++++++++
 include/dt-bindings/clock/sun50i-h6-r-ccu.h        |  24 +++
 include/dt-bindings/reset/sun50i-h6-r-ccu.h        |  17 ++
 13 files changed, 471 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
 create mode 100644 include/dt-bindings/clock/sun50i-h6-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h6-r-ccu.h

-- 
2.15.1
