Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BFB20449
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfBTHma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:42:30 -0500
Received: from mx.socionext.com ([202.248.49.38]:4065 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfBTHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:42:29 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Feb 2019 16:42:27 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A1629180097;
        Wed, 20 Feb 2019 16:42:27 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 20 Feb 2019 16:42:27 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 3C70A40368;
        Wed, 20 Feb 2019 16:42:27 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1843F120459;
        Wed, 20 Feb 2019 16:42:27 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v3 0/9] Add basic support for Socionext Milbeaut M10V SoC
Date:   Wed, 20 Feb 2019 16:42:58 +0900
Message-Id: <1550648578-9928-1-git-send-email-sugaya.taichi@socionext.com>
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

Changes since v2:
* Drop clk, pinctrl, and serial driver.
* Drop unneeded options from defconfig.
* Convert milbeaut soc binding to yaml.
* Fix serial driver binding.
* Change serial id of aliases in DT.
* Add platform checking when entering suspend/resume.
* Drop pr_err()s.

Changes since v1:
* Change file names.
* Change #define names.
* Refine cpu-enable-method and bindigs.
* Add documentation for Milbeaut SoCs.
* Add more infomation for timer driver.
* Add sched_clock to timer driver.
* Refine whole of clk driver.
* Add earlycon instead of earlyprintk.
* Refine Device Tree.

Sugaya Taichi (9):
  dt-bindings: sram: milbeaut: Add binding for Milbeaut smp-sram
  dt-bindings: arm: Add SMP enable-method for Milbeaut
  dt-bindings: Add documentation for Milbeaut SoCs
  ARM: milbeaut: Add basic support for Milbeaut m10v SoC
  dt-bindings: timer: Add Milbeaut M10V timer description
  clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs
  dt-bindings: serial: Add Milbeaut serial driver description
  ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
  ARM: configs: Add Milbeaut M10V defconfig

 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../bindings/arm/socionext/milbeaut.yaml           |  22 +++
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  21 +++
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt |  24 +++
 .../bindings/timer/socionext,milbeaut-timer.txt    |  17 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts            |  32 ++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi               |  95 +++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig           | 175 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/mach-milbeaut/Kconfig                     |  20 +++
 arch/arm/mach-milbeaut/Makefile                    |   1 +
 arch/arm/mach-milbeaut/platsmp.c                   | 143 +++++++++++++++++
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-milbeaut.c               | 161 +++++++++++++++++++
 18 files changed, 728 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 drivers/clocksource/timer-milbeaut.c

-- 
1.9.1

