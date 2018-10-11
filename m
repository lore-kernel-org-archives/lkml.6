Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E792087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kpWBj9qs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kpWBj9qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E792087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeJKRJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:09:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9C1260BE3; Thu, 11 Oct 2018 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539250980;
        bh=uJys4jIyKGN+h/OdA8rpxaf06/PHsTyOIM/P79Zukoc=;
        h=From:To:Cc:Subject:Date:From;
        b=kpWBj9qsVX0KbhhEk7givUo6uz+mN4vbauDNCx7SUNK77B4oSKP/jFqAkbYu5tdpE
         08K5lwU1MVi5PpnpZ5eln/acNA0aSua+NbbQw3TJSMhAMK6dtrJFasGUVIsVqI4XhC
         shk5M5MricORt/6IE/GU4uHdan2+YpjoILvus/kM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4219C601D4;
        Thu, 11 Oct 2018 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539250980;
        bh=uJys4jIyKGN+h/OdA8rpxaf06/PHsTyOIM/P79Zukoc=;
        h=From:To:Cc:Subject:Date:From;
        b=kpWBj9qsVX0KbhhEk7givUo6uz+mN4vbauDNCx7SUNK77B4oSKP/jFqAkbYu5tdpE
         08K5lwU1MVi5PpnpZ5eln/acNA0aSua+NbbQw3TJSMhAMK6dtrJFasGUVIsVqI4XhC
         shk5M5MricORt/6IE/GU4uHdan2+YpjoILvus/kM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4219C601D4
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
Date:   Thu, 11 Oct 2018 15:12:43 +0530
Message-Id: <20181011094245.7943-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables apps-smmu, the "arm,mmu-500" instance
on sdm845.

Changes since v3:
 - Refined the dt binding documentation more to align with
   Rob's comments for qcom,smmu-v2 binding documentation [1]
   on SoC specific compatibles and state things similar
   to qcom,smmu-v2 [2].

Changes since v2:
 - Dropped patch for gpu-smmu [3] as the same has been pushed by
   Jordan [4] after incorporating the dt binding update.
 - Updated binding doc to include valid value for '<soc>'
   in "qcom,<soc>-smmu-500" compatible string.

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://patchwork.kernel.org/patch/10576937/
[1] https://patchwork.kernel.org/patch/10581911/
[3] https://patchwork.kernel.org/patch/10565295/
[4] https://patchwork.kernel.org/patch/10577297/

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500

 .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

