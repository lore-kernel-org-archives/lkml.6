Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9F4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF64A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MtSepfmC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K9nd0ef/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF64A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeGSSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:38:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeGSSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:38:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3D6B60B7B; Thu, 19 Jul 2018 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022861;
        bh=UIDvS46kY51Mz1rBbsCmh6eZYMacCrHLATPd/yshq8k=;
        h=From:To:Cc:Subject:Date:From;
        b=MtSepfmCsuAoMVYB6loBaAOzz77nXwLsSVIRRGN0gLvTUjm5F39ZYuIXXX9rBIMJQ
         hI+O2GYhCOZpmVsWDc0+/of3FKaDWEu9h4c9wial7r9zwB7c7jsUVQ9I5Ck5Ag9BOH
         0pItx32ULb746T51jldpyHCwhUHRvgaM8djquASs=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA6A6606DB;
        Thu, 19 Jul 2018 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022860;
        bh=UIDvS46kY51Mz1rBbsCmh6eZYMacCrHLATPd/yshq8k=;
        h=From:To:Cc:Subject:Date:From;
        b=K9nd0ef/AnMDexZQ08ARL8I85vHXKnvSCaVgE+C05aETsrXsSm4QBd5TLQUITvMp+
         6fifBm0NXEj7yRPc6/xG4tY3ti0en36i9i/D3PphkFq1MLVKpiLoYdxyKPU9vgcBlb
         zB0pa4116si1iorzbXYcGhOECLkxtSEJtfLAQbMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA6A6606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, andy.gross@linaro.org
Cc:     mark.rutland@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, david.brown@linaro.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/3] Enable smmu support on sdm845
Date:   Thu, 19 Jul 2018 23:23:53 +0530
Message-Id: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables apps-smmu (arm,mmu-500) and gpu-smmu (qcom,smmu-v2)
on sdm845. gpu-smmu needs one power domain from gpu clock controller
whose driver was sent by Amit [1].

This series also contains a patch to split the check for num_context_irqs
and num_context_banks in two. We now error out only if num_context_irqs
is greater than num_context_banks.
There are cases such as on sdm845, in which few of the context banks are
reserved by the bootloader (secure software), and thus kernel view
lesser number than the total available context banks.
So, we shouldn't error out simply when the num_context_irqs is not equal
to num_context_banks.

[1] https://lore.kernel.org/patchwork/cover/962208/

Vivek Gautam (3):
  dts: arm64/sdm845: Add node for arm,mmu-500
  dts: arm64/sdm845: Add node for qcom,smmu-v2
  iommu/arm-smmu: Error out only if not enough context interrupts

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 96 +++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                | 19 ++++---
 3 files changed, 117 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

