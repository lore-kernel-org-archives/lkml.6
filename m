Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB25C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22A0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CL5bpmLL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aQe+A0nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfANQgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:36:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfANQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:36:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5C4B60791; Mon, 14 Jan 2019 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483769;
        bh=1i9ESgFiwkVuo/ASgMSyDhY3ilmjlwzqunHonO5kfDA=;
        h=From:To:Cc:Subject:Date:From;
        b=CL5bpmLLqpGo6/DKo+IdohUI4oHw1m4KQlFlTQbFajM5cYA9QaTxNsuY758iEJNVh
         6G1OWHVAEsoBvjzhTs5AgRTBnSdL5Nn/bIFtGd2wDpcV+8hvGm0DUDb6Da+2OYcNfl
         Ji1JAgKrX4u+p/2Q1ADXkoQYvfCirhWuVrznh25I=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B45B60791;
        Mon, 14 Jan 2019 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483767;
        bh=1i9ESgFiwkVuo/ASgMSyDhY3ilmjlwzqunHonO5kfDA=;
        h=From:To:Cc:Subject:Date:From;
        b=aQe+A0nRZw5kc1NuqmqWt7XjLxqylSAOJzuTbxJqTwkNWko2tD9zFvpXQ0V9Xg378
         OGeVFmN49dVKtmtUn2zNgZvOlLZ2sHWbxQyG3C+KKNr/+XTZB292VqBb3lLwewMBHz
         tFyX/U9JDSyzuhI6rCAtUzgeG40PUrkCQ3dsebMM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B45B60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 0/6] MSM8998 basic USB support
Date:   Mon, 14 Jan 2019 09:35:54 -0700
Message-Id: <1547483754-5296-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides basic USB support for MSM8998.  Currently missing is
wiring up the Type-C detection logic so that the controller can correctly
switch between host and peripheral modes.  Work to implement that is
ongoing, and expected to appear soon in followup patches.  Also missing is
Display Port (DP) support which apparently is different from sdm845 and
needs additional investigation.

v2:
-Fixed typo in QUSB2 bindings changes
-Split out bindings changes
-Fixed dual lane support in QMP to reflect Doug's updates
-Dropped the clock fixes which were accepted

Jeffrey Hugo (6):
  clk: qcom: Add missing freq for usb30_master_clk on 8998
  clk: qcom: Skip halt checks on gcc_usb3_phy_pipe_clk for 8998
  phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
  phy: qcom-qmp: Add QMP V3 USB3 PHY support for msm8998
  usb: dwc3: qcom: Add support for MSM8998
  arm64: dts: qcom: msm8998: Add USB-related nodes

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   5 +
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.txt          |   1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  22 ++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  90 +++++++++++++
 drivers/clk/qcom/gcc-msm8998.c                     |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 142 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   4 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  41 ++++++
 drivers/usb/dwc3/dwc3-qcom.c                       |   1 +
 10 files changed, 309 insertions(+), 1 deletion(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

