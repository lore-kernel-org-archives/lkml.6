Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeFDHdV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbeFDG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 03/29] tools lib: Add for_each_clear_bit macro
Date: Mon,  4 Jun 2018 08:57:59 +0200
Message-Id: <20180604065802.290584011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 02bc11de567273da8ab25c54336ddbb71986f38f upstream.

Adding for_each_clear_bit macro plus all its the necessary backbone
functions. Taken from related kernel code. It will be used in following
patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-cayv2zbqi0nlmg5sjjxs1775@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/asm-generic/bitops.h       |    1 +
 tools/include/asm-generic/bitops/__ffz.h |   12 ++++++++++++
 tools/include/asm-generic/bitops/find.h  |   28 ++++++++++++++++++++++++++++
 tools/include/linux/bitops.h             |    5 +++++
 tools/lib/find_bit.c                     |   25 +++++++++++++++++++++++++
 tools/perf/MANIFEST                      |    1 +
 6 files changed, 72 insertions(+)

--- a/tools/include/asm-generic/bitops.h
+++ b/tools/include/asm-generic/bitops.h
@@ -13,6 +13,7 @@
  */
 
 #include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/__ffz.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
--- /dev/null
+++ b/tools/include/asm-generic/bitops/__ffz.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FFZ_H_
+#define _ASM_GENERIC_BITOPS_FFZ_H_
+
+/*
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+#define ffz(x)  __ffs(~(x))
+
+#endif /* _ASM_GENERIC_BITOPS_FFZ_H_ */
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -15,6 +15,21 @@ extern unsigned long find_next_bit(const
 		size, unsigned long offset);
 #endif
 
+#ifndef find_next_zero_bit
+
+/**
+ * find_next_zero_bit - find the next cleared bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number of the next zero bit
+ * If no bits are zero, returns @size.
+ */
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset);
+#endif
+
 #ifndef find_first_bit
 
 /**
@@ -30,4 +45,17 @@ extern unsigned long find_first_bit(cons
 
 #endif /* find_first_bit */
 
+#ifndef find_first_zero_bit
+
+/**
+ * find_first_zero_bit - find the first cleared bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ *
+ * Returns the bit number of the first cleared bit.
+ * If no bits are zero, returns @size.
+ */
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size);
+#endif
+
 #endif /*_TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_ */
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -39,6 +39,11 @@ extern unsigned long __sw_hweight64(__u6
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
+#define for_each_clear_bit(bit, addr, size) \
+	for ((bit) = find_first_zero_bit((addr), (size));       \
+	     (bit) < (size);                                    \
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
 /* same as for_each_set_bit() but use bit as value to start with */
 #define for_each_set_bit_from(bit, addr, size) \
 	for ((bit) = find_next_bit((addr), (size), (bit));	\
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -82,3 +82,28 @@ unsigned long find_first_bit(const unsig
 	return size;
 }
 #endif
+
+#ifndef find_first_zero_bit
+/*
+ * Find the first cleared bit in a memory region.
+ */
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	unsigned long idx;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
+		if (addr[idx] != ~0UL)
+			return min(idx * BITS_PER_LONG + ffz(addr[idx]), size);
+	}
+
+	return size;
+}
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset)
+{
+	return _find_next_bit(addr, size, offset, ~0UL);
+}
+#endif
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -51,6 +51,7 @@ tools/include/asm-generic/bitops/arch_hw
 tools/include/asm-generic/bitops/atomic.h
 tools/include/asm-generic/bitops/const_hweight.h
 tools/include/asm-generic/bitops/__ffs.h
+tools/include/asm-generic/bitops/__ffz.h
 tools/include/asm-generic/bitops/__fls.h
 tools/include/asm-generic/bitops/find.h
 tools/include/asm-generic/bitops/fls64.h
