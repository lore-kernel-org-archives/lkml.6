Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47441C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED93824C1B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UOP5hVLX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FFX8/ndl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED93824C1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFWOTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:19:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeFWOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:19:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48BB360B13; Sat, 23 Jun 2018 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529763584;
        bh=b6pzEz+kanmN4eNCrSimpvpjvqILzVpsETPh/WW8qS4=;
        h=From:To:Cc:Subject:Date:From;
        b=UOP5hVLXEMKuZags2qDH04X2eHgN68SvNx2nFqWvOcz/NnthgkSDuGpX+yCRPLqtH
         PMwr8Kd8QGWlNP6LNWgyRcq0vS5ewy1CHpwR5xhLUsmRLv2ozlrMk0N9XuLi9UNrTY
         oGapJ+0Fw3dGmuFmq5X9CmJ3KypmAH+35SEDtdEQ=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9727607EB;
        Sat, 23 Jun 2018 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529763583;
        bh=b6pzEz+kanmN4eNCrSimpvpjvqILzVpsETPh/WW8qS4=;
        h=From:To:Cc:Subject:Date:From;
        b=FFX8/ndlr1ENVz9VMRHT1XSnHpEFXnbsa/vxmztedybDHZAeNLq+yw/UFPKFudiVA
         vZxpTmi+rJ1l4Kl0opgJiphCUiqGsHYUvHL0kb2NYndMF6C/vFB0cegJ2pe5trQD2H
         SPnQ2qdTpy3+3w5uti6Q5dCFtOirLsT4U3DjLXcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9727607EB
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
Subject: [PATCH v3 0/3] Add display clock controller driver for SDM845
Date:   Sat, 23 Jun 2018 19:49:24 +0530
Message-Id: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v3]
  * Move frequency table macro to common file,
    add the patch along to maintain dependency.

 [v2]
  * Removed unused header file includes.
  * Moved the frequency table macro to a common file [1].
  * Move to pll config to probe.
  * Update SoC name in device tree binding and
    also update the Kconfig.

Add support for the display clock controller found on SDM845
based devices. This would allow display drivers to probe and
control their clocks.

Taniya Das (3):
  clk: qcom: Move frequency table macro to common file
  dt-bindings: clock: Introduce QCOM Display clock bindings
  clk: qcom: Add display clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,dispcc.txt      |  19 +
 drivers/clk/qcom/Kconfig                           |  10 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-rcg.h                         |   2 +
 drivers/clk/qcom/dispcc-sdm845.c                   | 674 +++++++++++++++++++++
 drivers/clk/qcom/gcc-apq8084.c                     |   2 -
 drivers/clk/qcom/gcc-ipq4019.c                     |   2 -
 drivers/clk/qcom/gcc-ipq8074.c                     |   2 -
 drivers/clk/qcom/gcc-msm8916.c                     |   2 -
 drivers/clk/qcom/gcc-msm8974.c                     |   2 -
 drivers/clk/qcom/gcc-msm8994.c                     |   2 -
 drivers/clk/qcom/gcc-msm8996.c                     |   2 -
 drivers/clk/qcom/gcc-msm8998.c                     |   2 -
 drivers/clk/qcom/gcc-sdm845.c                      |   2 -
 drivers/clk/qcom/mmcc-apq8084.c                    |   2 -
 drivers/clk/qcom/mmcc-msm8974.c                    |   2 -
 drivers/clk/qcom/mmcc-msm8996.c                    |   2 -
 drivers/clk/qcom/videocc-sdm845.c                  |   2 -
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  45 ++
 19 files changed, 751 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

