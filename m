Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeEPNOe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbeEPNMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:12:44 -0400
Date: Wed, 16 May 2018 09:12:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: [GIT PULL] vsprintf: Replace memory barrier with static_key for
 random_ptr_key update
Message-ID: <20180516091241.2ea940d1@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The memory barrier usage in updating the random ptr hash for %p in
vsprintf is incorrect. Instead of adding the read memory barrier
into vsprintf() which will cause a slight degradation to a commonly
used function in the kernel just to solve a very unlikely race
condition that can only happen at boot up, change the code from
using a variable branch to a static_branch. Not only does this solve
the race condition, it actually will improve the performance of
vsprintf() by removing the conditional branch that is only needed
at boot.


Please pull the latest trace-v4.17-rc5-vsprintf tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc5-vsprintf

Tag SHA1: 3e2a2dfc8987e9a2b4e185b65a9b48c374c80791
Head SHA1: 85f4f12d51397f1648e1f4350f77e24039b82d61


Steven Rostedt (VMware) (1):
      vsprintf: Replace memory barrier with static_key for random_ptr_key update

----
 lib/vsprintf.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---------------------------
commit 85f4f12d51397f1648e1f4350f77e24039b82d61
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Tue May 15 22:24:52 2018 -0400

    vsprintf: Replace memory barrier with static_key for random_ptr_key update
    
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
    
            CPU0                            CPU1
            ----                            ----
                                       load ptr_key = 0
       store ptr_key = random
       smp_mb()
       store have_filled_random_ptr_key
    
                                       load have_filled_random_ptr_key = true
    
                                        BAD BAD BAD! (you're so bad!)
    
    Because nothing prevents CPU1 from loading ptr_key before loading
    have_filled_random_ptr_key.
    
    But this race is very unlikely, but we can't keep an incorrect smp_mb() in
    place. Instead, replace the have_filled_random_ptr_key with a static_branch
    not_filled_random_ptr_key, that is initialized to true and changed to false
    when we get enough entropy. If the update happens in early boot, the
    static_key is updated immediately, otherwise it will have to wait till
    entropy is filled and this happens in an interrupt handler which can't
    enable a static_key, as that requires a preemptible context. In that case, a
    work_queue is used to enable it, as entropy already took too long to
    establish in the first place waiting a little more shouldn't hurt anything.
    
    The benefit of using the static key is that the unlikely branch in
    vsprintf() now becomes a nop.
    
    Link: http://lkml.kernel.org/r/20180515100558.21df515e@gandalf.local.home
    
    Cc: stable@vger.kernel.org
    Fixes: ad67b74d2469d ("printk: hash addresses printed with %p")
    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..23920c5ff728 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1669,19 +1669,22 @@ char *pointer_string(char *buf, char *end, const void *ptr,
 	return number(buf, end, (unsigned long int)ptr, spec);
 }
 
-static bool have_filled_random_ptr_key __read_mostly;
+static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
 static siphash_key_t ptr_key __read_mostly;
 
-static void fill_random_ptr_key(struct random_ready_callback *unused)
+static void enable_ptr_key_workfn(struct work_struct *work)
 {
 	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/*
-	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
-	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
-	 * after get_random_bytes() returns.
-	 */
-	smp_mb();
-	WRITE_ONCE(have_filled_random_ptr_key, true);
+	/* Needs to run from preemptible context */
+	static_branch_disable(&not_filled_random_ptr_key);
+}
+
+static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+
+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+	/* This may be in an interrupt handler. */
+	queue_work(system_unbound_wq, &enable_ptr_key_work);
 }
 
 static struct random_ready_callback random_ready = {
@@ -1695,7 +1698,8 @@ static int __init initialize_ptr_random(void)
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-		fill_random_ptr_key(&random_ready);
+		/* This is in preemptible context */
+		enable_ptr_key_workfn(&enable_ptr_key_work);
 		return 0;
 	}
 
@@ -1709,7 +1713,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	unsigned long hashval;
 	const int default_width = 2 * sizeof(ptr);
 
-	if (unlikely(!have_filled_random_ptr_key)) {
+	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = default_width;
 		/* string length must be less than default_width */
 		return string(buf, end, "(ptrval)", spec);
