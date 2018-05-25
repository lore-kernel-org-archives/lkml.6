Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965977AbeEYKqF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:46:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeEYKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:46:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69BC260618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: Add support for RCG to register for DFS
Date: Fri, 25 May 2018 16:15:49 +0530
Message-Id: <1527245150-2726-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v1]
   * Update SPDX for files.
   * Add new clk_ops for DFS mode which would be used if dfs is enabled,
     else fall back to the clk_rcg2_shared_ops.
   * Use kcalloc in place kzalloc.
   * Fixed the return type for 'clk_parent_index_pre_div_and_mode' which
     is now renamed to 'clk_index_pre_div_and_mode'.
   * Removed return of -EPERM from 'clk_rcg2_set_rate' and new dfs
     clk_ops is introduced.
   * Pass frequency table entry structure to function calculate_m_and_n.
   * Remove desc from qcom_cc_register_rcg_dfs and instead pass array of
     clk_rcg2.
   * Add a dfs_enable flag to identify if dfs mode is enabled.

In the cases where a RCG requires a Dynamic Frequency switch support
requires to register which would at runtime read the clock perf level
registers to identify the frequencies supported and update the frequency
table accordingly.

Taniya Das (1):
  clk: qcom: Add support for RCG to register for DFS

 drivers/clk/qcom/clk-rcg.h  |   6 +
 drivers/clk/qcom/clk-rcg2.c | 272 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  22 ++++
 drivers/clk/qcom/common.h   |  18 +--
 4 files changed, 306 insertions(+), 12 deletions(-)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
