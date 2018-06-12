Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 720E2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EFB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCCUYlq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeFLMM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:12:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeFLMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QKSxCx8YXtcZbqDr7JOG45Jn1z6AumNMNW/ErgmOZA0=; b=kCCUYlq3MVdhS0n09XCgTCJ2n
        QmHnlWTCckYdhoc6EACeU3gqWi1tpfAlmSfq7P0//57QlbSOlMYfbKlSkd7EKSonrusxW+SERySCp
        NsALA+nB0xcxkHFbM7JTMSl0JTArveqQI36fd+yyEr+35UfNPu9lZrLa/o2tYi+NDwZCFR1gXhwV/
        dH2ass89x3GLEUsQ9kH5/fTcDFib566IewD5jHjBJLKQAevsVhhIyBCBV/zV7ow4wqZmc5WbobLom
        4prDdsUqr5AEYhy0YlsiQqYIjK8kDAhChFtIb15Y/c9f/Hin2fQPM1DF592axSk4qSPKRDT2Lu3Lz
        997fhlizg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSiAN-0002s4-Il; Tue, 12 Jun 2018 12:12:51 +0000
Date:   Tue, 12 Jun 2018 05:12:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     jackm <jackm@dev.mellanox.co.il>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180612121251.GC19433@bombadil.infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180612115046.00007213@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612115046.00007213@dev.mellanox.co.il>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:50:46AM +0300, jackm wrote:
> On Fri,  8 Jun 2018 10:42:18 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > +		rcu_read_lock();
> > +		mad_agent = idr_find(&ib_mad_clients, hi_tid);
> > +		if (mad_agent
> > && !atomic_inc_not_zero(&mad_agent->refcount))
> > +			mad_agent = NULL;
> > +		rcu_read_unlock();
> 
> Hi Matthew,
> 
> I don't see the flow which can explain using atomic_inc_not_zero() here.
> 
> The refcount will go to zero only when unregister_mad_agent() is
> called (code below, see asterisks):
>         idr_lock(&ib_mad_clients);
>  ***    idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
>         idr_unlock(&ib_mad_clients);
> 
>         flush_workqueue(port_priv->wq);
>         ib_cancel_rmpp_recvs(mad_agent_priv);
> 
>  ***    deref_mad_agent(mad_agent_priv);
> 		[JPM] The call to idr_find in the interrupt context
> 		would need to occur here for the refcount to have a
> 		possibility of being zero.
> 		Shouldn't idr_find in the interrupt context fail, since
> 		idr_remove has already been invoked?

RCU is tricky.  Here's the flow:

CPU 0		CPU 1
rcu_read_lock();
mad_agent = idr_find(&ib_mad_clients, hi_tid);
		idr_lock(&ib_mad_clients);
		idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
		idr_unlock(&ib_mad_clients);
		flush_workqueue(port_priv->wq);
		ib_cancel_rmpp_recvs(mad_agent_priv);
		deref_mad_agent(mad_agent_priv);

Now, you're going to argue that CPU 0 is running in interrupt context, but
with virtualisation, it can have the CPU taken away from it at any time.
This window which looks like a couple of instructions long can actually
be seconds long.

> 	wait_for_completion(&mad_agent_priv->comp);
> 
> The refcount will be able to go to zero only after deref_mad_agent is
> called above.  Before this, however, idr_remove() has been called --
> so, if my understanding is correct, the idr_find call in
> find_mad_agent() should not succeed since the refcount can get to zero
> only AFTER the idr_remove call.
> 
> Could you please explain the flow which can result in idr_find
> succeeding (in the interrupt context) after idr_remove has been invoked
> (in the process context)?  Will idr_find succeed even after
> idr_remove, and only fail after kfree_rcu is invoked as well? (or,
> maybe after some garbage-collection delay?)

Ordering is weird in SMP systems.  You can appear to have causality
violations when you're operating locklessly (and rcu_read_lock()
is essentially lockless).  So we can absolutely observe the store to
agent->refcount before we observe the store to idr->agent.

Documentation/memory-barriers.txt has a LOT more information on this.
