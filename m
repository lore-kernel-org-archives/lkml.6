Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898BBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B08F208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iWuF39df";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TpLgD0t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B08F208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeHQWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:16:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeHQWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:15:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C4ED6257E; Fri, 17 Aug 2018 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533036;
        bh=jZdQpDTxDkVJLgeMviO0IxRiOxMH8Y6zNGGTXVJ3qlE=;
        h=From:To:Cc:Subject:Date:From;
        b=iWuF39dfnS9Ty2fbKShYweHO7gWx9cWp9a8SpqFTLN6DoycbAKXN1AbiGgP4jlDg3
         paSZcH2iyBEhoNG7xQ6d8uBrw/BXtbwSf/5RCWfWNrjbL7jWCRIaEwYF1U3plIaPlZ
         AMmKPs/EyyaUp0CBIUk26Pl+fChlBcI2B6pYqBgY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F26EF62496;
        Fri, 17 Aug 2018 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533035;
        bh=jZdQpDTxDkVJLgeMviO0IxRiOxMH8Y6zNGGTXVJ3qlE=;
        h=From:To:Cc:Subject:Date:From;
        b=TpLgD0t3RcZqCgS6fXvFBYEpEbY3R9r62LJq1O6LUoZFYFlRgHef6pqxBezxwuE10
         CampQmGGGbsd6sCwCYdD3iuOZm6BtOrwuhF4dS2RypQTJj020SD8ZxmNV20eMuWww3
         vy4JarDBSPto+bh19KwXitpYJ++buob7e57rf/k8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F26EF62496
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND v1 0/5] Wakeup GPIO support for SDM845 SoC
Date:   Fri, 17 Aug 2018 13:10:21 -0600
Message-Id: <20180817191026.32245-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resending as v1. The series was sent incorrectly as v2.

Changes in v1:
        - Avoid GPIO-PDC map in .c file
        - Trigger GPIO by writing to the hardware
        - Hooked up to suspend/resume callbacks
        - Dropped PDC DT bindings (see dependencies)

Dependencies:
        https://lkml.org/lkml/2018/8/17/137
        https://lkml.org/lkml/2018/8/15/289

This is an attempt at a solution to enable wake up from suspend and deep idle
using GPIO as a wakeup source. The 845 uses a new interrupt controller (PDC)
that lies in the always-on domain and can sense interrupts that are routed to
it, when the GIC is powered off. It would then wakeup the GIC and replay the
interrupt which would then be relayed to the AP. The PDC interrupt controller
driver is merged upstream [1],[2]. The following set of patches extends the
wakeup capability to GPIOs using the PDC. The TLMM pinctrl driver for the SoC
available at [3].

The complexity with the solution stems from the fact that only a selected few
GPIO lines are routed to the PDC in addition the TLMMs. They are also from
different banks on the pinctrl and the TLMM summary line is not routed to the
PDC. Hence the PDC cannot be considered as parent of the TLMM irqchip (or can
we ?). This is what it looks like -

   [ PIN ] -----[ TLMM ]---------------> [ GIC ] ---> [ CPU ]
      |                  <summary IRQ>       ^
      |                                      |
      ----------------------------------> [ PDC ]
                <wakeup IRQs>

I had a brief discussion with Linus on this and the idea implemented is based
on his suggestion.

When an IRQ (let's call this latent IRQ) for a GPIO is requested, the
->irq_request_resources() is used by the TLMM driver to request a PDC pin. The
PDC pin associated with the GPIO is read from a  static map available in the
pinctrl-sdm845.c. (I think there should be a better location than a static map,
more on that later). Knowing the PDC pin from the map, we could look up the DT
bindings and request the PDC interrupt with the same trigger mask as the
interrupt requested. The ->set_type and ->set_wake are also trapped to set the
PDC IRQ's polarity and enable it when the latent IRQ is requested. When the PDC
detects the interrupt at suspend, it wakes up the GIC and replays the wakeup
IRQ. The GPIO handler function for the latent IRQ is invoked in turn.

Please review these patches and your inputs would be greatly appreciated and
(kindly) let me know if I have committed any blunders with this approach. There
is definitely opportunity to improve the location of the static GPIO-PDC pin
map. We could possibly put it as an data argument in the interrupts definition
of the PDC or with interrupt names. Also, I am still sorting out some issues
with the IRQ handling part of these patches. And I am unsure of how to set the
polarity of the PDC pin without locking, since we are not in hierarchy with the
PDC interrupt controller. Again, your inputs on these would be greatly helpful.

Thanks,
Lina

[1]. drivers/irqchip/qcom-pdc.c
[2]. Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
[3]. drivers/pinctrl/qcom/pinctrl-msm.c

*** BLURB HERE ***

Lina Iyer (4):
  dt-bindings: pinctrl: add wakeup capable GPIOs for SDM845
  drivers: pinctrl: msm: enable PDC interrupt only during suspend
  drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
  arm64: dts: qcom: add wake up interrupts for GPIOs for SDM845

Marc Zyngier (1):
  irqchip/gic-v3: Allow interrupt to be configured as wake-up sources

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 58 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 57 +++++++++++++++++-
 drivers/irqchip/irq-gic-v3.c                  |  8 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c            | 60 ++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h            |  3 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         |  6 ++
 6 files changed, 185 insertions(+), 7 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

