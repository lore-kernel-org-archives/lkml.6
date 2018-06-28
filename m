Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA0D273CA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTXlkJ60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA0D273CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935126AbeF1NHK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:07:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35714 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeF1NHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wFi6agvxReR/NogVb81FqyUet+GZUKeUFAGRyzXcbso=; b=wTXlkJ60KtcGcvabrN/Xrlpb1
        x7VhuEkznJLq5Nmr8GUW8obsK/CvitSpzqhze1pyZvQR8dlVrtEinvihAftzBaHOi1s7xz/C6ACwv
        BS0WOCF4aS/NO9MIoTusTOhJxjZmOWR4m3s/m7d3se8mw9ta5Kj5GEyGwbsRhW7lbUileA471FM8U
        ZhQiuPfbBFE62zNqp/zfCLQqHhXKjb4Dqc/dbplTBF+CKu71qcjC/WZLBQCWw1J/bAeBn0mNG4y4T
        b38Kt6Gl7d7dwv/C0nFG3UpwQBEKAsWrfBqAm5oubPmBqEZIqzz0xWw1PUzWFCA4CuBkbEJqEdIB4
        h22vv5Y3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWdO-0006Aq-Br; Thu, 28 Jun 2018 13:06:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 562BB20289CE6; Thu, 28 Jun 2018 15:06:46 +0200 (CEST)
Date:   Thu, 28 Jun 2018 15:06:46 +0200
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
Message-ID: <20180628130646.GH2494@hirez.programming.kicks-ass.net>
References: <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
 <20180627094633.GG2512@hirez.programming.kicks-ass.net>
 <20180627155721.GZ3593@linux.vnet.ibm.com>
 <20180627175134.GV2494@hirez.programming.kicks-ass.net>
 <20180628051334.GG3593@linux.vnet.ibm.com>
 <20180628082653.GX2494@hirez.programming.kicks-ass.net>
 <20180628123833.GJ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628123833.GJ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:38:33AM -0700, Paul E. McKenney wrote:
> Please let me try again.
> 
> The approach you are suggesting, clever though it is, disables a check

  https://lkml.kernel.org/r/20180627094633.GG2512@hirez.programming.kicks-ass.net

Is the one we're talking about, right?

That does not disable any actual check afaict. It simply does not do a
wakeup when ran on an offline CPU. And ensures we do an unconditional
wakeup soon after from a still running CPU.

> of a type that has proved to be an important diagnostic in the past.
> It is only reasonable to assume that this check would be important
> and helpful in the future, but only if that check remains in the code.

I am confused..

> Yes, agreed, given the current structure of the code, this particular
> instance of the check would not matter, but experience indicates that
> RCU code restructuring is not at all uncommon, with the current effort
> being but one case in point.

Once more confused...

> So, unless I am missing something, the only possible benefit of disabling
> this check is getting rid of an acquisition of an uncontended lock in
> a code path that is miles (sorry, kilometers) away from any fastpath.
> So, again, yes, it is clever.  If it sped up a fastpath, I might be
> sorely tempted to take it.  But the alternative is straightforward and
> isn't anywhere near a fastpath.  So, though I do very much appreciate
> the cleverness and creativity, I am not seeing your change to be a
> good tradeoff from a long-term maintainability viewpoint.

I think you mean guarantee/invariant instead of check. But I see it no
different than any other missed rcu_gp_kthread_wake(). You can similarly
fail to make the call while restructuring.
