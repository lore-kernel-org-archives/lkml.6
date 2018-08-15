Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCACC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E142156B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E142156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeHOEW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:22:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43463 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbeHOEWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:22:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DAEC63A23B2EA;
        Wed, 15 Aug 2018 09:32:30 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 09:32:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
Date:   Wed, 15 Aug 2018 09:28:25 +0800
Message-ID: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 -> v5:
1. change the type of global variable and struct member named "non_strict" from
   "int" to "bool".
2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
   in v4.
3. change boot option "arm_iommu" to "iommu.non_strict".
4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
   non-leaf unmaps still need to be synchronous.

Thanks for Robin's review comments.

v3 -> v4:
1. Add a new member "non_strict" in struct iommu_domain to mark whether
   that domain use non-strict mode or not. This can help us to remove the
   capability which was added in prior version.
2. Add a new quirk IO_PGTABLE_QUIRK_NON_STRICT, so that we can get "strict
   mode" in io-pgtable-arm.c according to data->iop.cfg.quirks.
3. rename the new boot option to "arm_iommu".

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

Zhen Lei (5):
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu/dma: add support for non-strict mode
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode
  iommu/arm-smmu-v3: add bootup option "iommu.non_strict"

 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++
 drivers/iommu/arm-smmu-v3.c                     | 35 ++++++++++++++++++++++++-
 drivers/iommu/dma-iommu.c                       | 29 +++++++++++++++++++-
 drivers/iommu/io-pgtable-arm.c                  | 20 +++++++++-----
 drivers/iommu/io-pgtable.h                      |  3 +++
 drivers/iommu/iommu.c                           |  1 +
 include/linux/iommu.h                           |  1 +
 7 files changed, 94 insertions(+), 8 deletions(-)

-- 
1.8.3


