Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7179020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B/aRUkTw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VIe6dCdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7179020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJKRQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:16:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:16:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6779060C60; Thu, 11 Oct 2018 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539251381;
        bh=wh1v/qNkgNQ8E5r5czIh8aRI1REa4Z/OcF5l5HLr27k=;
        h=From:To:Cc:Subject:Date:From;
        b=B/aRUkTwqZByrbsSyGqjC2qMRQ527dwHdXaZWEbswD0o3zbfioBl0LnDXhaVFRFPE
         5SA1aSvjRzC+xP8FQdHQWVeMJrto0g1xtfDA2NtHqq06RY+rS16rDIo5pZV3yzx0kK
         NRa7aTQEE17+yYJ4xxuV01ymgkogsHVbZigWkZJI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A22D460209;
        Thu, 11 Oct 2018 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539251380;
        bh=wh1v/qNkgNQ8E5r5czIh8aRI1REa4Z/OcF5l5HLr27k=;
        h=From:To:Cc:Subject:Date:From;
        b=VIe6dCdpqHPie49WjBk6lVTPPaIlcwoxe2HFM9nRo7BJjZOYdRUbq0C1f3ZBoC1EQ
         g/p9RO88mhspoxrA72xX2KITCHx3K5GVO/yQLT9Xk23htaZnxA8J4y6QKi/MzfHgqd
         qykk2qGPHgpEXUwq4CLcSMu5GyEqkgVetFVd+QR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A22D460209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, dianders@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v4 0/2] Enable smmu support on sdm845
Date:   Thu, 11 Oct 2018 15:19:28 +0530
Message-Id: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables apps-smmu, the "arm,mmu-500" instance
on sdm845.
Series tested on SDM845 MTP device with related smmu patch series [1],
and necessary config change, besides one hack to keep LDO14 in LPM mode
to boot things up (see the commit in the test branch).
The tested branch is available at [2].

Changes since v3:
 - Refined the dt binding documentation more to align with
   Rob's comments for qcom,smmu-v2 binding documentation [3]
   on SoC specific compatibles and state things similar
   to qcom,smmu-v2 [4].

Changes since v2:
 - Dropped patch for gpu-smmu [5] as the same has been pushed by
   Jordan [6] after incorporating the dt binding update.
 - Updated binding doc to include valid value for '<soc>'
   in "qcom,<soc>-smmu-500" compatible string.

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://patchwork.kernel.org/cover/10581891/
[2] https://github.com/vivekgautam1/linux/commits/v4.19-rc7/sdm845-smmu-dt
[3] https://patchwork.kernel.org/patch/10576937/
[4] https://patchwork.kernel.org/patch/10581911/
[5] https://patchwork.kernel.org/patch/10565295/
[6] https://patchwork.kernel.org/patch/10577297/

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500

 .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

