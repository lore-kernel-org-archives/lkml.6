Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8FBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A420BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3A420BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeGJUXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:23:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGJUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:23:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKMRNx3266437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:22:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKMR7O3266433;
        Tue, 10 Jul 2018 13:22:27 -0700
Date:   Tue, 10 Jul 2018 13:22:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-8f28177014925f968baf45fc833c25848faf8c1c@git.kernel.org>
Cc:     peterz@infradead.org, catalin.marinas@arm.com, rostedt@goodmis.org,
        luto@amacapital.net, mtk.manpages@gmail.com,
        linux-kernel@vger.kernel.org, bmaurer@fb.com, tglx@linutronix.de,
        mingo@kernel.org, joelaf@google.com, andi@firstfloor.org,
        pjt@google.com, mathieu.desnoyers@efficios.com,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        davejwatson@fb.com, linux@arm.linux.org.uk, hpa@zytor.com,
        torvalds@linux-foundation.org, cl@linux.com,
        akpm@linux-foundation.org, josh@joshtriplett.org,
        will.deacon@arm.com
Reply-To: bmaurer@fb.com, tglx@linutronix.de, mingo@kernel.org,
          joelaf@google.com, peterz@infradead.org, catalin.marinas@arm.com,
          mtk.manpages@gmail.com, luto@amacapital.net, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          will.deacon@arm.com, josh@joshtriplett.org, pjt@google.com,
          mathieu.desnoyers@efficios.com, andi@firstfloor.org,
          boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
          davejwatson@fb.com, hpa@zytor.com, cl@linux.com,
          torvalds@linux-foundation.org, linux@arm.linux.org.uk
In-Reply-To: <20180709195155.7654-3-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-3-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] rseq: Use get_user/put_user rather than
 __get_user/__put_user
Git-Commit-ID: 8f28177014925f968baf45fc833c25848faf8c1c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8f28177014925f968baf45fc833c25848faf8c1c
Gitweb:     https://git.kernel.org/tip/8f28177014925f968baf45fc833c25848faf8c1c
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 9 Jul 2018 15:51:51 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:18:52 +0200

rseq: Use get_user/put_user rather than __get_user/__put_user

__get_user()/__put_user() is used to read values for address ranges that
were already checked with access_ok() on rseq registration.

It has been recognized that __get_user/__put_user are optimizing the
wrong thing. Replace them by get_user/put_user across rseq instead.

If those end up showing up in benchmarks, the proper approach would be to
use user_access_begin() / unsafe_{get,put}_user() / user_access_end()
anyway.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Paul Turner <pjt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Chris Lameter <cl@linux.com>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20180709195155.7654-3-mathieu.desnoyers@efficios.com

---
 kernel/rseq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 16b38c5342f9..2c8463acb50d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -85,9 +85,9 @@ static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
 
-	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
+	if (put_user(cpu_id, &t->rseq->cpu_id_start))
 		return -EFAULT;
-	if (__put_user(cpu_id, &t->rseq->cpu_id))
+	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
 	trace_rseq_update(t);
 	return 0;
@@ -100,14 +100,14 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	/*
 	 * Reset cpu_id_start to its initial state (0).
 	 */
-	if (__put_user(cpu_id_start, &t->rseq->cpu_id_start))
+	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
 		return -EFAULT;
 	/*
 	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
 	 * in after unregistration can figure out that rseq needs to be
 	 * registered again.
 	 */
-	if (__put_user(cpu_id, &t->rseq->cpu_id))
+	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
 	return 0;
 }
@@ -120,7 +120,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
-	ret = __get_user(ptr, &t->rseq->rseq_cs);
+	ret = get_user(ptr, &t->rseq->rseq_cs);
 	if (ret)
 		return ret;
 	if (!ptr) {
@@ -163,7 +163,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	int ret;
 
 	/* Get thread flags. */
-	ret = __get_user(flags, &t->rseq->flags);
+	ret = get_user(flags, &t->rseq->flags);
 	if (ret)
 		return ret;
 
@@ -203,7 +203,7 @@ static int clear_rseq_cs(struct task_struct *t)
 	 *
 	 * Set rseq_cs to NULL with single-copy atomicity.
 	 */
-	return __put_user(0UL, &t->rseq->rseq_cs);
+	return put_user(0UL, &t->rseq->rseq_cs);
 }
 
 /*
