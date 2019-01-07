Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A463C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2520838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="IKInSSLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfAGCLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:11:55 -0500
Received: from onstation.org ([52.200.56.107]:46918 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfAGCLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:11:54 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4E0B114A;
        Mon,  7 Jan 2019 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546827113;
        bh=wDkjj6h/FHlpuxzIn6VJz9ckyAqF5ZE7VKucEdJw3iU=;
        h=From:To:Cc:Subject:Date:From;
        b=IKInSSLmkdP64hPdpITKc0zlrCVz6wZkpJNPdH+iyc/TMCcZ/Vx8D2q2+SvldhcGX
         xO0ndR+SHnEMTlsOQ6EHQNbyG/OxPt9IIXjMD8T20sc7OxLHiC/CK99LrAisYIz3++
         F208nUWXjv826Ne0driFk9I6bORA8zEMlpMDH+oc=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        lee.jones@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] qcom: spmi: add support for hierarchical IRQ chip
Date:   Sun,  6 Jan 2019 21:11:40 -0500
Message-Id: <20190107021145.6370-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds hierarchical IRQ chip support to spmi-gpio so
that device tree consumers can request an IRQ directly from the GPIO
block rather than having to request an IRQ from the underlying PMIC.
The first two patches in this series removes some IRQ count code that
was causing the IRQs to be prematurely initialized. Patch three
converts pmic-arb to use the version 2 IRQ interface. Patches 4/5
add support for the hierarchical IRQ chip to spmi-gpio.

For more background information, see the email thread with Linus
Walleij's excellent description of the problem at
https://www.spinics.net/lists/linux-gpio/msg34655.html.

Patches 3-5 need to be applied in the order that are presented here in
order to allow for a proper bisection. Patch 5 depends on the presence
of 1-4. Part of the series can be applied without any breakage.

This work was tested on a LG Nexus 5 (hammerhead) phone. My status page
at https://masneyb.github.io/nexus-5-upstream/ describes what is working
so far with an upstream kernel.

High-level changes since v1:
- Patches 1 and 2 are new. This brought in a third subsystem (mfd).
- I have detailed changelogs attached to the notes on patches 3-5.

Brian Masney (5):
  spmi: pmic-arb: hardcode IRQ counts
  mfd: qcom-spmi-pmic: use devm_mfd_add_devices instead of
    devm_of_platform_populate
  spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical
    IRQ chips
  qcom: spmi-gpio: add support for hierarchical IRQ chip
  ARM: dts: qcom: msm8974: add interrupt controller properties

 arch/arm/boot/dts/qcom-pm8941.dtsi       |  39 +-----
 drivers/mfd/Kconfig                      |   1 +
 drivers/mfd/qcom-spmi-pmic.c             |  61 ++++++++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 160 +++++++++++++++++++----
 drivers/spmi/spmi-pmic-arb.c             |  58 +++++---
 5 files changed, 233 insertions(+), 86 deletions(-)

-- 
2.17.2

