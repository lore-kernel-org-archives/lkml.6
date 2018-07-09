Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC07C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF61920883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kc/Qxm5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF61920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeGIIx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:53:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeGIIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rc0pwTbDq7Eh8g/XGIlvoUtSEjY5yrE4HZL1BpHw2XY=; b=Kc/Qxm5zeoqzaS8yJPuBFCYBH
        uv2oiRop5cjY+8PT6g7s3FkqT3wpBT5+s1UGbvBZiDa7neMuYT5QrEypGet8qfhxQhf9FX5NdRXKw
        8NAjhzMUhP7d3tBIcU2y1u3Gy9nC4Am5C6Fm7+kR7IHv8qanDkKIHVtiwwEfBqPp6QjavqOmrrcJP
        9hoYf+BlToXim3iEgBmQDmXgbOiA+qHQGrwiL5d590qFXnq4Yso339I3L/TPx7XWwtO7usQujfRax
        +uP5/HGILwyMk82rQo6jIr3BG1t0M1bHU7YdE+iQ260CJdIPckCtwRCuE4xCNQPAx36xYNFuQXTNN
        VmFqBJEMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcRvd-0007ii-GQ; Mon, 09 Jul 2018 08:53:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECB122028932D; Mon,  9 Jul 2018 10:53:51 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:53:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709085351.GC2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706171150.GI3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:11:50AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 06, 2018 at 06:29:05PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 06, 2018 at 03:53:30PM +0100, David Woodhouse wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index e4d4e60..89f5814 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1616,7 +1616,8 @@ static inline int spin_needbreak(spinlock_t *lock)
> > >  
> > >  static __always_inline bool need_resched(void)
> > >  {
> > > -	return unlikely(tif_need_resched());
> > > +	return unlikely(tif_need_resched()) ||
> > > +		rcu_urgent_qs_requested();
> > >  }
> > 
> > Instead of making need_resched() touch two cachelines, I think I would
> > prefer adding resched_cpu() to rcu_request_urgent_qs_task().
> 
> I used to do something like this, but decided that whacking each holdout
> CPU over the head ten times a second was a bit much.

This is only called from the !list_empty(rcu_tasks_holdout) loop in
rcu_tasks_kthread afaict, and that has a
schedule_timeout_interruptible(HZ) in it, which I read as once a second.

Which seems like an entirely reasonable amount of time to kick a task.
Not scheduling for a second is like an eternity.
