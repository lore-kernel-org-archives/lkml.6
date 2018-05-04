Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeEDLQD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:16:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEDLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:16:02 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86: Convert mce timer to hrtimer
Date: Fri,  4 May 2018 13:14:58 +0200
Message-Id: <20180504111459.24825-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

mce_timer is started in atomic contexts of cpu bringup. This results
in might_sleep() warnings on RT. Convert mce_timer to a hrtimer to
avoid this.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org (open list:X86 MCE INFRASTRUCTURE)
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
fold in:
|From: Mike Galbraith <bitbucket@online.de>
|Date: Wed, 29 May 2013 13:52:13 +0200
|Subject: [PATCH] x86/mce: fix mce timer interval
|
|Seems mce timer fire at the wrong frequency in -rt kernels since roughly
|forever due to 32 bit overflow.  3.8-rt is also missing a multiplier.
|
|Add missing us -> ns conversion and 32 bit overflow prevention.
|
|Signed-off-by: Mike Galbraith <bitbucket@online.de>
|[bigeasy: use ULL instead of u64 cast]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c |   52 +++++++++++++++++++---------------=
-----
 1 file changed, 26 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -41,6 +41,7 @@
 #include <linux/debugfs.h>
 #include <linux/irq_work.h>
 #include <linux/export.h>
+#include <linux/jiffies.h>
 #include <linux/jump_label.h>
=20
 #include <asm/intel-family.h>
@@ -1358,7 +1359,7 @@ int memory_failure(unsigned long pfn, in
 static unsigned long check_interval =3D INITIAL_CHECK_INTERVAL;
=20
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
-static DEFINE_PER_CPU(struct timer_list, mce_timer);
+static DEFINE_PER_CPU(struct hrtimer, mce_timer);
=20
 static unsigned long mce_adjust_timer_default(unsigned long interval)
 {
@@ -1367,26 +1368,18 @@ static unsigned long mce_adjust_timer_de
=20
 static unsigned long (*mce_adjust_timer)(unsigned long interval) =3D mce_a=
djust_timer_default;
=20
-static void __start_timer(struct timer_list *t, unsigned long interval)
+static void __start_timer(struct hrtimer *t, unsigned long iv)
 {
-	unsigned long when =3D jiffies + interval;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	if (!timer_pending(t) || time_before(when, t->expires))
-		mod_timer(t, round_jiffies(when));
-
-	local_irq_restore(flags);
+	if (!iv)
+		return;
+	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000ULL),
+			       0, HRTIMER_MODE_REL_PINNED);
 }
=20
-static void mce_timer_fn(struct timer_list *t)
+static enum hrtimer_restart mce_timer_fn(struct hrtimer *timer)
 {
-	struct timer_list *cpu_t =3D this_cpu_ptr(&mce_timer);
 	unsigned long iv;
=20
-	WARN_ON(cpu_t !=3D t);
-
 	iv =3D __this_cpu_read(mce_next_interval);
=20
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
@@ -1409,7 +1402,11 @@ static void mce_timer_fn(struct timer_li
=20
 done:
 	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (!iv)
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, ns_to_ktime(jiffies_to_nsecs(iv)));
+	return HRTIMER_RESTART;
 }
=20
 /*
@@ -1417,7 +1414,7 @@ static void mce_timer_fn(struct timer_li
  */
 void mce_timer_kick(unsigned long interval)
 {
-	struct timer_list *t =3D this_cpu_ptr(&mce_timer);
+	struct hrtimer *t =3D this_cpu_ptr(&mce_timer);
 	unsigned long iv =3D __this_cpu_read(mce_next_interval);
=20
 	__start_timer(t, interval);
@@ -1432,7 +1429,7 @@ static void mce_timer_delete_all(void)
 	int cpu;
=20
 	for_each_online_cpu(cpu)
-		del_timer_sync(&per_cpu(mce_timer, cpu));
+		hrtimer_cancel(&per_cpu(mce_timer, cpu));
 }
=20
 /*
@@ -1761,7 +1758,7 @@ static void __mcheck_cpu_clear_vendor(st
 	}
 }
=20
-static void mce_start_timer(struct timer_list *t)
+static void mce_start_timer(struct hrtimer *t)
 {
 	unsigned long iv =3D check_interval * HZ;
=20
@@ -1774,16 +1771,19 @@ static void mce_start_timer(struct timer
=20
 static void __mcheck_cpu_setup_timer(void)
 {
-	struct timer_list *t =3D this_cpu_ptr(&mce_timer);
+	struct hrtimer *t =3D this_cpu_ptr(&mce_timer);
=20
-	timer_setup(t, mce_timer_fn, TIMER_PINNED);
+	hrtimer_init(t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	t->function =3D mce_timer_fn;
 }
=20
 static void __mcheck_cpu_init_timer(void)
 {
-	struct timer_list *t =3D this_cpu_ptr(&mce_timer);
+	struct hrtimer *t =3D this_cpu_ptr(&mce_timer);
+
+	hrtimer_init(t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	t->function =3D mce_timer_fn;
=20
-	timer_setup(t, mce_timer_fn, TIMER_PINNED);
 	mce_start_timer(t);
 }
=20
@@ -2285,7 +2285,7 @@ static int mce_cpu_dead(unsigned int cpu
=20
 static int mce_cpu_online(unsigned int cpu)
 {
-	struct timer_list *t =3D this_cpu_ptr(&mce_timer);
+	struct hrtimer *t =3D this_cpu_ptr(&mce_timer);
 	int ret;
=20
 	mce_device_create(cpu);
@@ -2302,10 +2302,10 @@ static int mce_cpu_online(unsigned int c
=20
 static int mce_cpu_pre_down(unsigned int cpu)
 {
-	struct timer_list *t =3D this_cpu_ptr(&mce_timer);
+	struct hrtimer *t =3D this_cpu_ptr(&mce_timer);
=20
 	mce_disable_cpu();
-	del_timer_sync(t);
+	hrtimer_cancel(t);
 	mce_threshold_remove_device(cpu);
 	mce_device_remove(cpu);
 	return 0;
