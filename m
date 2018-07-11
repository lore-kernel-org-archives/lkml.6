Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F0420875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F0420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbeGKPox convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:44:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbeGKPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:44:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fdHDc-0004pQ-It; Wed, 11 Jul 2018 17:39:52 +0200
Date:   Wed, 11 Jul 2018 17:39:52 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT v2] sched/migrate_disable: fallback to
 preempt_disable() instead barrier()
Message-ID: <20180711153952.2fcniletg62hy7xf@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
 <20180705165937.5orx3md3krg4akaz@linutronix.de>
 <20180706105857.5tgi5irdxdryet64@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180706105857.5tgi5irdxdryet64@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 12:58:57 [+0200], To Joe Korty wrote:
> On SMP + !RT migrate_disable() is still around. It is not part of spin_lock()
> anymore so it has almost no users. However the futex code has a workaround for
> the !in_atomic() part of migrate disable which fails because the matching
> migrade_disable() is no longer part of spin_lock().
> 
> On !SMP + !RT migrate_disable() is reduced to barrier(). This is not optimal
> because we few spots where a "preempt_disable()" statement was replaced with
> "migrate_disable()".
> 
> We also used the migration_disable counter to figure out if a sleeping lock is
> acquired so RCU does not complain about schedule() during rcu_read_lock() while
> a sleeping lock is held. This changed, we no longer use it, we have now a
> sleeping_lock counter for the RCU purpose.
> 
> This means we can now:
> - for SMP + RT_BASE
>   full migration program, nothing changes here
> 
> - for !SMP + RT_BASE
>   the migration counting is no longer required. It used to ensure that the task
>   is not migrated to another CPU and that this CPU remains online. !SMP ensures
>   that already.
>   Move it to CONFIG_SCHED_DEBUG so the counting is done for debugging purpose
>   only.
> 
> - for all other cases including !RT
>   fallback to preempt_disable(). The only remaining users of migrate_disable()
>   are those which were converted from preempt_disable() and the futex
>   workaround which is already in the preempt_disable() section due to the
>   spin_lock that is held.
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
>        if migrate_disable() is used.

If there are no objections I would pick this up for next v4.16.

Sebastian
