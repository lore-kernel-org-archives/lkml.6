Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCNOJx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:09:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:59235 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeCNOJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:09:51 -0400
Date: Wed, 14 Mar 2018 15:09:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
References: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
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

In general, we want to get a message from printk() than a silent crash.
This patch adds a check using probe_kernel_read().

The check is used _only_ in situations where we would really crash. This is
why this patch adds a white list of %p* specifiers that need to read data
from the pointer. Note that "%p" might be followed by any character. Only
few of them are valid specifiers and only few specifiers need to access
the data.

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
Changes against v2:

	+ fix handling with strchr(string, '\0'); happens with
	  %p at the very end of the string
	+ even more clear commit message
	+ update Documentation/core-api/printk-formats.rst
	+ add check into lib/test_printf.c

Changes against v1:

	+ do not check access for plain %p
	+ more clear commit message

 Documentation/core-api/printk-formats.rst |  7 ++++++
 lib/test_printf.c                         | 39 +++++++++++++++++++++++------
 lib/vsprintf.c                            | 41 ++++++++++++++++++++++++-------
 3 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 934559b3c130..d3bbca732ed6 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -50,6 +50,13 @@ A raw pointer value may be printed with %p which will hash the address
 before printing. The kernel also supports extended specifiers for printing
 pointers of different types.
 
+Some of the extended specifiers print the data on the given address instead
+of printing the address itself. In this case, you might get two special
+values::
+
+	(null)	 data on plain NULL address
+	(efault) data on invalid address
+
 Plain Pointers
 --------------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 71ebfa43ad05..61c05a352d79 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -207,14 +207,15 @@ test_string(void)
 #define PTR ((void *)0xffff0123456789ab)
 #define PTR_STR "ffff0123456789ab"
 #define ZEROS "00000000"	/* hex 32 zero bits */
+#define SPACE "        "	/* 32 space bits */
 
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
@@ -227,6 +228,8 @@ plain_format(void)
 #define PTR_WIDTH 8
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
+#define ZEROS ""
+#define SPACE ""
 
 static int __init
 plain_format(void)
@@ -238,12 +241,12 @@ plain_format(void)
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
@@ -256,18 +259,18 @@ plain_hash(void)
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
@@ -275,6 +278,24 @@ plain(void)
 }
 
 static void __init
+null_pointer(void)
+{
+	plain(NULL);
+	test(ZEROS "00000000", "%px", NULL);
+	test(SPACE "  (null)", "%pC", NULL);
+}
+
+#define PTR_INVALID ((void *)0x000000ab)
+
+static void __init
+invalid_pointer(void)
+{
+	plain(PTR_INVALID);
+	test(ZEROS "000000ab", "%px", PTR_INVALID);
+	test(SPACE "(efault)", "%pC", PTR_INVALID);
+}
+
+static void __init
 symbol_ptr(void)
 {
 }
@@ -497,7 +518,9 @@ flags(void)
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
index d7a708f82559..54b985143e07 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -520,6 +520,19 @@ char *number(char *buf, char *end, unsigned long long num,
 	return buf;
 }
 
+static const char *check_pointer_access(const void *ptr)
+{
+	unsigned char byte;
+
+	if (!ptr)
+		return "(null)";
+
+	if (probe_kernel_read(&byte, ptr, 1))
+		return "(efault)";
+
+	return 0;
+}
+
 static noinline_for_stack
 char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
 {
@@ -586,9 +599,11 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 {
 	int len = 0;
 	size_t lim = spec.precision;
+	const char *err_msg;
 
-	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
+	err_msg = check_pointer_access(s);
+	if (err_msg)
+		s = err_msg;
 
 	while (lim--) {
 		char c = *s++;
@@ -1847,16 +1862,22 @@ static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
+	static const char data_access_fmt[] = "RrhbMmIiEUVNadCDgGO";
 	const int default_width = 2 * sizeof(void *);
+	const char *err_msg = NULL;
+
+	/* Prevent silent crash when this is called under logbuf_lock. */
+	if (*fmt && strchr(data_access_fmt, *fmt) != NULL)
+		err_msg = check_pointer_access(ptr);
 
-	if (!ptr && *fmt != 'K' && *fmt != 'x') {
+	if (err_msg) {
 		/*
-		 * Print (null) with the same width as a pointer so it makes
-		 * tabular output look nice.
+		 * Print the error message with the same width as a pointer
+		 * so it makes tabular output look nice.
 		 */
 		if (spec.field_width == -1)
 			spec.field_width = default_width;
-		return string(buf, end, "(null)", spec);
+		return string(buf, end, err_msg, spec);
 	}
 
 	switch (*fmt) {
@@ -2571,11 +2592,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
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
