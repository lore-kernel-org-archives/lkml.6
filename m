Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeEJMwo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:52:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757381AbeEJMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:52:17 -0400
X-Google-Smtp-Source: AB8JxZppD2sUuJCGX1sVCflgD0LBp3U9Q1Iz2aGSAzNz37dhQIp3kLa9SRxxmpRVRg1YsE/+diRg7A==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] lib/ratelimit: Lockless ratelimiting
Date: Thu, 10 May 2018 13:52:11 +0100
Message-Id: <20180510125211.12583-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180510125211.12583-1-dima@arista.com>
References: <20180510125211.12583-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ratelimit_state is protected with spin_lock. If the .lock is
taken at the moment of ___ratelimit() call, the message is suppressed to
make ratelimiting robust.

That results in the following issue issue:
      CPU0                          CPU1
------------------           ------------------
printk_ratelimit()           printk_ratelimit()
        |                             |
  try_spin_lock()              try_spin_lock()
        |                             |
time_is_before_jiffies()          return 0; // suppress

So, concurrent call of ___ratelimit() results in silently suppressing
one of the messages, regardless if the limit is reached or not.
And rc->missed is not increased in such case so the issue is covered
from user.

Convert ratelimiting to use atomic counters and drop spin_lock.

Note: in the rare corner-case when (rs->burst == 0) and concurrent
access suppressed message might be printed from both (several) CPUs,
that are accessing ratelimit.

Note: That might be unexpected, but with the first interval of messages
storm one can print up to burst*2 messages. So, it doesn't guarantee
that in *any* interval amount of messages is lesser than burst.
But, that differs lightly from previous behavior where one can start
burst=5 interval and print 4 messages on the last milliseconds of
interval + new 5 messages from new interval (totally 9 messages in
lesser than interval value).

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/char/random.c            | 16 ++++-------
 drivers/gpu/drm/i915/i915_perf.c |  4 +--
 include/linux/ratelimit.h        | 24 +++++++++-------
 lib/ratelimit.c                  | 59 +++++++++++++++++++---------------------
 4 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c1c40c7ed0e8..3694cbcb04a0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -937,25 +937,21 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	crng->init_time = jiffies;
 	spin_unlock_irqrestore(&crng->lock, flags);
 	if (crng == &primary_crng && crng_init < 2) {
+		int unseeded_miss, urandom_miss;
+
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
-		if (unseeded_warning.missed) {
+		if ((unseeded_miss = atomic_xchg(&unseeded_warning.missed, 0)))
 			pr_notice("random: %d get_random_xx warning(s) missed "
-				  "due to ratelimiting\n",
-				  unseeded_warning.missed);
-			unseeded_warning.missed = 0;
-		}
+				  "due to ratelimiting\n", unseeded_miss);
 		unseeded_warning.flags = 0;
-		if (urandom_warning.missed) {
+		if ((urandom_miss = atomic_xchg(&urandom_warning.missed, 0)))
 			pr_notice("random: %d urandom warning(s) missed "
-				  "due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
+				  "due to ratelimiting\n", urandom_miss);
 		urandom_warning.flags = 0;
 	}
 }
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index abaca6edeb71..a8e00913bdb9 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1316,9 +1316,9 @@ static void i915_oa_stream_destroy(struct i915_perf_stream *stream)
 
 	put_oa_config(dev_priv, stream->oa_config);
 
-	if (dev_priv->perf.oa.spurious_report_rs.missed) {
+	if (atomic_read(&dev_priv->perf.oa.spurious_report_rs.missed)) {
 		DRM_NOTE("%d spurious OA report notices suppressed due to ratelimiting\n",
-			 dev_priv->perf.oa.spurious_report_rs.missed);
+			 atomic_read(&dev_priv->perf.oa.spurious_report_rs.missed));
 	}
 }
 
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index e9a14a7641e0..ddc572389f08 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -4,7 +4,6 @@
 
 #include <linux/param.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 
 #define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
 #define DEFAULT_RATELIMIT_BURST		10
@@ -13,21 +12,21 @@
 #define RATELIMIT_MSG_ON_RELEASE	BIT(0)
 
 struct ratelimit_state {
-	raw_spinlock_t	lock;		/* protect the state */
+	atomic_t	printed;
+	atomic_t	missed;
 
 	int		interval;
 	int		burst;
-	int		printed;
-	int		missed;
 	unsigned long	begin;
 	unsigned long	flags;
 };
 
 #define RATELIMIT_STATE_INIT_FLAGS(name, _interval, _burst, _flags) {	\
