Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeA3Wjx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:39:53 -0500
Received: from terminus.zytor.com ([65.50.211.136]:35185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeA3Wju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:39:50 -0500
Date: Tue, 30 Jan 2018 14:34:18 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-f3804203306e098dae9ca51540fcd5eb700d7f40@git.kernel.org>
Cc: dan.j.williams@intel.com, will.deacon@arm.com, tglx@linutronix.de,
        linux@armlinux.org.uk, cnovikov@lynx.com, mingo@kernel.org,
        ast@kernel.org, catalin.marinas@arm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, cnovikov@lynx.com,
        linux@armlinux.org.uk, will.deacon@arm.com, tglx@linutronix.de,
        dan.j.williams@intel.com, ast@kernel.org, mingo@kernel.org
In-Reply-To: <151727414229.33451.18411580953862676575.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727414229.33451.18411580953862676575.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] array_index_nospec: Sanitize speculative array
 de-references
Git-Commit-ID: f3804203306e098dae9ca51540fcd5eb700d7f40
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

Commit-ID:  f3804203306e098dae9ca51540fcd5eb700d7f40
Gitweb:     https://git.kernel.org/tip/f3804203306e098dae9ca51540fcd5eb700d7f40
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:22 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:29 +0100

array_index_nospec: Sanitize speculative array de-references

array_index_nospec() is proposed as a generic mechanism to mitigate
against Spectre-variant-1 attacks, i.e. an attack that bypasses boundary
checks via speculative execution. The array_index_nospec()
implementation is expected to be safe for current generation CPUs across
multiple architectures (ARM, x86).

Based on an original implementation by Linus Torvalds, tweaked to remove
speculative flows by Alexei Starovoitov, and tweaked again by Linus to
introduce an x86 assembly implementation for the mask generation.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Cyril Novikov <cnovikov@lynx.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414229.33451.18411580953862676575.stgit@dwillia2-desk3.amr.corp.intel.com

---
 include/linux/nospec.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
new file mode 100644
index 0000000..b99bced
--- /dev/null
+++ b/include/linux/nospec.h
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2018 Linus Torvalds. All rights reserved.
+// Copyright(c) 2018 Alexei Starovoitov. All rights reserved.
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+
+#ifndef _LINUX_NOSPEC_H
+#define _LINUX_NOSPEC_H
+
+/**
+ * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * When @index is out of bounds (@index >= @size), the sign bit will be
+ * set.  Extend the sign bit to all bits and invert, giving a result of
+ * zero for an out of bounds index, or ~0 if within bounds [0, @size).
+ */
+#ifndef array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	/*
+	 * Warn developers about inappropriate array_index_nospec() usage.
+	 *
+	 * Even if the CPU speculates past the WARN_ONCE branch, the
+	 * sign bit of @index is taken into account when generating the
+	 * mask.
+	 *
+	 * This warning is compiled out when the compiler can infer that
+	 * @index and @size are less than LONG_MAX.
+	 */
+	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
+			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
+		return 0;
+
+	/*
+	 * Always calculate and emit the mask even if the compiler
+	 * thinks the mask is not needed. The compiler does not take
+	 * into account the value of @index under speculation.
+	 */
+	OPTIMIZER_HIDE_VAR(index);
+	return ~(long)(index | (size - 1UL - index)) >> (BITS_PER_LONG - 1);
+}
+#endif
+
+/*
+ * array_index_nospec - sanitize an array index after a bounds check
+ *
+ * For a code sequence like:
+ *
+ *     if (index < size) {
+ *         index = array_index_nospec(index, size);
+ *         val = array[index];
+ *     }
+ *
+ * ...if the CPU speculates past the bounds check then
+ * array_index_nospec() will clamp the index within the range of [0,
+ * size).
+ */
+#define array_index_nospec(index, size)					\
+({									\
+	typeof(index) _i = (index);					\
+	typeof(size) _s = (size);					\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+									\
+	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
+	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
+									\
+	_i &= _mask;							\
+	_i;								\
+})
+#endif /* _LINUX_NOSPEC_H */
