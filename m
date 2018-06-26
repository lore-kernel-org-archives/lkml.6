Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1268E26F4F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wpln2ZVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1268E26F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755090AbeFZUcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:32:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55416 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754947AbeFZUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uUmMeeUTwmq1xVmREQF4vesTADQoBJhL/x0ByqgkhQA=; b=wpln2ZVuDB/+lDnnfX27KUJlq
        t5Svk+MIScX3uOlH0jcftG+kGU2wJogIGv/NBvScTCoAoK9/+DoA1kE8sP/c9/yEu53YDqUG5NatR
        J9Miezz1V/utWrGbZ5SBSvUt96UXFW/oLUu1OLP99JI6nmvwZ4rrn3wgKNtEdT/WVwNe4uRAzTVxu
        eUSDTkIfIwT92/s99ljXo3J2PW0k38qTwH2wn3G870vXu0I3YBBLowSZhoiAWqvzX2CFGMsgCy8Vr
        q70Ec3ja+Mdmjgsm8lS/e3ssZZLuFo8SUkd7/y3r1Q+5kgfEKqCwi68TUXNvwpto5PAbO/JnAj+nz
        Ksv5s9qGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXudY-0005fc-9V; Tue, 26 Jun 2018 20:32:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE1B2029F1D5; Tue, 26 Jun 2018 22:32:25 +0200 (CEST)
Date:   Tue, 26 Jun 2018 22:32:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180626203225.GT2494@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626202615.GA32162@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:26:15PM -0700, Paul E. McKenney wrote:
> commit 2e5b2ff4047b138d6b56e4e3ba91bc47503cdebe
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Fri May 25 19:23:09 2018 -0700
> 
>     rcu: Fix grace-period hangs due to race with CPU offline
>     
>     Without special fail-safe quiescent-state-propagation checks, grace-period
>     hangs can result from the following scenario:
>     
>     1.      CPU 1 goes offline.
>     
>     2.      Because CPU 1 is the only CPU in the system blocking the current
>             grace period, the grace period ends as soon as
>             rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
>             returns.

My current code doesn't have that call... So this is a new problem
earlier in this series.

>     3.      At this point, the leaf rcu_node structure's ->lock is no longer
>             held: rcu_report_qs_rnp() has released it, as it must in order
>             to awaken the RCU grace-period kthread.
>     
>     4.      At this point, that same leaf rcu_node structure's ->qsmaskinitnext
>             field still records CPU 1 as being online.  This is absolutely
>             necessary because the scheduler uses RCU (in this case on the
>             wake-up path while awakening RCU's grace-period kthread), and
>             ->qsmaskinitnext contains RCU's idea as to which CPUs are online.
>             Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
>             bit from ->qsmaskinitnext would result in a lockdep-RCU splat
>             due to RCU being used from an offline CPU.

Argh.. so it's your own wakeup!

This all still smells really bad. But let me try and figure out where
you introduced the problem.
