Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeDIRLA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:11:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeDIRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:10:59 -0400
Date: Mon, 9 Apr 2018 10:10:30 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37@git.kernel.org>
Cc: peterz@infradead.org, konrad.wilk@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        linux@dominikbrodowski.net
Reply-To: mingo@kernel.org, linux@dominikbrodowski.net, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hch@lst.de,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
        peterz@infradead.org
In-Reply-To: <20180409091517.6619-2-hch@lst.de>
References: <20180409091517.6619-2-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] swiotlb: Use dma_direct_supported() for
 swiotlb_ops
Git-Commit-ID: 66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37
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

Commit-ID:  66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37
Gitweb:     https://git.kernel.org/tip/66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 9 Apr 2018 11:15:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:20:09 +0200

swiotlb: Use dma_direct_supported() for swiotlb_ops

swiotlb_alloc() calls dma_direct_alloc(), which can satisfy lower than 32-bit
DMA mask requests using GFP_DMA if the architecture supports it.  Various
x86 drivers rely on that, so we need to support that.  At the same time
the whole kernel expects a 32-bit DMA mask to just work, so the other magic
in swiotlb_dma_supported() isn't actually needed either.

Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org
Fixes: 6e4bf5867783 ("x86/dma: Use generic swiotlb_ops")
Link: http://lkml.kernel.org/r/20180409091517.6619-2-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index c43ec2271469..c67b06261160 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1130,6 +1130,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
-	.dma_supported		= swiotlb_dma_supported,
+	.dma_supported		= dma_direct_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
