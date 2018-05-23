Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527095797; cv=none;
        d=google.com; s=arc-20160816;
        b=OFFxd+OW5rkaBh+ejVY5vlX9E5D7qOM/6MB2z9N7JerPyecXUvKC6ZR29sXBtYJ/CG
         qVkvhncp/TbJlBBvdS4wa/F0VZ8Qlt1ghuTt7A6RHN73ZmgMZkTRltcx6C9qvC+y2xMD
         FORAfRiEVhzIlqsn4SVv6DMwfi5FhXSK/lhvMpBEBA6nv6DfeP9P0tMOT2jCsPok/o3P
         ZDMZ3AJXOF4EWayoWR5IzDkcpvMyP0nga9EmRwyHVfqEgfq9nj67h+JAnVLNiAQr5OSO
         7zTz90gF0cRkm0TvytWt9+7eor2Ua/mz24T3O/YmJi/0ZtQs3eqK4nDBhz0cwpOGPCck
         MqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=WN3xM8hvrCzA4kc2v1+oKvwlya33IS5HgHqC0tiaCqg=;
        b=NfzQAlDrev9DlciIi/lF5U+k6yxJjXMa+GYqEMxoMhbEaGd2b+XLRF2Ka0GQCFY6ia
         1Of7IMEbgLQGf1uf6XBWIVs8UJkj6TolFomk5+hzUqtgeWmbTPBlNib4Ks7jryJc7qHm
         JW3d9XonS0csuJCAiHwghQN7RlKje5gVxOoiDBEqbUjZaRXLWQSJJGQUvtrbC1qKh+mG
         dexDl9zWkY8KWCnDn370w3/aIYR+Go8UvV8ZW9szpFQMdw11sNMX9IRqj/2dJoaVXjai
         01gcWzf4AiqB8cU5ovDDn/vYbrmpVRblwB0L1xkmBsO8/vX4t0gxVF6EsxUClYiI3adb
         E/eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uZ3xSdrn;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uZ3xSdrn;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq6fZN6w10LFzifH+DIo6Ko7FkvG+6YdASooynEr+0cXsciwcspLMNTVoEY6u7gxxcVVDnwCg==
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
Subject: [RFC PATCH v3 5/9] drivers/block/zram/zram_drv: update usage of zone modifiers
Date: Thu, 24 May 2018 01:16:29 +0800
Message-Id: <1527095789-5668-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601276002835516278?=
X-GMAIL-MSGID: =?utf-8?q?1601276002835516278?=
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
Cc: Christoph Hellwig <hch@infradead.org>
---
 drivers/block/zram/zram_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd..1bb5ca8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1004,14 +1004,12 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
-				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				__GFP_ZONE_MOVABLE);
 	if (!handle) {
 		zcomp_stream_put(zram->comp);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
-				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				GFP_NOIO | __GFP_ZONE_MOVABLE);
 		if (handle)
 			goto compress_again;
 		return -ENOMEM;
-- 
1.8.3.1
