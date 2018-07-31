Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EBFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24A12083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k6WC+uxs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lxTA96f+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A12083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeHAA1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:27:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeHAA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:27:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54829602D7; Tue, 31 Jul 2018 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077083;
        bh=Hx/Gz15SoitSsQF5LAKXlle+0pJwMaQ8+xWLsuMiBLA=;
        h=From:To:Cc:Subject:Date:From;
        b=k6WC+uxsWwkWlw0WelRvUAe/ZdpfWITr2in4MIPl6Md+i2aBmgkRGw6nN3EL2YwQj
         ojd7eDJqVIeQqEeCsF7xy8EjbXXwUaD79Pag+7peuSsZBmnJoD+9hVGiVqnSWZSk7j
         32CoRDVaWwEJTFkNLUQVpqjcrAbqwq8tgnwyOa2Q=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FD52602D7;
        Tue, 31 Jul 2018 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533077082;
        bh=Hx/Gz15SoitSsQF5LAKXlle+0pJwMaQ8+xWLsuMiBLA=;
        h=From:To:Cc:Subject:Date:From;
        b=lxTA96f+SgKn5H+ah6fOpeNdmAmx/hIbrIaOWwC5Bjcl6+If5EiHoM9opplVNp5mG
         QOWWuTetT2WCp56BnHFwvOJYoYYi1l0ya89VhfhGEtdz3bpQRRMJTJlOTak64gjmlf
         mQLPbOMKT7g3IDZJdcXjXdwzwfiBcNAvZeIVa5QM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FD52602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, sboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 0/4] Wakeup GPIO support for SDM845 SoC
Date:   Tue, 31 Jul 2018 16:44:17 -0600
Message-Id: <20180731224421.29062-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
      |  		 <summary IRQ>       ^
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

Lina Iyer (4):
  drivers: pinctrl: qcom: add wakeup capability to GPIO
  drivers: pinctrl: qcom: add wakeup gpio map for sdm845
  arm64: dts: msm: add PDC device bindings for sdm845
  arm64: dts: qcom: add wake up interrupts for GPIOs

 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  78 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.c    | 163 ++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h    |  14 +++
 drivers/pinctrl/qcom/pinctrl-sdm845.c |  76 ++++++++++++
 4 files changed, 331 insertions(+)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

