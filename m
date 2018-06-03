Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeFCM1l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeFCM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/29] tools lib: Add for_each_clear_bit macro
Date: Sun,  3 Jun 2018 14:26:26 +0200
Message-Id: <20180603122652.17453-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 tools/include/asm-generic/bitops.h       |  1 +
 tools/include/asm-generic/bitops/__ffz.h | 12 ++++++++++
 tools/include/asm-generic/bitops/find.h  | 28 ++++++++++++++++++++++++
 tools/include/linux/bitops.h             |  5 +++++
 tools/lib/find_bit.c                     | 25 +++++++++++++++++++++
 tools/perf/MANIFEST                      |  1 +
 6 files changed, 72 insertions(+)
 create mode 100644 tools/include/asm-generic/bitops/__ffz.h

diff --git a/tools/include/asm-generic/bitops.h b/tools/include/asm-generic/bitops.h
index 653d1bad77de..0304600121da 100644
--- a/tools/include/asm-generic/bitops.h
+++ b/tools/include/asm-generic/bitops.h
@@ -13,6 +13,7 @@
  */
 
 #include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/__ffz.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
diff --git a/tools/include/asm-generic/bitops/__ffz.h b/tools/include/asm-generic/bitops/__ffz.h
new file mode 100644
index 000000000000..6744bd4cdf46
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
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 31f51547fcd4..5538ecdc964a 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -15,6 +15,21 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
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
@@ -30,4 +45,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
 
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
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 49c929a104ee..fc446343ff41 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -39,6 +39,11 @@ extern unsigned long __sw_hweight64(__u64 w);
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
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 9122a9e80046..6d8b8f22cf55 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -82,3 +82,28 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
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
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 0bda2cca2b3a..a511e5f31e36 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -51,6 +51,7 @@ tools/include/asm-generic/bitops/arch_hweight.h
 tools/include/asm-generic/bitops/atomic.h
 tools/include/asm-generic/bitops/const_hweight.h
 tools/include/asm-generic/bitops/__ffs.h
+tools/include/asm-generic/bitops/__ffz.h
 tools/include/asm-generic/bitops/__fls.h
 tools/include/asm-generic/bitops/find.h
 tools/include/asm-generic/bitops/fls64.h
-- 
2.17.1
