Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7338FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A67208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j5CMiF0L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j5CMiF0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A67208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeG3K4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:56:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeG3K4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:56:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E353E618AD; Mon, 30 Jul 2018 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532942551;
        bh=Lban2du/BWpwXhDP0mMC/+QJyZwvOlrTpeybhRFT/+A=;
        h=From:To:Cc:Subject:Date:From;
        b=j5CMiF0LWStDvVk6S+FTx/PKQzgtfUQkxjmTHR+KfQJ/HVWtyo1UUwQlPLpfJ4oMs
         q6WAzRmFih60xlI2QDmZ9ZTqn8AGKAKVdYLqmDu2IPaU6fmNdb8lvkL+SllzWsw/9w
         Vr5NAOiSJ6y0te5TBUpRITpRiQ7FnVpZhxudbi8Y=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DEEA561755;
        Mon, 30 Jul 2018 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532942551;
        bh=Lban2du/BWpwXhDP0mMC/+QJyZwvOlrTpeybhRFT/+A=;
        h=From:To:Cc:Subject:Date:From;
        b=j5CMiF0LWStDvVk6S+FTx/PKQzgtfUQkxjmTHR+KfQJ/HVWtyo1UUwQlPLpfJ4oMs
         q6WAzRmFih60xlI2QDmZ9ZTqn8AGKAKVdYLqmDu2IPaU6fmNdb8lvkL+SllzWsw/9w
         Vr5NAOiSJ6y0te5TBUpRITpRiQ7FnVpZhxudbi8Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEEA561755
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v2] Add QCOM camera clock controller driver
Date:   Mon, 30 Jul 2018 14:52:19 +0530
Message-Id: <1532942540-2814-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
Addressed below review comments - https://lkml.org/lkml/2018/7/23/377
1. Add comment to use clk_rcg2_shared_ops and CLK_SET_RATE_PARENT flag.
2. Replace commas with semicolon for PLL configuration in probe function.

Changes in v1:
This patch series adds a driver and device tree documentation binding
for the camera clock controller on some Qualcomm Technologies, Inc, SoCs
such as SDM845. This would allow camera drivers to probe and control
their clocks.

[v1] : https://lkml.org/lkml/2018/7/23/377

Amit Nischal (1):
  clk: qcom: Add camera clock controller driver for SDM845

 drivers/clk/qcom/Kconfig        |    8 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/camcc-sdm845.c | 1744 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1753 insertions(+)
 create mode 100644 drivers/clk/qcom/camcc-sdm845.c

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

