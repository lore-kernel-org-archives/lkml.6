Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AABC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0521721
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jWo6vCfp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OMHjq5bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B0521721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeHNNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:14:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbeHNNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:14:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 56FED60B62; Tue, 14 Aug 2018 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242471;
        bh=Ql3iaYXDrD02dBPNZdnP3nudl1Jl24mHM63EzSesTz8=;
        h=From:To:Cc:Subject:Date:From;
        b=jWo6vCfpLTed+abNAsC0s1gYiVOgRgJWVPuEZVnec8ACCtTv3J9lqFnSMrTss/xwU
         sTVc84gH52HPXlSTLuC+CevbSqcgvAPtsUFoH5cXgqtGKuFZri1BshikYXQVYGISE1
         wvmB6FDW7o53XED6i/4awi+exnPAqWaSFNiWGRvo=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF4560214;
        Tue, 14 Aug 2018 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242470;
        bh=Ql3iaYXDrD02dBPNZdnP3nudl1Jl24mHM63EzSesTz8=;
        h=From:To:Cc:Subject:Date:From;
        b=OMHjq5bkK6pSkb6ZTrsgegL0XtfnufpjR4KTDb24fyPCuJ9dkeAUACBzRYLfoNqEM
         A2Vz5UINlLnxIUptmDvgFNKdKcQFU2YLeWSJZZ0ng7hCmTHSIXNg+ajK0mYRHdtR+j
         5WBmyfzSJivl4DYxHGNx9gKLuDp5ORJCXC3Fo0ps=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF4560214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     mark.rutland@arm.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 0/3] Enable smmu support on sdm845
Date:   Tue, 14 Aug 2018 15:57:37 +0530
Message-Id: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables apps-smmu (arm,mmu-500) and gpu-smmu (qcom,smmu-v2)
on sdm845. gpu-smmu needs one power domain from gpu clock controller
whose driver was sent by Amit [1].

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://lore.kernel.org/patchwork/patch/973839/

Vivek Gautam (3):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500
  dts: arm64/sdm845: Add node for qcom,smmu-v2

 .../devicetree/bindings/iommu/arm,smmu.txt         |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 95 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

