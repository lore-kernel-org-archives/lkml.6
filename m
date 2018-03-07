Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeCGPwy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933833AbeCGPwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:52:51 -0500
Date: Wed, 7 Mar 2018 16:52:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
References: <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <1520330185.10722.401.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520330185.10722.401.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-06 11:56:25, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 10:25 +0100, Petr Mladek wrote:
> > On Mon 2018-03-05 16:16:37, Rasmus Villemoes wrote:
> > > On 2 March 2018 at 13:53, Petr Mladek <pmladek@suse.com> wrote:
> 
> > > > -       if (!ptr && *fmt != 'K' && *fmt != 'x') {
> > > > +       if ((unsigned long)ptr < PAGE_SIZE && *fmt != 'K' && *fmt
> > > > != 'x') {
> > > 
> > > ISTM that accidentally passing an ERR_PTR would be just as likely as
> > > passing a NULL pointer (or some small offset from one), so if we do
> > > this, shouldn't the test also cover IS_ERR values?
> > 
> > It would make perfect sense to catch IS_ERR_PTR(). Derefenrecing
> > such pointer cause crash. But it might be pretty confusing to print
> > "(null)" in this case.
> > 
> > I would handle this in separate patch and print "(err)" or so.
> > Any volunteer to prepare the patch?
> 
> As I pointed out, we have already such check for %s in binary printf().
> And it goes for "(null)". I'm not sure if changing that might break
> something.

I have missed this.

Anyway, I have discussed this with my colleagues. Different people had
different opinions. But I liked the following.

If we are changing things, let's do it properly. The range
(-PAGE_SIZE,+PAGE_SIZE) is just a small subset of invalid pointers.
Let's try to catch more of them by reading one byte using
probe_kernel_read(). It would return -FAULT if we are not able
to read the address but it would not crash.

Then we clearly need a new message when dereferencing invalid
poitners that are not pure NULL. I propose (efault).

I believe that the error message is not ABI. Otherwise we would
never be able to fix this. Anyway, we would not know if we did
not try it. And I think that this is worth the risk.

Below is my RFC patch. It is rather a concept to see if it would
work. I send it now because others seem to be working on different
approaches. I believe that this is the right direction. I hope
that it does not conflict much with your patches. I deliberately
touched only the locations that are supposed to stay.


>From 3aae11b504637aa29027949709482f4570cb8bec Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 7 Mar 2018 16:27:24 +0100
Subject: [RFC] vsprintf: Prevent crash when dereferencing invalid pointers

We already prevent crash when derefencing some obviously broken
pointers. The handling is not consistent. Sometimes we print "(null)"
only for pure NULL pointer, sometimes for pointers in the first
page and sometimes also for pointers in the last page (error codes).

Note that printk() formats the string under logbuf_lock. Any recursive
printks are redirected to the printk_safe implementation and the messages
are stored into per-CPU buffers. These buffers might be eventually flushed
in printk_safe_flush_on_panic() but it is not guaranteed.

In general, we should do our best to get useful message from printk().
This patch tries to find a wide range of invalid strings using
probe_kernel_read(). Also it makes the handling unified. We print:

   + (null) only when pure NULL pointer is dereferenced
   + (efault) in all other cases

Note that we could not print the exact pointer value from security reasons.
Developers need print the pointer using %px to get the real value.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..c1d8de016081 100644
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
@@ -1848,15 +1863,19 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
 	const int default_width = 2 * sizeof(void *);
+	const char *err_msg = NULL;
+
+	if (*fmt != 'K' && *fmt != 'x')
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
@@ -2571,11 +2590,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
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
