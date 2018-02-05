Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeBEOQR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:16:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752933AbeBEOQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:16:04 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] nospec: Move array_index_nospec parameter checking into separate macro
Date: Mon,  5 Feb 2018 14:16:06 +0000
Message-Id: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For architectures providing their own implementation of
array_index_mask_nospec in asm/barrier.h, attempting to use WARN_ONCE to
complain about out-of-range parameters using WARN_ON results in a mess
of mutually-dependent include files.

Rather than unpick the dependencies, simply have the core code in nospec.h
perform the checking for us.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/nospec.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index b99bced39ac2..fbc98e2c8228 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -20,20 +20,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 						    unsigned long size)
 {
 	/*
-	 * Warn developers about inappropriate array_index_nospec() usage.
-	 *
-	 * Even if the CPU speculates past the WARN_ONCE branch, the
-	 * sign bit of @index is taken into account when generating the
-	 * mask.
-	 *
-	 * This warning is compiled out when the compiler can infer that
-	 * @index and @size are less than LONG_MAX.
-	 */
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
-			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
-		return 0;
-
-	/*
 	 * Always calculate and emit the mask even if the compiler
 	 * thinks the mask is not needed. The compiler does not take
 	 * into account the value of @index under speculation.
@@ -44,6 +30,26 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #endif
 
 /*
+ * Warn developers about inappropriate array_index_nospec() usage.
+ *
+ * Even if the CPU speculates past the WARN_ONCE branch, the
+ * sign bit of @index is taken into account when generating the
+ * mask.
+ *
+ * This warning is compiled out when the compiler can infer that
+ * @index and @size are less than LONG_MAX.
+ */
+#define array_index_mask_nospec_check(index, size)				\
+({										\
+	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
+	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
+		_mask = 0;							\
+	else									\
+		_mask = array_index_mask_nospec(index, size);			\
+	_mask;									\
+})
+
+/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -61,7 +67,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
-- 
2.1.4
