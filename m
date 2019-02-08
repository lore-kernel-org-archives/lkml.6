Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C36C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C22177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBHPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:60056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbfBHPYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4720B148;
        Fri,  8 Feb 2019 15:24:28 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing invalid pointers
Date:   Fri,  8 Feb 2019 16:23:09 +0100
Message-Id: <20190208152310.29531-9-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already prevent crash when dereferencing some obviously broken
pointers. But the handling is not consistent. Sometimes we print "(null)"
only for pure NULL pointer, sometimes for pointers in the first
page and sometimes also for pointers in the last page (error codes).

Note that printk() call this code under logbuf_lock. Any recursive
printks are redirected to the printk_safe implementation and the messages
are stored into per-CPU buffers. These buffers might be eventually flushed
in printk_safe_flush_on_panic() but it is not guaranteed.

This patch adds a check using probe_kernel_read(). It is not a full-proof
test. But it should help to see the error message in 99% situations where
the kernel would silently crash otherwise.

Also it makes the error handling unified for "%s" and the many %p*
specifiers that need to read the data from a given address. We print:

   + (null)   when accessing data on pure pure NULL address
   + (efault) when accessing data on an invalid address

It does not affect the %p* specifiers that just print the given address
in some form, namely %pF, %pf, %pS, %ps, %pB, %pK, %px, and plain %p.

Note that we print (efault) from security reasons. In fact, the real
address can be seen only by %px or eventually %pK.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst |   7 ++
 lib/test_printf.c                         |  39 +++++++--
 lib/vsprintf.c                            | 132 ++++++++++++++++++++++--------
 3 files changed, 136 insertions(+), 42 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index a7fae4538946..732943b36828 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -50,6 +50,13 @@ A raw pointer value may be printed with %p which will hash the address
 before printing. The kernel also supports extended specifiers for printing
 pointers of different types.
 
+Some of the extended specifiers print the data on the given address instead
+of printing the address itself. In this case, the following error messages
+might be printed instead of the unreachable information::
+
+	(null)	 data on plain NULL address
+	(efault) data on invalid address
+
 Plain Pointers
 --------------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 159bb78b3992..2a701e2e5d24 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -211,12 +211,12 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
 static int __init
-plain_format(void)
+plain_format(void *ptr)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
+	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", ptr);
 
 	if (nchars != PTR_WIDTH)
 		return -1;
@@ -239,9 +239,10 @@ plain_format(void)
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
+#define ZEROS ""
 
 static int __init
-plain_format(void)
+plain_format(void *ptr)
 {
 	/* Format is implicitly tested for 32 bit machines by plain_hash() */
 	return 0;
@@ -250,12 +251,12 @@ plain_format(void)
 #endif	/* BITS_PER_LONG == 64 */
 
 static int __init
-plain_hash(void)
+plain_hash(void *ptr)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, sizeof(buf), "%p", PTR);
+	nchars = snprintf(buf, sizeof(buf), "%p", ptr);
 
 	if (nchars != PTR_WIDTH)
 		return -1;
@@ -277,18 +278,18 @@ plain_hash(void)
  * after an address is hashed.
  */
 static void __init
