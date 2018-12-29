Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21CEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B92218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="J1z2XPlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeL2LsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:48:04 -0500
Received: from onstation.org ([52.200.56.107]:46166 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeL2LsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:48:04 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1D34414A;
        Sat, 29 Dec 2018 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546084083;
        bh=RFqNgt4kh2hQcJjjzOy0dOpxHmpuEb/PNuxq066qzuA=;
        h=From:To:Cc:Subject:Date:From;
        b=J1z2XPlhYdTSevjpKEm7a+yeT9EsLwbdJzTsy1cwa/tASkEp7VtUL63k9SFhuvtjq
         x9wwkSK1E4EwlZDYo1GQCAsFFi1OJj2sgR4a3I6KPAyOnNa+boCKew4UxSMjsDm8Zn
         q/+ARai/u904KA1RGYF0cOL0h4vrjvSj8QTuuMOY=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] qcom: spmi: add support for hierarchical IRQ chip
Date:   Sat, 29 Dec 2018 06:47:52 -0500
Message-Id: <20181229114755.8711-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds hierarchical IRQ chip support to spmi-gpio so
that device tree consumers can request an IRQ directly from the GPIO
block rather than having to request an IRQ from the underlying PMIC.
The first patch in this series converts pmic-arb to use the version 2
IRQ interface and patches 2 and 3 add support for the hierarchical
IRQ chip to spmi-gpio.

For more background information, see the email thread with Linus
Walleij's excellent description of the problem at
https://www.spinics.net/lists/linux-gpio/msg34655.html.

The patches need to be applied in the order that I have them in order
to allow for a proper bisection, however part of the series can be
applied without any breakage. Maybe the spmi-arb change can go in
for v4.21 and the spmi-gpio changes can go in for v4.22?

This work was tested on a LG Nexus 5 (hammerhead) phone. My status page
at https://masneyb.github.io/nexus-5-upstream/ describes what is working
so far with an upstream kernel.

Brian Masney (3):
  spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical
    IRQ chips
  qcom: spmi-gpio: add support for hierarchical IRQ chip
  ARM: dts: qcom: msm8974: add interrupt properties

 arch/arm/boot/dts/qcom-pm8941.dtsi       |   3 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 119 ++++++++++++++++++++++-
 drivers/spmi/spmi-pmic-arb.c             |  91 ++++++++++++-----
 3 files changed, 182 insertions(+), 31 deletions(-)

-- 
2.17.2

