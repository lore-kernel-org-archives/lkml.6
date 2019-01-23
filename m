Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE6A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAWLKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:10:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7521 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727181AbfAWLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:10:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651109"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:10:03 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 31EDF4C4A88D;
        Wed, 23 Jan 2019 19:10:03 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:10:09 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>, <kasong@redhat.com>
Subject: [PATCH v16 1/7] x86/boot: Copy kstrtoull() to boot/string.c instead of simple_strtoull()
Date:   Wed, 23 Jan 2019 19:08:44 +0800
Message-ID: <20190123110850.12433-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 31EDF4C4A88D.AAC8E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy kstrtoull() and necessary functions from lib/kstrtox.c to
boot/string.c so that code in boot/ can use kstrtoull() and the old
simple_strtoull() can be replaced.

In boot/string.c, using div_u64() from math64.h directly will cause the
dividend handled as 64-bit value and bring ld error. The solution is to
separate the dividend to upper and lower in boot/string.o. So copy the
useful div_u64() and div_u64_rem() to boot/string.c also. To avoid
redefinition in i386, rename them as __div_u64() and __div_u64_rem().

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/string.c | 141 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/string.h |   1 +
 2 files changed, 142 insertions(+)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c4428a176973..315a67b8896b 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,10 +13,14 @@
  */
 
 #include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
 
+#define KSTRTOX_OVERFLOW       (1U << 31)
+
 /*
  * Undef these macros so that the functions that we provide
  * here will have the correct names regardless of how string.h
@@ -187,3 +191,140 @@ char *strchr(const char *s, int c)
 			return NULL;
 	return (char *)s;
 }
+
+static inline u64 __div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
+{
+	union {
+		u64 v64;
+		u32 v32[2];
+	} d = { dividend };
+	u32 upper;
+
+	upper = d.v32[1];
+	d.v32[1] = 0;
+	if (upper >= divisor) {
+		d.v32[1] = upper / divisor;
+		upper %= divisor;
+	}
+	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
+		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
+	return d.v64;
+}
+
+static inline u64 __div_u64(u64 dividend, u32 divisor)
+{
+	u32 remainder;
+
+	return __div_u64_rem(dividend, divisor, &remainder);
+}
+
+static inline char _tolower(const char c)
+{
+	return c | 0x20;
+}
+
+static const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
+{
+	if (*base == 0) {
+		if (s[0] == '0') {
+			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
+				*base = 16;
+			else
+				*base = 8;
+		} else
+			*base = 10;
+	}
+	if (*base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
+		s += 2;
+	return s;
+}
+
+/*
+ * Convert non-negative integer string representation in explicitly given radix
+ * to an integer.
+ * Return number of characters consumed maybe or-ed with overflow bit.
+ * If overflow occurs, result integer (incorrect) is still returned.
+ *
+ * Don't you dare use this function.
+ */
+static unsigned int _parse_integer(const char *s,
+				   unsigned int base,
+				   unsigned long long *p)
+{
+	unsigned long long res;
+	unsigned int rv;
+
+	res = 0;
+	rv = 0;
+	while (1) {
+		unsigned int c = *s;
+		unsigned int lc = c | 0x20; /* don't tolower() this line */
+		unsigned int val;
+
+		if ('0' <= c && c <= '9')
+			val = c - '0';
+		else if ('a' <= lc && lc <= 'f')
+			val = lc - 'a' + 10;
+		else
+			break;
+
+		if (val >= base)
+			break;
+		/*
+		 * Check for overflow only if we are within range of
+		 * it in the max base we support (16)
+		 */
+		if (unlikely(res & (~0ull << 60))) {
+			if (res > __div_u64(ULLONG_MAX - val, base))
+				rv |= KSTRTOX_OVERFLOW;
+		}
+		res = res * base + val;
+		rv++;
+		s++;
+	}
+	*p = res;
+	return rv;
+}
+
+static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+{
+	unsigned long long _res;
+	unsigned int rv;
+
+	s = _parse_integer_fixup_radix(s, &base);
+	rv = _parse_integer(s, base, &_res);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+	if (rv == 0)
+		return -EINVAL;
+	s += rv;
+	if (*s == '\n')
+		s++;
+	if (*s)
+		return -EINVAL;
+	*res = _res;
+	return 0;
+}
+
+/**
+ * kstrtoull - convert a string to an unsigned long long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Used as a replacement for the obsolete simple_strtoull. Return code must
+ * be checked.
+ */
+int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+{
+	if (s[0] == '+')
+		s++;
+	return _kstrtoull(s, base, res);
+}
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 3d78e27077f4..38d8f2f5e47e 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -29,4 +29,5 @@ extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 
+int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 #endif /* BOOT_STRING_H */
-- 
2.20.1



