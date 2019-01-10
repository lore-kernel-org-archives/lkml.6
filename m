Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8663B2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="S5lWgq7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfAJBNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:13:14 -0500
Received: from onstation.org ([52.200.56.107]:34224 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfAJBNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:13:13 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4E0A411;
        Thu, 10 Jan 2019 01:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547082792;
        bh=R+GevBIATXXjhmpxpMD4heN9KJC3iQ4KMwxmZbCRMnM=;
        h=From:To:Cc:Subject:Date:From;
        b=S5lWgq7cHq5FfhbB8RCx4FP7QDM+n8M5ycO33NKWETMC6nuYV6pAXd3Rqjqj2c0Xu
         8XI9DqK3NeE7EQwMJ0QfEsUhN0h5imITTovahQAL/XUEdKiTgTLqF9qBrZ63OLDWKD
         bB7X/W4Xr4wmjfJg1zHKVE1LLvu3xbcn/eoqaYB4=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] qcom: spmi: add support for hierarchical IRQ chip
Date:   Wed,  9 Jan 2019 20:12:52 -0500
Message-Id: <20190110011258.17227-1-masneyb@onstation.org>
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
so far with an upstream kernel.

High-level changes since v2:
- Dropped patch to mfd/qcom-spmi-pmic.c
- Patch 3 is new and adds two new functions to gpiolib
- Patch 6 is new and corrects the only other upstream user of spmi-gpio

High-level changes since v1:
- Patches 1 and 2 are new. This brought in a third subsystem (mfd).
- I have detailed changelogs attached to the notes on patches 3-5.

Brian Masney (6):
  pinctrl: qcom: spmi-gpio: hardcode IRQ counts
  spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical
    IRQ chips
  gpio: add irq domain activate/deactivate functions
  qcom: spmi-gpio: add support for hierarchical IRQ chip
  ARM: dts: qcom: pm8941: add interrupt controller properties
  ARM: dts: qcom: pma8084: add interrupt controller properties

 arch/arm/boot/dts/qcom-pm8941.dtsi       |  38 +------
 arch/arm/boot/dts/qcom-pma8084.dtsi      |  24 +---
 drivers/gpio/gpiolib.c                   |  37 +++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 134 +++++++++++++++++++----
 drivers/spmi/spmi-pmic-arb.c             |  58 ++++++----
 include/linux/gpio/driver.h              |   5 +
 6 files changed, 194 insertions(+), 102 deletions(-)

-- 
2.17.2

