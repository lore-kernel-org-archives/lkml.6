Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B6C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1EB2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1EB2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIWAL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:11:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35137 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIWAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 20:11:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 955A1208C7; Sat, 22 Sep 2018 20:17:27 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6443E204AE;
        Sat, 22 Sep 2018 20:17:17 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 0/6] Add CPU clock support for Armada 7K/8K
Date:   Sat, 22 Sep 2018 20:17:03 +0200
Message-Id: <20180922181709.13007-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series allows to mange the cpu clock for Armada 7K/8K. For these
SoCs, the CPUs share the same clock by cluster, so actually the clock
management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Gregory

Gregory CLEMENT (6): dt-bindings: ap806: add the cluster clock node in
  the syscon file clk: mvebu: add helper file for Armada AP and CP
  clocks clk: mvebu: add CPU clock driver for Armada 7K/8K clk: mvebu:
  ap806: Fix clock name for the cluster arm64: marvell: enable the
  Armada 7K/8K CPU clk driver arm64: dts: marvell: Add cpu clock node
  on Armada 7K/8K

 .../arm/marvell/ap806-system-controller.txt   |  22 ++
 arch/arm64/Kconfig.platforms                  |   1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   6 +
 drivers/clk/mvebu/Kconfig                     |   8 +
 drivers/clk/mvebu/Makefile                    |   2 +
 drivers/clk/mvebu/ap-cpu-clk.c                | 265 ++++++++++++++++++
 drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c       |  28 ++
 drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
 drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
 11 files changed, 361 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.19.0

