Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934449AbeEILoS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:44:18 -0400
Received: from ozlabs.org ([203.11.71.1]:38407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934185AbeEILoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:44:17 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, mawilcox@microsoft.com,
        ynorov@caviumnetworks.com, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, keescook@chromium.org,
        torvalds@linux-foundation.org
Subject: [PATCH] lib/test_bitmap.c: Fix bitmap optimisation tests to report errors correctly
Date: Wed,  9 May 2018 21:43:28 +1000
Message-Id: <20180509114328.9887-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

I had neglected to increment the error counter when the tests failed,
which made the tests noisy when they fail, but not actually return an
error code.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Fixes: 3cc78125a081 ("lib/test_bitmap.c: add optimisation tests")
Cc: stable@vger.kernel.org # v4.13+
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
---
 lib/test_bitmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

We noticed this a while back but the patch got lost.

Andrew are you happy to take it?

cheers


diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index de16f7869fb1..6cd7d0740005 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -331,23 +331,32 @@ static void noinline __init test_mem_optimisations(void)
 	unsigned int start, nbits;
 
 	for (start = 0; start < 1024; start += 8) {
-		memset(bmap1, 0x5a, sizeof(bmap1));
-		memset(bmap2, 0x5a, sizeof(bmap2));
 		for (nbits = 0; nbits < 1024 - start; nbits += 8) {
+			memset(bmap1, 0x5a, sizeof(bmap1));
+			memset(bmap2, 0x5a, sizeof(bmap2));
+
 			bitmap_set(bmap1, start, nbits);
 			__bitmap_set(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not __equal %d %d\n", start, nbits);
+				failed_tests++;
+			}
 
 			bitmap_clear(bmap1, start, nbits);
 			__bitmap_clear(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not __equal %d %d\n", start,
 									nbits);
+				failed_tests++;
+			}
 		}
 	}
 }
-- 
2.14.1
