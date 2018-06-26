Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D318A26E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXVcvfqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D318A26E5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeFZRvk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:51:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeFZRvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qv71m6jFU7lsZ2rKFZvtBOPZBhBWmX95qPyFmYuRgf0=; b=XXVcvfqDCjSac0dJE9jpjmHrl
        /o0/lgGj15Do2of/k1ReaAIJ4R4rrkj1ptXuWneYm3IJjaBAqRtFVCIh7Ymv8MC0vfmvYbT3kTI8C
        rL/aOR6LYHdSpS0M3Uw/zQtzjtlrjGDegdQ84EivthjI7SwoOrhh5mjhRXz7+WJWa9k0IDHuVy6lm
        VYOWV/RvqaZPG3gOtoFWSXaSso6TNoCaVG9n7/b/x2BrsIaJ+S9v8JuEyJ+3elDEwq0kQvWAYF29Q
        +Ai5xoyIqcSAHTAF4vnEFeejmm39BYtgyTEw1RWdrMcNVKekIkPhHtxH/49oIjJ16Xk8NXMlIeH0Y
        YGGmRuduQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXs7d-0000qd-TW; Tue, 26 Jun 2018 17:51:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0606C2029F1DB; Tue, 26 Jun 2018 19:51:20 +0200 (CEST)
Date:   Tue, 26 Jun 2018 19:51:19 +0200
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
Message-ID: <20180626175119.GL2494@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:10:39AM -0700, Paul E. McKenney wrote:
> Without special fail-safe quiescent-state-propagation checks, grace-period
> hangs can result from the following scenario:
> 
> 1.	CPU 1 goes offline.
> 
> 2.	Because CPU 1 is the only CPU in the system blocking the current
> 	grace period, as soon as rcu_cleanup_dying_idle_cpu()'s call to
> 	rcu_report_qs_rnp() returns.
> 
> 3.	At this point, the leaf rcu_node structure's ->lock is no longer
> 	held: rcu_report_qs_rnp() has released it, as it must in order
> 	to awaken the RCU grace-period kthread.
> 
> 4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> 	field still records CPU 1 as being online.  This is absolutely
> 	necessary because the scheduler uses RCU, and ->qsmaskinitnext

Can you expand a bit on this, where does the scheduler care about the
online state of the CPU that's about to call into arch_cpu_idle_dead()?

> 	contains RCU's idea as to which CPUs are online.  Therefore,
> 	invoking rcu_report_qs_rnp() after clearing CPU 1's bit from
> 	->qsmaskinitnext would result in a lockdep-RCU splat due to
> 	RCU being used from an offline CPU.
> 
> 5.	RCU's grace-period kthread awakens, sees that the old grace period
> 	has completed and that a new one is needed.  It therefore starts
> 	a new grace period, but because CPU 1's leaf rcu_node structure's
> 	->qsmaskinitnext field still shows CPU 1 as being online, this new
> 	grace period is initialized to wait for a quiescent state from the
> 	now-offline CPU 1.

If we're past cpuhp_report_idle_cpu() -> rcu_report_dead(), then
cpu_offline() is true. Is that not sufficient state to avoid this?

> 6.	Without the fail-safe force-quiescent-state checks, there would
> 	be no quiescent state from the now-offline CPU 1, which would
> 	eventually result in RCU CPU stall warnings and memory exhaustion.
