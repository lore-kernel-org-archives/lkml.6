Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeCGMrm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:47:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35274 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeCGMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:30 -0500
X-Google-Smtp-Source: AG47ELuD3rhIOSvvwjCDNqwYEQXmh1fG8J2n8YKm3eKfu6F8cPUxPoZtAzDNv7b/r0hClSe7iwCF8w==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] lib/scatterlist: Do not leak pages when high-order allocation fails
Date: Wed,  7 Mar 2018 12:47:09 +0000
Message-Id: <20180307124712.14963-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

If a higher-order allocation fails, the existing abort and cleanup path
would consider all segments allocated so far as 0-order page allocations
and would therefore leak memory.

Fix this by cleaning up using sgl_free_n_order which allows the correct
page order to be passed in.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/scatterlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 9884be50a2c0..e13a759c5c49 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -493,7 +493,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 {
 	unsigned int chunk_len = PAGE_SIZE << order;
 	struct scatterlist *sgl, *sg;
-	unsigned int nent;
+	unsigned int nent, i;
 
 	nent = round_up(length, chunk_len) >> (PAGE_SHIFT + order);
 
@@ -517,11 +517,12 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 
 	sg_init_table(sgl, nent);
 	sg = sgl;
+	i = 0;
 	while (length) {
 		struct page *page = alloc_pages(gfp, order);
 
 		if (!page) {
-			sgl_free(sgl);
+			sgl_free_n_order(sgl, i, order);
 			return NULL;
 		}
 
@@ -529,6 +530,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 		sg_set_page(sg, page, chunk_len, 0);
 		length -= chunk_len;
 		sg = sg_next(sg);
+		i++;
 	}
 	WARN_ONCE(length, "length = %ld\n", length);
 	return sgl;
-- 
2.14.1
