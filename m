Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFDFNZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:13:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45254 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeFDFNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:13:24 -0400
X-Google-Smtp-Source: ADUXVKK+aadw8bE+kuudamz6za6F00B5/sz99zaqSDPMsWJLATIxjlwHpmtYwjigsbhGVafH+YFtlw==
Date: Sun, 3 Jun 2018 22:13:22 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>
Subject: Testing RCU boosting with rcutorture
Message-ID: <20180604051322.GA21496@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I was testing RCU boosting behavior with rcutorture on rcu/dev and I had some
issues getting it to fail when no RCU boost is done (CONFIG_RCU_BOOST is
disabled and rcutorture is forced to test it using test_boost parameter).

It appears I need to disable RT throttling so that the readers can get
starved by the RT thread. I also noticed some problems in rcutorture where we
are not checking for failure correctly. Below is an RFC patch fixing these
issues, could you let me know your thoughts about it? Thanks a lot,

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Sun, 3 Jun 2018 21:30:26 -0700
Subject: [RFC] rcutorture: Make boost test more robust

Currently, with RCU_BOOST disabled, I get no failures when forcing
rcutorture to test RCU boost priority inversion. The reason seems to be
that we don't check for failures if the callback never ran at all for
the duration of the boost-test loop.

Further, the 'rtb' and 'rtbf' counters seem to be used inconsistently.
'rtb' is incremented at the start of each test and 'rtbf' is incremented
per-cpu on each failure of call_rcu. So its possible 'rtbf' > 'rtb'.

To test the boost with rcutorture, I did following on a 4-CPU x86 machine:

# Disable RT throttling
echo 1000000 > /proc/sys/kernel/sched_rt_period_us
echo 1000000 > /proc/sys/kernel/sched_rt_runtime_us

modprobe rcutorture  test_boost=2
sleep 20
rmmod rcutorture

With patch:
rtbf: 8 rtb: 12

Without patch:
rtbf: 0 rtb: 2

In summary this patch:
 - Increments failed and total test counters once per boost-test.
 - Checks for failure cases correctly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 45 +++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 773d6f1b4abf..1d26f9c27d36 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -769,6 +769,18 @@ static void rcu_torture_boost_cb(struct rcu_head *head)
 	smp_store_release(&rbip->inflight, 0);
 }
 
+static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
+{
+	if (end - start > test_boost_duration * HZ - HZ / 2) {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
+		n_rcu_torture_boost_failure++;
+
+		return true; /* failed */
+	}
+
+	return false; /* passed */
+}
+
 static int rcu_torture_boost(void *arg)
 {
 	unsigned long call_rcu_time;
@@ -789,6 +801,21 @@ static int rcu_torture_boost(void *arg)
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
+		/* Track if the test failed already in this test interval? */
+		bool failed = false;
+
+		/* Increment n_rcu_torture_boosts once per boost-test */
+		while (!kthread_should_stop()) {
+			if (mutex_trylock(&boost_mutex)) {
+				n_rcu_torture_boosts++;
+				mutex_unlock(&boost_mutex);
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
+		}
+		if (kthread_should_stop())
+			goto checkwait;
+
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
 		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
@@ -807,11 +834,10 @@ static int rcu_torture_boost(void *arg)
 				/* RCU core before ->inflight = 1. */
 				smp_store_release(&rbi.inflight, 1);
 				call_rcu(&rbi.rcu, rcu_torture_boost_cb);
-				if (jiffies - call_rcu_time >
-					 test_boost_duration * HZ - HZ / 2) {
-					VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
-					n_rcu_torture_boost_failure++;
-				}
+				/* Check if the boost test failed */
+				failed = failed ||
+					 rcu_torture_boost_failed(call_rcu_time,
+								 jiffies);
 				call_rcu_time = jiffies;
 			}
 			stutter_wait("rcu_torture_boost");
@@ -819,6 +845,14 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
+		/*
+		 * If boost never happened, then inflight will always be 1, in
+		 * this case the boost check would never happen in the above
+		 * loop so do another one here.
+		 */
+		if (!failed && smp_load_acquire(&rbi.inflight))
+			rcu_torture_boost_failed(call_rcu_time, jiffies);
+
 		/*
 		 * Set the start time of the next test interval.
 		 * Yes, this is vulnerable to long delays, but such
@@ -831,7 +865,6 @@ static int rcu_torture_boost(void *arg)
 			if (mutex_trylock(&boost_mutex)) {
 				boost_starttime = jiffies +
 						  test_boost_interval * HZ;
-				n_rcu_torture_boosts++;
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-- 
2.17.1.1185.g55be947832-goog
