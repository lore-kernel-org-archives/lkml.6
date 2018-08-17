Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE76C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F8921536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ey4tjzN4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eia5xKY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8921536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeHQTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:43:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeHQTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:43:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 452A8622D0; Fri, 17 Aug 2018 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534523954;
        bh=Lyz7yS+NvLBXEGzSkwK23/qXI9rr872IVp66sx2BNQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ey4tjzN4Y+hnThIUZlcwjVsK3psqhM0h9i4ItwsC4vWJmfylz3BzVIbMzJalMPBNi
         g43pSVrIUqrzITWONOGDSJxa+xCZQNMg6lTpoG5YIOsiyrOkxwrsCkK8bnve4VnSo9
         zIWF1Qm5RgP+8F7hui8IdB4eVsymk89eHP3hZf18=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5521661EBD;
        Fri, 17 Aug 2018 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534523953;
        bh=Lyz7yS+NvLBXEGzSkwK23/qXI9rr872IVp66sx2BNQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Eia5xKY6A+vCtwe6T1q+BNjNflx5Wzj/q4SafISohCokhuJFNAy9otP7hEFCs8OYS
         MBHq/hTkaJADmWLrDuhFTFc+VL68wdy8kHjTjk2eLxEChTcrie56E6ktsvO+QssufT
         dvpwbfMCGE1KlfBa6xAxJ362HA0vCTpoyKORO8Ec=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5521661EBD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 0/5] Wakeup GPIO support for SDM845 SoC
Date:   Fri, 17 Aug 2018 10:38:44 -0600
Message-Id: <20180817163849.30750-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Lina Iyer (5):
  drivers: pinctrl: qcom: add wakeup capability to GPIO
  dt-bindings: pinctrl: add wakeup capable GPIOs for SDM845
  drivers: pinctrl: msm: enable PDC interrupt only during suspend
  drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
  arm64: dts: qcom: add wake up interrupts for GPIOs for SDM845

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |  58 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  57 ++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c            | 155 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h            |   3 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         |   6 +
 5 files changed, 275 insertions(+), 4 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

