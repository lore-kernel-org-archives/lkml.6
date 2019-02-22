Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA60C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90C520675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bojbCGCr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h7LF4O/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfBVWTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FB946075A; Fri, 22 Feb 2019 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873943;
        bh=4wI5hivkZB2yujZV9m8gQAW5THP/ge+9DpFZ78cFaIM=;
        h=From:To:Cc:Subject:Date:From;
        b=bojbCGCrzX2Qcorov0wTIhqyGazrepfdjgJ/4G0/vonA8Rvr+p3qLLDQyoLYW6DMH
         7UeKLtAYIHJDdIThZs+wGwQYCIMUo79PaFUGMZG36DPRIDom6LUnOH39gC3UbG3xPE
         K8ZuxdNx3WIIYdGEw5OoKopTe1PER0tT2wiKL3IE=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8B666075A;
        Fri, 22 Feb 2019 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873942;
        bh=4wI5hivkZB2yujZV9m8gQAW5THP/ge+9DpFZ78cFaIM=;
        h=From:To:Cc:Subject:Date:From;
        b=h7LF4O/dCHafBKpEm8vKmmI8O6l4KcHkymQMAbcDj6yWIJU+U3A8aMuyBO8U+8yFH
         XtBRaWP7PVsG+dDvqEeAKtPe+k2n0trCxq1WrhZiG+C6voRFpfIGle3cCM6htC+R/5
         C8AmXRcdd/idfcNYkWaC2tRnUyvuBswcpRXJrXT0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8B666075A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 0/9] qcom: support wakeup capable GPIOs
Date:   Fri, 22 Feb 2019 15:18:41 -0700
Message-Id: <20190222221850.26939-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is based on idea of setting up a wakeup parent interrupt controller
for GPIOs that are wakeup capable. The patch is based on Thierry's hierarchical
GPIO irqdomains. Much of the idea stem's from Stephen's suggestions in [1] with
some fixes.

I am posting this series to help with the discussions around this approach.
Please take a look at the series and let me know your comments. We need to find
a good place to add the document the generic irqdomain-map bindings.

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/12/19/813

Lina Iyer (7):
  irqdomain: add bus token DOMAIN_BUS_WAKEUP
  drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
  dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
  drivers: pinctrl: msm: setup GPIO irqchip hierarchy
  arm64: dts: qcom: add PDC interrupt controller for SDM845
  arm64: dts: qcom: setup PDC as wakeup parent for GPIOs for SDM845
  arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845

Stephen Boyd (1):
  of: irq: add helper to remap interrupts to another irqdomain

Thierry Reding (1):
  gpio: Add support for hierarchical IRQ domains

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  87 +++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpio/gpiolib.c                        |  15 +-
 drivers/irqchip/qcom-pdc.c                    | 106 +++++++++++--
 drivers/of/irq.c                              | 125 ++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.c            | 141 ++++++++++++++++--
 include/linux/gpio/driver.h                   |   6 +
 include/linux/irqdomain.h                     |   1 +
 include/linux/of_irq.h                        |   1 +
 include/linux/soc/qcom/irq.h                  |  23 +++
 11 files changed, 486 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/soc/qcom/irq.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

