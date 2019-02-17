Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49716C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9A21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hAp4nz/J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U5Lc7tZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfBQEbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:31:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBQEbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:31:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 022966077A; Sun, 17 Feb 2019 04:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377899;
        bh=UbJ8UrSsqlj5y7Ik+kzW9PXxE+4Gz9rhjv3AR3igmGA=;
        h=From:To:Cc:Subject:Date:From;
        b=hAp4nz/JGjQdKSxCVGCTe2S0BZCdXEvlZpcOOu85ZydjHS7OSzkbxedotTxHJBx/o
         ZU6I8uxBNoNW0LqLrHyQj0rVD9yAxkXUWmdPEO2I1hERnjTebLZAdc405St/xw8K6S
         HQN7qeLCfMEddGnFWpOVv9UvumnZPZB0SEcQoVsg=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F14E060709;
        Sun, 17 Feb 2019 04:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377898;
        bh=UbJ8UrSsqlj5y7Ik+kzW9PXxE+4Gz9rhjv3AR3igmGA=;
        h=From:To:Cc:Subject:Date:From;
        b=U5Lc7tZP/pDj/tq+GJffTjIxGFLY/I1JklQP0JadJXV5xXBlUspV/clFVgUSPC9Ga
         FOLfxSV4oDPmWtTBHD5nSisfgeHrC84XwL7Ay+lnMFFMpZfnJqGoJtaumbA6NZT4aH
         w32o8hbkZXiUc/rNYDj/DxFFTYCAhhYqkBDn7mkk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F14E060709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 0/4] MSM8998 Multimedia Clock Controller
Date:   Sat, 16 Feb 2019 21:31:25 -0700
Message-Id: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multimedia clock controller (mmcc) is the main clock controller for
the multimedia subsystem and is required to enable things like display and
camera.

Based upon the "Rewrite clk parent handling" series [1] to simplify handling
of the external clocks that feed into the MMCC.

Assumes the "orphan probe defer" change [2] so that exposing XO via the RPM is
safe for the UART in case of late probe per review comments.

Assumes the common clk_hw registration is in place from "Make common clk_hw
registrations" [3]

[1] https://lore.kernel.org/lkml/20190129061021.94775-1-sboyd@kernel.org/T/#u
[2] https://lkml.org/lkml/2019/2/11/1895
[3] https://lkml.org/lkml/2019/2/10/132

v2:
-Rebased on the "Rewrite clk parent handling" series and updated to the clk init
mechanisms introduced there.
-Marked XO clk as CLK_IGNORE_UNUSED to avoid the concern about the XO going away
"incorrectly" during late init
-Corrected the name of the XO clock to "xo"
-Dropped the fake XO clock in GCC to prevent a namespace conflict
-Fully enumerated the external clocks (DSI PLLs, etc) in the DT binding
-Cleaned up the weird newlines in the added DT node
-Added DT header file to msm8998 DT for future clients

Jeffrey Hugo (4):
  clk: qcom: smd: Add XO clock for MSM8998
  dt-bindings: clock: Add support for the MSM8998 mmcc
  clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
  arm64: dts: qcom: msm8998: Add mmcc node

 .../devicetree/bindings/clock/qcom,mmcc.txt        |    7 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   15 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-smd-rpm.c                     |    4 +
 drivers/clk/qcom/mmcc-msm8998.c                    | 2937 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8998.h      |  210 ++
 7 files changed, 3183 insertions(+)
 create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

