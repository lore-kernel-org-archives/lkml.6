Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8502C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DCF2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DCF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKSLWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:02 -0500
Received: from mx.socionext.com ([202.248.49.38]:40639 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbeKSLWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:02 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:00:06 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 9885B180111;
        Mon, 19 Nov 2018 10:00:06 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:00:06 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1B8B3403AB;
        Mon, 19 Nov 2018 10:00:06 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E13E5120455;
        Mon, 19 Nov 2018 10:00:05 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 00/14] Add basic support for Socionext Milbeaut M10V SoCs
Date:   Mon, 19 Nov 2018 10:01:05 +0900
Message-Id: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the series of patches the initial support for SC2000(M10V) of
Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
source code.

SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
computer vision. It also features advanced functionalities such as 360-degree,
real-time spherical stitching with multi cameras, image stabilization for
without mechanical gimbals, and rolling shutter correction. More detail is
below:
https://www.socionext.com/en/products/assp/milbeaut/SC2000.html

Specifications for developers are below:
 - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
 - NEON support
 - DSP
 - GPU
 - MAX 3GB DDR3
 - Cortex-M0 for power control
 - NAND Flash Interface
 - SD UHS-I
 - SD UHS-II
 - SDIO
 - USB2.0 HOST / Device
 - USB3.0 HOST / Device
 - PCI express Gen2
 - Ethernet Engine
 - I2C
 - UART
 - SPI
 - PWM

Support is quite minimal for now, since it only includes timer, clock,
pictrl and serial controller drivers, so we can only boot to userspace
through initramfs. Support for the other peripherals  will come eventually.


Sugaya Taichi (14):
  ARM: milbeaut: Add basic support for Milbeaut m10v SoC
  dt-bindings: soc: milbeaut: Add Milbeaut trampoline description
  ARM: milbeaut: Add Milbeaut M10V early printk
  dt-bindings: timer: Add Milbeaut M10V timer description
  clocksource/drivers/timer-milbeaut: Add Milbeaut M10V timer
  dt-bindings: clock: milbeaut: add Milbeaut clock description
  clock: milbeaut: Add Milbeaut M10V clock control
  dt-bindings: serial: Add Milbeaut M10V serial description
  serial: Add Milbeaut M10V serial control
  dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V pinctrl description
  pinctrl: milbeaut: Add Milbeaut M10V pinctrl
  ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
  ARM: configs: Add Milbeaut M10V defconfig
  MAINTAINERS: Add entry to MAINTAINERS for Milbeaut

 .../devicetree/bindings/clock/milbeaut-clock.txt   |  93 +++
 .../pinctrl/socionext,milbeaut-pinctrl.txt         |  33 +
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  23 +
 .../bindings/soc/socionext/socionext,m10v.txt      |  12 +
 .../bindings/timer/socionext,milbeaut-timer.txt    |  17 +
 MAINTAINERS                                        |   9 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts            |  35 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dtsi           |  17 +
 arch/arm/boot/dts/milbeaut-m10v.dtsi               | 510 ++++++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig           | 364 ++++++++++
 arch/arm/include/debug/milbeaut.S                  |  25 +
 arch/arm/mach-milbeaut/Kconfig                     |  28 +
 arch/arm/mach-milbeaut/Makefile                    |   3 +
 arch/arm/mach-milbeaut/m10v_evb.c                  |  31 +
 arch/arm/mach-milbeaut/platsmp.c                   | 157 +++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-m10v.c                             | 671 ++++++++++++++++++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-m10v.c                   | 146 ++++
 drivers/pinctrl/Kconfig                            |   9 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-m10v.c                     | 765 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |  24 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/m10v_usio.c                     | 605 ++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 31 files changed, 3606 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dtsi
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/include/debug/milbeaut.S
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/m10v_evb.c
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 drivers/clk/clk-m10v.c
 create mode 100644 drivers/clocksource/timer-m10v.c
 create mode 100644 drivers/pinctrl/pinctrl-m10v.c
 create mode 100644 drivers/tty/serial/m10v_usio.c

-- 
1.9.1

