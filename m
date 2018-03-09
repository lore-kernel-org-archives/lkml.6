Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeCIPB5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:33452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeCIPB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:01:56 -0500
Date: Fri, 9 Mar 2018 16:01:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
References: <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-03-08 09:26:11, Linus Torvalds wrote:
> On Thu, Mar 8, 2018 at 8:45 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Umm. Look again. It _does_ affect plain %p.
> >
> > You're correct that it doesn't affect %px and %pK, since those never
> > printed out (null) in the first place.
> >
> > It not only affects %p, but it also affects %pS and friends (sSfFB),
> 
> Looking around at the x86 panic thing, %p doesn't matter that much,
> but %p[sSfFB] really do.
> 
> We use %pS/%pB to print out the instruction pointer. And a fault might
> be due to the instruction pointer being bad.
> 
> And then we very much need to see the value, which the current
> %pS-and-friends falls back to.
> 
> So printing <efault> would actually be horrible, in addition to the
> extra page fault being wrong. In fact, _only_ NULL itself needs to be
> printed as (null), because we'd care if it's 0 or 8 or something.
> 
> The other ones? The ones that would actually fault (%pI and friends)
> would not matter.

This all makes perfect sense. And I actually intended to do it this
way. Unfortunately, I sent the first RFC too fast without updating
the check for %p* specifiers. I am sorry for the confusion.


> The hex dumping one _might_ actually be useful if it got a buffer with
> 'probe_kernel_read()' and stopped half-way on problems.   Maybe. The
> others I can't imagine really care. efault or hex address.

I will try to keep it simple and check only the 1st byte for now.
It should prevent most of the possible silent crashes.

Here is the 2nd attempt. It never calls probe_kernel_read() when
the data need not be accessed:


>From 1c7123fbb8d098822b8f59c032e1ac79dbb6bf1a Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 7 Mar 2018 16:27:24 +0100
Subject: [PATCH v2] vsprintf: Prevent crash when dereferencing invalid pointers

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
why this patch adds a white list of %p* specifiers that do the dereference.
Note that "%p" might be followed by any character. Only few of them are
valid specifiers and only few specifiers need to access the data.

Also it makes the handling unified. We print:

   + (null) when pure NULL pointer is dereferenced
   + (efault) when an invalid address is dereferenced
   + pointer address otherwise

Note that we print (efault) from security reasons. In fact, the real
address can be seen only by %px or eventually %pK.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..36fa8a15c169 100644
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
+	if (strchr(data_access_fmt, *fmt) != NULL)
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
