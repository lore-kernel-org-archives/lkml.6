Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5152AC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0840E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0840E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeKBAsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1637 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbeKBAsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E3C23078AA5;
        Thu,  1 Nov 2018 15:45:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7BBB25E7C2;
        Thu,  1 Nov 2018 15:45:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Nov 2018 16:45:21 +0100 (CET)
Date:   Thu, 1 Nov 2018 16:45:19 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Message-ID: <20181101154518.GE23232@redhat.com>
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
 <20181022155644.GG4170@linux.ibm.com>
 <20181022161439.GA8640@redhat.com>
 <20181030175539.GL4170@linux.ibm.com>
 <20181031172604.GC21207@redhat.com>
 <20181031173349.GF4170@linux.ibm.com>
 <20181101141217.GC23232@redhat.com>
 <20181101144250.GN4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101144250.GN4170@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Nov 2018 15:45:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, Paul E. McKenney wrote:
>
> Any news on exactly which patch constituted the reworking of this
> code some time back?

Again, I never sent a patch, I simply showed the new code (more than 2 years
ago ;), see below. I need to re-read our discussiong, but iirc your and Peter's
reviews were mostly positive.

The new implementation (and the state machine) is simpler, plus the new
__rcu_sync_enter(). It can be used instead of rcu_sync_enter_start() hack,
and by freeze_super() which currently need 3 GP's to take 3 percpu rwsems.

Oleg.
-------------------------------------------------------------------------------

#include <linux/rcu_sync.h>
#include <linux/sched.h>

#ifdef CONFIG_PROVE_RCU
#define __INIT_HELD(func)	.held = func,
#else
#define __INIT_HELD(func)
#endif

static const struct {
	void (*call)(struct rcu_head *, void (*)(struct rcu_head *));
	void (*wait)(void);	// TODO: remove this, see the comment in dtor
#ifdef CONFIG_PROVE_RCU
	int  (*held)(void);
#endif
} gp_ops[] = {
	[RCU_SYNC] = {
		.call = call_rcu,
		.wait = rcu_barrier,
		__INIT_HELD(rcu_read_lock_held)
	},
	[RCU_SCHED_SYNC] = {
		.call = call_rcu_sched,
		.wait = rcu_barrier_sched,
		__INIT_HELD(rcu_read_lock_sched_held)
	},
	[RCU_BH_SYNC] = {
		.call = call_rcu_bh,
		.wait = rcu_barrier_bh,
		__INIT_HELD(rcu_read_lock_bh_held)
	},
};

#define	rss_lock	gp_wait.lock

enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };

#ifdef CONFIG_PROVE_RCU
void rcu_sync_lockdep_assert(struct rcu_sync *rsp)
{
	RCU_LOCKDEP_WARN(!gp_ops[rsp->gp_type].held(),
			 "suspicious rcu_sync_is_idle() usage");
}
#endif

void rcu_sync_init(struct rcu_sync *rsp, enum rcu_sync_type type)
{
	memset(rsp, 0, sizeof(*rsp));
	init_waitqueue_head(&rsp->gp_wait);
	rsp->gp_type = type;
}

static void rcu_sync_func(struct rcu_head *rcu);

static void rcu_sync_call(struct rcu_sync *rsp)
{
	// TODO: THIS IS SUBOPTIMAL. We want to call it directly
	// if rcu_blocking_is_gp() == T, but it has might_sleep().
	gp_ops[rsp->gp_type].call(&rsp->cb_head, rcu_sync_func);
}

static void rcu_sync_func(struct rcu_head *rcu)
{
	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
	unsigned long flags;

	BUG_ON(rsp->gp_state == GP_IDLE);
	BUG_ON(rsp->gp_state == GP_PASSED);

	spin_lock_irqsave(&rsp->rss_lock, flags);
	if (rsp->gp_count) {
		/*
		 * We're at least a GP after the first __rcu_sync_enter().
		 */
		rsp->gp_state = GP_PASSED;
		wake_up_locked(&rsp->gp_wait);
	} else if (rsp->gp_state == GP_REPLAY) {
		/*
		 * A new rcu_sync_exit() has happened; requeue the callback
		 * to catch a later GP.
		 */
		rsp->gp_state = GP_EXIT;
		rcu_sync_call(rsp);
	} else {
		/*
		 * We're at least a GP after the last rcu_sync_exit();
		 * eveybody will now have observed the write side critical
		 * section. Let 'em rip!.
		 *
		 * OR. ->gp_state can be still GP_ENTER if __rcu_sync_wait()
		 * wasn't called after __rcu_sync_enter(), abort.
		 */
		rsp->gp_state = GP_IDLE;
	}
	spin_unlock_irqrestore(&rsp->rss_lock, flags);
}

bool __rcu_sync_enter(struct rcu_sync *rsp)
{
	int gp_count, gp_state;

	spin_lock_irq(&rsp->rss_lock);
	gp_count = rsp->gp_count++;
	gp_state = rsp->gp_state;
	if (gp_state == GP_IDLE) {
		rsp->gp_state = GP_ENTER;
		rcu_sync_call(rsp);
	}
	spin_unlock_irq(&rsp->rss_lock);

	BUG_ON(gp_count != 0 && gp_state == GP_IDLE);
	BUG_ON(gp_count == 0 && gp_state == GP_PASSED);

	return gp_state < GP_PASSED;
}

void __rcu_sync_wait(struct rcu_sync *rsp)
{
	BUG_ON(rsp->gp_state == GP_IDLE);
	BUG_ON(rsp->gp_count == 0);

	wait_event(rsp->gp_wait, rsp->gp_state >= GP_PASSED);
}

void rcu_sync_enter(struct rcu_sync *rsp)
{
	if (__rcu_sync_enter(rsp))
		__rcu_sync_wait(rsp);
}

void rcu_sync_exit(struct rcu_sync *rsp)
{
	BUG_ON(rsp->gp_state == GP_IDLE);
	BUG_ON(rsp->gp_count == 0);

	spin_lock_irq(&rsp->rss_lock);
	if (!--rsp->gp_count) {
		if (rsp->gp_state == GP_PASSED) {
			rsp->gp_state = GP_EXIT;
			rcu_sync_call(rsp);
		} else if (rsp->gp_state == GP_EXIT) {
			rsp->gp_state = GP_REPLAY;
		}
	}
	spin_unlock_irq(&rsp->rss_lock);
}

void rcu_sync_dtor(struct rcu_sync *rsp)
{
	int gp_state;

	BUG_ON(rsp->gp_count);
	BUG_ON(rsp->gp_state == GP_PASSED);

	spin_lock_irq(&rsp->rss_lock);
	if (rsp->gp_state == GP_REPLAY)
		rsp->gp_state = GP_EXIT;
	gp_state = rsp->gp_state;
	spin_unlock_irq(&rsp->rss_lock);

	// TODO: add another wake_up_locked() into rcu_sync_func(),
	// use wait_event + spin_lock_wait, remove gp_ops->wait().
	if (gp_state != GP_IDLE) {
		gp_ops[rsp->gp_type].wait();
		BUG_ON(rsp->gp_state != GP_IDLE);
	}
}


