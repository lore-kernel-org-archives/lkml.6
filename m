Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2620846
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ir6H24rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B2620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeGITxi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:53:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:59784 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbeGITwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:52:01 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C46582325F3;
        Mon,  9 Jul 2018 15:52:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OMYNM7q0_fpf; Mon,  9 Jul 2018 15:52:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4C5F12325E7;
        Mon,  9 Jul 2018 15:52:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4C5F12325E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531165920;
        bh=mqiLrHqJtdELXfU5/Cumvxr5KaIXy0GWOCfZe8DAEAs=;
        h=From:To:Date:Message-Id;
        b=Ir6H24rLubBn7gcBdX+biEbQ3RmCg6aM0mx/ni743KzSXVf11A7W+0wpKWhXMbyHb
         hNwqBEbtMNyPMYAPEyPuF+E6GoHj1VGf1fHtxMRjBvxB/a5oG4ivyI6CXbPTjYoAg+
         P0oJTa1XN1tonK6s9s0OY5rVA1cC5Dzqm7AwEyQu/XrLyJHC6yhqolFf1xeqCdPa7T
         Ttw82kPqjmwoOGS1fCsnLDfGq8PWIPTXDnUGZD/WcOfE4wUCRGEPuA3X+hlebIlb7y
         Iowg4v6OM88ZvLqT7glc4aNA+fg/GvpIziE4DU0Q5ydh39f0EIs54YYf5B2UYCBIzy
         l4k6cHHcdANZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dYkW2n80TVyi; Mon,  9 Jul 2018 15:52:00 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id E24BB2325D6;
        Mon,  9 Jul 2018 15:51:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than __get_user/__put_user
Date:   Mon,  9 Jul 2018 15:51:51 -0400
Message-Id: <20180709195155.7654-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180709195155.7654-1-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user()/__put_user() is used to read values for address ranges that
were already checked with access_ok() on rseq registration.

It has been recognized that __get_user/__put_user are optimizing the
wrong thing. Replace them by get_user/put_user across rseq instead.

If those end up showing up in benchmarks, the proper approach would be to
use user_access_begin() / unsafe_{get,put}_user() / user_access_end()
anyway.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
-- 
2.11.0

