Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D8C468C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C27120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C27120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGLG1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:27:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbeGLG1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:27:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E1307381B60DA;
        Thu, 12 Jul 2018 14:19:04 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 14:18:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 0/6] add non-strict mode support for arm-smmu-v3
Date:   Thu, 12 Jul 2018 14:18:26 +0800
Message-ID: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
Add a bootup option "iommu_strict_mode" to make the manager can choose which
mode to be used. The first 5 patches have not changed.
+	iommu_strict_mode=	[arm-smmu-v3]
+		0 - strict mode (default)
+		1 - non-strict mode

v1 -> v2:
Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
0, IOMMU_STRICT;
1, IOMMU_NON_STRICT;
Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
other IOMMUs which still use strict mode. In other words, this patch series
will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
driver to io-pgtable module. 

Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
initialized when the related domain and IOMMU driver support non-strict mode.

v1:
In common, a IOMMU unmap operation follow the below steps:
1. remove the mapping in page table of the specified iova range
2. execute tlbi command to invalid the mapping which is cached in TLB
3. wait for the above tlbi operation to be finished
4. free the IOVA resource
5. free the physical memory resource

This maybe a problem when unmap is very frequently, the combination of tlbi
and wait operation will consume a lot of time. A feasible method is put off
tlbi and iova-free operation, when accumulating to a certain number or
reaching a specified time, execute only one tlbi_all command to clean up
TLB, then free the backup IOVAs. Mark as non-strict mode.

But it must be noted that, although the mapping has already been removed in
the page table, it maybe still exist in TLB. And the freed physical memory
may also be reused for others. So a attacker can persistent access to memory
based on the just freed IOVA, to obtain sensible data or corrupt memory. So
the VFIO should always choose the strict mode.

Some may consider put off physical memory free also, that will still follow
strict mode. But for the map_sg cases, the memory allocation is not controlled
by IOMMU APIs, so it is not enforceable.

Fortunately, Intel and AMD have already applied the non-strict mode, and put
queue_iova() operation into the common file dma-iommu.c., and my work is based
on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
unmap, but Intel and AMD IOMMU drivers are not.

Below is the performance data of strict vs non-strict for NVMe device:
Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
Randomly Write IOPS: 143K(strict) vs 513K(non-strict)


Zhen Lei (6):
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu/dma: add support for non-strict mode
  iommu/amd: use default branch to deal with all non-supported
    capabilities
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode
  iommu/arm-smmu-v3: add bootup option "iommu_strict_mode"

 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++
 drivers/iommu/amd_iommu.c                       |  4 +--
 drivers/iommu/arm-smmu-v3.c                     | 42 +++++++++++++++++++++++--
 drivers/iommu/dma-iommu.c                       | 25 +++++++++++++++
 drivers/iommu/io-pgtable-arm.c                  | 23 ++++++++------
 include/linux/iommu.h                           |  7 +++++
 6 files changed, 98 insertions(+), 15 deletions(-)

-- 
1.8.3


