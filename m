Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCPGjR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:39:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38093 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750748AbeCPGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:39:16 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37873194"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>
CC: <tglx@linutronix.de>, <mingo@elte.hu>, <peterz@infradead.org>,
        <jiangshanlai@gmail.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] kernel/cpu: Move cpuhp_is_atomic_state() into #ifdef CONFIG_SMP
Date: Fri, 16 Mar 2018 14:38:52 +0800
Message-ID: <20180316063852.22701-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C829F486A799.A0549
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
removed the last use of cpuhp_is_atomic_state() in common case, that caused
Kernel produced a warning:

  'cpuhp_is_ap_state' defined but not used

So, Move it into #ifdef CONFIG_SMP

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 kernel/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a1860d42aacf..db7ec7572348 100644
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
@@ -247,6 +238,15 @@ static inline void complete_ap_thread(struct cpuhp_cpu_state *st, bool bringup)
 	complete(done);
 }
 
+static bool cpuhp_is_ap_state(enum cpuhp_state state)
+{
+	/*
+	 * The extra check for CPUHP_TEARDOWN_CPU is only for documentation
+	 * purposes as that state is handled explicitly in cpu_down.
+	 */
+	return state > CPUHP_BRINGUP_CPU && state != CPUHP_TEARDOWN_CPU;
+}
+
 /*
  * The former STARTING/DYING states, ran with IRQs disabled and must not fail.
  */
-- 
2.14.3
