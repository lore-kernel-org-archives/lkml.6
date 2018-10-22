Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E681C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB24320645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y71J/XsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB24320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeJVX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbeJVX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4YuG151290;
        Mon, 22 Oct 2018 15:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=9DvNYd3YImdHLPyrRPXieetOWzWbhe28DdbVY1T1Cus=;
 b=Y71J/XsXG0lP1PTQuATrUD4CMRBgzmHidC06DWoIvdhPBSAHScpMq3QuFixatkH8CLCf
 7Xwfoab3yqa483Mq99h1GmM4iwDbZOZmU2oM8CeoMApqwVi/mdB5bTL1fgdaejF1FYJm
 Tmi+QexgoIUvu25Fz+mUQaG0VkbcgMLeV5tf7DsS1yr36+8rV2CzQq/6u4OKu8QQ+7wT
 Y74NSOxBBbQfPAzWOnakY2059rsf6Bx/GFTLSwyHwp3wpoP61cKVFyos70T6p8I1hx+a
 +C8OljgmOfMkIHOEruOJluxyJQwKoqvBo+YyjNFRt13S0IXyZs9Uzs5HNv7kJPhfwH7B qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usty8fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF962q019980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF96rc020726;
        Mon, 22 Oct 2018 15:09:06 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:05 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] sched: Provide sparsemask, a reduced contention bitmap
Date:   Mon, 22 Oct 2018 07:59:32 -0700
Message-Id: <1540220381-424433-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide struct sparsemask and functions to manipulate it.  A sparsemask is
a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
threads concurrently set, clear, and visit elements, by reducing the number
of significant bits per cacheline.  For each 64 byte chunk of the mask,
only the first K bits of the first word are used, and the remaining bits
are ignored, where K is a creation time parameter.  Thus a sparsemask that
can represent a set of N elements is approximately (N/K * 64) bytes in
size.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/linux/sparsemask.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile               |   2 +-
 lib/sparsemask.c           | 142 +++++++++++++++++++++++++
 3 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sparsemask.h
 create mode 100644 lib/sparsemask.c

