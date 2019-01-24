Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88FD217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="npCaLPrq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CtliHd/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfAXUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:22:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAXUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:22:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A96F560C67; Thu, 24 Jan 2019 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361333;
        bh=Z9RHpS+nfnxj9wj8Ndnj+M3utpCJDGFvarlIjAETQLw=;
        h=From:To:Cc:Subject:Date:From;
        b=npCaLPrqEDcaUEy067DirhyXh9D4nmVOaHFJJzaRWv4grE5NqtEHP+XkyLViByZ7t
         x0qKhZlQqje2RUbXw9jjRJM/KRCpQmPV1SEBpYlRXsmmdKPbU1edAvlcACirFgR8QP
         C3xeiUFol3Ov+RMcfqdBkNXNat5EEQDWIFIdkic4=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D451609F3;
        Thu, 24 Jan 2019 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361331;
        bh=Z9RHpS+nfnxj9wj8Ndnj+M3utpCJDGFvarlIjAETQLw=;
        h=From:To:Cc:Subject:Date:From;
        b=CtliHd/qz4lKNSGV7fuG9+dbX/IiioNd9oudfkUCq6s5s+ga6CN3eovpjpjBg8N5F
         0KQf/X/SrmcLwQoQzqcICif/lx8fZ2SV8TZhlDqHQxVOcUIfDZXS6K5zEIEnRszJeP
         KzZ/IVUmnFbwnO4dy4KHwux40mzETU8FjgLlvOZM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D451609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 0/8] qcom: support wakeup capable GPIOs
Date:   Thu, 24 Jan 2019 13:21:57 -0700
Message-Id: <20190124202205.7940-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a bug fix submission of the v1 posted here [1]. The discussion on how
to represent the wakeup-parent interrupt controller is on-going [2] here. The
reiew comments in [1], from Doug and Stephen are addressed in this patch.

The series attempts to add GPIO chip in hierarchy with PDC interrupt controller
that can detect and wakeup the GPIOs routed to it, when the system is
suspend/deep sleep mode.

Changes in v2:
	- Fix bug related to unmasking PDC interrupt
	- Address review comments from Doug and Stepehn
	- Rebase on top of 5.0-rc2
	- Fix signed-off-by tags
	- Enable QCOM_PDC in defconfig
	
Do note that this patch uses the register address convention updated by Bjorn
per [3].

Thanks,
Lina

[1]. https://lkml.org/lkml/2018/12/19/807
[2]. https://lkml.org/lkml/2018/12/19/813
[3]. https://lkml.org/lkml/2019/1/17/924

Lina Iyer (7):
  irqdomain: add bus token DOMAIN_BUS_WAKEUP
  drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
  dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
  drivers: pinctrl: msm: setup GPIO irqchip hierarchy
  arm64: dts: qcom: add PDC interrupt controller for SDM845
  arm64: dts: qcom: setup PDC as wakeup parent for GPIOs for SDM845
  arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845

Thierry Reding (1):
  gpio: Add support for hierarchical IRQ domains

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  10 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpio/gpiolib.c                        |  15 +-
 drivers/irqchip/qcom-pdc.c                    | 204 +++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c            | 133 ++++++++++--
 include/linux/gpio/driver.h                   |   6 +
 include/linux/irqdomain.h                     |   1 +
 include/linux/soc/qcom/irq.h                  |  23 ++
 9 files changed, 371 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/soc/qcom/irq.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

