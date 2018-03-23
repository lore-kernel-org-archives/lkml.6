Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeCWTul (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:50:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCWTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:50:39 -0400
Date: Fri, 23 Mar 2018 12:50:12 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-f3c39d51043dcee5dd4d51dffcfe9ce01a263582@git.kernel.org>
Cc: thomas.lendacky@amd.com, konrad.wilk@oracle.com, mulix@mulix.org,
        dwmw2@infradead.org, hch@lst.de, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        joro@8bytes.org, mingo@kernel.org, torvalds@linux-foundation.org,
        jdmason@kudzu.us
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, joro@8bytes.org,
        mingo@kernel.org, torvalds@linux-foundation.org, jdmason@kudzu.us,
        thomas.lendacky@amd.com, konrad.wilk@oracle.com, mulix@mulix.org,
        dwmw2@infradead.org, hch@lst.de
In-Reply-To: <20180319103826.12853-6-hch@lst.de>
References: <20180319103826.12853-6-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] x86/dma/amd_gart: Look at dev->coherent_dma_mask
 instead of GFP_DMA
Git-Commit-ID: f3c39d51043dcee5dd4d51dffcfe9ce01a263582
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3c39d51043dcee5dd4d51dffcfe9ce01a263582
Gitweb:     https://git.kernel.org/tip/f3c39d51043dcee5dd4d51dffcfe9ce01a263582
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:57 +0100

x86/dma/amd_gart: Look at dev->coherent_dma_mask instead of GFP_DMA

We want to phase out looking at the magic GFP_DMA flag in the DMA mapping
routines, so switch the gart driver to use the dev->coherent_dma_mask
instead, which is used to select the GFP_DMA flag in the caller.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-6-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 52e3abcf3e70..79ac6caaaabb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -484,7 +484,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 	unsigned long align_mask;
 	struct page *page;
 
-	if (force_iommu && !(flag & GFP_DMA)) {
+	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
 		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
 		if (!page)
