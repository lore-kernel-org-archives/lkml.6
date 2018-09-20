Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02186ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1C02087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeITVy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:58 -0400
Received: from foss.arm.com ([217.140.101.70]:48620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731009AbeITVy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996331684;
        Thu, 20 Sep 2018 09:10:46 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF4A73F557;
        Thu, 20 Sep 2018 09:10:44 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 6/7] iommu/io-pgtable-arm-v7s: Add support for non-strict mode
Date:   Thu, 20 Sep 2018 17:10:26 +0100
Message-Id: <b6f3140cb5f4f4beb24b507c16d8d142e7389d06.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for LPAE, it's simply a case of skipping the leaf invalidation for a
regular unmap, and ensuring that the one in split_blk_unmap() is paired
with an explicit sync ASAP rather than relying on one which might only
eventually happen way down the line.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8: Do this properly instead of just hacking around not doing it
    (look, it turns out barely any more complicated!)

 drivers/iommu/io-pgtable-arm-v7s.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index b5948ba6b3b3..445c3bde0480 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -587,6 +587,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 	}
 
 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+	io_pgtable_tlb_sync(&data->iop);
 	return size;
 }
 
@@ -642,6 +643,13 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				io_pgtable_tlb_sync(iop);
 				ptep = iopte_deref(pte[i], lvl);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
+			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
+				/*
+				 * Order the PTE update against queueing the IOVA, to
+				 * guarantee that a flush callback from a different CPU
+				 * has observed it before the TLBIALL can be issued.
+				 */
+				smp_wmb();
 			} else {
 				io_pgtable_tlb_add_flush(iop, iova, blk_size,
 							 blk_size, true);
@@ -712,7 +720,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 			    IO_PGTABLE_QUIRK_NO_PERMS |
 			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
 			    IO_PGTABLE_QUIRK_ARM_MTK_4GB |
-			    IO_PGTABLE_QUIRK_NO_DMA))
+			    IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
-- 
2.19.0.dirty

