Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeDIGPL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:15:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeDIGPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:15:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70E5360386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v4 0/3] Misc patches to support clocks for SDM845
Date: Mon,  9 Apr 2018 11:44:50 +0530
Message-Id: <1523254493-5313-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
1. Adressed review comments for v2 version of GCC driver for SDM845
   https://lkml.org/lkml/2018/4/9/55.
2. The GCC clock driver(patch 3) depends upon the below patches
   related to GDSC operation and are under review.

   https://lkml.org/lkml/2018/4/2/142

Changes in v3:
1. Adressed review comments given for v2 series.
2. The GCC clock driver(patch 3) depends upon the below patches related
   to GDSC operation and are under review.

   https://lkml.org/lkml/2018/4/2/142

Changes in v2:
Fixup for recalc_rate ops for clk_rcg2_shared_ops:
There could be few scenarios where shared clocks are configured
at rate other than CXO by boot. In those cases there would be a
mismatch between the rate calculated by the recalc shared ops
and the actual HW register configuration. Fix the same by adding
an additional check to read current src from CFG register and
make a decision based on that.

Changes in v1:
https://lkml.org/lkml/2018/1/31/209

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

[v1] : https://lkml.org/lkml/2018/1/31/209
[v2] : https://lkml.org/lkml/2018/3/8/495
[v3] : https://www.spinics.net/lists/linux-arm-msm/msg35009.html

Amit Nischal (2):
  clk: qcom: Clear hardware clock control bit of RCG
  clk: qcom: Configure the RCGs to a safe source as needed

Taniya Das (1):
  clk: qcom: Add Global Clock controller (GCC) driver for SDM845

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-rcg.h                         |    7 +-
 drivers/clk/qcom/clk-rcg2.c                        |  176 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 3546 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  242 ++
 7 files changed, 3979 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/qcom/gcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
