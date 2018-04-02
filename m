Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeDBW6l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:58:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45419 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:58:40 -0400
X-Google-Smtp-Source: AIpwx4/b6L016KxVZGlFb8sLtNBleTsvydaEJKNDoIQOzx/L5tWhY+429FydKx87e3XibIaKEXrYMQ==
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com, Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Subject: [PATCH] bitmap: fix memset optimization on big-endian systems
Date: Mon,  2 Apr 2018 15:58:31 -0700
Message-Id: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 2a98dc028f91 introduced an optimization to bitmap_{set,clear}()
which uses memset() when the start and length are constants aligned to a
byte. This is wrong on big-endian systems; our bitmaps are arrays of
unsigned long, so bit n is not at byte n / 8 in memory. This was caught
by the Btrfs selftests, but the bitmap selftests also fail when run on a
big-endian machine.

We can still use memset if the start and length are aligned to an
unsigned long, so do that on big-endian. The same problem applies to the
memcmp in bitmap_equal(), so fix it there, too.

Fixes: 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and bitmap_clear into memset when possible")
Fixes: 2c6deb01525a ("bitmap: use memcmp optimisation in more situations")
Cc: stable@kernel.org
Reported-by: "Erhard F." <erhard_f@mailbox.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/bitmap.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 5f11fbdc27f8..1ee46f492267 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -302,12 +302,20 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 		__bitmap_complement(dst, src, nbits);
 }
 
+#ifdef __LITTLE_ENDIAN
+#define BITMAP_MEM_ALIGNMENT 8
+#else
+#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#endif
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
-	if (__builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
+	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
 		return !memcmp(src1, src2, nbits / 8);
 	return __bitmap_equal(src1, src2, nbits);
 }
@@ -358,8 +366,10 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
-	else if (__builtin_constant_p(start & 7) && IS_ALIGNED(start, 8) &&
-		 __builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
+	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
+		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
 		memset((char *)map + start / 8, 0xff, nbits / 8);
 	else
 		__bitmap_set(map, start, nbits);
@@ -370,8 +380,10 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
-	else if (__builtin_constant_p(start & 7) && IS_ALIGNED(start, 8) &&
-		 __builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
+	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
+		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
 		memset((char *)map + start / 8, 0, nbits / 8);
 	else
 		__bitmap_clear(map, start, nbits);
-- 
2.16.3
