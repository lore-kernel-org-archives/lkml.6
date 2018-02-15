Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032280AbeBOA30 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:29:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeBOA3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:29:24 -0500
Date: Wed, 14 Feb 2018 16:28:00 -0800
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-8fa80c503b484ddc1abbd10c7cb2ab81f3824a50@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, will.deacon@arm.com,
        peterz@infradead.org, dan.j.williams@intel.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com,
        tglx@linutronix.de, hpa@zytor.com, dan.j.williams@intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
References: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] nospec: Move array_index_nospec() parameter checking
 into separate macro
Git-Commit-ID: 8fa80c503b484ddc1abbd10c7cb2ab81f3824a50
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8fa80c503b484ddc1abbd10c7cb2ab81f3824a50
Gitweb:     https://git.kernel.org/tip/8fa80c503b484ddc1abbd10c7cb2ab81f3824a50
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Mon, 5 Feb 2018 14:16:06 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:51 +0100

nospec: Move array_index_nospec() parameter checking into separate macro

For architectures providing their own implementation of
array_index_mask_nospec() in asm/barrier.h, attempting to use WARN_ONCE() to
complain about out-of-range parameters using WARN_ON() results in a mess
of mutually-dependent include files.

Rather than unpick the dependencies, simply have the core code in nospec.h
perform the checking for us.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1517840166-15399-1-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nospec.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index b99bced..fbc98e2 100644
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
