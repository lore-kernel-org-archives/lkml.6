Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67193C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6DA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6DA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLCR2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:28:39 -0500
Received: from foss.arm.com ([217.140.101.70]:42910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeLCR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:28:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC44168F;
        Mon,  3 Dec 2018 09:28:32 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55A2A3F59C;
        Mon,  3 Dec 2018 09:28:31 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [RFC 4/4] dma-debug: Make leak-like behaviour apparent
Date:   Mon,  3 Dec 2018 17:28:09 +0000
Message-Id: <7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can dynamically allocate DMA debug entries to cope with
drivers maintaining excessively large numbers of live mappings, a driver
which *does* actually have a bug leaking mappings (and is not unloaded)
will no longer trigger the "DMA-API: debugging out of memory - disabling"
message until it gets to actual kernel OOM conditions, which means it
could go unnoticed for a while. To that end, let's inform the user each
time the pool has grown to a multiple of its initial size, which should
make it apparent that they either have a leak or might want to increase
the preallocation size.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Tagging this one as RFC since people might think it's silly.

 kernel/dma/debug.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 46cc075aec99..c4759dab0f8c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -696,6 +696,17 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
+void __dma_entry_alloc_check_leak(void)
+{
+	u32 tmp = nr_total_entries % nr_prealloc_entries;
+
+	/* Shout each time we tick over some multiple of the initial pool */
+	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
+		pr_info("dma_debug_entry pool grown to %u00%% - possible mapping leak?\n",
+			(nr_total_entries / nr_prealloc_entries));
+	}
+}
+
 /* struct dma_entry allocator
  *
  * The next two functions implement the allocator for
@@ -716,8 +727,10 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 		spin_unlock_irqrestore(&free_entries_lock, flags);
 
 		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
-		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
+		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES)) {
+			__dma_entry_alloc_check_leak();
 			continue;
+		}
 
 		global_disable = true;
 		pr_err("debugging out of memory - disabling\n");
-- 
2.19.1.dirty

