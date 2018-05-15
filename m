Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeEOS5t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbeEOS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:57:47 -0400
Date: Tue, 15 May 2018 14:57:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180515145744.3bdcbbe9@gandalf.local.home>
In-Reply-To: <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
References: <20180515100558.21df515e@gandalf.local.home>
        <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 09:55:13 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 15, 2018 at 7:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > -       smp_mb();
> > +       smp_wmb();
> >          WRITE_ONCE(have_filled_random_ptr_key, true);  
> 
> 
> > +       /* Read ptr_key after reading have_filled_random_ptr_key */
> > +       smp_rmb();
> > +
> >   #ifdef CONFIG_64BIT
> >          hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);  
> 
> Hmm. smp_wmb/rmb are basically free on x86, but on some architectures
> smp_rmb() in particular can be pretty expensive.
> 
> So when you have a "handoff" situation like this, it's _probably_ better to
> use use "smp_store_release()" and "smp_load_acquire()". To some degree that
> might also be better for documentation purposes, because that's exactly the
> "release-acquire" pattern.
> 
> That said, I'm not convinced this really matters all that much for a
> boot-time flag like this. The race is pretty theoretical.
>

I was thinking the same. But since the smp_mb() is there, then it
should be correct, which it currently isn't.

We could change this to a static key, and enable it after we set up
the ptr_key. That would be a one time change at boot up, wont have
races, and have no overhead.

-- Steve

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..da4ea056a309 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1669,19 +1669,21 @@ char *pointer_string(char *buf, char *end, const void *ptr,
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
+	queue_work(system_unbound_wq, &enable_ptr_key_work);
 }
 
 static struct random_ready_callback random_ready = {
@@ -1709,7 +1711,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	unsigned long hashval;
 	const int default_width = 2 * sizeof(ptr);
 
-	if (unlikely(!have_filled_random_ptr_key)) {
+	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = default_width;
 		/* string length must be less than default_width */
 		return string(buf, end, "(ptrval)", spec);
