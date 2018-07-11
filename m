Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25690C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC7420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC7420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbeGKPss convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeGKPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:48:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E1C20C03;
        Wed, 11 Jul 2018 15:43:52 +0000 (UTC)
Date:   Wed, 11 Jul 2018 11:43:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT v2] sched/migrate_disable: fallback to
 preempt_disable() instead barrier()
Message-ID: <20180711114350.3e43613f@gandalf.local.home>
In-Reply-To: <20180711153952.2fcniletg62hy7xf@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
        <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
        <20180705161807.GA5800@zipoli.concurrent-rt.com>
        <20180705165937.5orx3md3krg4akaz@linutronix.de>
        <20180706105857.5tgi5irdxdryet64@linutronix.de>
        <20180711153952.2fcniletg62hy7xf@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 17:39:52 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-07-06 12:58:57 [+0200], To Joe Korty wrote:
> > On SMP + !RT migrate_disable() is still around. It is not part of spin_lock()
> > anymore so it has almost no users. However the futex code has a workaround for
> > the !in_atomic() part of migrate disable which fails because the matching
> > migrade_disable() is no longer part of spin_lock().
> > 
> > On !SMP + !RT migrate_disable() is reduced to barrier(). This is not optimal
> > because we few spots where a "preempt_disable()" statement was replaced with
> > "migrate_disable()".
> > 
> > We also used the migration_disable counter to figure out if a sleeping lock is
> > acquired so RCU does not complain about schedule() during rcu_read_lock() while
> > a sleeping lock is held. This changed, we no longer use it, we have now a
> > sleeping_lock counter for the RCU purpose.
> > 
> > This means we can now:
> > - for SMP + RT_BASE
> >   full migration program, nothing changes here
> > 
> > - for !SMP + RT_BASE
> >   the migration counting is no longer required. It used to ensure that the task
> >   is not migrated to another CPU and that this CPU remains online. !SMP ensures
> >   that already.
> >   Move it to CONFIG_SCHED_DEBUG so the counting is done for debugging purpose
> >   only.
> > 
> > - for all other cases including !RT
> >   fallback to preempt_disable(). The only remaining users of migrate_disable()
> >   are those which were converted from preempt_disable() and the futex
> >   workaround which is already in the preempt_disable() section due to the
> >   spin_lock that is held.
> > 
> > Cc: stable-rt@vger.kernel.org
> > Reported-by: joe.korty@concurrent-rt.com
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v1…v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
> >        if migrate_disable() is used.  
> 
> If there are no objections I would pick this up for next v4.16.
>

I still rather have migrate_disable() be a nop (barrier at most)
when !RT, to keep it from being used, and just fix the places that are
of issue. But we can discuss this when we push this to mainline. I'm
fine with adding it to -rt if it fixes a real bug now.

-- Steve