diff --git a/include/linux/sparsemask.h b/include/linux/sparsemask.h
new file mode 100644
index 0000000..d36a3be
--- /dev/null
+++ b/include/linux/sparsemask.h
@@ -0,0 +1,260 @@
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
+ * each 64 byte chunk of the mask, only the first K bits of the first word are
+ * used, and the remaining bits are ignored, where K is a creation time
+ * parameter.  Thus a sparsemask that can represent a set of N elements is
+ * approximately (N/K * 64) bytes in size.
+ *
+ * Clients pass and receive element numbers in the public API, and the
+ * implementation translates them to bit numbers to perform the bitmap
+ * operations.
+ *
+ * This file is partially derived from cpumask.h, and the public sparsemask
+ * operations are drop-in replacements for cpumask operations. However,
+ * sparsemask has no dependency on CPU definitions and can be used to
+ * represent any kind of elements.
+ */
+
+struct sparsemask {
+	short nelems;		/* current number of elements */
+	short density;		/* store 2^density elements per chunk */
+	unsigned long bits[0];	/* embedded array of chunks */
+};
+
+/* The maximum value for density, which implicitly defines the chunk size */
+
+#define _SMASK_DENSITY_MAX	6
+
+#define SMASK_DENSITY_TO_BYTES(density)		(1U << (density))
+#define SMASK_DENSITY_TO_ELEMS(density)		(1U << (density))
+
+/* The number of elements/bits/bytes/longs in a chunk */
+
+#define SMASK_ELEMS(mask)	SMASK_DENSITY_TO_ELEMS((mask)->density)
+#define SMASK_BYTES		SMASK_DENSITY_TO_BYTES(_SMASK_DENSITY_MAX)
+#define SMASK_BITS		(SMASK_BYTES * BITS_PER_BYTE)
+#define SMASK_LONGS		(SMASK_BYTES / sizeof(long))
+
+/*
+ * Translate element index @elem to a bit/byte/long index.
+ * @density: the density of a chunk.
+ */
+
+#define _SMASK_ELEM_TO_BIT(elem, density)			\
+	((elem) / SMASK_DENSITY_TO_ELEMS(density) * SMASK_BITS +\
+	 (elem) % SMASK_DENSITY_TO_ELEMS(density))
+
+#define _SMASK_ELEM_TO_BYTE(elem, density)	\
+	(_SMASK_ELEM_TO_BIT(elem, density) / BITS_PER_BYTE)
+
+#define _SMASK_ELEM_TO_LONG(elem, density)	\
+	(_SMASK_ELEM_TO_BYTE(elem, density) / sizeof(long))
+
+/* Translate @bit/@byte/@long index to an element index */
+
+#define _SMASK_BIT_TO_ELEM(bit, density)			\
+	((bit) / SMASK_BITS * SMASK_DENSITY_TO_ELEMS(density) +	\
+	 (bit) % SMASK_BITS)
+
+#define _SMASK_BYTE_TO_ELEM(byte, density)	\
+	_SMASK_BIT_TO_ELEM((byte) * BITS_PER_BYTE, density)
+
+#define _SMASK_LONG_TO_ELEM(index, density)	\
+	_SMASK_BYTE_TO_ELEM((index) * sizeof(long), density)
+
+/* Same translations as above, but taking sparsemask @m instead of density */
+
+#define SMASK_ELEM_TO_BYTE(elem, m)	_SMASK_ELEM_TO_BYTE(elem, (m)->density)
+#define SMASK_ELEM_TO_BIT(elem, m)	_SMASK_ELEM_TO_BIT(elem, (m)->density)
+#define SMASK_ELEM_TO_LONG(elem, m)	_SMASK_ELEM_TO_LONG(elem, (m)->density)
+#define SMASK_BYTE_TO_ELEM(byte, m)	_SMASK_BYTE_TO_ELEM(byte, (m)->density)
+#define SMASK_BIT_TO_ELEM(bit, m)	_SMASK_BIT_TO_ELEM(bit, (m)->density)
+#define SMASK_LONG_TO_ELEM(index, m)	_SMASK_LONG_TO_ELEM(index, (m)->density)
+
+/*
+ * Verify the @elem argument to sparsemask functions, and return its bit.
+ */
+static inline int
+sparsemask_check(int elem, const struct sparsemask *mask)
+{
+	WARN_ON_ONCE(elem >= mask->nelems);
+	return SMASK_ELEM_TO_BIT(elem, mask);
+}
+
+int sparsemask_next(int n, const struct sparsemask *srcp);
+int sparsemask_next_wrap(int n, const struct sparsemask *mask,
+			 int start, bool wrap);
+
+/****************** The public API ********************/
+
+/*
+ * for_each_sparse - iterate over every element in a mask
+ * @elem: the (optionally unsigned) integer iterator
+ * @mask: the sparsemask
+ *
+ * After the loop, @elem is >= @mask->nelems.
+ */
+#define for_each_sparse(elem, mask)			\
+	for ((elem) = -1;				\
+	     (elem) = sparsemask_next((elem), (mask)),	\
+	     (elem) < (mask)->nelems;)
+
+/*
+ * for_each_sparse_wrap - iterate over every element in a mask, starting at a
+ *   specified location.
+ * @elem: the (optionally unsigned) integer iterator
+ * @mask: the sparsemask
+ * @start: the start location
+ *
+ * The implementation does not assume any bit in @mask is set(including @start).
+ * After the loop, @elem is >= @mask->nelems.
+ */
+#define for_each_sparse_wrap(elem, mask, start)				       \
+	for ((elem) = sparsemask_next_wrap((start)-1, (mask), (start), false); \
+	     (elem) < (mask)->nelems;					       \
+	     (elem) = sparsemask_next_wrap((elem), (mask), (start), true))
+
+/*
+ * sparsemask_set_elem - set an element in a sparsemask
+ * @elem: element number (< @dstp->nelems)
+ * @dstp: the sparsemask
+ */
+static inline void sparsemask_set_elem(int elem, struct sparsemask *dstp)
+{
+	set_bit(sparsemask_check(elem, dstp), dstp->bits);
+}
+
+static inline void __sparsemask_set_elem(int elem, struct sparsemask *dstp)
+{
+	__set_bit(sparsemask_check(elem, dstp), dstp->bits);
+}
+
+/*
+ * sparsemask_clear_elem - clear an element in a sparsemask
+ * @elem: element number (< @dstp->nelems)
+ * @dstp: the sparsemask
+ */
+static inline void sparsemask_clear_elem(int elem, struct sparsemask *dstp)
+{
+	clear_bit(sparsemask_check(elem, dstp), dstp->bits);
+}
+
+static inline void __sparsemask_clear_elem(int elem, struct sparsemask *dstp)
+{
+	__clear_bit(sparsemask_check(elem, dstp), dstp->bits);
+}
+
+/*
+ * sparsemask_test_elem - test for an element in a sparsemask
+ * @elem: element number (< @mask->nelems)
+ * @mask: the sparsemask
+ *
+ * Returns 1 if @elem is set in @mask, else returns 0
+ */
+static inline int sparsemask_test_elem(int elem, const struct sparsemask *mask)
+{
+	return test_bit(sparsemask_check(elem, mask), mask->bits);
+}
+
+/*
+ * sparsemask_test_and_set_elem - atomically test and set an element
+ * @elem: element number (< @mask->nelems)
+ * @mask: the sparsemask
+ *
+ * Returns 1 if @elem is set in old bitmap of @mask, else returns 0
+ */
+static inline int
+sparsemask_test_and_set_elem(int elem, struct sparsemask *mask)
+{
+	return test_and_set_bit(sparsemask_check(elem, mask), mask->bits);
+}
+
+/*
+ * sparsemask_test_and_clear_elem - atomically test and clear an element
+ * @elem: element number (< @mask->nelems)
+ * @mask: the sparsemask
+ *
+ * Returns 1 if @elem is set in old bitmap of @mask, else returns 0
+ */
+static inline int
+sparsemask_test_and_clear_elem(int elem, struct sparsemask *mask)
+{
+	return test_and_clear_bit(sparsemask_check(elem, mask), mask->bits);
+}
+
+/*
+ * sparsemask_weight - return count of bits in @mask (<= @mask->nelems)
+ * @mask: the sparsemask
+ */
+unsigned int sparsemask_weight(const struct sparsemask *srcp);
+
+/*
+ * Suggested and max value for the density parameter
+ */
+#define SPARSEMASK_DENSITY_DEFAULT	3
+#define SMASK_DENSITY_MAX		_SMASK_DENSITY_MAX
+
+/*
+ * Allocate and initialize a sparsemask and return it in @maskp.
+ * @nelems - maximum number of elements.
+ * @density - store 2^density elements per 64-byte chunk.
+ *	      values from 0 to SMASK_DENSITY_MAX inclusive.
+ * @flags - kmalloc allocation flags
+ * @node - numa node
+ *
+ * Return true on success, like the cpumask functions.
+ */
+
+bool alloc_sparsemask(struct sparsemask **maskp, int nelems,
+		      int density, gfp_t flags);
+
+bool zalloc_sparsemask(struct sparsemask **maskp, int nelems,
+		       int density, gfp_t flags);
+
+bool alloc_sparsemask_node(struct sparsemask **maskp, int nelems,
+			   int density, gfp_t flags, int node);
+
+bool zalloc_sparsemask_node(struct sparsemask **maskp, int nelems,
+			    int density, gfp_t flags, int node);
+
+/*
+ * Free a sparsemask allocated by any of the above
+ */
+void free_sparsemask(struct sparsemask *mask);
+
+/*
+ * Return bytes to allocate for a sparsemask, for custom allocators
+ */
+size_t sparsemask_size(int nelems, int density);
+
+/*
+ * Initialize an allocated sparsemask, for custom allocators
+ */
+void sparsemask_init(struct sparsemask *mask, int nelems, int density);
+
+#endif /* __LINUX_SPARSEMASK_H */
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7eb..77c168e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
-lib-$(CONFIG_SMP) += cpumask.o
+lib-$(CONFIG_SMP) += cpumask.o sparsemask.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
diff --git a/lib/sparsemask.c b/lib/sparsemask.c
new file mode 100644
index 0000000..d51cf50
--- /dev/null
+++ b/lib/sparsemask.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sparsemask.c - sparse bitmap operations
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
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/sparsemask.h>
+
+/*
+ * Return the next one bit in @mask after @start, not including @start.
+ */
+int sparsemask_next(int start, const struct sparsemask *mask)
+{
+	const unsigned long *addr = mask->bits;
+	unsigned long nelems = mask->nelems;
+	unsigned long tmp, nbits;
+
+	/* -1 is a legal arg here. */
+	if (start != -1)
+		sparsemask_check(start, mask);
+	start++;
+
+	if (unlikely(start >= nelems))
+		return nelems;
+
+	start = SMASK_ELEM_TO_BIT(start, mask);
+	nbits = SMASK_ELEM_TO_BIT(nelems, mask);
+	tmp = addr[start / BITS_PER_LONG];
+
+	/* Handle 1st word. */
+	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	start = round_down(start, BITS_PER_LONG);
+
+	while (!tmp) {
+		start += SMASK_BITS;
+		if (start >= nbits)
+			return nelems;
+		tmp = addr[start / BITS_PER_LONG];
+	}
+
+	return min(SMASK_BIT_TO_ELEM(start, mask) + __ffs(tmp), nelems);
+}
+
+int
+sparsemask_next_wrap(int n, const struct sparsemask *mask, int start, bool wrap)
+{
+	int next;
+
+again:
+	next = sparsemask_next(n, mask);
+
+	if (wrap && n < start && next >= start) {
+		return mask->nelems;
+
+	} else if (next >= mask->nelems) {
+		wrap = true;
+		n = -1;
+		goto again;
+	}
+
+	return next;
+}
+
+unsigned int sparsemask_weight(const struct sparsemask *mask)
+{
+	int weight = 0;
+	const unsigned long *addr = mask->bits;
+	int nlongs = SMASK_ELEM_TO_LONG(mask->nelems, mask);
+	int i, extra, shift;
+
+	for (i = 0; i < nlongs; i += SMASK_LONGS) {
+		if (addr[i])
+			weight += hweight_long(addr[i]);
+	}
+	extra = mask->nelems - SMASK_LONG_TO_ELEM(i, mask);
+	if (extra > 0) {
+		shift = BITS_PER_LONG - extra;
+		weight += hweight_long((addr[i] << shift) >> shift);
+	}
+	return weight;
+}
+
+size_t sparsemask_size(int nelems, int density)
+{
+	nelems = round_up(nelems, SMASK_DENSITY_TO_ELEMS(density));
+	return sizeof(struct sparsemask) + _SMASK_ELEM_TO_BYTE(nelems, density);
+}
+
+void sparsemask_init(struct sparsemask *mask, int nelems, int density)
+{
+	WARN_ON(density < 0 || density > SMASK_DENSITY_MAX);
+	mask->nelems = nelems;
+	mask->density = density;
+}
+
+bool alloc_sparsemask_node(struct sparsemask **mask, int nelems, int density,
+			   gfp_t flags, int node)
+{
+	*mask = kmalloc_node(sparsemask_size(nelems, density), flags, node);
+	if (*mask)
+		sparsemask_init(*mask, nelems, density);
+	return !!*mask;
+}
+
+bool zalloc_sparsemask_node(struct sparsemask **mask, int nelems, int density,
+			    gfp_t flags, int node)
+{
+	flags |= __GFP_ZERO;
+	return alloc_sparsemask_node(mask, nelems, density, flags, node);
+}
+
+bool alloc_sparsemask(struct sparsemask **mask, int nelems, int density,
+		      gfp_t flags)
+{
+	return alloc_sparsemask_node(mask, nelems, density, flags,
+				     NUMA_NO_NODE);
+}
+
+bool zalloc_sparsemask(struct sparsemask **mask, int nelems, int density,
+		       gfp_t flags)
+{
+	flags |= __GFP_ZERO;
+	return alloc_sparsemask(mask, nelems, density, flags);
+}
+
+void free_sparsemask(struct sparsemask *mask)
+{
+	kfree(mask);
+}
-- 
1.8.3.1

