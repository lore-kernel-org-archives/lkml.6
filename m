Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeEOUKb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbeEOUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:10:29 -0400
Date: Tue, 15 May 2018 16:10:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180515161027.468e8975@gandalf.local.home>
In-Reply-To: <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
References: <20180515100558.21df515e@gandalf.local.home>
        <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
        <20180515145744.3bdcbbe9@gandalf.local.home>
        <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 12:03:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 15, 2018 at 11:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > +       queue_work(system_unbound_wq, &enable_ptr_key_work);  
> 
> I think this part just makes the whole thing entirely pointless.
> 
> Now the 'not_filled_random_ptr_key' thing won't actually take effect until
> possibly much later, so all the work with making this work very early
> during boot (when those works are *not* done) is all for naught.
> 
> Did I miss something?
> 
>               Linus

The work queue looks to run immediately. When adding this:

@@ -1674,6 +1674,7 @@
 
 static void enable_ptr_key_workfn(struct work_struct *work)
 {
+       printk("enable static branch\n");
        /* Needs to run from preemptable context */
        static_branch_disable(&not_filled_random_ptr_key);
 }
@@ -1683,6 +1684,7 @@
 static void fill_random_ptr_key(struct random_ready_callback *unused)
 {
        get_random_bytes(&ptr_key, sizeof(ptr_key));
+       printk("queue enable static branch work\n");
        queue_work(system_unbound_wq, &enable_ptr_key_work);
 }
 
@@ -1694,10 +1696,11 @@
 {
        int ret = add_random_ready_callback(&random_ready);
 
+       printk("initialize random\n");
+       fill_random_ptr_key(&random_ready);
        if (!ret) {
                return 0;
        } else if (ret == -EALREADY) {
-               fill_random_ptr_key(&random_ready);
                return 0;
        }


I found this in the dmesg:

[    0.052824] initialize random
[    0.053010] random: get_random_bytes called from fill_random_ptr_key+0x15/0x40 with crng_init=0
[    0.054005] queue enable static branch work
[    0.056066] enable static branch

2 milliseconds isn't that bad. But if you don't like that, we could
always do this:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..1b7bcc6c1032 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1669,19 +1669,24 @@ char *pointer_string(char *buf, char *end, const void *ptr,
 	return number(buf, end, (unsigned long int)ptr, spec);
 }
 
-static bool have_filled_random_ptr_key __read_mostly;
+static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
 static siphash_key_t ptr_key __read_mostly;
 
+static void enable_ptr_key_workfn(struct work_struct *work)
+{
+	/* Needs to run from preemptable context */
+	static_branch_disable(&not_filled_random_ptr_key);
+}
+
+static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+
 static void fill_random_ptr_key(struct random_ready_callback *unused)
 {
 	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/*
-	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
-	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
-	 * after get_random_bytes() returns.
-	 */
-	smp_mb();
-	WRITE_ONCE(have_filled_random_ptr_key, true);
+	if (irqs_disabled() || in_atomic())
+		queue_work(system_unbound_wq, &enable_ptr_key_work);
+	else
+		enable_ptr_key_workfn(&enable_ptr_key_work);
 }
 
 static struct random_ready_callback random_ready = {
@@ -1709,7 +1714,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	unsigned long hashval;
 	const int default_width = 2 * sizeof(ptr);
 
-	if (unlikely(!have_filled_random_ptr_key)) {
+	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = default_width;
 		/* string length must be less than default_width */
 		return string(buf, end, "(ptrval)", spec);