-		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
 		.interval	= _interval,				\
 		.burst		= _burst,				\
 		.flags		= _flags,				\
+		.printed	= ATOMIC_INIT(0),			\
+		.missed		= ATOMIC_INIT(0),			\
 	}
 
 #define RATELIMIT_STATE_INIT(name, _interval, _burst)			\
@@ -46,9 +45,10 @@ static inline void ratelimit_state_init(struct ratelimit_state *rs,
 {
 	memset(rs, 0, sizeof(*rs));
 
-	raw_spin_lock_init(&rs->lock);
 	rs->interval	= interval;
 	rs->burst	= burst;
+	atomic_set(&rs->printed, 0);
+	atomic_set(&rs->missed, 0);
 }
 
 static inline void ratelimit_default_init(struct ratelimit_state *rs)
@@ -57,16 +57,20 @@ static inline void ratelimit_default_init(struct ratelimit_state *rs)
 					DEFAULT_RATELIMIT_BURST);
 }
 
+/*
+ * Keeping It Simple: not reenterable and not safe for concurrent
+ * ___ratelimit() call as used only by devkmsg_release().
+ */
 static inline void ratelimit_state_exit(struct ratelimit_state *rs)
 {
+	int missed;
+
 	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
 		return;
 
-	if (rs->missed) {
+	if ((missed = atomic_xchg(&rs->missed, 0)))
 		pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
-			current->comm, rs->missed);
-		rs->missed = 0;
-	}
+			current->comm, missed);
 }
 
 static inline void
diff --git a/lib/ratelimit.c b/lib/ratelimit.c
index d01f47135239..c99305e9239f 100644
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -13,6 +13,18 @@
 #include <linux/jiffies.h>
 #include <linux/export.h>
 
+static void ratelimit_end_interval(struct ratelimit_state *rs, const char *func)
+{
+	rs->begin = jiffies;
+
+	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
+		unsigned missed = (unsigned)atomic_xchg(&rs->missed, 0);
+
+		if (missed)
+			pr_warn("%s: %u callbacks suppressed\n", func, missed);
+	}
+}
+
 /*
  * __ratelimit - rate limiting
  * @rs: ratelimit_state data
@@ -27,45 +39,30 @@
  */
 int ___ratelimit(struct ratelimit_state *rs, const char *func)
 {
-	unsigned long flags;
-	int ret;
-
 	if (!rs->interval)
 		return 1;
 
-	/*
-	 * If we contend on this state's lock then almost
-	 * by definition we are too busy to print a message,
-	 * in addition to the one that will be printed by
-	 * the entity that is holding the lock already:
-	 */
-	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
+	if (unlikely(!rs->burst)) {
+		atomic_add_unless(&rs->missed, 1, -1);
+		if (time_is_before_jiffies(rs->begin + rs->interval))
+			ratelimit_end_interval(rs, func);
+
 		return 0;
+	}
 
-	if (!rs->begin)
-		rs->begin = jiffies;
+	if (atomic_add_unless(&rs->printed, 1, rs->burst))
+		return 1;
 
 	if (time_is_before_jiffies(rs->begin + rs->interval)) {
-		if (rs->missed) {
-			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
-				printk_deferred(KERN_WARNING
-						"%s: %d callbacks suppressed\n",
-						func, rs->missed);
-				rs->missed = 0;
-			}
-		}
-		rs->begin   = jiffies;
-		rs->printed = 0;
-	}
-	if (rs->burst && rs->burst > rs->printed) {
-		rs->printed++;
-		ret = 1;
-	} else {
-		rs->missed++;
-		ret = 0;
+		if (atomic_cmpxchg(&rs->printed, rs->burst, 0))
+			ratelimit_end_interval(rs, func);
 	}
-	raw_spin_unlock_irqrestore(&rs->lock, flags);
 
-	return ret;
+	if (atomic_add_unless(&rs->printed, 1, rs->burst))
+		return 1;
+
+	atomic_add_unless(&rs->missed, 1, -1);
+
+	return 0;
 }
 EXPORT_SYMBOL(___ratelimit);
-- 
2.13.6
