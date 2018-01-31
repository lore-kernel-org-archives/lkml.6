Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeAaKzr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:55:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeAaKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:55:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77B026050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH 0/4] Misc patches to support clocks for SDM845
Date: Wed, 31 Jan 2018 16:24:31 +0530
Message-Id: <1517396075-29297-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the miscellaneous changes to support
clock nodes for SDM845. Below are the major changes for
which the existing code does not have support.

1. Clear hardware clock control bit of RCGs where HW clock
   control bit is set by default so that software can control
   those root clocks.
2. Introduces clk_rcg2_shared_ops to support clock controller
   drivers for SDM845. With new shared ops, RCGs with shared
   branches will be configured to a safe source in disable
   path and actual RCG update configuration will be done in
   enable path instead of doing config update in set_rate.
   In set_rate(), just cache the rate instead of doing actual
   configuration update. Also each RCG in clock controller
   driver will have their own safe configuration frequency
   table to switch to safe frequency.
3. Add support for controlling Fabia PLL for which the support
   is not available in existing alpha PLL code.
4. Add Global Clock controller (GCC) driver for SDM845. This
   should allow most non-multimedia device drivers to probe
   and control their clocks.

Amit Nischal (3):
  clk: qcom: Clear hardware clock control bit of RCG
  clk: qcom: Configure the RCGs to a safe source as needed
  clk: qcom: Add support for controlling Fabia PLL

Taniya Das (1):
  clk: qcom: Add Global Clock controller (GCC) driver for SDM845

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 drivers/clk/qcom/Kconfig                           |   11 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  322 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |   16 +
 drivers/clk/qcom/clk-rcg.h                         |    8 +-
 drivers/clk/qcom/clk-rcg2.c                        |  154 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 3619 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  242 ++
 9 files changed, 4365 insertions(+), 9 deletions(-)
 create mode 100644 drivers/clk/qcom/gcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
