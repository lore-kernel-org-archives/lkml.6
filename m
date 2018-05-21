Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916093; cv=none;
        d=google.com; s=arc-20160816;
        b=QyWaldYJ9Prwg1mAM+xdliZkSnFseEF4upcU/ByRFVVENOIjdzxr5H/HNtXDItLZi4
         HhUEghVlH/M3w/1A38bqrWla5lVrWzwz8w907tE7xoDzW/l160eB/kDtDfsMzyt8/bnC
         l/Bmp9VO773v4hf3f0bwQvwBK1Nz3u+FowbTpAH9lx3q9IU9UzAYhj+qG0CrinCXQmaJ
         h01ySs1AOybspaMwT/dV1G20mbLeuz2KouH2Qm2jk5HUfk4SloZhfFRY8BfwqBWJyiWi
         jAYpwktxhMYMIJCXPAABl/UFnO4Sl6Rijc5797aueQsqjhaw1RliYqJEXS6lcJ3ZpOzB
         e0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Rg6BKxT24DTcq0T6rzs0UC5ZSOHr8p7gHnyYQom/FPU=;
        b=BrDHvqfuFtd7HVg1wk16C+ndKSCVgrVuPyAMweyFn8u1JAVEpWisBFI1/c1mBwed2W
         oxH+2+hH4UP8nn25Zp9S3rOFj5fAaO9iURUl/rLNS3DYQITFU6IQtBOApH/LDPsB8niw
         sUvtuPSTHllvaDX/efyYERuv/egH5gpDya5RxQICJQml8pqR+wbJDTKbICuTRhWLATTZ
         Xnx6i2qdpVMNpPqdWGgqeTLkZ5voI2LNge2BIYOEaZ8DPZD5ESGAG//n4fbDhz67qlB6
         2O4D7DupLfNUkCY/L+lQSixbBdKjQcY+Wqu6VAnerPa2m5+uCNilIgpft24E3fGWy3sY
         lxWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rbwSmOsP;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rbwSmOsP;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpd+VUeHXEfmUKTzkaAcy6nRUqAEQMkRUjG5Ow1Tl9xgeMQTm41T6DzPgvXTExphSx2MkLfuA==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	alexander.levin@verizon.com,
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
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC PATCH v2 10/12] mm/zsmalloc: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:31 +0800
Message-Id: <1526916033-4877-11-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087569730678169?=
X-GMAIL-MSGID: =?utf-8?q?1601087569730678169?=
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
GFP_ZONE_TABLE, replace (__GFP_HIGHMEM | __GFP_MOVABLE) with
__GFP_ZONE_MOVABLE.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 mm/zsmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c301350..06b2902 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -343,7 +343,7 @@ static void destroy_cache(struct zs_pool *pool)
 static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 {
 	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
-			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			gfp & ~__GFP_ZONE_MOVABLE);
 }
 
 static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
@@ -354,7 +354,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
 	return kmem_cache_alloc(pool->zspage_cachep,
-			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			flags & ~__GFP_ZONE_MOVABLE);
 }
 
 static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
-- 
1.8.3.1
