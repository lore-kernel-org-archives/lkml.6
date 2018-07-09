Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE70A2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsS1XyYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeGIP0i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:26:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbeGIP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YftlQ5IiNeav9nDJzXvcbQWQNiSBjaszK4Ku56CAfII=; b=PsS1XyYCnpS0GhsyjuySlG+0T
        bMCqDPjWpw6mSPmepUdHNvGY6xFXWAH0D5AWt8G9W2dAmysL9iDW+Ma/Rfx8ZOogRSExRCOmIHFAd
        Bdzas4bXi+H+fShlKtI3th6K5N35l0qzqy26a+do5sEOX4omwaHol2cwl5+Yq+0ewQbTj5OPgJrgo
        pRabegJbXZ2EZ95vU6WlPWVVsoD+FztftPRZgQ22wZ8eFeZF4nDxBvDuGbY+5sdWxDtNpNEjdh2nu
        dJeUeDYsMSbaHYSlTSV8JtEQz4qMrnJYAOa8KzvzL4cxKHXqTS3ZlExITS1O/WnSxNgAGuKEUQelw
        70eZ/R6Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcY3e-0001PH-GS; Mon, 09 Jul 2018 15:26:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E62B42029764D; Mon,  9 Jul 2018 17:26:32 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:26:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709152632.GX2476@hirez.programming.kicks-ass.net>
References: <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709142932.GO3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:29:32AM -0700, Paul E. McKenney wrote:
> OK, so here are our options:
> 
> 1.	Add the RCU conditional to need_resched(), as David suggests.
> 	Peter has concerns about overhead.
> 
> 2.	Create a new need_resched_rcu_qs() that is to be used when
> 	deciding whether or not to do cond_resched().  This would
> 	exact the overhead only where it is needed, but is one more
> 	thing for people to get wrong.

Also, with the crypto guys checking need_resched() in asm that won't
really work either.

> 3.	Revert my changes to de-emphasize cond_resched_rcu_qs(),
> 	and go back to sprinkling cond_resched_rcu_qs() throughout
> 	the code.  This also is one more thing for people to get wrong,
> 	and might well eventually convert all cond_resched() calls to
> 	cond_resched_rcu_qs(), which sure seems like a failure mode to me.

 4a.	use resched_cpu() more agressive
 4b.	use the tick to set TIF_NEED_RESCHED when it finds rcu_urgent_qs
	(avoids the IPI at the 'cost' of a slight delay in processing)

 5.	make guest mode a quiescent state (like supposedly already done
	for NOHZ_FULL) (but this would not help the crypto guys).

 6.	....

ok I ran out of ideas here I think.


So for PREEMPT the tick can check preempt_count() == 0 and if so, know
it _could_ have rescheduled and advance the qs, right? But since we
don't have a preempt count for !PREEMPT_COUNT kernels this doesn't work.

And thus we need to invoke actual scheduling events and then through the
schedule() callback RCU knows things happened.

4b seems like something worth trying for !PREEMPT kernels I suppose
