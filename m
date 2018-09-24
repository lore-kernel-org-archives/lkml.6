Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30442148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30442148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeIXS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeIXS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6A2F1018;
        Mon, 24 Sep 2018 12:27:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 018/235] iommu/io-pgtable-arm-v7s: Abort allocation when table address overflows the PTE
Date:   Mon, 24 Sep 2018 13:50:04 +0200
Message-Id: <20180924113106.410621564@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 29859aeb8a6ea17ba207933a81b6b77b4d4df81a ]

When run on a 64-bit system in selftest, the v7s driver may obtain page
table with physical addresses larger than 32-bit. Level-2 tables are 1KB
and are are allocated with slab, which doesn't accept the GFP_DMA32
flag. Currently map() truncates the address written in the PTE, causing
iova_to_phys() or unmap() to access invalid memory. Kasan reports it as
a use-after-free. To avoid any nasty surprise, test if the physical
address fits in a PTE before returning a new table. 32-bit systems,
which are the main users of this page table format, shouldn't see any
difference.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -192,6 +192,7 @@ static void *__arm_v7s_alloc_table(int l
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	struct device *dev = cfg->iommu_dev;
+	phys_addr_t phys;
 	dma_addr_t dma;
 	size_t size = ARM_V7S_TABLE_SIZE(lvl);
 	void *table = NULL;
@@ -200,6 +201,10 @@ static void *__arm_v7s_alloc_table(int l
 		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+	phys = virt_to_phys(table);
+	if (phys != (arm_v7s_iopte)phys)
+		/* Doesn't fit in PTE */
+		goto out_free;
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -209,7 +214,7 @@ static void *__arm_v7s_alloc_table(int l
 		 * address directly, so if the DMA layer suggests otherwise by
 		 * translating or truncating them, that bodes very badly...
 		 */
-		if (dma != virt_to_phys(table))
+		if (dma != phys)
 			goto out_unmap;
 	}
 	kmemleak_ignore(table);


