Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F4C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FA920833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSj6QVef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FA920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeGYRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbeGYRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:31:46 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A8920852;
        Wed, 25 Jul 2018 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532535564;
        bh=00yiBleOmCB4bfuVXaAUuLs0zMniPNEfnwtaGhNygwE=;
        h=From:To:Cc:Subject:Date:From;
        b=nSj6QVefmztmee9RaQtxo9z2la4FHg4TWUgl1oUZ0a1wYOk79QfyyhBPlbI2tZi0S
         /UqCg/g2lzLA1fVaRZY47SQg7pB2eGjAtgSDkdMnVIm6C+WBtrZe7W+izEoTNMtEh7
         Rs0wXbryhEwOxCHB9xQ3RUNLkt1vzYk3fKR7MN2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [GIT PULL] pinctrl: samsung: Stuff for v4.19
Date:   Wed, 25 Jul 2018 18:18:52 +0200
Message-Id: <20180725161852.6963-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.19

for you to fetch changes up to b3793159249bb091efce4b1515ce18cdfc4c6e41:

  dt-bindings: pinctrl: samsung: Add SPDX license identifier (2018-07-24 21:59:17 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v4.19

1. Add handling of external wakeup interrupts mask inside the pin
   controller driver.

   Existing solution is spread between the driver and machine code.  The
   machine code writes the mask but its value is taken from pin
   controller driver.

   This moves everything into pin controller driver allowing later to
   remove the cross-subsystem interaction.  Also this is a necessary
   step for implementing later Suspend to RAM on ARMv8 Exynos5433.

2. Bring necessary suspend/resume callbacks for Exynos542x and
   Exynos5260.
3. Document hidden requirement about one external wakeup interrupts
   device node.
4. Minor documentation cleanups.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      pinctrl: samsung: Define suspend and resume callbacks for all banks and SoCs
      pinctrl: samsung: Document suspend and resume members
      pinctrl: samsung: Document hidden requirement about one external wakeup
      pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup interrupts
      ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and Exynos5433
      pinctrl: samsung: Write external wakeup interrupt mask
      dt-bindings: pinctrl: samsung: Add SPDX license identifier

 .../bindings/pinctrl/samsung-pinctrl.txt           | 11 +++-
 arch/arm/mach-exynos/suspend.c                     |  2 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 68 +++++++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 ++++
 include/dt-bindings/pinctrl/samsung.h              |  7 +--
 include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
 7 files changed, 113 insertions(+), 10 deletions(-)
