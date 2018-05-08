Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoKku9YLqqe4L48RbcOaamRdtiB8xuMSeYCDPpSG4PAZPhGjOztIP/sO4v18JHnNYUejlz0
ARC-Seal: i=1; a=rsa-sha256; t=1525767216; cv=none;
        d=google.com; s=arc-20160816;
        b=ActvhslqZdjWwD1+6OF0fdcExQr9sPmC3woOuF7dH80k0a03N6Jbeuj9hGa15zKmEJ
         xV1sg2F3suVytlYwmHpkdAij+H6EitX5jgkrp1jwJXGjVRFeHcdYYMLtLv6gGBJ/J4o1
         AyH+rhyU5nB5XPhS+J62QjEU60v6A0W2Rw4sULoHYeTGR0e3VNxWWHi0wDbS7OuAp3Sk
         nKKtp9l/iYJTYRFFon3f6TlIYVRUbH+hEctalQh7rIPWfyAge840GFwKr7+QF8sc4E61
         vjGwVh55KY84PhxfqAG0w/uIvndJK66jDJ6j3fiCloilHMIjxbe4OG9TdWGtlnrJ2N4V
         rM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x6E6S8nHNnVpbeD39q7Hs8i9seMtb5TP+558mgTJSHk=;
        b=Q5kXX4y7rqA0xEftac8Fawyvlb0subBwXq0AvGsRzBNPQu59XOVFOS3oY58kdHIPb5
         VrvrusS1NJ7QDJF+As/4rSVYg6jGs4/pLrN1vQZRqsegKvgQII/Wfoa78bUcX1NWvvo3
         8/fP/D84TqiXw0nuU7QfRFuxb/ZLY+eVMa0mTdrDSTGBC8kfrJvVw8NZICIJ3JHq08hp
         Bkv4LcvBOUOore9PwPQH4HVCopUwvkmk5shPtRmTPuWUbf5Oh3OQ6j0YqxA8Yu1KnLiX
         NX6z6eCAqNkOZHD/caUB4r2LXEdjipifFykVcSnVsNIE+5VTcaKEi2kAA2DN2kCP/CKD
         Pq3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mC3l4r62;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mC3l4r62;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Diego Viola <diego.viola@gmail.com>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	rui.zhang@intel.com
Subject: [PATCH 4.16 49/52] clocksource: Allow clocksource_mark_unstable() on unregistered clocksources
Date: Tue,  8 May 2018 10:10:47 +0200
Message-Id: <20180508073935.046644011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882884503016015?=
X-GMAIL-MSGID: =?utf-8?q?1599882884503016015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 2aae7bcfa4104b770e6f612356adb8d66c6144d6 upstream.

Because of how the code flips between tsc-early and tsc clocksources
it might need to mark one or both unstable. The current code in
mark_tsc_unstable() only worked because previously it registered the
tsc clocksource once and then never touched it.

Since it now unregisters the tsc-early clocksource, it needs to know
if a clocksource got unregistered and the current cs->mult test
doesn't work for that. Instead use list_empty(&cs->list) to test for
registration.

Furthermore, since clocksource_mark_unstable() needs to place the cs
on the wd_list, it links the cs->list and cs->wd_list serialization.
It must not see a clocsource registered (!empty cs->list) but already
past dequeue_watchdog(). So place {en,de}queue{,_watchdog}() under the
same lock.

Provided cs->list is initialized to empty, this then allows us to
unconditionally use clocksource_mark_unstable(), regardless of the
registration state.

Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Diego Viola <diego.viola@gmail.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180502135312.GS12217@hirez.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/clocksource.c |   50 +++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -119,6 +119,16 @@ static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
 
