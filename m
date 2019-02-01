Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B0AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C8120869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfBAK7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:59:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfBAK7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:59:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11AwcKh3280935
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 02:58:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11AwcR53280932;
        Fri, 1 Feb 2019 02:58:38 -0800
Date:   Fri, 1 Feb 2019 02:58:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-de50ce20cd05da4d1a7e5709a12fc23bc0b66be9@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com,
        mingo@kernel.org, x86@kernel.org, keescook@chromium.org,
        bp@suse.de, linux-kernel@vger.kernel.org, fanc.fnst@cn.fujitsu.com
Reply-To: keescook@chromium.org, bp@suse.de, linux-kernel@vger.kernel.org,
          fanc.fnst@cn.fujitsu.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@redhat.com, mingo@kernel.org, x86@kernel.org
In-Reply-To: <20190123110850.12433-2-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-2-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Copy kstrtoull() to boot/string.c
Git-Commit-ID: de50ce20cd05da4d1a7e5709a12fc23bc0b66be9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  de50ce20cd05da4d1a7e5709a12fc23bc0b66be9
Gitweb:     https://git.kernel.org/tip/de50ce20cd05da4d1a7e5709a12fc23bc0b66be9
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:44 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:54 +0100

x86/boot: Copy kstrtoull() to boot/string.c

Copy kstrtoull() and the other necessary functions from lib/kstrtox.c
to boot/string.c so that code in boot/ can use kstrtoull() and the old
simple_strtoull() can gradually be phased out.

Using div_u64() from math64.h directly will cause the dividend to be
handled as a 64-bit value and cause the infamous __divdi3 linker error
due to gcc trying to use its library function for the 64-bit division.

Therefore, separate the dividend into an upper and lower part.

 [ bp: Rewrite commit message. ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-2-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/string.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
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
