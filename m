Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Q4+kBoN7v5TMBL59sMhlHsDEzGAbbsxSjMJ6SPm2QlhD5t84kbUEMibe6hdjsi0fzRK+G
ARC-Seal: i=1; a=rsa-sha256; t=1523022137; cv=none;
        d=google.com; s=arc-20160816;
        b=FF/0td5Y1lnVYYUKejlMhocMZsYrpaUgojBvwvQ9uRGkdQYax7Vnzh400ztELUhtNe
         geHg/bLUKYUsET+XT9cbbbF0eS79iW0VyP02zSvLjebIYNC5wkSBDnjNk+CuFh4oq08h
         zpUOtVVsdYM52REm5cVZK3zxiZ4M1Y2zwztMGQ//25OSGP2zzcneV2xa4LpTUo98UpYQ
         CU1mMEbh0O+C7F+iLuwRAzYVVV2pW6sRmlrm7n+SrZVH1sTN746UuoaULsn1gzajjzEO
         lY0dXvDfaaBWAYw9jAAJK8sOy5uyOJG95EiLZ7abRsyZPD8WN0BTbLkTgk/h8cUrpEUx
         fPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tr6c58aEcwKQ9tnuhiOPxKMWGjszOlEli4c02To2DoE=;
        b=iPDvxG8PCcnzwMqmpF0OiKRZ3d/UmcsJ89ldRypp4GAR97LVtwCkVzJYd5R/kVKgQW
         Jl6TrRplnKOWT80I4pjBVtiOH85DvdhR3cCwXXWMr/B9jLKY75Vn9juNu+TYi1jabAi0
         eFlo0uM6z17UUU+AjJ2/+0FTaRSkSG/2tmp2XPhX/AGMr9Vyj5KwErAFEvytSShgj20c
         Itv7sAhG5U3RDuBTuBl3zmYH85mZ4Je/P2hDiHEcivC+HLLoYI1JT6jfz0/oZBGof1+R
         E7KaPCUQHRAC63L80Ic6ZyIgFnZ43BBzN9me7ZOio2qvhSE0EqYPf2P9mTbEAEBlobJN
         argQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	"Erhard F." <erhard_f@mailbox.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Omar Sandoval <osandov@fb.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 40/72] bitmap: fix memset optimization on big-endian systems
Date: Fri,  6 Apr 2018 15:24:15 +0200
Message-Id: <20180406084352.504891273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004345240253782?=
X-GMAIL-MSGID: =?utf-8?q?1597004460155442892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit 21035965f60b0502fc6537b232839389bb4ce664 upstream.

Commit 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and
bitmap_clear into memset when possible") introduced an optimization to
bitmap_{set,clear}() which uses memset() when the start and length are
constants aligned to a byte.

This is wrong on big-endian systems; our bitmaps are arrays of unsigned
long, so bit n is not at byte n / 8 in memory.  This was caught by the
Btrfs selftests, but the bitmap selftests also fail when run on a
big-endian machine.

We can still use memset if the start and length are aligned to an
unsigned long, so do that on big-endian.  The same problem applies to
the memcmp in bitmap_equal(), so fix it there, too.

Fixes: 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and bitmap_clear into memset when possible")
Fixes: 2c6deb01525a ("bitmap: use memcmp optimisation in more situations")
Cc: stable@kernel.org
Reported-by: "Erhard F." <erhard_f@mailbox.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/bitmap.h |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -271,12 +271,20 @@ static inline void bitmap_complement(uns
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
@@ -327,8 +335,10 @@ static __always_inline void bitmap_set(u
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
@@ -339,8 +349,10 @@ static __always_inline void bitmap_clear
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
