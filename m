Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6664C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E3C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="csw6EXJq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SUgsPHZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfAUHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:14:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43298 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfAUHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A13CD6087B; Mon, 21 Jan 2019 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050028;
        bh=2DBDGwUlWjS1IStdYezKwR/C6qSSDYrOCCPTeQbHBPs=;
        h=From:To:Cc:Subject:Date:From;
        b=csw6EXJqFlaJcz/mDGAS8bmthO41fNyf81CtfIqM6mpjIYfCQafOUM1Ux6H18YF1R
         7KHF2r+ex1f6a/rLHZjvwiThQ81Rq4h6gVivUbBR6CXpGkTLeBrZh/KcD/Q47+bZHA
         ovPMT91+u1L8Xx5cfCU9OYKBpVqYrzxuxhufkuSk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 220F060237;
        Mon, 21 Jan 2019 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548050027;
        bh=2DBDGwUlWjS1IStdYezKwR/C6qSSDYrOCCPTeQbHBPs=;
        h=From:To:Cc:Subject:Date:From;
        b=SUgsPHZFTLtAvaxvBOLZIasN0cZOSNphdom2Imladlv5KpMymgB2QkWB/LdMuzsx0
         y1prPUyk4LHw+cOVlWa8C7jO4gsARYgK3Y4nrqHp/M1GQGRvEByjVEQJQ6pIbJ9Wp2
         wDOTDQZYXNml2oZTIx+7Z9XRj1+CyZFY92ZBAa/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 220F060237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        jcrouse@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
Date:   Mon, 21 Jan 2019 11:23:32 +0530
Message-Id: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoCs have an additional level of cache called as
System cache, aka. Last level cache (LLC). This cache sits right
before the DDR, and is tightly coupled with the memory controller.
The clients using this cache request their slices from this
system cache, make it active, and can then start using it.
For these clients with smmu, to start using the system cache for
buffers and, related page tables [1], memory attributes need to be
set accordingly. This series add the required support.

This change is a realisation of following changes from downstream msm-4.9:
iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]

Changes since v2:
 - Split the patches into io-pgtable-arm driver and arm-smmu driver.
 - Converted smmu domain attributes to a bitmap, so multiple attributes
   can be managed easily.
 - With addition of non-coherent page table mapping support [4], this
   patch series now aligns with the understanding of upgrading the
   non-coherent devices to use some level of outer cache.
 - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
 - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
   stage-1 mapping.
 - Added change to disable the attribute from arm_smmu_domain_set_attr()
   when needed.
 - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
   level.

Goes on top of the non-coherent page tables support patch series [4]

[1] https://patchwork.kernel.org/patch/10302791/
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
[4] https://lore.kernel.org/patchwork/cover/1032938/

Vivek Gautam (3):
  iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
  iommu/io-pgtable-arm: Add support to use system cache
  iommu/arm-smmu: Add support to use system cache

 drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
 drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
 drivers/iommu/io-pgtable.h     |  4 ++++
 include/linux/iommu.h          |  2 ++
 4 files changed, 43 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

