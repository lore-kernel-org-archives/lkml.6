Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeEOOGC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbeEOOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:06:00 -0400
Date: Tue, 15 May 2018 10:05:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180515100558.21df515e@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewing Tobin's patches for getting pointers out early before
entropy has been established, I noticed that there's a lone smp_mb() in
the code. As with most lone memory barriers, this one appears to be
incorrectly used.

We currently basically have this:

	get_random_bytes(&ptr_key, sizeof(ptr_key));
	/*
	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
	 * after get_random_bytes() returns.
	 */
	smp_mb();
	WRITE_ONCE(have_filled_random_ptr_key, true);

And later we have:

	if (unlikely(!have_filled_random_ptr_key))
		return string(buf, end, "(ptrval)", spec);

/* Missing memory barrier here. */

	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);

As the CPU can perform speculative loads, we could have a situation
with the following:

	CPU0				CPU1
	----				----
				   load ptr_key = 0
   store ptr_key = random
   smp_mb()
   store have_filled_random_ptr_key

				   load have_filled_random_ptr_key = true

				    BAD BAD BAD!

Because nothing prevents CPU1 from loading ptr_key before loading
have_filled_random_ptr_key.

Note, I also do not see the reason to use smp_mb() instead of smp_wmb()
since we are only worried about the store of ptr_key with respect to
the store of have_filled_random_ptr_key.

Cc: stable@vger.kernel.org
Fixes: ad67b74d2469d ("printk: hash addresses printed with %p")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..e8a0b8e54bd3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1680,7 +1680,7 @@ static void fill_random_ptr_key(struct random_ready_callback *unused)
 	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
 	 * after get_random_bytes() returns.
 	 */
-	smp_mb();
+	smp_wmb();
 	WRITE_ONCE(have_filled_random_ptr_key, true);
 }
 
@@ -1715,6 +1715,9 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 		return string(buf, end, "(ptrval)", spec);
 	}
 
+	/* Read ptr_key after reading have_filled_random_ptr_key */
+	smp_rmb();
+
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
 	/*
