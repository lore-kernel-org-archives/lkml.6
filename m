Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBWRQU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:16:20 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:59925 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBWRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:16:19 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Date: Fri, 23 Feb 2018 18:15:52 +0100
Message-Id: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series gets back on the TCB drivers rework. It introduces a new driver to
handle the clocksource and clockevent devices.

As a reminder, this is necessary because:
 - the current tcb_clksrc driver is probed too late to be able to be used at
   boot and we now have SoCs that don't have a PIT. They currently are not able
   to boot a mainline kernel.
 - using the PIT doesn't work well with preempt-rt because its interrupt is
   shared (in particular with the UART and their interrupt flags are
   incompatible)
 - the current solution is wasting some TCB channels

The plan is to get this driver upstream, then convert the TCB PWM driver to be
able to get rid of the tcb_clksrc driver along with atmel_tclib.

changes in v3:
 - use SPDX tag in include/soc/at91/atmel_tcb.h
 - rework option selection to make the clocksource option silent

Main changes in v2:
 - use direct IO instead of regmap when accessing channel specific registers to
   avoid the regmap locking
 - implement suspend/resume


Alexandre Belloni (6):
  ARM: at91: add TCB registers definitions
  clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
  clocksource/drivers: atmel-pit: make option silent
  ARM: at91: Implement clocksource selection
  ARM: configs: at91: use new TCB timer driver
  ARM: configs: at91: unselect PIT

 arch/arm/configs/at91_dt_defconfig    |   2 +-
 arch/arm/configs/sama5_defconfig      |   2 +-
 arch/arm/mach-at91/Kconfig            |  25 ++
 drivers/clocksource/Kconfig           |  13 +-
 drivers/clocksource/Makefile          |   3 +-
 drivers/clocksource/timer-atmel-tcb.c | 608 ++++++++++++++++++++++++++++++++++
 include/soc/at91/atmel_tcb.h          | 216 ++++++++++++
 7 files changed, 865 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clocksource/timer-atmel-tcb.c
 create mode 100644 include/soc/at91/atmel_tcb.h

-- 
2.16.1
