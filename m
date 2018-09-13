Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F1FA3742
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41372170B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41372170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeIMVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:53:02 -0400
Received: from foss.arm.com ([217.140.101.70]:51132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIMVxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:53:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840251596;
        Thu, 13 Sep 2018 09:42:44 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B96DF3F703;
        Thu, 13 Sep 2018 09:42:42 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v6 4/7] iommu/io-pgtable: Add helper for toggling non-strict mode
Date:   Thu, 13 Sep 2018 17:42:21 +0100
Message-Id: <63a2a074219ff045c4616b9f5680d0dd9e922b59.1536856828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this might become a repeated idiom in drivers, let's add a tidy
encapsulation from the outset.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable.c | 9 +++++++++
 drivers/iommu/io-pgtable.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 127558d83667..af9abe52cf06 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -77,3 +77,12 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_tlb_flush_all(iop);
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
+
+void io_pgtable_set_non_strict(struct io_pgtable_ops *ops, bool val) {
+	struct io_pgtable *iop = io_pgtable_ops_to_pgtable(ops);
+
+	if (val)
+		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+	else
+		iop->cfg.quirks &= ~IO_PGTABLE_QUIRK_NON_STRICT;
+}
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae559329..0602a132655c 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -153,6 +153,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
  */
 void free_io_pgtable_ops(struct io_pgtable_ops *ops);
 
+void io_pgtable_set_non_strict(struct io_pgtable_ops *ops, bool val);
 
 /*
  * Internal structures for page table allocator implementations.
-- 
2.19.0.dirty

