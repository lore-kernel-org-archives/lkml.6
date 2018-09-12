Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD04C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF1A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeILVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:16:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60128 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbeILVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:16:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E843207A8; Wed, 12 Sep 2018 18:11:24 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 793A52071D;
        Wed, 12 Sep 2018 18:11:24 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 0/7] clocksource: rework Atmel TCB timer driver
Date:   Wed, 12 Sep 2018 18:11:15 +0200
Message-Id: <20180912161122.7717-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series reworks the Atmel TCB drivers. It introduces a new driver to handle
the clocksource and clockevent devices.

As a reminder, this is necessary because:
 - the current tcb_clksrc driver is probed too late to be able to be used at
   boot and we now have SoCs that don't have a PIT. They currently are not able
   to boot a mainline kernel.
 - using the PIT doesn't work well with preempt-rt because its interrupt is
   shared (in particular with the UART and their interrupt flags are
   incompatible)
 - the current solution is wasting some TCB channels

The plan is to get this driver upstream, then convert the TCB PWM driver to be
able to get rid of the tcb_clksrc driver along with atmel_tclib now that AVR32
is gone.

changes in v6:
 - rebased on v4.19-rc1
 - separated the clocksource/clockevent and the single clockevent in two
   different patches
 - removed struct tc_clkevt_device and simply use struct atmel_tcb_clksrc
 - removed struct atmel_tcb_info
 - moved tcb_clk_get and tcb_irq_get to users

changes in v5:
 - rebased on v4.18-rc1
 - fixed the clock enabling/disabling in atomic context under preempt-rt

Changes in v4:
 - rebased on top of v4.17-rc1
 - fixed an issue when setting max_delta for clockevents_config_and_register


Alexandre Belloni (7):
  ARM: at91: add TCB registers definitions
  clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
  clocksource/drivers: timer-atmel-tcb: add clockevent device on
    separate channel
  clocksource/drivers: atmel-pit: make option silent
  ARM: at91: Implement clocksource selection
  ARM: configs: at91: use new TCB timer driver
  ARM: configs: at91: unselect PIT

 arch/arm/configs/at91_dt_defconfig    |   2 +-
 arch/arm/configs/sama5_defconfig      |   2 +-
 arch/arm/mach-at91/Kconfig            |  25 ++
 drivers/clocksource/Kconfig           |  13 +-
 drivers/clocksource/Makefile          |   3 +-
 drivers/clocksource/timer-atmel-tcb.c | 616 ++++++++++++++++++++++++++
 include/soc/at91/atmel_tcb.h          | 183 ++++++++
 7 files changed, 840 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clocksource/timer-atmel-tcb.c
 create mode 100644 include/soc/at91/atmel_tcb.h

-- 
2.19.0.rc2

