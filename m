Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969897AbeEXNwX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:52:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52464 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966066AbeEXNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:52:19 -0400
X-Google-Smtp-Source: AB8JxZoD80J9Be84nGegygf/JElItSt/0yWcUHOE5QCepQoYdH7lJlRvJlri1ltAJhLSwcLOF4Ze0Q==
X-ME-Sender: <xms:jMMGW4HPgGrgB8qa6v-yRYFTitXb5qTwb37j47LqWDuaDpoJDr-vRg>
Date: Thu, 24 May 2018 21:51:58 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180524135158.GA19987@tardis>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <20180523130547.GF26965@arm.com>
 <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
 <20180523153607.GD2983@arm.com>
 <CA+55aFy9mVCJUniAMVvJjqaa=ke2mx6HfkPhCGP54ncdh70peQ@mail.gmail.com>
 <20180524124928.GH8689@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524124928.GH8689@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 01:49:31PM +0100, Will Deacon wrote:
> On Wed, May 23, 2018 at 09:26:35AM -0700, Linus Torvalds wrote:
> > On Wed, May 23, 2018 at 8:35 AM Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > In other words, qrwlock requires consistent locking order wrt spinlocks.
> > 
> > I *thought* lockdep already tracked and detected this. Or is that only with
> > with the sleeping versions?
> 
> There are patches in-flight to detect this:
> 
> https://marc.info/?l=linux-kernel&m=152483640529740&w=2k
> 
> as part of Boqun's work into recursive read locking.
> 

Yeah, lemme put some details here:

So we have three cases:

Case #1 (from Will)

	P0:			P1:			P2:

	spin_lock(&slock)	read_lock(&rwlock)
							write_lock(&rwlock)
	read_lock(&rwlock)	spin_lock(&slock)

, which is a deadlock, and couldn't not be detected by lockdep yet. And
lockdep could detect this with the patch I attach at the end of the
mail.

Case #2

	P0:			P1:			P2:

	<in irq handler>
	spin_lock(&slock)	read_lock(&rwlock)
							write_lock(&rwlock)
	read_lock(&rwlock)	spin_lock_irq(&slock)

, which is not a deadlock, as the read_lock() on P0 can use the unfair
fastpass.

Case #3

	P0:			P1:			P2:

				<in irq handler>
	spin_lock_irq(&slock)	read_lock(&rwlock)
							write_lock_irq(&rwlock)
	read_lock(&rwlock)	spin_lock(&slock)

, which is a deadlock, as the read_lock() on P0 cannot use the fastpass.
To detect this and not to make case #2 as a false positive, the
recursive deadlock detection patchset is needed, the WIP version is at:

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git arr-rfc-wip

The code is done, I'm just working on the rework for documention stuff,
so if anyone is interested, could try it out ;-)

Regards,
Boqun

------------------->8
Subject: [PATCH] locking: More accurate annotations for read_lock()

On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
read lock, actually it's only recursive if in_interrupt() is true. So
change the annotation accordingly to catch more deadlocks.

Note we used to treat read_lock() as pure recursive read locks in
lib/locking-seftest.c, and this is useful, especially for the lockdep
development selftest, so we keep this via a variable to force switching
lock annotation for read_lock().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h | 35 ++++++++++++++++++++++++++++++++++-
 lib/locking-selftest.c  | 11 +++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..07793986c063 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -27,6 +27,7 @@ extern int lock_stat;
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
+#include <linux/preempt.h>
 
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
@@ -540,6 +541,31 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 }
 #endif
 
+/* Variable used to make lockdep treat read_lock() as recursive in selftests */
+#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
+extern unsigned int force_read_lock_recursive;
+#else /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+#define force_read_lock_recursive 0
+#endif /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+
+#ifdef CONFIG_LOCKDEP
+/*
+ * read_lock() is recursive if:
+ * 1. We force lockdep think this way in selftests or
+ * 2. The implementation is not queued read/write lock or
+ * 3. The locker is at an in_interrupt() context.
+ */
+static inline bool read_lock_is_recursive(void)
+{
+	return force_read_lock_recursive ||
+	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
+	       in_interrupt();
+}
+#else /* CONFIG_LOCKDEP */
+/* If !LOCKDEP, the value is meaningless */
+#define read_lock_is_recursive() 0
+#endif
+
 /*
  * For trivial one-depth nesting of a lock-class, the following
  * global define can be used. (Subsystems with multiple levels
@@ -561,7 +587,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define spin_release(l, n, i)			lock_release(l, n, i)
 
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, s, t, NULL, i)
+#define rwlock_acquire_read(l, s, t, i)					\
+do {									\
+	if (read_lock_is_recursive())					\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+	else								\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+} while (0)
+
 #define rwlock_release(l, n, i)			lock_release(l, n, i)
 
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..dd92f8ad83d5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -28,6 +28,7 @@
  * Change this to 1 if you want to see the failure printouts:
  */
 static unsigned int debug_locks_verbose;
+unsigned int force_read_lock_recursive;
 
 static DEFINE_WW_CLASS(ww_lockdep);
 
@@ -1978,6 +1979,11 @@ void locking_selftest(void)
 		return;
 	}
 
+	/*
+	 * treats read_lock() as recursive read locks for testing purpose
+	 */
+	force_read_lock_recursive = 1;
+
 	/*
 	 * Run the testsuite:
 	 */
@@ -2072,6 +2078,11 @@ void locking_selftest(void)
 
 	ww_tests();
 
+	force_read_lock_recursive = 0;
+	/*
+	 * queued_read_lock() specific test cases can be put here
+	 */
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.16.2
