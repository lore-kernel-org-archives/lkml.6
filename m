Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE8E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfAaNwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:52:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbfAaNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:52:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D2E2C22D26A4371F7288;
        Thu, 31 Jan 2019 21:52:50 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 21:52:42 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as non-strict
Date:   Thu, 31 Jan 2019 21:52:11 +0800
Message-ID: <20190131135211.6732-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, many peripherals are faster than before. For example, the top
speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
when iommu page-table mapping enabled, it's hard to reach the top speed
in strict mode, because of frequently map and unmap operations. In order
to keep abreast of the times, I think it's better to set non-strict as
default.

Below it's our iperf performance data of 25Gb netcard:
strict mode: 18-20 Gb/s
non-strict mode: 23.5 Gb/s

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 drivers/iommu/iommu.c                           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf..667221f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1779,13 +1779,13 @@

 	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
 			Format: { "0" | "1" }
-			0 - Lazy mode.
+			0 - Lazy mode (default).
 			  Request that DMA unmap operations use deferred
 			  invalidation of hardware TLBs, for increased
 			  throughput at the cost of reduced device isolation.
 			  Will fall back to strict mode if not supported by
 			  the relevant IOMMU driver.
-			1 - Strict mode (default).
+			1 - Strict mode.
 			  DMA unmap operations invalidate IOMMU hardware TLBs
 			  synchronously.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db3..10e0b49 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,7 +43,7 @@
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
-static bool iommu_dma_strict __read_mostly = true;
+static bool iommu_dma_strict __read_mostly;

 struct iommu_callback_data {
 	const struct iommu_ops *ops;
--
1.8.3


