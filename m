Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B441EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB842540C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB842540C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeF3URy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:17:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:58752 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbeF3URw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:17:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 13:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,291,1526367600"; 
   d="scan'208";a="71283388"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Jun 2018 13:17:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40C06C5; Sat, 30 Jun 2018 23:17:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/5] dm: Avoid namespace collision with bitmap API
Date:   Sat, 30 Jun 2018 23:17:46 +0300
Message-Id: <20180630201750.2588-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
References: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap API (include/linux/bitmap.h) has 'bitmap' prefix for its methods.

On the other hand DM bitmap API is special case.
Adding 'dm' prefix to it to avoid potential name space collision.

No functional changes intended.

Suggested-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../md/persistent-data/dm-space-map-common.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index 829b4ce057d8..0a3b8ae4a29c 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -69,9 +69,9 @@ static struct dm_block_validator index_validator = {
  */
 #define BITMAP_CSUM_XOR 240779
 
-static void bitmap_prepare_for_write(struct dm_block_validator *v,
-				     struct dm_block *b,
-				     size_t block_size)
+static void dm_bitmap_prepare_for_write(struct dm_block_validator *v,
+					struct dm_block *b,
+					size_t block_size)
 {
 	struct disk_bitmap_header *disk_header = dm_block_data(b);
 
@@ -81,9 +81,9 @@ static void bitmap_prepare_for_write(struct dm_block_validator *v,
 						       BITMAP_CSUM_XOR));
 }
 
-static int bitmap_check(struct dm_block_validator *v,
-			struct dm_block *b,
-			size_t block_size)
+static int dm_bitmap_check(struct dm_block_validator *v,
+			   struct dm_block *b,
+			   size_t block_size)
 {
 	struct disk_bitmap_header *disk_header = dm_block_data(b);
 	__le32 csum_disk;
@@ -108,8 +108,8 @@ static int bitmap_check(struct dm_block_validator *v,
 
 static struct dm_block_validator dm_sm_bitmap_validator = {
 	.name = "sm_bitmap",
-	.prepare_for_write = bitmap_prepare_for_write,
-	.check = bitmap_check
+	.prepare_for_write = dm_bitmap_prepare_for_write,
+	.check = dm_bitmap_check,
 };
 
 /*----------------------------------------------------------------*/
@@ -124,7 +124,7 @@ static void *dm_bitmap_data(struct dm_block *b)
 
 #define WORD_MASK_HIGH 0xAAAAAAAAAAAAAAAAULL
 
-static unsigned bitmap_word_used(void *addr, unsigned b)
+static unsigned dm_bitmap_word_used(void *addr, unsigned b)
 {
 	__le64 *words_le = addr;
 	__le64 *w_le = words_le + (b >> ENTRIES_SHIFT);
@@ -170,7 +170,7 @@ static int sm_find_free(void *addr, unsigned begin, unsigned end,
 {
 	while (begin < end) {
 		if (!(begin & (ENTRIES_PER_WORD - 1)) &&
-		    bitmap_word_used(addr, begin)) {
+		    dm_bitmap_word_used(addr, begin)) {
 			begin += ENTRIES_PER_WORD;
 			continue;
 		}
-- 
2.18.0

