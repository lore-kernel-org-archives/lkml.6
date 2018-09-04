Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC22077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TBQ/AlRR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ehwYmxZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FC22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeIEBpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:45:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeIEBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:45:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 588FD6083E; Tue,  4 Sep 2018 21:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095904;
        bh=OrCpsSnAWYm/N+QzMJvJVY/kjOr4Pnope/TW3xkPa/8=;
        h=From:To:Cc:Subject:Date:From;
        b=TBQ/AlRRhxvjEeSTkJvMQbaL6VhqSRdlVDKN8DERw5Yf0CTAewsQM34ZyokQXIuFr
         7ljXtdTiQ52vOOF8RmzhLwVjjx/it8ITqAsYC1QoUUUM9XcMlCrjnJETZNPWWZWWwa
         Tu30j67srM/yAy6dFMLQjo75WMjL02aRItqUoD3w=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8801960710;
        Tue,  4 Sep 2018 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095903;
        bh=OrCpsSnAWYm/N+QzMJvJVY/kjOr4Pnope/TW3xkPa/8=;
        h=From:To:Cc:Subject:Date:From;
        b=ehwYmxZhadkFe6NXaYs5vIVqzvUtpGx3BaU9M9rhqVjpR++RUejvji6m4HFgDpbrm
         D3xR6uaztr6vfz7NJ099JnTSzxSYI+fJhJ8c32yXsmuk/bTC6rFJGmV65g5BsSKWNs
         Fne3o80myy0Azb3M7UjHmBM7cXIi5QhGLt37OrcA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8801960710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 0/5]  Wakeup GPIO support for SDM845
Date:   Tue,  4 Sep 2018 15:18:05 -0600
Message-Id: <20180904211810.5506-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
	- Release memory allocated for IRQ anme
	- Minor fixes as suggested by Mathias, Bjorn, Evan

Changes in v2:
        - Compile and test on 4.18 on SDM845
        - Fix IRQ map in patch #3
        - Address review comments
        (I still need to find a way to free memory allocated for PDC IRQ.)
        - Specify type for IRQ in DT
        - This series needs V3 of the PDC DT bingings [4]
        - gic-v3 settings are also needed [5]

Changes in v1:
        - Avoid GPIO-PDC map in .c file
        - Trigger GPIO by writing to the hardware
        - Hooked up to suspend/resume callbacks
        - Dropped PDC DT bindings (see dependencies)

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
[4]. https://lore.kernel.org/patchwork/patch/977589/
[5]. https://lore.kernel.org/patchwork/patch/975425/

Lina Iyer (5):
  drivers: pinctrl: qcom: add wakeup capability to GPIO
  dt-bindings: pinctrl: add wakeup capable GPIOs for SDM845
  drivers: pinctrl: msm: enable PDC interrupt only during suspend
  drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
  arm64: dts: qcom: add wake up interrupts for GPIOs for SDM845

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 104 ++++++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 152 ++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c            | 174 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h            |   5 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         |   1 +
 5 files changed, 432 insertions(+), 4 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

