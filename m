Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54712C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1682320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1682320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeKACZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbeKACZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84FAD4E8BA;
        Wed, 31 Oct 2018 17:26:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1E6517BB0;
        Wed, 31 Oct 2018 17:26:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Oct 2018 18:26:07 +0100 (CET)
Date:   Wed, 31 Oct 2018 18:26:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Message-ID: <20181031172604.GC21207@redhat.com>
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
 <20181022155644.GG4170@linux.ibm.com>
 <20181022161439.GA8640@redhat.com>
 <20181030175539.GL4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030175539.GL4170@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 31 Oct 2018 17:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Paul E. McKenney wrote:
>
> On Mon, Oct 22, 2018 at 06:14:40PM +0200, Oleg Nesterov wrote:
> > > > ----------------------------------------------------------------------------
> > > > Damn.
> > > >
> > > > This suddenly reminds me that I rewrote this code completely, and you even
> > > > reviewed the new implementation and (iirc) acked it!
> > > >
> > > > However, I failed to force myself to rewrite the comments, and that is why
> > > > I didn't send the "official" patch :/
> > > >
> > > > May be some time...
> > >
> > > Could you please point me at the last email thread?  Yes, I should be
> > > able to find it, but I would probably get the wrong one.  :-/
> >
> > probably this one,
> >
> > 	[PATCH] rcu_sync: simplify the state machine, introduce __rcu_sync_enter()
> > 	https://lkml.org/lkml/2016/7/16/150
> >
> > but I am not sure, will recheck tomorrow.
>
> Just following up...  Here is what I currently have.

Hmm. Are you sure you replied to the correct message? ;)

the patch below looks absolutely unrelated...

>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 1c1d315dfb7049d0233b89948a3fbcb61ea15d26
> Author: Dennis Krein <Dennis.Krein@netapp.com>
> Date:   Fri Oct 26 07:38:24 2018 -0700
>
>     srcu: Lock srcu_data structure in srcu_gp_start()
>
>     The srcu_gp_start() function is called with the srcu_struct structure's
>     ->lock held, but not with the srcu_data structure's ->lock.  This is
>     problematic because this function accesses and updates the srcu_data
>     structure's ->srcu_cblist, which is protected by that lock.  Failing to
>     hold this lock can result in corruption of the SRCU callback lists,
>     which in turn can result in arbitrarily bad results.
>
>     This commit therefore makes srcu_gp_start() acquire the srcu_data
>     structure's ->lock across the calls to rcu_segcblist_advance() and
>     rcu_segcblist_accelerate(), thus preventing this corruption.
>
>     Reported-by: Bart Van Assche <bvanassche@acm.org>
>     Reported-by: Christoph Hellwig <hch@infradead.org>
>     Signed-off-by: Dennis Krein <Dennis.Krein@netapp.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 60f3236beaf7..697a2d7e8e8a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -451,10 +451,12 @@ static void srcu_gp_start(struct srcu_struct *sp)
>
>  	lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
>  	WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
> +	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&sp->srcu_gp_seq));
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>  				       rcu_seq_snap(&sp->srcu_gp_seq));
> +	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
>  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
>  	rcu_seq_start(&sp->srcu_gp_seq);
>  	state = rcu_seq_state(READ_ONCE(sp->srcu_gp_seq));
>

