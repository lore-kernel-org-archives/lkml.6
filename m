Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D28C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="AtlBjAQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7135B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeLJSm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:42:27 -0500
Received: from plaes.org ([188.166.43.21]:55062 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:42:26 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id AE34440302;
        Mon, 10 Dec 2018 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544467344; bh=fTb19bShObdTgbAkz3Z+05tI/7iVObx7qNqh1LH392I=;
        h=From:To:Cc:Subject:Date:From;
        b=AtlBjAQtndCAVH6bxmAlruUaZWXSjUlrD1E7PmUQuTvFq6pMuzMI2A8U+i8KX98kC
         1zEe6dD50noHmnLRrZLGbg6wwvNeTNt7fzBanUkXcJ3pIva9D4MstYg+/BoAvQKVmo
         f+2qwnLx4ndIQjDOvhYTBW0zrZrGWp+2tp9U00G83pZa34mrW+BIZrBPwzc+moCZEH
         pctpxHYidVcUb32io5OlwE1Be1o68uJYDAJxRyOdilwMEBjCTUWiFg9bMYyUMkaMGJ
         G3C2jJO1xXlXNtZzi9/ekunyZFVIDcm+9vMTGEyl/89h37RH/jli1iL4xxKT0hCeZb
         yLniGxhtyf7xg==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 0/8] This is a second edition of a series that implements voltage
Date:   Mon, 10 Dec 2018 20:42:11 +0200
Message-Id: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ramping for AXP209 DCDC2 and LDO3 regulators and software
based soft-start for AXP209 LDO3 regulator.

Both features are needed to work around a PMIC shutdown when
toggling LDO3 on certain boards with high capacitance on the
LDO3 output.

Similar features (or workarounds) have been also implemented
on u-boot side [1].

Changes since v1:
- Rebased on top of next and dropped already merged patches.
- Dropped LDO4 full range devicetree change for Lime2 (prev patch 9)
  in favor of general pin-bank regulator dependency [2].
- Fixed paths in devicetree bindings (patch 3)
- Added note about software based soft-start for LDO3 (patch 5)

[1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618459.html

Olliver Schinagl (8):
  mfd: axp20x: name voltage ramping define properly
  regulator: axp20x: add support for set_ramp_delay for AXP209
  dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
  regulator: axp20x: add software based soft_start for AXP209 LDO3
  dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
  regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
  mfd: axp20x: Clean up included headers
  mfd: axp20x: use explicit bit defines

 Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |   2 +-
 drivers/mfd/axp20x.c                             |  13 +-
 drivers/regulator/axp20x-regulator.c             | 142 +++++++++++++++-
 include/linux/mfd/axp20x.h                       |   4 +-
 5 files changed, 161 insertions(+), 9 deletions(-)

base-commit: 14cf8c1d5b90a0cf6a8ba51ef59db8da8c7a2622
-- 
git-series 0.9.1
