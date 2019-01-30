Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0D12087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O8pU4N58";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NKKKtfhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfA3Qf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:35:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfA3Qf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:35:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B718609D1; Wed, 30 Jan 2019 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866123;
        bh=Sn/o9Zo2pS31LUlDBCLQBnSSLsTRSCQKUntDW02tJ9k=;
        h=From:To:Cc:Subject:Date:From;
        b=O8pU4N58gZmWS+AaDdAR0Ij/zxkFFnrYc6HnGztv5otgb1+EtTCiINkoOLm7k3ao1
         lzx239/25J+uZprN1jbMs9VeyrdpPhFz/es3AH14zJNrCcZx5ozbk4dx5Yz0bT/EJP
         OZoaaW6nb4N8r+tRIG01DThgj1O96KBVAnt0T6cM=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EC0060CEB;
        Wed, 30 Jan 2019 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866122;
        bh=Sn/o9Zo2pS31LUlDBCLQBnSSLsTRSCQKUntDW02tJ9k=;
        h=From:To:Cc:Subject:Date:From;
        b=NKKKtfhId+LoKumJ/cQTaLRavtXmEnTyG2EYzp76OgPf0loMD9DsDqUSqxSr0fxfF
         3RQ4L3E72ePoBd1yk4eYaoFJvZso8VJFjRZTa54jNUQHxO7gOClsYojhLv+zSZ8+xE
         c/LGwwwtfF3HqrSm7qlNdDWpRW0LDQUrGqgKWlcs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EC0060CEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 0/4] MSM8998 Multimedia Clock Controller
Date:   Wed, 30 Jan 2019 09:35:02 -0700
Message-Id: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multimedia clock controller (mmcc) is the main clock controller for
the multimedia subsystem and is required to enable things like display and
camera.

The mmcc consumes a few external clocks inorder to configure the root clock
generators that it controls.  We can use DT to grab XO (from rpmcc) and
gpll0 (from gcc), but we'll have to rely on the global namespace to consume
the plls from elsewhere in the mmss.

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