-plain(void)
+plain(void *ptr)
 {
 	int err;
 
-	err = plain_hash();
+	err = plain_hash(ptr);
 	if (err) {
 		pr_warn("plain 'p' does not appear to be hashed\n");
 		failed_tests++;
 		return;
 	}
 
-	err = plain_format();
+	err = plain_format(ptr);
 	if (err) {
 		pr_warn("hashing plain 'p' has unexpected format\n");
 		failed_tests++;
@@ -296,6 +297,24 @@ plain(void)
 }
 
 static void __init
+null_pointer(void)
+{
+	plain(NULL);
+	test(ZEROS "00000000", "%px", NULL);
+	test("(null)", "%pE", NULL);
+}
+
+#define PTR_INVALID ((void *)0x000000ab)
+
+static void __init
+invalid_pointer(void)
+{
+	plain(PTR_INVALID);
+	test(ZEROS "000000ab", "%px", PTR_INVALID);
+	test("(efault)", "%pE", PTR_INVALID);
+}
+
+static void __init
 symbol_ptr(void)
 {
 }
@@ -540,7 +559,9 @@ flags(void)
 static void __init
 test_pointer(void)
 {
-	plain();
+	plain(PTR);
+	null_pointer();
+	invalid_pointer();
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d8509f6adda6..3a95b4d1ca2e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -611,12 +611,45 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
+ /*
+  * This is not a fool-proof test. 99% of the time that this will fault is
+  * due to a bad pointer, not one that crosses into bad memory. Just test
+  * the address to make sure it doesn't fault due to a poorly added printk
+  * during debugging.
+  */
+static const char *check_pointer_msg(const void *ptr)
+{
+	char byte;
+
+	if (!ptr)
+		return "(null)";
+
+	if (probe_kernel_address(ptr, byte))
+		return "(efault)";
+
+	return NULL;
+}
+
+static int check_pointer(char **buf, char *end, const void *ptr,
+			     struct printf_spec spec)
+{
+	const char *err_msg;
+
+	err_msg = check_pointer_msg(ptr);
+	if (err_msg) {
+		*buf = string_nocheck(*buf, end, err_msg, spec);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static noinline_for_stack
 char *string(char *buf, char *end, const char *s,
 		   struct printf_spec spec)
 {
-	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
+	if (check_pointer(&buf, end, s, spec))
+		return buf;
 
 	return string_nocheck(buf, end, s, spec);
 }
@@ -791,6 +824,11 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
+		if (check_pointer(&buf, end, d, spec)) {
+			rcu_read_unlock();
+			return buf;
+		}
+
 		p = READ_ONCE(d->d_parent);
 		array[i] = READ_ONCE(d->d_name.name);
 		if (p == d) {
@@ -821,8 +859,12 @@ static noinline_for_stack
 char *bdev_name(char *buf, char *end, struct block_device *bdev,
 		struct printf_spec spec, const char *fmt)
 {
-	struct gendisk *hd = bdev->bd_disk;
-	
+	struct gendisk *hd;
+
+	if (check_pointer(&buf, end, bdev, spec))
+		return buf;
+
+	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
 	if (bdev->bd_part->partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
@@ -941,6 +983,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
+	if (check_pointer(&buf, end, res, spec))
+		return buf;
+
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
 		p = string_nocheck(p, pend, "io  ", str_spec);
@@ -1003,9 +1048,8 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		/* nothing to print */
 		return buf;
 
-	if (ZERO_OR_NULL_PTR(addr))
-		/* NULL pointer */
-		return string(buf, end, NULL, spec);
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'C':
@@ -1052,6 +1096,9 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 	int i, chunksz;
 	bool first = true;
 
+	if (check_pointer(&buf, end, bitmap, spec))
+		return buf;
+
 	/* reused to print numbers */
 	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
 
@@ -1093,6 +1140,9 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	int cur, rbot, rtop;
 	bool first = true;
 
+	if (check_pointer(&buf, end, bitmap, spec))
+		return buf;
+
 	rbot = cur = find_first_bit(bitmap, nr_bits);
 	while (cur < nr_bits) {
 		rtop = cur;
@@ -1131,6 +1181,9 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	char separator;
 	bool reversed = false;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		separator = '-';
@@ -1436,6 +1489,9 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 {
 	char *err_fmt_msg;
 
+	if (check_pointer(&buf, end, ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case '6':
 		return ip6_addr_string(buf, end, ptr, spec, fmt);
@@ -1474,9 +1530,8 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (spec.field_width == 0)
 		return buf;				/* nothing to print */
 
-	if (ZERO_OR_NULL_PTR(addr))
-		return string(buf, end, NULL, spec);	/* NULL pointer */
-
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
 
 	do {
 		switch (fmt[count++]) {
@@ -1522,10 +1577,14 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
-static char *va_format(char *buf, char *end, struct va_format *va_fmt)
+static char *va_format(char *buf, char *end, struct va_format *va_fmt,
+		       struct printf_spec spec, const char *fmt)
 {
 	va_list va;
 
+	if (check_pointer(&buf, end, va_fmt, spec))
+		return buf;
+
 	va_copy(va, *va_fmt->va);
 	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
 	va_end(va);
@@ -1543,6 +1602,9 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	const u8 *index = uuid_index;
 	bool uc = false;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (*(++fmt)) {
 	case 'L':
 		uc = true;		/* fall-through */
@@ -1581,6 +1643,9 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 	unsigned long long num;
 	int size;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		num = *(const netdev_features_t *)addr;
@@ -1594,11 +1659,15 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 }
 
 static noinline_for_stack
-char *address_val(char *buf, char *end, const void *addr, const char *fmt)
+char *address_val(char *buf, char *end, const void *addr,
+		  struct printf_spec spec, const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
+	if (check_pointer(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'd':
 		num = *(const dma_addr_t *)addr;
@@ -1650,12 +1719,16 @@ char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
 }
 
 static noinline_for_stack
-char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
+char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
+	      struct printf_spec spec, const char *fmt)
 {
 	bool have_t = true, have_d = true;
 	bool raw = false;
 	int count = 2;
 
+	if (check_pointer(&buf, end, tm, spec))
+		return buf;
+
 	switch (fmt[count]) {
 	case 'd':
 		have_t = false;
@@ -1689,7 +1762,7 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 {
 	switch (fmt[1]) {
 	case 'R':
-		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
+		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
 	default:
 		return string_nocheck(buf, end, "(%ptR?)", spec);
 	}
@@ -1702,8 +1775,8 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
 		return string_nocheck(buf, end, "(%pC?)", spec);
 
-	if (!clk)
-		return string(buf, end, NULL, spec);
+	if (check_pointer(&buf, end, clk, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'n':
@@ -1750,6 +1823,9 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
+	if (check_pointer(&buf, end, flags_ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
@@ -2021,18 +2097,6 @@ static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
-	const int default_width = 2 * sizeof(void *);
-
-	if (!ptr && *fmt != 'K' && *fmt != 'x') {
-		/*
-		 * Print (null) with the same width as a pointer so it makes
-		 * tabular output look nice.
-		 */
-		if (spec.field_width == -1)
-			spec.field_width = default_width;
-		return string_nocheck(buf, end, "(null)", spec);
-	}
-
 	switch (*fmt) {
 	case 'F':
 	case 'f':
@@ -2074,13 +2138,13 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		return va_format(buf, end, ptr);
+		return va_format(buf, end, ptr, spec, fmt);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
 		return netdev_bits(buf, end, ptr, spec, fmt);
 	case 'a':
-		return address_val(buf, end, ptr, fmt);
+		return address_val(buf, end, ptr, spec, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
 	case 't':
@@ -2714,11 +2778,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
 		case FORMAT_TYPE_STR: {
 			const char *save_str = va_arg(args, char *);
+			const char *err_msg;
 			size_t len;
 
-			if ((unsigned long)save_str > (unsigned long)-PAGE_SIZE
-					|| (unsigned long)save_str < PAGE_SIZE)
-				save_str = "(null)";
+			err_msg = check_pointer_msg(save_str);
+			if (err_msg)
+				save_str = err_msg;
+
 			len = strlen(save_str) + 1;
 			if (str + len < end)
 				memcpy(str, save_str, len);
-- 
2.13.7

