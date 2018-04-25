Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbeDYLOB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753850AbeDYLNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:51 -0400
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 09/11] vsprintf: Prevent crash when dereferencing invalid pointers
Date: Wed, 25 Apr 2018 13:12:49 +0200
Message-Id: <20180425111251.13246-10-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 lib/test_printf.c                         |  37 +++++++--
 lib/vsprintf.c                            | 128 ++++++++++++++++++++++--------
 3 files changed, 131 insertions(+), 41 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index eb30efdd2e78..7c73bed2fad8 100644
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
index cea592f402ed..45c33143fb4a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -209,12 +209,12 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
 static int __init
-plain_format(void)
+plain_format(void *ptr)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
+	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", ptr);
 
 	if (nchars != PTR_WIDTH || strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
 		return -1;
@@ -227,6 +227,7 @@ plain_format(void)
 #define PTR_WIDTH 8
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
+#define ZEROS ""
 
 static int __init
 plain_format(void)
@@ -238,12 +239,12 @@ plain_format(void)
 #endif	/* BITS_PER_LONG == 64 */
 
 static int __init
-plain_hash(void)
+plain_hash(void *ptr)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
+	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", ptr);
 
 	if (nchars != PTR_WIDTH || strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
 		return -1;
@@ -256,18 +257,18 @@ plain_hash(void)
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
@@ -275,6 +276,24 @@ plain(void)
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
@@ -497,7 +516,9 @@ flags(void)
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
index 3536796c483c..5dfdc7e11d05 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -610,12 +610,45 @@ static char *valid_string(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
+ /*
+  * This is not a fool-proof test. 99% of the time that this will fault is
+  * due to a bad pointer, not one that crosses into bad memory. Just test
+  * the address to make sure it doesn't fault due to a poorly added printk
+  * during debugging.
+  */
+static const char *check_pointer_access(const void *ptr)
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
+static bool valid_pointer_access(char **buf, char *end, const void *ptr,
+				 struct printf_spec spec)
+{
+	const char *err_msg;
+
+	err_msg = check_pointer_access(ptr);
+	if (err_msg) {
+		*buf = valid_string(*buf, end, err_msg, spec);
+		return false;
+	}
+
+	return true;
+}
+
 static noinline_for_stack
 char *string(char *buf, char *end, const char *s,
 		   struct printf_spec spec)
 {
-	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
+	if (!valid_pointer_access(&buf, end, s, spec))
+		return buf;
 
 	return valid_string(buf, end, s, spec);
 }
@@ -761,6 +794,11 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
+		if (!valid_pointer_access(&buf, end, d, spec)) {
+			rcu_read_unlock();
+			return buf;
+		}
+
 		p = READ_ONCE(d->d_parent);
 		array[i] = READ_ONCE(d->d_name.name);
 		if (p == d) {
@@ -791,8 +829,12 @@ static noinline_for_stack
 char *bdev_name(char *buf, char *end, struct block_device *bdev,
 		struct printf_spec spec, const char *fmt)
 {
-	struct gendisk *hd = bdev->bd_disk;
-	
+	struct gendisk *hd;
+
+	if (!valid_pointer_access(&buf, end, bdev, spec))
+		return buf;
+
+	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
 	if (bdev->bd_part->partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
@@ -897,6 +939,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
+	if (!valid_pointer_access(&buf, end, res, spec))
+		return buf;
+
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
 		p = valid_string(p, pend, "io  ", str_spec);
@@ -959,9 +1004,8 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		/* nothing to print */
 		return buf;
 
-	if (ZERO_OR_NULL_PTR(addr))
-		/* NULL pointer */
-		return string(buf, end, NULL, spec);
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'C':
@@ -1008,6 +1052,9 @@ char *bitmap_string(char *buf, char *end, unsigned long *bitmap,
 	int i, chunksz;
 	bool first = true;
 
+	if (!valid_pointer_access(&buf, end, bitmap, spec))
+		return buf;
+
 	/* reused to print numbers */
 	spec = (struct printf_spec){ .flags = SMALL | ZEROPAD, .base = 16 };
 
@@ -1049,6 +1096,9 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	int cur, rbot, rtop;
 	bool first = true;
 
+	if (!valid_pointer_access(&buf, end, bitmap, spec))
+		return buf;
+
 	rbot = cur = find_first_bit(bitmap, nr_bits);
 	while (cur < nr_bits) {
 		rtop = cur;
@@ -1087,6 +1137,9 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	char separator;
 	bool reversed = false;
 
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		separator = '-';
@@ -1387,11 +1440,14 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 }
 
 static noinline_for_stack
-char *ip_addr_string(char *buf, char *end, const void *ptr,
-		     struct printf_spec spec, const char *fmt)
+char *ip_addr_string(char *buf, char *end, void *ptr, struct printf_spec spec,
+		     const char *fmt)
 {
 	char *err_fmt_msg;
 
+	if (!valid_pointer_access(&buf, end, ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case '6':
 		return ip6_addr_string(buf, end, ptr, spec, fmt);
@@ -1431,9 +1487,8 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (spec.field_width == 0)
 		return buf;				/* nothing to print */
 
-	if (ZERO_OR_NULL_PTR(addr))
-		return string(buf, end, NULL, spec);	/* NULL pointer */
-
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
 
 	do {
 		switch (fmt[count++]) {
@@ -1479,10 +1534,14 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
-static char *va_format(char *buf, char *end, struct va_format *va_fmt)
+static char *va_format(char *buf, char *end, struct va_format *va_fmt,
+		       struct printf_spec spec, const char *fmt)
 {
 	va_list va;
 
+	if (!valid_pointer_access(&buf, end, va_fmt, spec))
+		return buf;
+
 	va_copy(va, *va_fmt->va);
 	buf += vsnprintf(buf, end > buf ? end - buf : 0,
 			 va_fmt->fmt, va);
@@ -1501,6 +1560,9 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	const u8 *index = uuid_index;
 	bool uc = false;
 
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
+
 	switch (*(++fmt)) {
 	case 'L':
 		uc = true;		/* fall-through */
@@ -1539,6 +1601,9 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 	unsigned long long num;
 	int size;
 
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'F':
 		num = *(const netdev_features_t *)addr;
@@ -1552,11 +1617,15 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 }
 
 static noinline_for_stack
-char *address_val(char *buf, char *end, const void *addr, const char *fmt)
+char *address_val(char *buf, char *end, const void *addr,
+		  struct printf_spec spec, const char *fmt)
 {
 	unsigned long long num;
 	int size;
 
+	if (!valid_pointer_access(&buf, end, addr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'd':
 		num = *(const dma_addr_t *)addr;
@@ -1579,8 +1648,8 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
 		return valid_string(buf, end, "(%pC?)", spec);
 
-	if (!clk)
-		return string(buf, end, NULL, spec);
+	if (!valid_pointer_access(&buf, end, clk, spec))
+		return buf;
 
 	switch (fmt[1]) {
 	case 'r':
@@ -1630,6 +1699,9 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
+	if (!valid_pointer_access(&buf, end, flags_ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
@@ -1897,18 +1969,6 @@ static noinline_for_stack
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
-		return valid_string(buf, end, "(null)", spec);
-	}
-
 	switch (*fmt) {
 	case 'F':
 	case 'f':
@@ -1950,13 +2010,13 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
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
 	case 'C':
@@ -2588,11 +2648,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
 		case FORMAT_TYPE_STR: {
 			const char *save_str = va_arg(args, char *);
+			const char *err_msg;
 			size_t len;
 
-			if ((unsigned long)save_str > (unsigned long)-PAGE_SIZE
-					|| (unsigned long)save_str < PAGE_SIZE)
-				save_str = "(null)";
+			err_msg = check_pointer_access(save_str);
+			if (err_msg)
+				save_str = err_msg;
+
 			len = strlen(save_str) + 1;
 			if (str + len < end)
 				memcpy(str, save_str, len);
-- 
2.13.6
