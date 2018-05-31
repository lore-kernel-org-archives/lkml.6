Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbeEaNTU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:19:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:2912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754820AbeEaNTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:19:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="52276706"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] bitmap: Drop unnecessary 0 check for u32 array operations
Date: Thu, 31 May 2018 16:19:14 +0300
Message-Id: <20180531131914.44352-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nbits == 0 is safe to be supplied to the function body, so,
remove unnecessary checks in bitmap_to_arr32() and bitmap_from_arr32().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/bitmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 58f9750e49c6..33e95cd359a2 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1132,14 +1132,10 @@ EXPORT_SYMBOL(bitmap_copy_le);
  *	@buf: array of u32 (in host byte order), the source bitmap
  *	@nbits: number of bits in @bitmap
  */
-void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
-						unsigned int nbits)
+void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits)
 {
 	unsigned int i, halfwords;
 
-	if (!nbits)
-		return;
-
 	halfwords = DIV_ROUND_UP(nbits, 32);
 	for (i = 0; i < halfwords; i++) {
 		bitmap[i/2] = (unsigned long) buf[i];
@@ -1163,9 +1159,6 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
 {
 	unsigned int i, halfwords;
 
-	if (!nbits)
-		return;
-
 	halfwords = DIV_ROUND_UP(nbits, 32);
 	for (i = 0; i < halfwords; i++) {
 		buf[i] = (u32) (bitmap[i/2] & UINT_MAX);
-- 
2.17.0
