Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26D820989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26D820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeLET5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbeLET5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE906EBD;
        Wed,  5 Dec 2018 11:57:15 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67D313F614;
        Wed,  5 Dec 2018 11:57:14 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v2 4/8] dma-debug: Dynamically expand the dma_debug_entry pool
Date:   Wed,  5 Dec 2018 19:56:53 +0000
Message-Id: <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain drivers such as large multi-queue network adapters can use pools
of mapped DMA buffers larger than the default dma_debug_entry pool of
65536 entries, with the result that merely probing such a device can
cause DMA debug to disable itself during boot unless explicitly given an
appropriate "dma_debug_entries=..." option.

Developers trying to debug some other driver on such a system may not be
immediately aware of this, and at worst it can hide bugs if they fail to
realise that dma-debug has already disabled itself unexpectedly by the
time the code of interest gets to run. Even once they do realise, it can
be a bit of a pain to emprirically determine a suitable number of
preallocated entries to configure without massively over-allocating.

There's really no need for such a static limit, though, since we can
quite easily expand the pool at runtime in those rare cases that the
preallocated entries are insufficient, which is arguably the least
surprising and most useful behaviour.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Use GFP_ATOMIC, make retry loop redundant, update documentation

 Documentation/DMA-API.txt | 11 +++++------
 kernel/dma/debug.c        | 15 +++++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 6bdb095393b0..0fcb7561af1e 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -717,8 +717,8 @@ dma-api/num_errors		The number in this file shows how many
 dma-api/min_free_entries	This read-only file can be read to get the
 				minimum number of free dma_debug_entries the
 				allocator has ever seen. If this value goes
-				down to zero the code will disable itself
-				because it is not longer reliable.
+				down to zero the code will attempt to increase
+				nr_total_entries to compensate.
 
 dma-api/num_free_entries	The current number of free dma_debug_entries
 				in the allocator.
@@ -745,10 +745,9 @@ driver filter at boot time. The debug code will only print errors for that
 driver afterwards. This filter can be disabled or changed later using debugfs.
 
 When the code disables itself at runtime this is most likely because it ran
-out of dma_debug_entries. These entries are preallocated at boot. The number
-of preallocated entries is defined per architecture. If it is too low for you
-boot with 'dma_debug_entries=<your_desired_number>' to overwrite the
-architectural default.
+out of dma_debug_entries and was unable to allocate more on-demand. 65536
+entries are preallocated at boot - if this is too low for you boot with
+'dma_debug_entries=<your_desired_number>' to overwrite the default.
 
 ::
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1b0858d7edfd..b1fe8b78acc4 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -47,6 +47,8 @@
 #ifndef PREALLOC_DMA_DEBUG_ENTRIES
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 #endif
+/* If the pool runs out, add this many new entries at once */
+#define DMA_DEBUG_DYNAMIC_ENTRIES 256
 
 enum {
 	dma_debug_single,
@@ -702,12 +704,13 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (list_empty(&free_entries)) {
-		global_disable = true;
-		spin_unlock_irqrestore(&free_entries_lock, flags);
-		pr_err("debugging out of memory - disabling\n");
-		return NULL;
+	if (num_free_entries == 0) {
+		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {
+			global_disable = true;
+			spin_unlock_irqrestore(&free_entries_lock, flags);
+			pr_err("debugging out of memory - disabling\n");
+			return NULL;
+		}
 	}
 
 	entry = __dma_entry_alloc();
-- 
2.19.1.dirty

