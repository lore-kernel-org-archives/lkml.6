Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDIMYS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:24:18 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeDIMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:24:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tick-sched: avoid a maybe-uninitialized warning
Date: Mon,  9 Apr 2018 14:23:33 +0200
Message-Id: <20180409122339.1709840-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:UnUjYs4VVfULcW1CA3PwUiPKZ5HXk8zJXRTyX2UV7MPGA9qGoPq
 PCX2mqF16f04Lm5xi0GAgPm6O7r2YGmIq+cyADGJE8FQ6ZaXAjp1Ez30ZLJqqnesSeLnU+P
 dDjb4W4VVm68Md5r6KCN9beM5QANXpGHHZ970Nf7C2e8ku4TYqoeRFzoam0IXD90C9MG5ig
 PQTfd8JyaKzbPUFeFxYwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iOWimIA0ojc=:ITd5rM/1PwDbaoUTS07ZWH
 gBU3u6kTrHmu91hMWBjFYhEMrlgTvzxtvjZh2//cVsv8nnDfgnn0pl8xxe4MkcWhCFdPaF1AL
 RTDbEmCTHduC6sBT8uInC80av+hSy6cH3IbiENMDG4L8BSYJd3nlfrKtbC/iK5X/O8W2XOQ0X
 Nhke+lsGMJGhNBvvoQL5IaFILPIdtpWSdyLuEUKVGn9yz8+5MvHp8T8I4WFtrINwBBDSxCsaw
 PjxldlBNH7dVGh0q/AHSiSqm7njQypGQTrG2arLwqHV586GDhkX2b9DFdPhrN7MzLGVcLcvef
 CZxKKKeYbL2H7OJgV68xPP4CAiWVQ/tZKq2RaphFtQBneaqq71Nx8SeaEnThUih5fr363v1/E
 ++6yalLlV3P4YqMRBqrVikFcDUYpPQ7kKTtEQrFGuFMUN4W2LWetgl2hychp8wZ+bEEsalXZy
 DTZXbwwh8CDYAIkuk2/oX37Coego0eZE0iBbnn1aWHBUAc0HnU7gVpaYGlRhmhyP0cxLZoseH
 X20+PalB+PsMs3RjGdAkllJZSxgxYS5BFAotMenFSJCv5FD7pLeSH3Ug8jy+QdCwfx9LJOPMR
 HPsc3bp68k2uqVUdXC6KODm7gSFia8iWjnQumrFgc6LnJ/rd8ZOLJ37yvdtgogEvFTu5gbimc
 oyq1uA30lkX5W1ebRt4srRcF9U54VDpeayJOk0XCBxZUL/mVTKwUy7LfqFYhP+3gTU5RRagrx
 lIhvxgpxuQIFTEXtAlqBlzn19788FGzCcp3HiA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of bitfields seems to confuse gcc, leading to a false-positive
warning in all compiler versions:

kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
kernel/time/tick-sched.c:538:2: error: 'now' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This introduces a temporary variable to track the flags so gcc
doesn't have to evaluate twice, eliminating the code path that
leads to the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85301
Fixes: 1cae544d42d2 ("nohz: Gather tick_sched booleans under a common flag field")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/tick-sched.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7eef9431ca24..646645e981f9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1143,6 +1143,7 @@ void tick_nohz_idle_restart_tick(void)
 void tick_nohz_idle_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	bool idle_active, tick_stopped;
 	ktime_t now;
 
 	local_irq_disable();
@@ -1151,14 +1152,16 @@ void tick_nohz_idle_exit(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 
 	ts->inidle = 0;
+	idle_active = ts->idle_active;
+	tick_stopped = ts->tick_stopped;
 
-	if (ts->idle_active || ts->tick_stopped)
+	if (idle_active || tick_stopped)
 		now = ktime_get();
 
-	if (ts->idle_active)
+	if (idle_active)
 		tick_nohz_stop_idle(ts, now);
 
-	if (ts->tick_stopped)
+	if (tick_stopped)
 		__tick_nohz_idle_restart_tick(ts, now);
 
 	local_irq_enable();
-- 
2.9.0
