Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F512C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBABB214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBABB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeLFKht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:37:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23319 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727763AbeLFKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:37:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,321,1539619200"; 
   d="scan'208";a="49118429"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Dec 2018 18:37:47 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C7E3B4B7349C;
        Thu,  6 Dec 2018 18:37:47 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Dec 2018 18:37:54 +0800
Date:   Thu, 6 Dec 2018 18:37:20 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181206103720.GA2046@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181130024346.GB30941@localhost.localdomain>
 <20181130173515.6zx5wvs52s5aqnge@gabell>
 <20181201060539.GD30941@localhost.localdomain>
 <20181204184220.GC16705@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181204184220.GC16705@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C7E3B4B7349C.ACA7B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Baoquan and Masa,

When copying kstrtoull() and functions needed to arch/x86/boot/string.c,
I got an error in LD period:

  LD      arch/x86/boot/setup.elf
ld: arch/x86/boot/string.o: in function `div_u64_rem':
/home/cfan/code/tip/./include/linux/math64.h:28: undefined reference to `__udivdi3'
make[1]: *** [arch/x86/boot/Makefile:105: arch/x86/boot/setup.elf] Error 1
make: *** [arch/x86/Makefile:289: bzImage] Error 2

I google it and the key problem is div_u64(ULLONG_MAX - val, base))
when dividend is u64 and divisor is u32, the dividend must be a variable,
since the result will be stored in the first variable.
So here when I changed it to ((ULLONG_MAX - val) / base), I got the
same error.
But what puzzled me is, why the cdoe in lib/kstrtox.c works well.
And in old version PATCHSET, I ever copy the code to
arch/x86/boot/compressed/misc.c, it also worked well.

So I wonder if there are some options I miss or some problems.
The patch is below.

Thanks,
Chao Fan


diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c4428a176973..62ffe0437c8e 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,6 +13,9 @@
  */

 #include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
@@ -187,3 +190,112 @@ char *strchr(const char *s, int c)
                        return NULL;
        return (char *)s;
 }
+
+static inline char _tolower(const char c)
+{
+       return c | 0x20;
+}
+
+const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
+{
+       if (*base == 0) {
+               if (s[0] == '0') {
+                       if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
+                               *base = 16;
+                       else
+                               *base = 8;
+               } else
+                       *base = 10;
+       }
+       if (*base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
+               s += 2;
+       return s;
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
+unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+       unsigned long long res;
+       unsigned int rv;
+
+       res = 0;
+       rv = 0;
+       while (1) {
+               unsigned int c = *s;
+               unsigned int lc = c | 0x20; /* don't tolower() this line */
+               unsigned int val;
+
+               if ('0' <= c && c <= '9')
+                       val = c - '0';
+               else if ('a' <= lc && lc <= 'f')
+                       val = lc - 'a' + 10;
+               else
+                       break;
+
+               if (val >= base)
+                       break;
+               /*
+                * Check for overflow only if we are within range of
+                * it in the max base we support (16)
+                */
+               if (unlikely(res & (~0ull << 60))) {
+                       if (res > div_u64(ULLONG_MAX - val, base))
+                               rv |= KSTRTOX_OVERFLOW;
+               }
+               res = res * base + val;
+               rv++;
+               s++;
+       }
+       *p = res;
+       return rv;
+}
+
+static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+{
+       unsigned long long _res;
+       unsigned int rv;
+
+       s = _parse_integer_fixup_radix(s, &base);
+       rv = _parse_integer(s, base, &_res);
+       if (rv & KSTRTOX_OVERFLOW)
+               return -ERANGE;
+       if (rv == 0)
+               return -EINVAL;
+       s += rv;
+       if (*s == '\n')
+               s++;
+       if (*s)
+               return -EINVAL;
+       *res = _res;
+       return 0;
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
+       if (s[0] == '+')
+               s++;
+       return _kstrtoull(s, base, res);
+}
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 3d78e27077f4..9619c8990d95 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -29,4 +29,6 @@ extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
                                          unsigned int base);

+#define KSTRTOX_OVERFLOW       (1U << 31)
+
 #endif /* BOOT_STRING_H */


