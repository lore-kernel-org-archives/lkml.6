Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeA3Wg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:36:56 -0500
Received: from terminus.zytor.com ([65.50.211.136]:46653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeA3Wgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:36:55 -0500
Date: Tue, 30 Jan 2018 14:34:44 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-babdde2698d482b6c0de1eab4f697cf5856c5859@git.kernel.org>
Cc: dan.j.williams@intel.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com
In-Reply-To: <151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86: Implement array_index_mask_nospec
Git-Commit-ID: babdde2698d482b6c0de1eab4f697cf5856c5859
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

Commit-ID:  babdde2698d482b6c0de1eab4f697cf5856c5859
Gitweb:     https://git.kernel.org/tip/babdde2698d482b6c0de1eab4f697cf5856c5859
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:28 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:29 +0100

x86: Implement array_index_mask_nospec

array_index_nospec() uses a mask to sanitize user controllable array
indexes, i.e. generate a 0 mask if 'index' >= 'size', and a ~0 mask
otherwise. While the default array_index_mask_nospec() handles the
carry-bit from the (index - size) result in software.

The x86 array_index_mask_nospec() does the same, but the carry-bit is
handled in the processor CF flag without conditional instructions in the
control flow.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/include/asm/barrier.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7fb3362..173b38f 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -24,6 +24,30 @@
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+/**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=r" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
