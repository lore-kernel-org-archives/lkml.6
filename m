Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeEGKum (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:50:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEGKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:50:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3530C601A0
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v7 0/3] Misc patches to support clocks for SDM845
Date: Mon,  7 May 2018 16:20:17 +0530
Message-Id: <1525690220-26525-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
1. Addressed review comments from Stephen and Rob for GCC driver.
   - Split dt-bindings to a separate patch from the driver patch.
   - Change the 'halt_check' type to BRANCH_HALT_SKIP for pipe
     and ufs_card tx/rx symbol clocks.
   - Remove 'halt_reg' for the clocks where 'halt_check' type is
     BRANCH_HALT_DELAY. For such clocks, there is no status bit
     to poll. For e.g. gcc_disp_gpll0_clk_src clock.
2. Implemented rcg2_shared_ops as suggested by Stephen in
   https://lkml.org/lkml/2018/5/2/91.
3. The GCC clock driver(patch 3) depends upon the below patches related to
   GDSC operation and RPMh clock driver, which are under review.
   https://lkml.org/lkml/2018/4/27/110
   https://lkml.org/lkml/2018/4/24/390

Changes in v6:
1. Addressed review comments for v3 and v4 version of GCC driver for SDM845.
   https://lkml.org/lkml/2018/4/16/1129.
2. Add support for new flag 'BRANCH_NO_DELAY' for branch clocks.
3. Addressed review comments for v5 version of rcg2_shared_ops patch.
   https://lkml.org/lkml/2018/4/19/86
4. The GCC clock driver(patch 3) depends upon the below patches related to
   GDSC operation and RPMh clock driver, which are under review.
   https://lkml.org/lkml/2018/4/27/110
   https://lkml.org/lkml/2018/4/24/390

Changes in v5:
1. Addressed review comments for v3 and v4 version of GCC driver for SDM845
   https://lkml.org/lkml/2018/4/16/1129
2. Removed bi_tcxo clock being modelled from the GCC driver, as RPMH clock
   driver would provide the same. https://lkml.org/lkml/2018/4/13/685
3. The GCC clock driver(patch 2) depends upon the below patches related to
   GDSC operation and RPMh clock driver, which are under review.
   https://lkml.org/lkml/2018/4/2/143
   https://lkml.org/lkml/2018/4/13/685

Changes in v4:
1. Addressed review comments for v2 version of GCC driver for SDM845
   https://lkml.org/lkml/2018/4/9/55.
2. The GCC clock driver(patch 3) depends upon the below patches
   related to GDSC operation and are under review.

   https://lkml.org/lkml/2018/4/2/142

Changes in v3:
1. Addressed review comments given for v2 series.
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
[v3] : https://lkml.org/lkml/2018/4/3/356
[v4] : https://lkml.org/lkml/2018/4/9/79
[v5] : https://lkml.org/lkml/2018/4/18/367
[v6] : https://lkml.org/lkml/2018/4/30/533

Amit Nischal (2):
  clk: qcom: Configure the RCGs to a safe source as needed
  clk: qcom: Add DT bindings for SDM845 gcc clock controller

Taniya Das (1):
  clk: qcom: Add Global Clock controller (GCC) driver for SDM845

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-rcg.h                         |   17 +-
 drivers/clk/qcom/clk-rcg2.c                        |  170 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 3465 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |  239 ++
 7 files changed, 3878 insertions(+), 24 deletions(-)
 create mode 100644 drivers/clk/qcom/gcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
