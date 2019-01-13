Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207120842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="L3bgPsO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfAMPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:47:41 -0500
Received: from onstation.org ([52.200.56.107]:42648 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfAMPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:41 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5DC46153;
        Sun, 13 Jan 2019 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394460;
        bh=eqyvMZ/L+3ixP8Y+XtzEx6AukltpV50rNkEcpm+gZTU=;
        h=From:To:Cc:Subject:Date:From;
        b=L3bgPsO7iGl2zloSFEnhncrklLQelyViA7IgngIxMSzqdkp2jHIaUPMaRePPZg3DX
         +TQbBaVBIAF876aNcyLXwKPZlu81eSWudpAgeYrWCzrEFnaHHPwsRG2GOW1bGy29Qj
         5qf/jHaaNxLIR/MFZovRw3U6I3W62a7cPm4Ri/Oc=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 00/14] qcom: spmi: add support for hierarchical IRQ chip
Date:   Sun, 13 Jan 2019 10:47:02 -0500
Message-Id: <20190113154716.5145-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds hierarchical IRQ chip support to spmi-gpio so
that device tree consumers can request an IRQ directly from the GPIO
block rather than having to request an IRQ from the underlying PMIC.

For more background information, see the email thread with Linus
Walleij's excellent description of the problem at
https://www.spinics.net/lists/linux-gpio/msg34655.html.

This work was tested on a LG Nexus 5 (hammerhead) phone. My status page
at https://masneyb.github.io/nexus-5-upstream/ describes what is working
so far with the upstream kernel.

High-level changes since v3:
- Add missing variants to spmi-gpio driver and device tree binding doc
  that are already in use in device tree.
- Introduce patch that disassociates the old virq if hwirq mapping
  already exists and then drop it at the end of the series. This is to
  not break git bisect for existing boards.
- Migrate arm64 device tree files.
- There are 8 new patches in this series and I denoted this in the notes
  on the relevant patches.

High-level changes since v2:
- Dropped patch to mfd/qcom-spmi-pmic.c
- Patch 3 is new and adds two new functions to gpiolib
- Patch 6 is new and corrects the only other upstream user of spmi-gpio

High-level changes since v1:
- Patches 1 and 2 are new. This brought in a third subsystem (mfd).
- I have detailed changelogs attached to the notes on patches 3-5.

Brian Masney (14):
  dt-bindings: pinctrl: qcom-pmic-gpio: add qcom,pmi8998-gpio binding
  pinctrl: qcom: spmi-gpio: add support for three new variants
  pinctrl: qcom: spmi-gpio: hardcode IRQ counts
  spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical
    IRQ chips
  gpio: add irq domain activate/deactivate functions
  spmi: pmic-arb: disassociate old virq if hwirq mapping already exists
  qcom: spmi-gpio: add support for hierarchical IRQ chip
  ARM: dts: qcom: pm8941: add interrupt controller properties
  ARM: dts: qcom: pma8084: add interrupt controller properties
  arm64: dts: qcom: pm8005: add interrupt controller properties
  arm64: dts: qcom: pm8998: add interrupt controller properties
  arm64: dts: qcom: pmi8994: add interrupt controller properties
  arm64: dts: qcom: pmi8998: add interrupt controller properties
  spmi: pmic-arb: revert "disassociate old virq if hwirq mapping already
    exists"

 .../bindings/pinctrl/qcom,pmic-gpio.txt       |   1 +
 arch/arm/boot/dts/qcom-pm8941.dtsi            |  38 +----
 arch/arm/boot/dts/qcom-pma8084.dtsi           |  24 +---
 arch/arm64/boot/dts/qcom/pm8005.dtsi          |   6 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |  28 +---
 arch/arm64/boot/dts/qcom/pmi8994.dtsi         |  12 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  16 +--
 drivers/gpio/gpiolib.c                        |  37 +++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      | 136 ++++++++++++++----
 drivers/spmi/spmi-pmic-arb.c                  |  58 +++++---
 include/linux/gpio/driver.h                   |   5 +
 11 files changed, 205 insertions(+), 156 deletions(-)

-- 
2.17.2

