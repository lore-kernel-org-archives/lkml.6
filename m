Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeCOThi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:37:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOThh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:37:37 -0400
Date: Thu, 15 Mar 2018 12:36:53 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-fcb3029a8d89487470f2e175645a9a993949233c@git.kernel.org>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, bigeasy@linutronix.de, hpa@zytor.com, arnd@arndb.de
Reply-To: arnd@arndb.de, hpa@zytor.com, mingo@kernel.org,
        bigeasy@linutronix.de, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com
In-Reply-To: <20180315153829.3819606-1-arnd@arndb.de>
References: <20180315153829.3819606-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Fix unused function warning
Git-Commit-ID: fcb3029a8d89487470f2e175645a9a993949233c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fcb3029a8d89487470f2e175645a9a993949233c
Gitweb:     https://git.kernel.org/tip/fcb3029a8d89487470f2e175645a9a993949233c
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Thu, 15 Mar 2018 16:38:04 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 15 Mar 2018 20:34:40 +0100

cpu/hotplug: Fix unused function warning

The cpuhp_is_ap_state() function is no longer called outside of the
CONFIG_SMP #ifdef section, causing a harmless warning:

kernel/cpu.c:129:13: error: 'cpuhp_is_ap_state' defined but not used [-Werror=unused-function]

This moves the function into the #ifdef to get a clean build again.

Fixes: 17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20180315153829.3819606-1-arnd@arndb.de

---
 kernel/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a1860d42aacf..0db8938fbb23 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -126,15 +126,6 @@ struct cpuhp_step {
 static DEFINE_MUTEX(cpuhp_state_mutex);
 static struct cpuhp_step cpuhp_hp_states[];
 
-static bool cpuhp_is_ap_state(enum cpuhp_state state)
-{
-	/*
-	 * The extra check for CPUHP_TEARDOWN_CPU is only for documentation
-	 * purposes as that state is handled explicitly in cpu_down.
-	 */
-	return state > CPUHP_BRINGUP_CPU && state != CPUHP_TEARDOWN_CPU;
-}
-
 static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 {
 	return cpuhp_hp_states + state;
@@ -235,6 +226,15 @@ err:
 }
 
 #ifdef CONFIG_SMP
+static bool cpuhp_is_ap_state(enum cpuhp_state state)
+{
+	/*
+	 * The extra check for CPUHP_TEARDOWN_CPU is only for documentation
+	 * purposes as that state is handled explicitly in cpu_down.
+	 */
+	return state > CPUHP_BRINGUP_CPU && state != CPUHP_TEARDOWN_CPU;
+}
+
 static inline void wait_for_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
 {
 	struct completion *done = bringup ? &st->done_up : &st->done_down;
