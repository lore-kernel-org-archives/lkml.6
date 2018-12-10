Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC21C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856322086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856322086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeLJOAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:00:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54632 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbeLJOAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:00:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76A6015AD;
        Mon, 10 Dec 2018 06:00:47 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 209B53F575;
        Mon, 10 Dec 2018 06:00:45 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v3 4/7] dma-debug: Make leak-like behaviour apparent
Date:   Mon, 10 Dec 2018 14:00:30 +0000
Message-Id: <22f6c17167b7270226d30dcd320eaff656a98bd4.1544447601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 Documentation/DMA-API.txt |  6 +++++-
 kernel/dma/debug.c        | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 0fcb7561af1e..7a7d8a415ce8 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -747,7 +747,11 @@ driver afterwards. This filter can be disabled or changed later using debugfs.
 When the code disables itself at runtime this is most likely because it ran
 out of dma_debug_entries and was unable to allocate more on-demand. 65536
 entries are preallocated at boot - if this is too low for you boot with
-'dma_debug_entries=<your_desired_number>' to overwrite the default.
+'dma_debug_entries=<your_desired_number>' to overwrite the default. The
+code will print to the kernel log each time it has dynamically allocated
+as many entries as were initially preallocated. This is to indicate that a
+larger preallocation size may be appropriate, or if it happens continually
+that a driver may be leaking mappings.
 
 ::
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index ef7c90b7a346..912c23f4c177 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -691,6 +691,18 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
+void __dma_entry_alloc_check_leak(void)
+{
+	u32 tmp = nr_total_entries % nr_prealloc_entries;
+
+	/* Shout each time we tick over some multiple of the initial pool */
+	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
+		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
+			nr_total_entries,
+			(nr_total_entries / nr_prealloc_entries));
+	}
+}
+
 /* struct dma_entry allocator
  *
  * The next two functions implement the allocator for
@@ -710,6 +722,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
+		__dma_entry_alloc_check_leak();
 	}
 
 	entry = __dma_entry_alloc();
-- 
2.19.1.dirty