+static void inline clocksource_watchdog_lock(unsigned long *flags)
+{
+	spin_lock_irqsave(&watchdog_lock, *flags);
+}
+
+static void inline clocksource_watchdog_unlock(unsigned long *flags)
+{
+	spin_unlock_irqrestore(&watchdog_lock, *flags);
+}
+
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
@@ -142,6 +152,9 @@ static void __clocksource_unstable(struc
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
+	if (list_empty(&cs->list))
+		return;
+
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
@@ -164,7 +177,7 @@ void clocksource_mark_unstable(struct cl
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	if (!(cs->flags & CLOCK_SOURCE_UNSTABLE)) {
-		if (list_empty(&cs->wd_list))
+		if (!list_empty(&cs->list) && list_empty(&cs->wd_list))
 			list_add(&cs->wd_list, &watchdog_list);
 		__clocksource_unstable(cs);
 	}
@@ -319,9 +332,6 @@ static void clocksource_resume_watchdog(
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
@@ -331,7 +341,6 @@ static void clocksource_enqueue_watchdog
 		if (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS)
 			cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static void clocksource_select_watchdog(bool fallback)
@@ -373,9 +382,6 @@ static void clocksource_select_watchdog(
 
 static void clocksource_dequeue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs != watchdog) {
 		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 			/* cs is a watched clocksource. */
@@ -384,21 +390,19 @@ static void clocksource_dequeue_watchdog
 			clocksource_stop_watchdog();
 		}
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static int __clocksource_watchdog_kthread(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
-	LIST_HEAD(unstable);
 	int select = 0;
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
-			list_add(&cs->wd_list, &unstable);
+			__clocksource_change_rating(cs, 0);
 			select = 1;
 		}
 		if (cs->flags & CLOCK_SOURCE_RESELECT) {
@@ -410,11 +414,6 @@ static int __clocksource_watchdog_kthrea
 	clocksource_stop_watchdog();
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 
-	/* Needs to be done outside of watchdog lock */
-	list_for_each_entry_safe(cs, tmp, &unstable, wd_list) {
-		list_del_init(&cs->wd_list);
-		__clocksource_change_rating(cs, 0);
-	}
 	return select;
 }
 
@@ -447,6 +446,9 @@ static inline int __clocksource_watchdog
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
+static void inline clocksource_watchdog_lock(unsigned long *flags) { }
+static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
 /**
@@ -775,14 +777,19 @@ EXPORT_SYMBOL_GPL(__clocksource_update_f
  */
 int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 {
+	unsigned long flags;
 
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 
 	/* Add clocksource to the clocksource list */
 	mutex_lock(&clocksource_mutex);
+
+	clocksource_watchdog_lock(&flags);
 	clocksource_enqueue(cs);
 	clocksource_enqueue_watchdog(cs);
+	clocksource_watchdog_unlock(&flags);
+
 	clocksource_select();
 	clocksource_select_watchdog(false);
 	mutex_unlock(&clocksource_mutex);
@@ -804,8 +811,13 @@ static void __clocksource_change_rating(
  */
 void clocksource_change_rating(struct clocksource *cs, int rating)
 {
+	unsigned long flags;
+
 	mutex_lock(&clocksource_mutex);
+	clocksource_watchdog_lock(&flags);
 	__clocksource_change_rating(cs, rating);
+	clocksource_watchdog_unlock(&flags);
+
 	clocksource_select();
 	clocksource_select_watchdog(false);
 	mutex_unlock(&clocksource_mutex);
@@ -817,6 +829,8 @@ EXPORT_SYMBOL(clocksource_change_rating)
  */
 static int clocksource_unbind(struct clocksource *cs)
 {
+	unsigned long flags;
+
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
 		clocksource_select_watchdog(true);
@@ -830,8 +844,12 @@ static int clocksource_unbind(struct clo
 		if (curr_clocksource == cs)
 			return -EBUSY;
 	}
+
+	clocksource_watchdog_lock(&flags);
 	clocksource_dequeue_watchdog(cs);
 	list_del_init(&cs->list);
+	clocksource_watchdog_unlock(&flags);
+
 	return 0;
 }
 
