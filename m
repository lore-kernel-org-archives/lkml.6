Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0392175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yw5aJb5G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="olkDozlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0392175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeKLQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:30:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeKLQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:30:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1DBC660866; Mon, 12 Nov 2018 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004737;
        bh=Wr0zzxg+xLJxQlm7qy0mjg5Dhg7NvDS7hc/9/HIf/28=;
        h=From:To:Cc:Subject:Date:From;
        b=Yw5aJb5G53106UZZxY4e/3BVdf4QuXd96H35Hf651BSfuZnLiU+y+ihjAySsihIja
         xNqC0mKCDTGsIr8gPKqs6E2/MCFvdF3pnTOSDYzjzWhlGvgbqzjHhNBbyOWuLHTbOj
         T/XdwYg8B0JILqAgbhlkBkh2ooilDRakjnPn2Mvk=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C70B60600;
        Mon, 12 Nov 2018 06:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004736;
        bh=Wr0zzxg+xLJxQlm7qy0mjg5Dhg7NvDS7hc/9/HIf/28=;
        h=From:To:Cc:Subject:Date:From;
        b=olkDozlUedWc73JJHqQI5RvEM+l8RGXndIScdeYTgsSt3FNXLs3Ny9XbuEd/ajbpq
         HS84Y4PZeZZGBJmvzADHgX0Mv+gOEpHDKjTmktqyaJNwBRrZLE8TDn3D1JBwjI3HZD
         u2LsNOFRrMZoXJ9W9sCbSXRbW/zUXhWug6+T8h5g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C70B60600
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
Subject: [PATCH V2 0/2] Re-initialize DLL when MCLK is gated dynamically
Date:   Mon, 12 Nov 2018 12:08:22 +0530
Message-Id: <1542004704-17066-1-git-send-email-vbadigan@codeaurora.org>
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

