Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5243208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC2QUx1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5243208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLFVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:38:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:38:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6LYfw1154728;
        Thu, 6 Dec 2018 21:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=z8D5sEmL565RwCB23O/6Oz3RqPg2sXiVRhWhBuRa/Zs=;
 b=XC2QUx1PM3vX3Dm411xLaJInFbVGV5qwXakmBQO1GtwEhIKAEmuSH6JOmeBssCj6XeZT
 Ifs0ZbZNaX/t57ltDJEFEjRG3OYYxVpQVEz0nm74xYQbUWZkwosYWSs/v/n704Ilxx63
 tJ160HH1sSsTFnN1wtXpi/NbYNVLWJ3be+nG3+NMBeXnUU8U6/VK5JzyxL3rX5fdgfXv
 XZ90vucsRMMXemHl/za3mbgSmoLCv1ZdoauTPIB8jIsURUed5V1JIom+xTEkbbtk2ob7
 XSwWn6pNNGwWTbNo5KL6i9NlbkwbhOOYMSN8KkT4k947O4i4/ZYoJT1Vgje8GdZ/qg2o 3g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxrtmds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 21:38:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcFA6004471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 21:38:16 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcFb1021691;
        Thu, 6 Dec 2018 21:38:15 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:38:15 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] sched: Provide sparsemask, a reduced contention bitmap
Date:   Thu,  6 Dec 2018 13:28:07 -0800
Message-Id: <1544131696-2888-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide struct sparsemask and functions to manipulate it.  A sparsemask is
a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
threads concurrently set, clear, and visit elements, by reducing the number
of significant bits per cacheline.  For each cacheline chunk of the mask,
only the first K bits of the first word are used, and the remaining bits
are ignored, where K is a creation time parameter.  Thus a sparsemask that
can represent a set of N elements is approximately (N/K * CACHELINE) bytes
in size.

This type is simpler and more efficient than the struct sbitmap used by
block drivers.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/sparsemask.h | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)
 create mode 100644 kernel/sched/sparsemask.h

