Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Ug+dy2WZegFjNfXrDGKRCkTfGOsidUzWfDc7eiIgFs/0mhvHTU0cyYO2RoNX5K4kG3X+O
ARC-Seal: i=1; a=rsa-sha256; t=1518708920; cv=none;
        d=google.com; s=arc-20160816;
        b=RzcXJtPK7gIx6BovuYfySp3P64fxQE5jKhgbGOJmIa+ZvD6qeYKOIrO6ORFYifiuXV
         VVOxNJ3ADvIyjnoajKoDtT7/C4t5b4EE0fvLEoltfeu26f+jXJBSC6gqOaboiyyagWo/
         PphJcfXGr6Lg7VuHy5gWrfsXxd+bjrj0jeLvR4aM4D3wimIurrUIxOZvWUyyoeepP2VU
         n2hzjhSzQac6n+otlKu8z6YhdNawOg5MmTsp4vu7tbKpqjl5QBta1YmiVusZ0560qL8e
         aearOMtOlSVKrzS/T+G/WICnneZwERhxgx0gP7plWILJ/GxtJnhnIHB2CX1DEbVdpixX
         wGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ordzn02Hkl77EzOsaLbg9QWRhUzZJsAVJAPtEOklS0U=;
        b=ZpoPmpwyTfy0RXQ1Rd1g/z4yz+G9Rdb1OC7ZjKLKh1UZ+dY4Fk4IKEcOO29/RQI0Q9
         Lck+ca3G05myM52zPOKNrUYZUidIXAWxLeWy9VKU/a+97EcHFOZM+GYBGHfRNJSouIzs
         cT9W3hViWHntSxlSxMsMO0gS0Geiv02ez9g7kTN3yS/W82oZjJWkPJ1WiAYmiOS5YpZD
         hRL9THRcFBC18tkFiH2QFatghVo1i6ruP3ZQGBFKUqUW2PdiiBeJdK3TYTlnq2OmWFUn
         hDz75x9PBwJso0reloKTFh92RSGxGVChYSi4AhEL+H7ka7vgQnGQppm+e0zpfZKr5UDe
         2mKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.14 095/195] mtd: cfi: convert inline functions to macros
Date: Thu, 15 Feb 2018 16:16:26 +0100
Message-Id: <20180215151710.448472190@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481046728605284?=
X-GMAIL-MSGID: =?utf-8?q?1592481724980818018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 9e343e87d2c4c707ef8fae2844864d4dde3a2d13 upstream.

The map_word_() functions, dating back to linux-2.6.8, try to perform
bitwise operations on a 'map_word' structure. This may have worked
with compilers that were current then (gcc-3.4 or earlier), but end
up being rather inefficient on any version I could try now (gcc-4.4 or
higher). Specifically we hit a problem analyzed in gcc PR81715 where we
fail to reuse the stack space for local variables.

This can be seen immediately in the stack consumption for
cfi_staa_erase_varsize() and other functions that (with CONFIG_KASAN)
can be up to 2200 bytes. Changing the inline functions into macros brings
this down to 1280 bytes.  Without KASAN, the same problem exists, but
the stack consumption is lower to start with, my patch shrinks it from
920 to 496 bytes on with arm-linux-gnueabi-gcc-5.4, and saves around
1KB in .text size for cfi_cmdset_0020.c, as it avoids copying map_word
structures for each call to one of these helpers.

With the latest gcc-8 snapshot, the problem is fixed in upstream gcc,
but nobody uses that yet, so we should still work around it in mainline
kernels and probably backport the workaround to stable kernels as well.
We had a couple of other functions that suffered from the same gcc bug,
and all of those had a simpler workaround involving dummy variables
in the inline function. Unfortunately that did not work here, the
macro hack was the best I could come up with.

It would also be helpful to have someone to a little performance testing
on the patch, to see how much it helps in terms of CPU utilitzation.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mtd/map.h |  130 ++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 69 deletions(-)

--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -270,75 +270,67 @@ void map_destroy(struct mtd_info *mtd);
 #define INVALIDATE_CACHED_RANGE(map, from, size) \
 	do { if (map->inval_cache) map->inval_cache(map, from, size); } while (0)
 
-
-static inline int map_word_equal(struct map_info *map, map_word val1, map_word val2)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if (val1.x[i] != val2.x[i])
-			return 0;
-	}
-
-	return 1;
-}
-
-static inline map_word map_word_and(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] & val2.x[i];
-
-	return r;
-}
-
-static inline map_word map_word_clr(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] & ~val2.x[i];
-
-	return r;
-}
-
-static inline map_word map_word_or(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] | val2.x[i];
-
-	return r;
-}
-
-static inline int map_word_andequal(struct map_info *map, map_word val1, map_word val2, map_word val3)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if ((val1.x[i] & val2.x[i]) != val3.x[i])
-			return 0;
-	}
-
-	return 1;
-}
-
-static inline int map_word_bitsset(struct map_info *map, map_word val1, map_word val2)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if (val1.x[i] & val2.x[i])
-			return 1;
-	}
-
-	return 0;
-}
+#define map_word_equal(map, val1, val2)					\
+({									\
+	int i, ret = 1;							\
+	for (i = 0; i < map_words(map); i++)				\
+		if ((val1).x[i] != (val2).x[i]) {			\
+			ret = 0;					\
+			break;						\
+		}							\
+	ret;								\
+})
+
+#define map_word_and(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] & (val2).x[i];			\
+	r;								\
+})
+
+#define map_word_clr(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] & ~(val2).x[i];			\
+	r;								\
+})
+
+#define map_word_or(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] | (val2).x[i];			\
+	r;								\
+})
+
+#define map_word_andequal(map, val1, val2, val3)			\
+({									\
+	int i, ret = 1;							\
+	for (i = 0; i < map_words(map); i++) {				\
+		if (((val1).x[i] & (val2).x[i]) != (val2).x[i]) {	\
+			ret = 0;					\
+			break;						\
+		}							\
+	}								\
+	ret;								\
+})
+
+#define map_word_bitsset(map, val1, val2)				\
+({									\
+	int i, ret = 0;							\
+	for (i = 0; i < map_words(map); i++) {				\
+		if ((val1).x[i] & (val2).x[i]) {			\
+			ret = 1;					\
+			break;						\
+		}							\
+	}								\
+	ret;								\
+})
 
 static inline map_word map_word_load(struct map_info *map, const void *ptr)
 {
