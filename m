Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB47C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119032086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="cZUz2ob+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119032086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeK0CWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:37 -0500
Received: from plaes.org ([188.166.43.21]:49892 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0CWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:37 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id EB1DC4128B;
        Mon, 26 Nov 2018 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246089; bh=+dxr20gmRSo77fcR/PRI+1UvYyHbhSOv99xBK9H8OMI=;
        h=From:To:Cc:Subject:Date:From;
        b=cZUz2ob+RoyUsYR6CIsgPEa75MPHxc8bN0kj4zIIwmwxlM0n8r17sVDgPbCFMGF7J
         nnBoith9ZKxQqGwcTmDRDFbTPoCXq1Z7W2kvWufHPNZxRjuMRCgsBMgCqiq06418B2
         7K+qKRtnGmHDkpwS7RYKhaycPQN8Y6NXvnBN3Mch+R4Cx9yRSh0r4UB5qe/vULxBqn
         1Y8TB+J22ZM4/vwG/ne+QQqAnN3orj+aJ2/65d9MGIMlgAC/bXIOFctkR4Y+xTqUlE
         AwJXWxxMgef3tJVOAKwwRtYjG3C9h1heK1wLogdDyRoL+eHFlKTuqJDSwxUyuMkhjp
         IWr5gyXPuqkWA==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 00/14] regulator: axp20x: Stop AXP209 from crashing when enabling LDO3
Date:   Mon, 26 Nov 2018 17:27:41 +0200
Message-Id: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements voltage ramping for AXP209 DCDC2 and LDO3
regulators and software based soft-start for AXP209 LDO3 regulator.

Both features are needed to work around a PMIC shutdown when
toggling LDO3 on certain boards with high capacitance on the
LDO3 output.

Similar features (or workarounds) have been also implemented
on u-boot side [1].

Also included in this series are various magic constant cleanups
and also fix for core regulator framework, where 'always-enabled'
constraint overrides the 'soft-start' and 'ramp-delay' features.

[1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html

Olliver Schinagl (14):
  regulator: axp20x: use defines for masks
  regulator: axp20x: name voltage ramping define properly
  regulator: core: enable power when setting up constraints
  regulator: axp20x: add support for set_ramp_delay for AXP209
  dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
  regulator: axp20x: add software based soft_start for AXP209 LDO3
  dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
  regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
  regulator: dts: add full voltage range to LDO4 on the Lime2
  regulator: dts: set proper lradc vref on OLinuXino Lime2
  mfd: axp20x: Clean up included headers
  mfd: axp20x: use explicit bit defines
  power: supply: axp20x: add missing include bitops.h
  power: supply: axp288: use the BIT() macro

 Documentation/devicetree/bindings/mfd/axp20x.txt |   8 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  13 +-
 drivers/mfd/axp20x.c                             |  13 +-
 drivers/power/supply/axp20x_usb_power.c          |   1 +-
 drivers/power/supply/axp288_charger.c            |  35 +-
 drivers/regulator/axp20x-regulator.c             | 875 ++++++++++++----
 drivers/regulator/core.c                         |  22 +-
 include/linux/mfd/axp20x.h                       |   4 +-
 8 files changed, 753 insertions(+), 218 deletions(-)

base-commit: 2e6e902d185027f8e3cb8b7305238f7e35d6a436
-- 
git-series 0.9.1
