Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BFF20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jVtsQTWp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bb97B/uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeLSWLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbeLSWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 768A760851; Wed, 19 Dec 2018 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257489;
        bh=2HsORYIzhRzBiA8U7lu4n6cxvzSqDNW0O7eObXYubCE=;
        h=From:To:Cc:Subject:Date:From;
        b=jVtsQTWpKXUt0RNyf4lFInwX8v2N10nrkW3TH7h/MzJrdJ67+vXg3R/+ZUEt/3B2h
         V1ZNq6oBwom6DF6I1Lf1OfCbuKLYvy6UEcMQY0NG9N2uUWK+XYE50b1ALE1zXVFgwa
         k9Xk5wYQoiOpftEnyGgzNPZPM4UBhYSmgA6lHdP4=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D941660208;
        Wed, 19 Dec 2018 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257488;
        bh=2HsORYIzhRzBiA8U7lu4n6cxvzSqDNW0O7eObXYubCE=;
        h=From:To:Cc:Subject:Date:From;
        b=bb97B/uSh62DnWIJyQjxQYrxOTKbmpeBsERBTfXnugEOC98+x8wRlV5PWyZkAOsSL
         uaF31MWcAwMN0MjtdVqm3KZb4h3eJYDpn/XyhsrDdmga94TJtJlO8o+VPyatRJUjQf
         m6IUdGaycewU9j+mdoiKrgh+0ZnBrUY6T4wMWXBI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D941660208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 0/7] qcom: support wakeup capable GPIOs
Date:   Wed, 19 Dec 2018 15:10:58 -0700
Message-Id: <20181219221105.3004-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set of patches adds support for wakeup capable GPIOs. After discussions in
[1], this patches implement the recommendations suggested by Stephen.

The gist of the approach is that GPIO is setup in hierarchy with a
wakeup-parent irqchip. The key difference to [1] is that the TLMM GPIO driver
could mask the TLMM GPIO if requested by the wakeup-parent irqchip, thereby
supporing both MPM and PDC based architectures for QCOM SoCs. The work uses
Stephen's code pretty much as-is from [1].

Stephen,
I moved the GPIO-PDC pin map to a separate file to allow the follow-on chips to
add their SoC specific maps in the data file and avoid clobbering the PDC
driver.

Thanks to Thierry's patches to add support for hierarchy in GPIO framework. It
has been included here for completeness.

Kindly review these patches and let me know your commennts.

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/11/21/168

Lina Iyer (5):
  irqdomain: add bus token DOMAIN_BUS_WAKEUP
  dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
  drivers: pinctrl: msm: setup GPIO irqchip hierarchy
  arm64: dts: msm: add PDC device bindings for sdm845
  arm64: dts: msm: setup PDC as wakeup parent for GPIOs for SDM845

Stephen Boyd (1):
  drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs

Thierry Reding (1):
  gpio: Add support for hierarchical IRQ domains

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  10 ++
 drivers/gpio/gpiolib.c                        |  15 +-
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/qcom-pdc-data.c               |  94 ++++++++++++
 drivers/irqchip/qcom-pdc.c                    | 111 ++++++++++++--
 drivers/irqchip/qcom-pdc.h                    |  24 ++++
 drivers/pinctrl/qcom/pinctrl-msm.c            | 136 ++++++++++++++++--
 include/linux/gpio/driver.h                   |   6 +
 include/linux/irqdomain.h                     |   1 +
 include/linux/soc/qcom/irq.h                  |  23 +++
 11 files changed, 401 insertions(+), 28 deletions(-)
 create mode 100644 drivers/irqchip/qcom-pdc-data.c
 create mode 100644 drivers/irqchip/qcom-pdc.h
 create mode 100644 include/linux/soc/qcom/irq.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

