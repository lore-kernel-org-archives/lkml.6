Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtFCaaUNl9rx5CBX+UChJFgp1ly+B6wT1jBErjV5qSvAmbDqHDeVjubQFlgUNTou9qxQqU3
ARC-Seal: i=1; a=rsa-sha256; t=1520824062; cv=none;
        d=google.com; s=arc-20160816;
        b=n9CC1zPEWs6UZgkBPzE+DP4lw7HfGaeAN5DC08aH5iic6x29Qs9u7GgwCvxwsuj+kr
         DzQ8KXN6Zp/wrbnvacJR/xh0ltIpfa6OpgW65jgAxvHxbgZ6038O6zlRhL12bhNGdVri
         tlSCFELY717Y3MjmAeqIH5+/io6tWEy9Bpsh5nGgSohUNBgvE2kMLVjBWCn1Vmon1ePC
         Iz9I+QhSF4Da8pEUYFcW7EGlfALJHUw1swOEYI8acYEpTP6Q7vf/R3cWkYjySdsEN5Sy
         lDbO2o1DpY7sQxV9ZfcC9IDj54AHcitrXPu+3k+Dh/CffiN1nfw5XZ1nkHSJbfGA5kis
         aWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+Ky8nmlsEAVt+eKwq99t/+TVdmUsSsMH4sVkKvYnetY=;
        b=l7rVHcP3GHRTZQnzL6VwiQvzaxYGulCYLJxpZDrMC1MRqrp3Gm1iU/ScNNY52ykv+d
         cB/iChwMJaVjFKLhy9j9iL66mxtY8K5ZAkBCEPmN2YJ+WWfKVbfjgeRUI+AUdPW2EN2j
         rxJBivkgtb2qPlAik59cZiSWWSnoRwGYzNkBo2PQTbOBLKDAP46MtJkpRAW7fgRrrH1Z
         fRBb/MspYLymWvxiHeMf1Nc3+0MrLLz60rZDGYeu8mXQMxVVuId5kXaCaFjofQzyHkJa
         UIhJCTx66d2WjI5cWxfZpKuQiGYMFKy6IBuUYzGbBGJSDmhrngKSI8PDM+M4A1n3pII6
         rzkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Will Deacon" <will.deacon@arm.com>,
 linux-arch@vger.kernel.org,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Russell King" <linux@armlinux.org.uk>,
 "Dan Williams" <dan.j.williams@intel.com>,
 torvalds@linux-foundation.org,
 "Peter Zijlstra" <peterz@infradead.org>,
 kernel-hardening@lists.openwall.com, alan@linux.intel.com,
 "Cyril Novikov" <cnovikov@lynx.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.577754296@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 083/104] array_index_nospec: Sanitize speculative
 array de-references
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699612399286204?=
X-GMAIL-MSGID: =?utf-8?q?1594699612399286204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit f3804203306e098dae9ca51540fcd5eb700d7f40 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/linux/nospec.h

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
