Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965506AbeEIQ2n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:28:43 -0400
Received: from mail.monom.org ([188.138.9.77]:52434 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965012AbeEIQ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:28:42 -0400
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.131-rt148
Date: Wed, 09 May 2018 18:18:49 +0200
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com
Message-Id: <20180509162840.7BB9D500C4B@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.131-rt148 stable release.

This release add the missing stable-rt patches from Sebastian. With
this the v4.4-rt tree should contain all stable-rt patches. Let me
knonw if I missed anything.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: d103ae2fc7d8e8a3a713dab5eabd6e4e3a1488b3

Or to build 4.4.131-rt148 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.131.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.131-rt148.patch.xz


You can also build from 4.4.131-rt147 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.131-rt147-rt148.patch.xz

Enjoy!
   Daniel

Changes from v4.4.131-rt147:
---
Daniel Wagner (1):
      Linux 4.4.131-rt148

Sebastian Andrzej Siewior (2):
      alarmtimer: Prevent live lock in alarm_cancel()
      posix-timers: move the rcu head out of the union

---
 include/linux/posix-timers.h | 2 +-
 kernel/time/alarmtimer.c     | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 localversion-rt              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 907f3fd191ac..e2e43c61f6a1 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -92,8 +92,8 @@ struct k_itimer {
 			struct alarm alarmtimer;
 			ktime_t interval;
 		} alarm;
-		struct rcu_head rcu;
 	} it;
+	struct rcu_head rcu;
 };
 
 struct k_clock {
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6fcc367ad531..9d5eac2c9275 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -392,7 +392,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 48ca053dae2e..0808e2ae49bf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -567,7 +567,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -584,7 +584,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/localversion-rt b/localversion-rt
index d3fa072b6b43..857407b62668 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt147
+-rt148
