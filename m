Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380AAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6034272E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GrFelARE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nWk/GI+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6034272E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965746AbeF1Lrz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:47:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbeF1Lrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:47:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8504E60711; Thu, 28 Jun 2018 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186472;
        bh=F4TjvXuaEdSKhLR2W+e7yHexkdLA0rHAubeyenIG9o4=;
        h=From:To:Cc:Subject:Date:From;
        b=GrFelAREs/gSaXUxRw1PyfHQQerk9GmXL3Fa5Vsdoppk+61BgBs9OLR1QQdN2C8uX
         pCXDmBXX/CREj1OHnGQBdYNCcEVPLc3nyjUzqgSX0+wW80J8f/fMDoBF1A9O7yccnL
         yF8cTBQJ28L71qW6Bkz982HNX8ZkqSl4M3ihAEfY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13819606FC;
        Thu, 28 Jun 2018 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186471;
        bh=F4TjvXuaEdSKhLR2W+e7yHexkdLA0rHAubeyenIG9o4=;
        h=From:To:Cc:Subject:Date:From;
        b=nWk/GI+8T90Jt0khrFVV3ASNmwMGQvD620ByXp0seTO46WoQy61gzA4fitS5r208I
         ESzRU7uz3QISeM7RDfoWkkb29IeoN358Hw8WetU7e5bpN/OwpPWmMzMu1HHLXaZBso
         HrIOby6qSdQCJ6xznbgROVAUHfUPRjJfkNjn9/nM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13819606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] clk: qcom: Add support for RCG to register for DFS
Date:   Thu, 28 Jun 2018 17:17:29 +0530
Message-Id: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v2]
  * Move the dfs register function 'qcom_cc_register_rcg_dfs'
    to clk-rcg2.c instead of common.c
  * At boot read the DFS enable register and override the clk_ops
    to be used for dfs or non-dfs RCGs.
  * Remove flag 'dfs_enabled'.
  * Remove functions 'clk_rcg2_dfs_determine_rate_lazy'
  * Remove 'struct dfs_table *dfs_entry'
  * Remove '_freq_tbl_determine_dfs_rate'
  * Combine the function 'clk_index_pre_div_and_mode' and 'calculate_m_and_n'
    to a single function and named it 'clk_rcg2_calculate_m_and_n'.
  * Remove taking M/N/PERF offsets as function arguments.
  * Add clocks in gcc-sdm845.c the DFS clock array to register.

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

Taniya Das (2):
  clk: qcom: Add support for RCG to register for DFS
  clk: qcom: gcc: Register QUPv3 RCGs for DFS on SDM845

 drivers/clk/qcom/clk-rcg.h    |   5 +
 drivers/clk/qcom/clk-rcg2.c   | 214 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c     |  14 +--
 drivers/clk/qcom/common.h     |  16 +---
 drivers/clk/qcom/gcc-sdm845.c |  27 +++++-
 5 files changed, 250 insertions(+), 26 deletions(-)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

