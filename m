Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbeEWPRA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:17:00 -0400
Received: from m50-134.163.com ([123.125.50.134]:56155 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933674AbeEWPQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:16:05 -0400
From: Huaisheng Ye <yehs2007@163.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, hch@lst.de, vbabka@suse.cz,
        mgorman@techsingularity.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 4/9] fs/btrfs/extent_io: update usage of zone modifiers
Date: Wed, 23 May 2018 22:57:49 +0800
Message-Id: <1527087474-93986-5-git-send-email-yehs2007@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527087474-93986-1-git-send-email-yehs2007@163.com>
References: <1527087474-93986-1-git-send-email-yehs2007@163.com>
X-CM-TRANSID: DtGowAAXEWSIgQVbCQ9NAA--.108S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryDZw48JFyfurW5KFyDKFg_yoW8JFW7p3
        srur1agrs8ZrnIv34rGw48WF1I9w4DJrW7Gry5JF1UuFy5JryUWrsrtFyUXasrZayfAF15
        AwsrC395Zan8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b2cTdUUUUU=
X-Originating-IP: [103.244.59.4]
X-CM-SenderInfo: p1hk2jqqqxqiywtou0bp/1tbiPRdPT1SIWxQuqgAAs9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA32 | __GFP_HIGHMEM).

In function alloc_extent_state, it is obvious that __GFP_DMA is not
the expecting zone type.

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Use GFP_NORMAL() to clear bottom 3 bits of GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e99b329..f41fc61 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -220,7 +220,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	 * The given mask might be not appropriate for the slab allocator,
 	 * drop the unsupported bits
 	 */
-	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
+	mask = GFP_NORMAL(mask);
 	state = kmem_cache_alloc(extent_state_cache, mask);
 	if (!state)
 		return state;
-- 
1.8.3.1
