Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeCOPjA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:39:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeCOPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:38:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu/hotplug: fix unused function warning
Date: Thu, 15 Mar 2018 16:38:04 +0100
Message-Id: <20180315153829.3819606-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:J+yHwgJ38KnYt2rrG6M038BZEXBYgICtq1NUm2XdvDwaUp4EuiW
 Q/64GIxwAfkIvvqc1l24QqEW4Yz7oWm7dKFnsO1lq2PRH02hYNNsWWZiKg66ylbEGjonSW4
 1Itlj3Cmin39xSxy6PrhBgdwqkAndTXgnHKB8J4eSlXwUuSzZ7ESwdpvo84OJefJ/RZ2dIT
 0G6z1nZTE6+kfxw8lZbjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bndKs1VCD4A=:0XP1cTj3W5zJ1LkM5IpCoD
 teeAZmCC3lW1DSXcASsF+bHU9QEw3FrjXxYCJd6tepa8r+W/Qw0x/YegEJCzUNswmglnIotpa
 aZhJ3SGtY+uygrbJkx3T+NLEYQ0M3EwTC4GGwian47t/J1DygdrxKwdDfM0/tkZTl6hFvPhr0
 JL8ihHo2tLJcFuR/JVSy4OF1e3FVLPotWslYDshPrkjXLAvXoMKCT1BK0trx9v7PFKBdpIysz
 mYHoiB537CzrRzPNF9aYUWLhU33LfkKejbgvagbL9wvMwAXGPJAwXd1OzBg5PLvJUmAdKorg2
 WQi13ofHqFzD8i39SUD9O7dTZo7854NjkOsFuAOWJ94u3L38dnOueatX9nzBBVDvOpO+lxVwt
 cIW5sh5N3U5TthxhVvYUXZpJRFSPOIJwkyiI/9pZNvT51nVTycRXZB1wN3g8WhkgrwluTm/FK
 RNjvo6X55RlWSFR9eJKCr94imaD+uDx1wyOG7PPBdUanJWgXFo/WqWkPjscEAT0NuFLecer+r
 5elLce57mXQhMbC1VevDfdcQoyuePVmq7/Wox3mqtTNTyq5uc6sLYsgL6r37SquKOPE2Oo4/w
 AXnoVCVZIHPagyHYREsGYI61zHUcayTMYXf1SVlsGZ4DNa6AF9H7DNXDTLogg7tNf8SS+ZUvc
 Vzc4hRDnPGnfJ9Z+L3X0YudNZY1j2XNs+PKsBsY4j7rTy1jHJHbn1qS8T8sd04Jig0rK2wK3Z
 YktO1YbczUvDyU2jSnMYEy7ntFhLusFCgQFkuw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuhp_is_ap_state() function is no longer called outside of the
CONFIG_SMP #ifdef section, causing a harmless warning:

kernel/cpu.c:129:13: error: 'cpuhp_is_ap_state' defined but not used [-Werror=unused-function]

This moves the function into the #ifdef to get a clean build again.

Fixes: 17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
@@ -235,6 +226,15 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
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
-- 
2.9.0
