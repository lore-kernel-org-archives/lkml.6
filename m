Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7404C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C956218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XDe9PYmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAYQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:23:09 -0500
Received: from onstation.org ([52.200.56.107]:54966 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfAYQXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:23:08 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1D66519F;
        Fri, 25 Jan 2019 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1548433388;
        bh=kCv0Id3NPpiClfGC6MKEg4/Q1E814l4CTmjoOLIKv3g=;
        h=From:To:Cc:Subject:Date:From;
        b=XDe9PYmd9G4wuGb47p2xvSOCndcCgf2iH16Opdxu9pnEsfP20W/J+zOBSIh3Uj6zD
         mJKwuneIDFrsAOm0f3Q47TPHBeDuM/xpu2NBBRbi4mj/K23pdJuZ2JtQH8zFBELc4E
         eA69/BwDZ/ALIAx4BjGNZTOadfaylt9vBrz3iP2k=
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
Subject: [PATCH 0/9] qcom: ssbi-gpio: add support for hierarchical IRQ chip
Date:   Fri, 25 Jan 2019 11:22:53 -0500
Message-Id: <20190125162302.14036-1-masneyb@onstation.org>
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

This change was not tested on any actual hardware, however the same
change was made to spmi-gpio and tested on a LG Nexus 5 (hammerhead)
phone. That patch series is available at
https://lore.kernel.org/lkml/20190119204252.18370-1-masneyb@onstation.org/
and is queued for the next merge window.

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

 arch/arm/boot/dts/qcom-apq8064.dtsi      |  46 +------
 arch/arm/boot/dts/qcom-mdm9615.dtsi      |   9 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi      |  47 +------
 drivers/mfd/qcom-pm8xxx.c                |  86 +++++++-----
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 161 +++++++++++++++++++----
 include/linux/irqdomain.h                |   5 +
 kernel/irq/irqdomain.c                   |  21 +++
 7 files changed, 218 insertions(+), 157 deletions(-)

-- 
2.17.2

