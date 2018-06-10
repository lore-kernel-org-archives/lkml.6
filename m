Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EY4vANIGHVuxOAAAmS7hNA
	; Sun, 10 Jun 2018 11:09:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10DE060850; Sun, 10 Jun 2018 11:09:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8E6C6606FA;
	Sun, 10 Jun 2018 11:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E6C6606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeFJLIk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:08:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42728 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753873AbeFJLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:08:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4890E73957343;
        Sun, 10 Jun 2018 19:08:31 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Sun, 10 Jun 2018
 19:08:22 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>,
        "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
Date: Sun, 10 Jun 2018 19:07:18 +0800
Message-ID: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Zhen Lei (5):
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu/dma: add support for non-strict mode
  iommu/amd: use default branch to deal with all non-supported
    capabilities
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode

 drivers/iommu/amd_iommu.c      |  4 +---
 drivers/iommu/arm-smmu-v3.c    | 16 +++++++++++++---
 drivers/iommu/dma-iommu.c      | 25 +++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
 include/linux/iommu.h          |  7 +++++++
 5 files changed, 60 insertions(+), 15 deletions(-)

-- 
1.8.3
