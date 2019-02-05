Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0935C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D2D217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GZeoBUWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfBESay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:30:54 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:35903 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728993AbfBESay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:30:54 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 13:30:51 EST
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 07F93F217B3;
        Tue,  5 Feb 2019 21:24:20 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2KB80zExpd-OJ6SVVMi;
        Tue, 05 Feb 2019 21:24:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549391060;
        bh=ttOGnD7aFvpPi6+wm6Y2EXAmeD39k+aU9vjgaHPtoGY=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=GZeoBUWoLNfN1Ozn+y3ADC60loxH3eqahULKjEX4AYR/3dwJBDG/ggpyrWzIGZwZ8
         kCWqAxxj7KzYWP44I/f+9dWg+TQbaSxMYkP1saYe4Cz0pNYRUYBfaqMA8XRMf+PLQ+
         xhrPwsd37rWQTNEChAqd4W+4oIXM6NmXyfdX4dHM=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5Ct2TZlNuf-OIBq1ddM;
        Tue, 05 Feb 2019 21:24:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Andrey Abramov <st5pub@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, davem@davemloft.net,
        Andrey Abramov <st5pub@yandex.ru>
Subject: [PATCH 1/1] Lib: sort.c: replaced heap sort algorithm with introspective sort
Date:   Tue,  5 Feb 2019 21:24:13 +0300
Message-Id: <20190205182413.16202-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced heap sort algorithm with faster introspective sort algorithm.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
v1: The introspective sort algorithm is faster the heap sort (for example on my machine on a 100MB of random data it was consistently almost twice faster) and it doesn't have the worst case, unlike qsort.

 lib/sort.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 15 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index d6b7a202b0b6..edc09287e572 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * A fast, small, non-recursive O(nlog n) sort for the Linux kernel
+ * A fast, recursive O(nlog n) sort for the Linux kernel
  *
  * Jan 23 2005  Matt Mackall <mpm@selenic.com>
+ * Feb 5  2019  Andrey Abramov <st5pub@yandex.ru> (introspective sort)
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -48,33 +49,22 @@ static void generic_swap(void *a, void *b, int size)
  * @num: number of elements
  * @size: size of each element
  * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
+ * @swap_func: pointer to swap function
  *
- * This function does a heapsort on the given array. You may provide a
- * swap_func function optimized to your element type.
+ * This function does a heapsort on the given array.
  *
  * Sorting time is O(n log n) both on average and worst-case. While
  * qsort is about 20% faster on average, it suffers from exploitable
  * O(n*n) worst-case behavior and extra memory requirements that make
  * it less suitable for kernel use.
  */
-
-void sort(void *base, size_t num, size_t size,
+void heapsort(void *base, size_t num, size_t size,
 	  int (*cmp_func)(const void *, const void *),
 	  void (*swap_func)(void *, void *, int size))
 {
 	/* pre-scale counters for performance */
 	int i = (num/2 - 1) * size, n = num * size, c, r;
 
-	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
-		else
-			swap_func = generic_swap;
-	}
-
 	/* heapify */
 	for ( ; i >= 0; i -= size) {
 		for (r = i; r * 2 + size < n; r  = c) {
@@ -103,4 +93,111 @@ void sort(void *base, size_t num, size_t size,
 	}
 }
 
+void introsort(void *base, size_t num, size_t size,
+	  int (*cmp_func)(const void *, const void *),
+	  void (*swap_func)(void *, void *, int size),
+	  unsigned int max_depth, unsigned int depth)
+{
+
+	void *last = base + (num - 1) * size;
+	void *pivot = base + ((num - 1) / 2) * size;
+	void *i = base;
+	void *j = last;
+
+	if (num <= 1)
+		return;
+
+	/* switching to heapsort */
+	if (depth >= max_depth) {
+		heapsort(base, num, size, cmp_func, swap_func);
+		return;
+	}
+
+	/* making pivot be the median of middle, first and last elements */
+	if ((cmp_func(pivot, base) >= 0 && cmp_func(base, last) >= 0)
+		|| (cmp_func(last, base) >= 0 && cmp_func(base, pivot) >= 0)) {
+		pivot = base;
+	} else if ((cmp_func(pivot, last) >= 0 && cmp_func(last, base) >= 0)
+		|| (cmp_func(base, last) >= 0 && cmp_func(last, pivot) >= 0)) {
+		pivot = last;
+	}
+
+	/* split array */
+	while (true) {
+		while (cmp_func(i, pivot) < 0 && i < last)
+			i += size;
+		while (cmp_func(j, pivot) > 0 && j > base)
+			j -= size;
+
+		if (i >= j)
+			break;
+
+		swap_func(i, j, size);
+
+		if (i == pivot)
+			pivot = j;
+		else if (j == pivot)
+			pivot = i;
+
+		j -= size;
+		i += size;
+	}
+
+	/* continue for smaller parts */
+	if (i < last)
+		introsort(i, ((size_t)last - (size_t)i) / size + 1,
+			size, cmp_func, swap_func, max_depth, depth + 1);
+	if (base < j)
+		introsort(base, ((size_t)j - (size_t)base) / size + 1,
+			size, cmp_func, swap_func, max_depth, depth + 1);
+}
+
+unsigned int log2_up(size_t val)
+{
+	unsigned int log = 0;
+	size_t current = 1;
+
+	unsigned int max_reachable_log = sizeof(val) * 8 - 1;
+
+	while (current < val) {
+		current <<= 1;
+		log++;
+		if (log == max_reachable_log && current < val)
+			return max_reachable_log + 1;
+	}
+
+	return log;
+}
+
+
+/**
+ * sort - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ *
+ * This function does a introspective sort on the given array. You may provide a
+ * swap_func function optimized to your element type.
+ *
+ * The introspective sort use both qsort and heapsort,
+ * so it is faster than heapsort on average,
+ * but it doesn't have the worst case unlike qsort
+ */
+void sort(void *base, size_t num, size_t size,
+	  int (*cmp_func)(const void *, const void *),
+	  void (*swap_func)(void *, void *, int size))
+{
+	if (!swap_func) {
+		if (size == 4 && alignment_ok(base, 4))
+			swap_func = u32_swap;
+		else if (size == 8 && alignment_ok(base, 8))
+			swap_func = u64_swap;
+		else
+			swap_func = generic_swap;
+	}
+
+	introsort(base, num, size, cmp_func, swap_func, log2_up(num) * 2, 1);
+}
 EXPORT_SYMBOL(sort);
-- 
2.20.1

