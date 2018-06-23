Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80162C43145
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427FB24A7D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427FB24A7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934616AbeFWBVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933850AbeFWBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:21:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393B324A72;
        Sat, 23 Jun 2018 01:21:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fWXEf-0008Qh-7g; Fri, 22 Jun 2018 21:21:05 -0400
Message-Id: <20180623012105.136449195@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Jun 2018 21:20:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>,
        Julia Cartwright <julia@ni.com>,
        Byungchul Park <byungchul.park@lge.com>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/5] softirq: Reorder trace_softirqs_on to prevent lockdep splat
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-softirq-Reorder-trace_softirqs_on-to-prevent-lockdep.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Link: http://lkml.kernel.org/r/20180607201143.247775-1-joel@joelfernandes.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Erick Reyes <erickreyes@google.com>
Cc: Julia Cartwright <julia@ni.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index de2f57fddc04..900dcfee542c 100644
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
2.17.1


