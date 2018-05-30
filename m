Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755395AbeE3AG7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:06:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38008 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbeE3AFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:05:13 -0400
X-Google-Smtp-Source: ADUXVKJyyq2YjkCMn4cZO9H1wg3n4uf3S+8VH1Noh1McadFu6lHZg12x5x9Zn3MrF71C8Z/BJ9ICKA==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        stable@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v8 1/8] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Tue, 29 May 2018 17:04:53 -0700
Message-Id: <20180530000500.257225-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180530000500.257225-1-joel@joelfernandes.org>
References: <20180530000500.257225-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

I'm able to reproduce a lockdep splat with config options:
CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_LOCK_ALLOC=y and
CONFIG_PREEMPTIRQ_EVENTS=y

$ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable

[   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
[...]
[   26.144229] Call Trace:
[   26.144926]  <IRQ>
[   26.145506]  lock_acquire+0x55/0x1b0
[   26.146499]  ? __do_softirq+0x46f/0x4d9
[   26.147571]  ? __do_softirq+0x46f/0x4d9
[   26.148646]  trace_preempt_on+0x8f/0x240
[   26.149744]  ? trace_preempt_on+0x4d/0x240
[   26.150862]  ? __do_softirq+0x46f/0x4d9
[   26.151930]  preempt_count_sub+0x18a/0x1a0
[   26.152985]  __do_softirq+0x46f/0x4d9
[   26.153937]  irq_exit+0x68/0xe0
[   26.154755]  smp_apic_timer_interrupt+0x271/0x280
[   26.156056]  apic_timer_interrupt+0xf/0x20
[   26.157105]  </IRQ>

The issue was this:

preempt_count = 1 << SOFTIRQ_SHIFT

	__local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
		if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
			trace_softirqs_on() {
				current->softirqs_enabled = 1;
			}
		}
		preempt_count_sub(cnt) {
			trace_preempt_on() {
				tracepoint() {
					rcu_read_lock_sched() {
						// jumps into lockdep

Where preempt_count still has softirqs disabled, but
current->softirqs_enabled is true, and we get a splat.

Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..8a040bcaa033 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
+	if (preempt_count() == cnt)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_on(_RET_IP_);
-	preempt_count_sub(cnt);
+
+	__preempt_count_sub(cnt);
 }
 
 /*
-- 
2.17.0.921.gf22659ad46-goog
