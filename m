Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227y6GsPLVEJAU7YedX+yOpBXw/2+3AllFhyHik+52Wlo6am0rTYLJryE3PqKTX9wrbuDRZe
ARC-Seal: i=1; a=rsa-sha256; t=1517855127; cv=none;
        d=google.com; s=arc-20160816;
        b=xF9NK0l81sK8988q4x2iVJqrG2PmeT3NfpT/ym1gHMoxxSBaUo8ZlS229rnO064gJ/
         LFk/RKADFYgTjMHpcOPOcS+QZX4xXG/cLf5XIGwXaeFgAkmBg01Fehh2T2+AY7wapHuc
         11Mijbws0oisWY2BWO5e9EcwTdn0t6/XlCjPxQ6pfEXAkitT3rc0h5VAWR8CvQ9rGYH5
         rzPCqGTt61cr6BZXHe3WNrLPvfBL1b3UwO5MYb2JlyOBBqGlTOPKzYTOpUOeiIFfgSDj
         xKnrV9CasrEAUdQdcp6BvdBC5AQM8PatcZ8cl6DVgtL6CRoAAzRkW9m9d7tUS+Mq7o25
         TEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qvaU4YXIQEFLhz524gVG8SuCGktClYtMASQIZYOHi/w=;
        b=W1aT6p2Cqu34C8YBpmEXmfT36vrqlB97wPkl6iV4DI8m4B8y9GFMJ1PD1VAGzrXm7H
         lBNM6WOOVgVqPNsXXpL+XF4vytEtLwv90/t1E4kJpDPOJmyBZY2B29FkWd8nN22k+8F1
         uQLIu+DkRNQ40qK1YltHPmO3ogsh8e3tsTIVT3uzRhOs4+Lc+rbKs39eWLaQvHAhTxFN
         gqaX222vLyFQKIsBA6osbszrGs6KFEu+ClcUHgLR2lc8JV2rYX2q8zIC8srKWQjElP/U
         9deXDUBo6TS0oJy/BNEXnWSvLdPT9DysT5NQCwgEEmWvGLX8kGRBQ936ZL09oCVgNNci
         R9RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Cyril Novikov <cnovikov@lynx.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	torvalds@linux-foundation.org,
	alan@linux.intel.com
Subject: [PATCH 4.15 33/60] array_index_nospec: Sanitize speculative array de-references
Date: Mon,  5 Feb 2018 10:23:06 -0800
Message-Id: <20180205182215.312530327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586383314058175?=
X-GMAIL-MSGID: =?utf-8?q?1591586457850299078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit f3804203306e098dae9ca51540fcd5eb700d7f40

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 include/linux/nospec.h |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

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
