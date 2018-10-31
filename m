Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB291C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C2220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U3xdc9tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C2220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeKAIo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:44:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7174 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeKAIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:44:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bda3e530000>; Wed, 31 Oct 2018 16:44:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Oct 2018 16:44:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Oct 2018 16:44:34 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 31 Oct
 2018 23:44:34 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 31 Oct 2018 23:44:34 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bda3e570004>; Wed, 31 Oct 2018 16:44:34 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <nicolinc@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Date:   Wed, 31 Oct 2018 16:43:45 -0700
Message-ID: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541029459; bh=ZaaMTIa6v2NWOtPxYwF2QbPw3hjJCTiME0tR4tMuFP0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=U3xdc9tRgj7PM1LnKznuSg4tX2J/Xo8JbOM6klmipGMVwc0VnVG+xxPfQuaSHvp/W
         wkoES9bPoBA0VkEBXAoRL/KbeD7P56G97h2+Ynbyb9xa0/QCVgQa0ZbyXaezgjohB3
         86NvufF6OnyfMfMSAnCFUxEW1dRDSaU/7X1R7PYB82jpcXOH4S28xnw8fWL+Yha/rs
         C3Thm3y3CImZdjB8X6rg/y2WABSUUdGYuwZzTd+7IplEPX9qCxARcH4cPqiVj3v1JM
         5lBCliNZrLM/uW+w9VaeYtLHDuh+vd0HbvR2j7Wm9gogtvmA9+haLHURHdf08s2rbh
         jvFSHhQxVJE3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA's Xavier (Tegra194) SOC has three ARM SMMU(MMU-500) instances.
Two of the SMMU instances are used to interleave IOVA accesses across them.
The IOVA accesses from HW devices are interleaved across these two SMMU instances
and they need to be programmed identical.

The existing ARM SMMU driver can't be used in its current form for programming the
two SMMU instances identically. But, most of the code can be shared between ARM SMMU
driver and Tegra194 SMMU driver.
Page fault handling and TLB sync operations need to know about specific instance
of SMMU for correct fault handling and optimal TLB sync wait. Rest of the code doesn't
need to know about number of SMMU instances. Based on this fact, The patch series here
rearranges the arm-smmu.c code to allow sharing most of the ARM SMMU programming/iommu_ops
code between ARM SMMU driver and Tegra194 SMMU driver and transparently
handles programming of two SMMU instances.

The third SMMU instance would use the existing ARM SMMU driver.

Changes in v2:
* Added CONFIG_ARM_SMMU_TEGRA to protect Tegra194 SMMU driver compilation
* Enabled CONFIG_ARM_SMMU_TEGRA in defconfig
* Added SMMU nodes in Tegra194 device tree

Krishna Reddy (5):
  iommu/arm-smmu: rearrange arm-smmu.c code
  iommu/arm-smmu: Prepare fault, probe, sync functions for sharing code
  iommu/tegra194_smmu: Add Tegra194 SMMU driver
  arm64: defconfig: Enable ARM_SMMU_TEGRA
  arm64: tegra: Add SMMU nodes to Tegra194 device tree

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  148 ++
 arch/arm64/configs/defconfig             |    1 +
 drivers/iommu/Kconfig                    |   10 +
 drivers/iommu/Makefile                   |    1 +
 drivers/iommu/arm-smmu-common.c          | 1971 +++++++++++++++++++++++++++
 drivers/iommu/arm-smmu-common.h          |  256 ++++
 drivers/iommu/arm-smmu.c                 | 2167 +-----------------------------
 drivers/iommu/tegra194-smmu.c            |  201 +++
 8 files changed, 2595 insertions(+), 2160 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-common.c
 create mode 100644 drivers/iommu/arm-smmu-common.h
 create mode 100644 drivers/iommu/tegra194-smmu.c

-- 
2.1.4

