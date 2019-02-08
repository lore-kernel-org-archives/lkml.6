Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BEEC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73B921907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Y/xCMwl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBHCQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:16:50 -0500
Received: from onstation.org ([52.200.56.107]:34920 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBHCQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:50 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 34A7B11;
        Fri,  8 Feb 2019 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592208;
        bh=+cm7uQOdgPrn6N1qmlKrYR6UiAHumMlV+rDxFVROaj4=;
        h=From:To:Cc:Subject:Date:From;
        b=Y/xCMwl/EluaHfMnVGaR6QVEGt+r+6q6Xr+AUzTynnBAxUbTqurl7IpSePz8+z7wY
         DyiqgSKfRbCEWRI09TqfAisQPiw81ALlddxzfMRws9YCNf7d6XNogMEXO0IXFky3Rh
         ObVBp5rJWUZecZVIZ/E9B2PavFeWAPcizyiBDyfo=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/11] qcom: ssbi-gpio: add support for hierarchical IRQ chip
Date:   Thu,  7 Feb 2019 21:16:20 -0500
Message-Id: <20190208021631.30252-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds hierarchical IRQ chip support to ssbi-gpio so
that device tree consumers can request an IRQ directly from the GPIO
block rather than having to request an IRQ from the underlying PMIC.

For more background information, see the email thread with Linus
Walleij's excellent description of the problem at
https://www.spinics.net/lists/linux-gpio/msg34655.html.

These changes were tested by Linus Walleij on an APQ8060 DragonBoard.

See the notes on the individual patches for the changelog.

Brian Masney (9):
  pinctrl: qcom: ssbi-gpio: hardcode IRQ counts
  genirq: introduce irq_domain_translate_twocell
  mfd: pm8xxx: convert to v2 irq interfaces to support hierarchical IRQ
    chips
  mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
  qcom: ssbi-gpio: add support for hierarchical IRQ chip
  arm: dts: qcom: apq8064: add interrupt controller properties
  arm: dts: qcom: msm8660: add interrupt controller properties
  arm: dts: qcom: mdm9615: add interrupt controller properties
  mfd: pm8xxx: revert "disassociate old virq if hwirq mapping already
    exists"

Linus Walleij (2):
  genirq: introduce irq_chip_mask_ack_parent()
  ARM: dts: qcom-apq8060: Fix up interrupt parents

 .../arm/boot/dts/qcom-apq8060-dragonboard.dts |  21 +--
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  46 +-----
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |   9 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  47 +-----
 drivers/mfd/qcom-pm8xxx.c                     |  75 ++++-----
 drivers/pinctrl/qcom/Kconfig                  |   1 +
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c      | 156 +++++++++++++++---
 include/linux/irq.h                           |   1 +
 include/linux/irqdomain.h                     |   5 +
 kernel/irq/chip.c                             |  11 ++
 kernel/irq/irqdomain.c                        |  45 +++--
 11 files changed, 234 insertions(+), 183 deletions(-)

-- 
2.17.2

