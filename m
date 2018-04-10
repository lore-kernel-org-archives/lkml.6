Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeDJRFS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:05:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40605 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeDJRFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:05:17 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
Date: Tue, 10 Apr 2018 19:05:13 +0200
Message-Id: <20180410170513.22834-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code refactoring by commit 0176adb00406 ("swiotlb: refactor
coherent buffer allocation") made swiotlb_alloc_buffer() almost always
failing due to a thinko: namely, the function evaluates the
dma_coherent_ok() call incorrectly and dealing as if it's invalid.
This ends up with weird errors like iwlwifi probe failure or amdgpu
screen flickering.

This patch corrects the logic error.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088658
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088902
Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..de7cc540450f 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -719,7 +719,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		goto out_warn;
 
 	*dma_handle = __phys_to_dma(dev, phys_addr);
-	if (dma_coherent_ok(dev, *dma_handle, size))
+	if (!dma_coherent_ok(dev, *dma_handle, size))
 		goto out_unmap;
 
 	memset(phys_to_virt(phys_addr), 0, size);
-- 
2.16.3
