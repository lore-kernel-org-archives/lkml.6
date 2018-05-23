Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933689AbeEWPPx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:15:53 -0400
Received: from m50-134.163.com ([123.125.50.134]:54780 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933595AbeEWPPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:15:47 -0400
From: Huaisheng Ye <yehs2007@163.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, hch@lst.de, vbabka@suse.cz,
        mgorman@techsingularity.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 3/9] drivers/xen/swiotlb-xen: update usage of zone modifiers
Date: Wed, 23 May 2018 22:57:48 +0800
Message-Id: <1527087474-93986-4-git-send-email-yehs2007@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527087474-93986-1-git-send-email-yehs2007@163.com>
References: <1527087474-93986-1-git-send-email-yehs2007@163.com>
X-CM-TRANSID: DtGowAAXEWSIgQVbCQ9NAA--.108S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfCFWrtFW5AFyUWF4kZwb_yoW8Gw18pF
        srCr1S9Fsxurn3A3yFyw1fWF1a9w1xuryUGFyav34UZr15JrWUWrs8KFyj93sxXw4fuF15
        JrsrZw4rZFs8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bsTmhUUUUU=
X-Originating-IP: [103.244.59.4]
X-CM-SenderInfo: p1hk2jqqqxqiywtou0bp/xtbBFRZPT1Xlblwj4wAAsB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM).

In function xen_swiotlb_alloc_coherent, it is obvious that __GFP_DMA32
is not the expecting zone type.

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Use GFP_NORMAL() to clear bottom 3 bits of GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e1c6089..3999959 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -301,7 +301,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	* machine physical layout.  We can't allocate highmem
 	* because we can't return a pointer to it.
 	*/
-	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
+	flags = GFP_NORMAL(flags);
 
 	/* On ARM this function returns an ioremap'ped virtual address for
 	 * which virt_to_phys doesn't return the corresponding physical
-- 
1.8.3.1
