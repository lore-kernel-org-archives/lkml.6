Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83DEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE1520852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE1520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeFRON1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:13:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59372 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeFRONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:20 -0400
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="16045950"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 07:13:19 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Jun 2018 07:13:09 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <nicolas.ferre@microchip.com>, <boris.brezillon@bootlin.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH v5 0/5] ASoC: add driver for Atmel I2S controller
Date:   Mon, 18 Jun 2018 17:12:34 +0300
Message-ID: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rework of Cyrille's patches named:
[PATCH v3 0/2] ASoC: add driver for Atmel I2S controller
https://lkml.org/lkml/2015/9/29/454

This is the version 5 of the series, and addresses the received feedback
on the mailing lists.

This series applies on top of clk-next branch of clk/linux.git.

Based on received feedback, I created a mux clock driver to select the I2S
clock source, that also includes proper devicetree bindings and nodes.
Also, I added the I2S nodes in sama5d2's devicetree, with the missing
pin muxing for the second I2S controller.

Alexandre Belloni plans to change the at91 fine grained clock nodes and
he recommended to leave the bindings for this clock driver in the same
(wrong) manner, so he could fix them all at once.

This series of patches adds support to the new Atmel I2S controller
embedded on sama5d2 SoCs.

ChangeLog

v4 -> v5
 - removed patches:
   [PATCH v4 4/7] ASoC: atmel-i2s: dt-bindings: add DT bindings for I2S controller
   [PATCH v4 5/7] ASoC: atmel-i2s: add driver for the new Atmel I2S controller
   from this series since they were applied to the asoc tree at:
   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
 - addressed comments received on the mux clock;

v3 -> v4
 - as suggested by Rob Herring:
   - added a clock mux driver for I2S's clock control bit;
   - more precise description of I2S's devicetree bindings;
   - removed SoC and internal detalls from bindings;
 - addressed comments from Mark Brown;
 - added devicetree nodes and pin muxing for I2S;

v2 -> v3
 - fix the coding style, add some more comments and add a section dedicated
  to sama5d2 SoCs in the DT binding documentation as suggested by Mark
  Brown.

v1 -> v2
 - initialize dev->dev before calling dev->caps->mck_init()

Codrin Ciubotariu (3):
  dt-bindings: clk: at91: add an I2S mux clock
  clk: at91: add I2S clock mux driver
  ARM: dts: at91: sama5d2: add I2S clock muxing nodes

Cyrille Pitchen (2):
  ARM: dts: at91: sama5d2: add nodes for I2S controllers
  ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 .../devicetree/bindings/clock/at91-clock.txt  |  35 ++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  28 +++++
 arch/arm/boot/dts/sama5d2.dtsi                |  52 ++++++++
 arch/arm/mach-at91/Kconfig                    |   4 +
 drivers/clk/at91/Makefile                     |   1 +
 drivers/clk/at91/clk-i2s-mux.c                | 116 ++++++++++++++++++
 6 files changed, 236 insertions(+)
 create mode 100644 drivers/clk/at91/clk-i2s-mux.c

-- 
2.17.1

