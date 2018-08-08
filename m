Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DD5208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DD5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHHMnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:43:00 -0400
Received: from foss.arm.com ([217.140.101.70]:36802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeHHMnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:43:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A51EF18A;
        Wed,  8 Aug 2018 03:23:57 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75E383F2EA;
        Wed,  8 Aug 2018 03:23:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CEA991AE180A; Wed,  8 Aug 2018 11:24:01 +0100 (BST)
Date:   Wed, 8 Aug 2018 11:24:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3] locking/rwsem: Exit read lock slowpath if queue empty
 & no writer
Message-ID: <20180808102401.GC28557@arm.com>
References: <1532459425-19204-1-git-send-email-longman@redhat.com>
 <55866c24-ff40-22cb-1390-6c9055bd2cb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55866c24-ff40-22cb-1390-6c9055bd2cb7@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Tue, Aug 07, 2018 at 07:29:49PM -0400, Waiman Long wrote:
> On 07/24/2018 03:10 PM, Waiman Long wrote:
> > diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> > index 3064c50..01fcb80 100644
> > --- a/kernel/locking/rwsem-xadd.c
> > +++ b/kernel/locking/rwsem-xadd.c
> > @@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
> >  	waiter.type = RWSEM_WAITING_FOR_READ;
> >  
> >  	raw_spin_lock_irq(&sem->wait_lock);
> > -	if (list_empty(&sem->wait_list))
> > +	if (list_empty(&sem->wait_list)) {
> > +		/*
> > +		 * In case the wait queue is empty and the lock isn't owned
> > +		 * by a writer, this reader can exit the slowpath and return
> > +		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
> > +		 * been set in the count.
> > +		 */
> > +		if (atomic_long_read(&sem->count) >= 0) {
> > +			raw_spin_unlock_irq(&sem->wait_lock);
> > +			return sem;
> > +		}
> >  		adjustment += RWSEM_WAITING_BIAS;
> > +	}
> >  	list_add_tail(&waiter.list, &sem->wait_list);
> >  
> >  	/* we're now waiting on the lock, but no longer actively locking */
> 
> Will this patch be eligible to go into 4.19 or 4.20?

It's probably worth reposting with the Acks you've received, so that Ingo
can easily pick it up into -tip (but it might be a bit close for 4.19 at
this point).

Will
