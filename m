Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E27206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E27206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGQXEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:04:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59044 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbeGQXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 97EFE2093F; Wed, 18 Jul 2018 00:28:16 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 697B9206A6;
        Wed, 18 Jul 2018 00:28:06 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 00/16] clk: at91: Rework DT bindings
Date:   Wed, 18 Jul 2018 00:27:41 +0200
Message-Id: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
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

The series is based on top of clk-next plus at91-dt so I don't think it
is convenient to have it this cycle. However, I would really like to
ensure we agree on the new bindings this cycle before converting all the
other platforms as this is a bit tedious.

The first two patches are actually fixes and may be considered for this
cycle.

One nice note:
at91-sama5d2_xplained.dtb goes from 29351 bytes to 22082 bytes

drivers/clk/at91/built-in.o changes that way:

   text	   data	    bss	    dec	    hex	
  34792	     24	    732	  35548	   8adc	before
  39438	     32	    741	  40211	   9d13	after
  28300	     32	    741	  29073	   7191	without dt-compat


Alexandre Belloni (16):
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
  clk: at91: add at91sam9x5 PMCs driver
  clk: at91: move DT compatibility code to its own file
  ARM: dts: at91: sama5d4: switch to new clock bindings
  ARM: dts: at91: sama5d2: switch to new binding
  ARM: dts: at91: at91sam9x5: switch to new clock bindings

 .../devicetree/bindings/clock/at91-clock.txt  | 523 +---------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts          |   2 +-
 arch/arm/boot/dts/at91sam9g15.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9g25.dtsi            |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts           |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi            |   4 +
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
 drivers/clk/at91/at91sam9x5.c                 | 302 ++++++
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
 drivers/clk/at91/pmc.h                        | 157 +++
 drivers/clk/at91/sama5d2.c                    | 333 ++++++
 drivers/clk/at91/sama5d4.c                    | 262 +++++
 include/dt-bindings/clock/at91.h              |  14 +
 43 files changed, 2398 insertions(+), 2946 deletions(-)
 create mode 100644 drivers/clk/at91/at91sam9x5.c
 create mode 100644 drivers/clk/at91/dt-compat.c
 create mode 100644 drivers/clk/at91/sama5d2.c
 create mode 100644 drivers/clk/at91/sama5d4.c

-- 
2.18.0

