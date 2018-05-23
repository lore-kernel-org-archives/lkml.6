Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527095244; cv=none;
        d=google.com; s=arc-20160816;
        b=Pya/jCKuItRD39kv/i/y3UP7yC5k1mCKqF/yGjzAAizcI0LGW1Hfq3CePoEIqr+wnC
         Mfs4VUZq+UaNLB6zqIwsPRSLu7TywdjVWi2SW/xhDwlJjDTFXv5XFZueG7AkEVQHfJWC
         aiZtrU1brifnnoSthItOGuYClDVWClw06ly2S5eqRWyw0ihDLOqNzsn9W3F60wqOD7Qw
         yVhpsukado93lytckNAVcbqe1uoiWbP4xEZV8eRPN/VRsl1P5dTfgf5IiTO+cuKXyJQo
         hlWVtJMjuenD0KC+1KD1us10O+gXNe0jSf9lxxbewh1Yhig+aHSKpbCbqZ/hYW/7s+/V
         EcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zHX6vj0yUosU1Yfo3onMPiW90dQ8apjipbJ481pfeSI=;
        b=INCeBNlutnImnCv8Ai/ZW/bXasEtx5Pa3K+Q9YOS4fc/x6+lHt/qxnYpFx8ZX44/SR
         TNj+R5Y8ySjV6fPqN6ZbczBB6PZ3hBKCy5iHbJYyOrrrhlswdKfu+sO5ngCn7x3k/WRV
         6lVtqDZ3LgOb0F0XkZYJkSzC1La2isqyEfuvESujpnKnBdGg2TasJXi4ulYgOcKMhu8t
         Pl7XyS95Hl1ghAbx5+SAK6SGCA/2nBo3YYSuJQGac1ntW5HZYs40Lm8UBe8e5UCAm/Pe
         GYOG+92xsgP+S/pnnxFLWkMmV8o2NZPA3gJ1r32n8rNCQ1mQtZ1J9HPCWp+6xgr5X4xB
         gGNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OQPjybPZ;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OQPjybPZ;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrgR9gjPZKz2l7J7uS/+SBPb63YzOQOlQ2mNOdpKXmOjHt1pTcsRaObh2VYyNRTh8/1Bqey/g==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	hch@lst.de,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 7/9] mm/zsmalloc: update usage of zone modifiers
Date: Thu, 24 May 2018 01:07:06 +0800
Message-Id: <1527095226-5079-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601275423106595685?=
X-GMAIL-MSGID: =?utf-8?q?1601275423106595685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MOVABLE to replace (__GFP_HIGHMEM | __GFP_MOVABLE).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.

__GFP_ZONE_MOVABLE contains encoded ZONE_MOVABLE and __GFP_MOVABLE flag.

With GFP_ZONE_TABLE, __GFP_HIGHMEM ORing __GFP_MOVABLE means gfp_zone
should return ZONE_MOVABLE. In order to keep that compatible with
GFP_ZONE_TABLE, Use GFP_NORMAL_UNMOVABLE() to clear bottom 4 bits of
GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 mm/zsmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 61cb05d..e250c69 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -345,7 +345,7 @@ static void destroy_cache(struct zs_pool *pool)
 static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 {
 	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
-			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			GFP_NORMAL_UNMOVABLE(gfp));
 }
 
 static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
@@ -356,7 +356,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
 	return kmem_cache_alloc(pool->zspage_cachep,
-			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			GFP_NORMAL_UNMOVABLE(flags));
 }
 
 static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
-- 
1.8.3.1
