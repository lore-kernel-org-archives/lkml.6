Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933613AbeCSOWS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:22:18 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:5653 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933520AbeCSOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:22:11 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC PATCH 1/3] include/linux: add 256-bit IO accessors
Date: Mon, 19 Mar 2018 19:50:34 +0530
Message-Id: <a05fb08ec04fe09a9932e7c0d2606280dc02aaf8.1521469118.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add readqq and writeqq (quad quadword - 4 x 64) IO non-atomic
accessors.  Also add byteorder conversions for 256-bit.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 include/linux/byteorder/generic.h     | 48 ++++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-hi-lo.h | 59 +++++++++++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 59 +++++++++++++++++++++++++++++++++++
 include/linux/types.h                 |  7 +++++
 4 files changed, 173 insertions(+)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 451aaa0786ae..c6c936818a3a 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -187,4 +187,52 @@ static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
 		dst[i] = be32_to_cpu(src[i]);
 }
 
+static inline __le256 cpu_to_le256(u256 val)
+{
+	__le256 ret;
+
+	ret.a = cpu_to_le64(val.a);
+	ret.b = cpu_to_le64(val.b);
+	ret.c = cpu_to_le64(val.c);
+	ret.d = cpu_to_le64(val.d);
+
+	return ret;
+}
+
+static inline u256 le256_to_cpu(__le256 val)
+{
+	u256 ret;
+
+	ret.a = le64_to_cpu(val.a);
+	ret.b = le64_to_cpu(val.b);
+	ret.c = le64_to_cpu(val.c);
+	ret.d = le64_to_cpu(val.d);
+
+	return ret;
+}
+
+static inline __be256 cpu_to_be256(u256 val)
+{
+	__be256 ret;
+
+	ret.a = cpu_to_be64(val.d);
+	ret.b = cpu_to_be64(val.c);
+	ret.c = cpu_to_be64(val.b);
+	ret.d = cpu_to_be64(val.a);
+
+	return ret;
+}
+
+static inline u256 be256_to_cpu(__be256 val)
+{
+	u256 ret;
+
+	ret.a = be64_to_cpu(val.d);
+	ret.b = be64_to_cpu(val.c);
+	ret.c = be64_to_cpu(val.b);
+	ret.d = be64_to_cpu(val.a);
+
+	return ret;
+}
+
 #endif /* _LINUX_BYTEORDER_GENERIC_H */
diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index 862d786a904f..9bdc42132020 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -55,4 +55,63 @@ static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 #define writeq_relaxed hi_lo_writeq_relaxed
 #endif
 
+static inline __u256 hi_lo_readqq(const volatile void __iomem *addr)
+{
+	const volatile u64 __iomem *p = addr;
+	__u256 ret;
+
+	ret.d = readq(p + 3);
+	ret.c = readq(p + 2);
+	ret.b = readq(p + 1);
+	ret.a = readq(p);
+
+	return ret;
+}
+
+static inline void hi_lo_writeqq(__u256 val, volatile void __iomem *addr)
+{
+	writeq(val.d, addr + 24);
+	writeq(val.c, addr + 16);
+	writeq(val.b, addr + 8);
+	writeq(val.a, addr);
+}
+
+static inline __u256 hi_lo_readqq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u64 __iomem *p = addr;
+	__u256 ret;
+
+	ret.d = readq_relaxed(p + 3);
+	ret.c = readq_relaxed(p + 2);
+	ret.b = readq_relaxed(p + 1);
+	ret.a = readq_relaxed(p);
+
+	return ret;
+}
+
+static inline void hi_lo_writeqq_relaxed(__u256 val,
+					 volatile void __iomem *addr)
+{
+	writeq_relaxed(val.d, addr + 24);
+	writeq_relaxed(val.c, addr + 16);
+	writeq_relaxed(val.b, addr + 8);
+	writeq_relaxed(val.a, addr);
+}
+
+#ifndef readqq
+#define readqq hi_lo_readqq
+#endif
+
+#ifndef writeqq
+#define writeqq hi_lo_writeqq
+#endif
+
+#ifndef readqq_relaxed
+#define readqq_relaxed hi_lo_readqq_relaxed
+#endif
+
+#ifndef writeqq_relaxed
+#define writeqq_relaxed hi_lo_writeqq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index d042e7bb5adb..8aaf734e1d51 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -55,4 +55,63 @@ static inline void lo_hi_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 #define writeq_relaxed lo_hi_writeq_relaxed
 #endif
 
+static inline __u256 lo_hi_readqq(const volatile void __iomem *addr)
+{
+	const volatile u64 __iomem *p = addr;
+	__u256 ret;
+
+	ret.a = readq(p);
+	ret.b = readq(p + 1);
+	ret.c = readq(p + 2);
+	ret.d = readq(p + 3);
+
+	return ret;
+}
+
+static inline void lo_hi_writeqq(__u256 val, volatile void __iomem *addr)
+{
+	writeq(val.a, addr);
+	writeq(val.b, addr + 8);
+	writeq(val.c, addr + 16);
+	writeq(val.d, addr + 24);
+}
+
+static inline __u256 lo_hi_readqq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u64 __iomem *p = addr;
+	__u256 ret;
+
+	ret.a = readq_relaxed(p);
+	ret.b = readq_relaxed(p + 1);
+	ret.c = readq_relaxed(p + 2);
+	ret.d = readq_relaxed(p + 3);
+
+	return ret;
+}
+
+static inline void lo_hi_writeqq_relaxed(__u256 val,
+					 volatile void __iomem *addr)
+{
+	writeq_relaxed(val.a, addr);
+	writeq_relaxed(val.b, addr + 8);
+	writeq_relaxed(val.c, addr + 16);
+	writeq_relaxed(val.d, addr + 24);
+}
+
+#ifndef readqq
+#define readqq lo_hi_readqq
+#endif
+
+#ifndef writeqq
+#define writeqq lo_hi_writeqq
+#endif
+
+#ifndef readqq_relaxed
+#define readqq_relaxed lo_hi_readqq_relaxed
+#endif
+
+#ifndef writeqq_relaxed
+#define writeqq_relaxed lo_hi_writeqq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
diff --git a/include/linux/types.h b/include/linux/types.h
index c94d59ef96cc..f4ee2857d253 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -114,6 +114,13 @@ typedef		__u64		u_int64_t;
 typedef		__s64		int64_t;
 #endif
 
+typedef struct {
+	__u64 a, b, c, d;
+} __u256;
+typedef __u256 u256;
+typedef __u256 __le256;
+typedef __u256 __be256;
+
 /* this is a special 64bit data type that is 8-byte aligned */
 #define aligned_u64 __u64 __attribute__((aligned(8)))
 #define aligned_be64 __be64 __attribute__((aligned(8)))
-- 
2.14.1
