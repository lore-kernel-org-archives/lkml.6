Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FCC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF45521473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfA3ImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:42:25 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60652 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfA3ImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:42:21 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id B51445FBD8; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] arm64: dts: allwinner: h5: Enable CPU DVFS (cpufreq)
Date:   Wed, 30 Jan 2019 16:41:53 +0800
Message-Id: <20190130084203.25053-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series enables DVFS for the CPU cores (aka cpufreq) on the
Allwinner H5 SoC. The OPP table was taken from Armbian, with minor
tweaks to the maximum voltage to account for slightly increased voltage
on some of the boards.

This has been tested on the Bananapi M2+ v1.2 and Libre Computer
ALL-H3-CC H5 ver..  I do not have the remaining boards so I've CC-ed
people who did the original submission or have modified the board
specifically later on.

Patch 1 fixes the voltages specified for the GPIO-controlled regulator
on the Bananapi M2+ v1.2. The voltages are slightly higher than what
was originally written.

Patch 2 adds a fixed regulator for the CPU on the original Bananapi M2+.
This is for the retail version, not the engineering samples that had an
even higher voltage setting.

Patch 3 hooks up the CPU regulator supply for H5 boards that already
define the regulator, but were missing the property to tie it to the
CPUs.

Patch 4 ~ 8 adds the CPU regulator for boards that don't have it
defined. This is based on each vendor's schematics. I need people
to test each of these specifically and the whole series.

Patch 9 ties the CPU clock to the CPU cores.

Patch 10 adds the OPP table, based on the one from Armbian.

Please have a look and please help test this.


Regards
ChenYu


Chen-Yu Tsai (10):
  ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
  ARM: dts: bananapi-m2-plus: Add CPU supply regulator
  arm64: dts: allwinner: h5: Hook up cpu regulator supplies
  arm64: dts: allwinner: h5: nanopi-neo2: Add CPU regulator supply
  arm64: dts: allwinner: h5: orange-pi-zero-plus: Add CPU regulator
    supply
  arm64: dts: allwinner: h5: orange-pi-zero-plus2: Add CPU regulator
    supply
  arm64: dts: allwinner: h5: orange-pi-pc2: Add CPU regulator supply
  arm64: dts: allwinner: h5: orange-pi-prime: Add CPU regulator supply
  arm64: dts: allwinner: h5: Add clock to CPU cores
  arm64: dts: allwinner: h5: Add CPU Operating Performance Points table

 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 30 +++-----
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 ++++
 .../sun50i-h5-emlid-neutis-n5-devboard.dts    |  4 +
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  |  4 +
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 20 +++++
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 28 +++++++
 .../allwinner/sun50i-h5-orangepi-prime.dts    | 28 +++++++
 .../sun50i-h5-orangepi-zero-plus.dts          | 20 +++++
 .../sun50i-h5-orangepi-zero-plus2.dts         | 20 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 75 +++++++++++++++++++
 10 files changed, 224 insertions(+), 19 deletions(-)

-- 
2.20.1

