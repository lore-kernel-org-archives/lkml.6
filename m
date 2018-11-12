Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965BB216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QMbPy5FA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QMbPy5FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965BB216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbeKLQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:44:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbeKLQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:44:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4ABF60A33; Mon, 12 Nov 2018 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005560;
        bh=cqiYZu6Wij26fC87EmM+XUN9HPtPfXUiPkihWSapYaY=;
        h=From:To:Cc:Subject:Date:From;
        b=QMbPy5FAcej6TKSo/aB/5J3K6AWQoR8/kNbjLv972kENtWBtfMB3Yc8UgrYj4yKAY
         W3edTPSot8mJVau28pzQD1X9iujmYj2cy1FeUjvj8fIvy+Y5TD8X1WU4DyQfVaCfP5
         ajaftgsS/8X7aBAOsUkasCQCIjhZnUGxNlxEXjRs=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EE9B60795;
        Mon, 12 Nov 2018 06:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542005560;
        bh=cqiYZu6Wij26fC87EmM+XUN9HPtPfXUiPkihWSapYaY=;
        h=From:To:Cc:Subject:Date:From;
        b=QMbPy5FAcej6TKSo/aB/5J3K6AWQoR8/kNbjLv972kENtWBtfMB3Yc8UgrYj4yKAY
         W3edTPSot8mJVau28pzQD1X9iujmYj2cy1FeUjvj8fIvy+Y5TD8X1WU4DyQfVaCfP5
         ajaftgsS/8X7aBAOsUkasCQCIjhZnUGxNlxEXjRs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EE9B60795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V5 0/2] Re-initialize DLL when MCLK is gated dynamically
Date:   Mon, 12 Nov 2018 12:22:15 +0530
Message-Id: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On few SDHCI-MSM controllers, the host controller's clock tuning
circuit may go out of sync if controller clocks are gated which
eventually, result in data CRC and command CRC/timeout errors.
To fix this issue, the DLL needs to be re-initialized and restored with
its old settings once clocks are ungated. SDHC cotroller on SDM845 SOC
has this limitation.

Changes since V4:
	- Exactly same as V3, posted multiple mails for V4.
	So to avoid confusion updating it as V5.

Changes since V3:
	- Introduced SoC specific dt compatible string for sdhci-msm
	controller
	- Moved the condition which checks whether tuning is needed or
	not, to a common function.

Changes since V2:
	- Removed an unused variable.
	- Renamed the newly introduced flags to be more meaningful.
	- Added new dt compatible string for SDM845 SOC.

Changes since V1:
	- Replaced dt flag with a dt compatible string to
	indicate SHDCI-MSM controller varients which need this fix.
	- Moved the DLL settings restoration logic from request 
	context to platform driver runtime pm context.

Tested on: sdm845
Veerabhadrarao Badiganti (2):
  dt-bindings: mmc: sdhci-msm: Add SoC-specific compatible strings
  mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically

 .../devicetree/bindings/mmc/sdhci-msm.txt          | 21 ++++--
 drivers/mmc/host/sdhci-msm.c                       | 78 +++++++++++++++++++---
 2 files changed, 84 insertions(+), 15 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

