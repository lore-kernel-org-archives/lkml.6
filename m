Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A16C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2915520846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqfVP+3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2915520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeGKNR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:17:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733158AbeGKNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aqdGvAZ4L1WETrJ1jqSe4+Gv0xZ8RAWJONo/CeTXP4U=; b=qqfVP+3FjRcJtXwM5KmoK29iz
        lG9PirH1b7N55zhDDouQao4I1vFIfCtDph1uQAyXVQsy2/Nra0uada+e4eG27aXjTWelq+cpQTloH
        NaYizOOPlXspxvhA3RMLXPDtR3PmzgVG96BiSpI+hge8NACKwc2P2RoquZlbamYvzHdanxoOppHO1
        tkVaibWGdj0XcxA1jLJS2+wjItWVcmEYyUBgnX7XjeToXD0kg4HarVGc6bIwEGz2n4sKqjSKxl+Qc
        zbulQ6slT07VjSfCOzBmXvKZQm08yA1LL9cfDMF8Hna7PWkidkOuBf6BzyZayIlgACL+nXP4dLJNi
        AQwGwT3Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdEvR-00009c-Bl; Wed, 11 Jul 2018 13:12:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D57320289CE4; Wed, 11 Jul 2018 15:12:56 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:12:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180711131256.GH2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628182149.226164-6-joel@joelfernandes.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:21:47AM -0700, Joel Fernandes wrote:
> One note, I have to check for lockdep recursion in the code that calls
> the trace events API and bail out if we're in lockdep recursion

I'm not seeing any new lockdep_recursion checks...

> protection to prevent something like the following case: a spin_lock is
> taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> this function, a call to get_lock_stats happens which calls
> preempt_disable, which calls trace IRQS off somewhere which enters my
> tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> This flag is then never cleared causing lockdep paths to never be
> entered and thus causing splats and other bad things.

Would it not be much easier to avoid that entirely, afaict all
get/put_lock_stats() callers already have IRQs disabled, so that
(traced) preempt fiddling is entirely superfluous.

---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..8f5ce0048d15 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -248,12 +248,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(cpu_lock_stats);
+	return &this_cpu_ptr(&cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
@@ -271,7 +266,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
 		lock_time_inc(&stats->read_holdtime, holdtime);
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -4090,7 +4084,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 		stats->contending_point[contending_point]++;
 	if (lock->cpu != smp_processor_id())
 		stats->bounces[bounce_contended + !!hlock->read]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -4138,7 +4131,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	}
 	if (lock->cpu != cpu)
 		stats->bounces[bounce_acquired + !!hlock->read]++;
-	put_lock_stats(stats);
 
 	lock->cpu = cpu;
 	lock->ip = ip;
