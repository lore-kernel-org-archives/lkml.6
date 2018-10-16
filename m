Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E166C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D738208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D738208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJPWMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:12:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeJPWMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:12:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9280F20E02; Tue, 16 Oct 2018 16:22:10 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6620C20794;
        Tue, 16 Oct 2018 16:22:00 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 00/22] clk: at91: Rework DT bindings
Date:   Tue, 16 Oct 2018 16:21:38 +0200
Message-Id: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the promised rework of the at91 PMC clocks driver. It is mainly
necessary to remove the DTC warnings but it also complies with the CCF
rule that there should be one node per controller instead of one node
per clock.

This only handles the PMC, I'm planning to also rework the SCKC bindings
later (without breaking the DT ABI).

The series is based on top of v4.19-rc1.

The first two patches are actually fixes and may be considered for this
cycle.

I'll take the device tree changes through the at91 tree as DT backward
compatibility is working.

Changes in v2:
 - Add at91sam926x and at91sam9rl drivers
 - use CLK_OF_DECLARE_DRIVER
 - Add helpers to allocate for the proper number of clocks
 - Collected Rob's acks

Alexandre Belloni (22):
  clk: at91: audio-pll: fix audio pmc type
  clk: at91: generated: SSCs don't have a gclk
  clk: at91: h32mx: separate registration from DT parsing
  clk: at91: audio-pll: separate registration from DT parsing
  clk: at91: generated: set audio_pll_allowed in
    at91_clk_register_generated()
  clk: at91: allow clock registration from C code
  clk: at91: add pmc_data struct and helpers
  dt-bindings: clk: at91: Document new PMC binding
  clk: at91: add new DT lookup function
  clk: at91: add sama5d4 pmc driver
  clk: at91: add sama5d2 PMC driver
  clk: at91: add at91sam9260 PMC driver
  clk: at91: add at91sam9x5 PMCs driver
  clk: at91: add at91sam9rl PMC driver
  clk: at91: move DT compatibility code to its own file
  ARM: dts: at91: sama5d4: switch to new clock bindings
  ARM: dts: at91: sama5d2: switch to new binding
  ARM: dts: at91: at91sam9260: switch to new clock bindings
  ARM: dts: at91: at91sam9261: switch to new clock bindings
  ARM: dts: at91: at91sam9263: switch to new clock bindings
  ARM: dts: at91: at91sam9x5: switch to new clock bindings
  ARM: dts: at91: at91sam9rl: switch to new clock bindings

 .../devicetree/bindings/clock/at91-clock.txt  | 516 +---------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts          |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi            | 308 +-----
 arch/arm/boot/dts/at91sam9261.dtsi            | 287 +-----
 arch/arm/boot/dts/at91sam9263.dtsi            | 315 +-----
 arch/arm/boot/dts/at91sam9g15.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9g20.dtsi            |  23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts           |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9rl.dtsi             | 239 +----
 arch/arm/boot/dts/at91sam9x25.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi             | 326 +-----
 arch/arm/boot/dts/at91sam9x5_can.dtsi         |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi         |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi         |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi      |  11 +-
 arch/arm/boot/dts/sama5d2.dtsi                | 642 +-----------
 arch/arm/boot/dts/sama5d4.dtsi                | 535 +---------
 drivers/clk/at91/Makefile                     |   5 +-
 drivers/clk/at91/at91sam9260.c                | 494 +++++++++
 drivers/clk/at91/at91sam9rl.c                 | 171 ++++
 drivers/clk/at91/at91sam9x5.c                 | 309 ++++++
 drivers/clk/at91/clk-audio-pll.c              | 107 +-
 drivers/clk/at91/clk-generated.c              |  81 +-
 drivers/clk/at91/clk-h32mx.c                  |  22 +-
 drivers/clk/at91/clk-i2s-mux.c                |  40 +-
 drivers/clk/at91/clk-main.c                   | 112 +-
 drivers/clk/at91/clk-master.c                 |  99 +-
 drivers/clk/at91/clk-peripheral.c             |  81 +-
 drivers/clk/at91/clk-pll.c                    | 187 +---
 drivers/clk/at91/clk-plldiv.c                 |  27 +-
 drivers/clk/at91/clk-programmable.c           |  81 +-
 drivers/clk/at91/clk-slow.c                   |  32 +-
 drivers/clk/at91/clk-smd.c                    |  34 +-
 drivers/clk/at91/clk-system.c                 |  39 +-
 drivers/clk/at91/clk-usb.c                    |  94 +-
 drivers/clk/at91/clk-utmi.c                   |  45 +-
 drivers/clk/at91/dt-compat.c                  | 961 ++++++++++++++++++
 drivers/clk/at91/pmc.c                        |  78 ++
 drivers/clk/at91/pmc.h                        | 159 +++
 drivers/clk/at91/sama5d2.c                    | 336 ++++++
 drivers/clk/at91/sama5d4.c                    | 264 +++++
 include/dt-bindings/clock/at91.h              |  15 +
 50 files changed, 3185 insertions(+), 4004 deletions(-)
 create mode 100644 drivers/clk/at91/at91sam9260.c
 create mode 100644 drivers/clk/at91/at91sam9rl.c
 create mode 100644 drivers/clk/at91/at91sam9x5.c
 create mode 100644 drivers/clk/at91/dt-compat.c
 create mode 100644 drivers/clk/at91/sama5d2.c
 create mode 100644 drivers/clk/at91/sama5d4.c

-- 
2.19.1

