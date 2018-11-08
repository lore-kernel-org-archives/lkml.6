Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1D1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2551220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2551220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKIBEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:04:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:53048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeKIBEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:04:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 07:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="106409715"
Received: from kohsamui.iil.intel.com ([10.236.193.12])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2018 07:28:11 -0800
From:   Alexey Skidanov <alexey.skidanov@intel.com>
To:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, labbott@redhat.com,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH v2] lib/genaloc: Fix allocation of aligned buffer from non-aligned chunk
Date:   Thu,  8 Nov 2018 17:29:13 +0200
Message-Id: <1541690953-4623-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gen_pool_alloc_algo() uses different allocation functions implementing
different allocation algorithms. With gen_pool_first_fit_align() allocation
function, the returned address should be aligned on the requested boundary.

If chunk start address isn't aligned on the requested boundary, the
returned address isn't aligned too. The only way to get properly aligned
address is to initialize the pool with chunks aligned on the requested
boundary. If want to have an ability to allocate buffers aligned on
different boundaries (for example, 4K, 1MB, ...), the chunk start address
should be aligned on the max possible alignment.

This happens because gen_pool_first_fit_align() looks for properly aligned
memory block without taking into account the chunk start address alignment.

To fix this, we provide chunk start address to gen_pool_first_fit_align()
and change its implementation such that it starts looking for properly
aligned block with appropriate offset (exactly as it done in CMA).

Link: https://lkml.kernel.org/lkml/a170cf65-6884-3592-1de9-4c235888cc8a@intel.com
Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
---
Changes:
	v2: 
		Correct typos
		Add more details to changelog

 include/linux/genalloc.h | 13 +++++++------
 lib/genalloc.c           | 20 ++++++++++++--------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 872f930..dd0a452 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -51,7 +51,8 @@ typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
 			unsigned long start,
 			unsigned int nr,
-			void *data, struct gen_pool *pool);
+			void *data, struct gen_pool *pool,
+			unsigned long start_addr);
 
 /*
  *  General purpose special memory pool descriptor.
@@ -131,24 +132,24 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
 
 extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool);
+		struct gen_pool *pool, unsigned long start_addr);
 
 extern unsigned long gen_pool_fixed_alloc(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
-		void *data, struct gen_pool *pool);
+		void *data, struct gen_pool *pool, unsigned long start_addr);
 
 extern unsigned long gen_pool_first_fit_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
-		void *data, struct gen_pool *pool);
+		void *data, struct gen_pool *pool, unsigned long start_addr);
 
 
 extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
-		void *data, struct gen_pool *pool);
+		void *data, struct gen_pool *pool, unsigned long start_addr);
 
 extern unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool);
+		struct gen_pool *pool, unsigned long start_addr);
 
 
 extern struct gen_pool *devm_gen_pool_create(struct device *dev,
diff --git a/lib/genalloc.c b/lib/genalloc.c
index ca06adc..5deb25c 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -311,7 +311,7 @@ unsigned long gen_pool_alloc_algo(struct gen_pool *pool, size_t size,
 		end_bit = chunk_size(chunk) >> order;
 retry:
 		start_bit = algo(chunk->bits, end_bit, start_bit,
-				 nbits, data, pool);
+				 nbits, data, pool, chunk->start_addr);
 		if (start_bit >= end_bit)
 			continue;
 		remain = bitmap_set_ll(chunk->bits, start_bit, nbits);
@@ -525,7 +525,7 @@ EXPORT_SYMBOL(gen_pool_set_algo);
  */
 unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool)
+		struct gen_pool *pool, unsigned long start_addr)
 {
 	return bitmap_find_next_zero_area(map, size, start, nr, 0);
 }
@@ -543,16 +543,19 @@ EXPORT_SYMBOL(gen_pool_first_fit);
  */
 unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool)
+		struct gen_pool *pool, unsigned long start_addr)
 {
 	struct genpool_data_align *alignment;
-	unsigned long align_mask;
+	unsigned long align_mask, align_off;
 	int order;
 
 	alignment = data;
 	order = pool->min_alloc_order;
 	align_mask = ((alignment->align + (1UL << order) - 1) >> order) - 1;
-	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
+	align_off = (start_addr & (alignment->align - 1)) >> order;
+
+	return bitmap_find_next_zero_area_off(map, size, start, nr,
+					      align_mask, align_off);
 }
 EXPORT_SYMBOL(gen_pool_first_fit_align);
 
@@ -567,7 +570,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_align);
  */
 unsigned long gen_pool_fixed_alloc(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool)
+		struct gen_pool *pool, unsigned long start_addr)
 {
 	struct genpool_data_fixed *fixed_data;
 	int order;
@@ -601,7 +604,8 @@ EXPORT_SYMBOL(gen_pool_fixed_alloc);
  */
 unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start,
-		unsigned int nr, void *data, struct gen_pool *pool)
+		unsigned int nr, void *data, struct gen_pool *pool,
+		unsigned long start_addr)
 {
 	unsigned long align_mask = roundup_pow_of_two(nr) - 1;
 
@@ -624,7 +628,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
  */
 unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
-		struct gen_pool *pool)
+		struct gen_pool *pool, unsigned long start_addr)
 {
 	unsigned long start_bit = size;
 	unsigned long len = size + 1;
-- 
2.7.4