diff --git a/kernel/sched/sparsemask.h b/kernel/sched/sparsemask.h
new file mode 100644
index 0000000..1194862
--- /dev/null
+++ b/kernel/sched/sparsemask.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * sparsemask.h - sparse bitmap operations
+ *
+ * Copyright (c) 2018 Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_SPARSEMASK_H
+#define __LINUX_SPARSEMASK_H
+
+#include <linux/kernel.h>
+#include <linux/bitmap.h>
+#include <linux/bug.h>
+
+/*
+ * A sparsemask is a sparse bitmap.  It reduces cache contention vs the usual
+ * bitmap when many threads concurrently set, clear, and visit elements.  For
+ * each cacheline chunk of the mask, only the first K bits of the first word are
+ * used, and the remaining bits are ignored, where K is a creation time
+ * parameter.  Thus a sparsemask that can represent a set of N elements is
+ * approximately (N/K * CACHELINE) bytes in size.
+ *
+ * Clients pass and receive element numbers in the public API, and the
+ * implementation translates them to bit numbers to perform the bitmap
+ * operations.
+ */
+
+struct sparsemask_chunk {
+	unsigned long word;	/* the significant bits */
+} ____cacheline_aligned_in_smp;
+
+struct sparsemask {
+	short nelems;		/* current number of elements */
+	short density;		/* store 2^density elements per chunk */
+	struct sparsemask_chunk chunks[0];  /* embedded array of chunks */
+};
+
+#define _SMASK_INDEX(density, elem)	((elem) >> (density))
+#define _SMASK_BIT(density, elem)	((elem) & ((1U << (density)) - 1U))
+#define SMASK_INDEX(mask, elem)		_SMASK_INDEX((mask)->density, elem)
+#define SMASK_BIT(mask, elem)		_SMASK_BIT((mask)->density, elem)
+#define SMASK_WORD(mask, elem)		\
+	(&(mask)->chunks[SMASK_INDEX((mask), (elem))].word)
+
+/*
+ * sparsemask_next() - Return the next one bit in a bitmap, starting at a
+ * specified position and wrapping from the last bit to the first, up to but
+ * not including a specified origin.  This is a helper, so do not call it
+ * directly.
+ *
+ * @mask: Bitmap to search.
+ * @origin: Origin.
+ * @prev: Previous bit. Start search after this bit number.
+ *	  If -1, start search at @origin.
+ *
+ * Return: the bit number, else mask->nelems if no bits are set in the range.
+ */
+static inline int
+sparsemask_next(const struct sparsemask *mask, int origin, int prev)
+{
+	int density = mask->density;
+	int bits_per_word = 1U << density;
+	const struct sparsemask_chunk *chunk;
+	int nelems = mask->nelems;
+	int next, bit, nbits;
+	unsigned long word;
+
+	/* Calculate number of bits to be searched. */
+	if (prev == -1) {
+		nbits = nelems;
+		next = origin;
+	} else if (prev < origin) {
+		nbits = origin - prev;
+		next = prev + 1;
+	} else {
+		nbits = nelems - prev + origin - 1;
+		next = prev + 1;
+	}
+
+	if (unlikely(next >= nelems))
+		return nelems;
+
+	/*
+	 * Fetch and adjust first word.  Clear word bits below @next, and round
+	 * @next down to @bits_per_word boundary because later ffs will add
+	 * those bits back.
+	 */
+	chunk = &mask->chunks[_SMASK_INDEX(density, next)];
+	bit = _SMASK_BIT(density, next);
+	word = chunk->word & (~0UL << bit);
+	next -= bit;
+	nbits += bit;
+
+	while (!word) {
+		next += bits_per_word;
+		nbits -= bits_per_word;
+		if (nbits <= 0)
+			return nelems;
+
+		if (next >= nelems) {
+			chunk = mask->chunks;
+			nbits -= (next - nelems);
+			next = 0;
+		} else {
+			chunk++;
+		}
+		word = chunk->word;
+	}
+
+	next += __ffs(word);
+	if (next >= origin && prev != -1)
+		return nelems;
+	return next;
+}
+
+/****************** The public API ********************/
+
+/*
+ * Max value for the density parameter, limited by 64 bits in the chunk word.
+ */
+#define SMASK_DENSITY_MAX		6
+
+/*
+ * Return bytes to allocate for a sparsemask, for custom allocators.
+ */
+static inline size_t sparsemask_size(int nelems, int density)
+{
+	int index = _SMASK_INDEX(density, nelems) + 1;
+
+	return offsetof(struct sparsemask, chunks[index]);
+}
+
+/*
+ * Initialize an allocated sparsemask, for custom allocators.
+ */
+static inline void
+sparsemask_init(struct sparsemask *mask, int nelems, int density)
+{
+	WARN_ON(density < 0 || density > SMASK_DENSITY_MAX || nelems < 0);
+	mask->nelems = nelems;
+	mask->density = density;
+}
+
+/*
+ * sparsemask_alloc_node() - Allocate, initialize, and return a sparsemask.
+ *
+ * @nelems - maximum number of elements.
+ * @density - store 2^density elements per cacheline chunk.
+ *	      values from 0 to SMASK_DENSITY_MAX inclusive.
+ * @flags - kmalloc allocation flags
+ * @node - numa node
+ */
+static inline struct sparsemask *
+sparsemask_alloc_node(int nelems, int density, gfp_t flags, int node)
+{
+	int nbytes = sparsemask_size(nelems, density);
+	struct sparsemask *mask = kmalloc_node(nbytes, flags, node);
+
+	if (mask)
+		sparsemask_init(mask, nelems, density);
+	return mask;
+}
+
+static inline void sparsemask_free(struct sparsemask *mask)
+{
+	kfree(mask);
+}
+
+static inline void sparsemask_set_elem(struct sparsemask *dst, int elem)
+{
+	set_bit(SMASK_BIT(dst, elem), SMASK_WORD(dst, elem));
+}
+
+static inline void sparsemask_clear_elem(struct sparsemask *dst, int elem)
+{
+	clear_bit(SMASK_BIT(dst, elem), SMASK_WORD(dst, elem));
+}
+
+static inline int sparsemask_test_elem(const struct sparsemask *mask, int elem)
+{
+	return test_bit(SMASK_BIT(mask, elem), SMASK_WORD(mask, elem));
+}
+
+/*
+ * sparsemask_for_each() - iterate over each set bit in a bitmap, starting at a
+ *   specified position, and wrapping from the last bit to the first.
+ *
+ * @mask: Bitmap to iterate over.
+ * @origin: Bit number at which to start searching.
+ * @elem: Iterator.  Can be signed or unsigned integer.
+ *
+ * The implementation does not assume any bit in @mask is set, including
+ * @origin.  After the loop, @elem = @mask->nelems.
+ */
+#define sparsemask_for_each(mask, origin, elem)				\
+	for ((elem) = -1;						\
+	     (elem) = sparsemask_next((mask), (origin), (elem)),	\
+		(elem) < (mask)->nelems;)
+
+#endif /* __LINUX_SPARSEMASK_H */
-- 
1.8.3.1

