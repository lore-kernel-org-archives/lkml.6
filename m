Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71547214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loFnscbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71547214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLDIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:14:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLDIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wt6Qcr0MFiw9wJQCE6DeZZsX1mzPNojAtPSbLz3FeLA=; b=loFnscbPHHJK0R3dsXYcsPkRb
        kY+gPlUlyB+UgjYtLkkKOj+Ksv6lCqiZk2zV8JlssrbZGt8IE9mV28OF/8i0lMXAxJt709pv+JymA
        ljt52UFkpODvJkmsdSJjZTcs+Twjo1hbD5pQU8LxxAhiM6adnrHzieKVJuptAvzsaIQlahOkI8bi8
        jtK/Dw5ajuSLWmoXR00IAz2Nu51uOlLnMoLz9+eNRUU7sDWq9Nr3Ehw1x4sAcyQW0yr9McvDV373J
        jcbsDNf66h7v2h4L6t65saEBxJfII1dII2ADuz1IEP/cJguw06ZhiUDxHuOE7ibXSUaC3zcJV2+Ly
        sXhi/c0BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gU5qo-00083n-S1; Tue, 04 Dec 2018 08:14:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B85A2029FD58; Tue,  4 Dec 2018 09:14:36 +0100 (CET)
Date:   Tue, 4 Dec 2018 09:14:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
Message-ID: <20181204081436.GL11614@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-23-bvanassche@acm.org>
 <20181129104902.GH2131@hirez.programming.kicks-ass.net>
 <20181129120143.GG2149@hirez.programming.kicks-ass.net>
 <1543510130.185366.139.camel@acm.org>
 <20181201202446.GA19706@hirez.programming.kicks-ass.net>
 <1543855248.185366.158.camel@acm.org>
 <20181203173258.GK11614@hirez.programming.kicks-ass.net>
 <1543861019.185366.167.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543861019.185366.167.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:16:59AM -0800, Bart Van Assche wrote:
> On Mon, 2018-12-03 at 18:32 +0100, Peter Zijlstra wrote:
> > On Mon, Dec 03, 2018 at 08:40:48AM -0800, Bart Van Assche wrote:
> > 
> > > > I think we can do this with a free bitmap and an array of 2 pending
> > > > bitmaps and an index. Add newly freed entries to the pending bitmap
> > > > indicated by the current index, when complete flip the index -- such
> > > > that further new bits go to the other pending bitmap -- and call_rcu().
> > > > 
> > > > Then, on the call_rcu() callback, ie. after a GP has happened, OR our
> > > > pending bitmap into the free bitmap, and when the other pending bitmap
> > > > isn't empty, flip the index again and start it all again.
> > > > 
> > > > This ensures there is at least one full GP between setting a bit and it
> > > > landing in the free mask.
> > > 
> > > Hi Peter,
> > > 
> > > How about the following alternative which requires only two bitmaps instead
> > > of three:
> > > - Maintain two bitmaps, one for the free entries and one for the entries
> > >   that are being freed.
> > > - Protect all accesses to both bitmaps with the graph lock.
> > > - zap_class() sets a bit in the "being freed" bitmap for the entries that
> > >   should be freed after a GP.
> > > - Instead of making free_zapped_classes() wait for a grace period by calling
> > >   synchronize_sched(), use call_rcu() and do the freeing work from inside the
> > >   RCU callback.
> > > - From inside the RCU callback, set a bit in the "free" bitmap for all entries
> > >   that have a bit set in the "being freed" bitmap and clears the "being freed"
> > >   bitmap.
> > 
> > What happens when another unreg happens while the rcu_call thing is
> > still pending?
> 
> A new flag will have to keep track of whether or not an RCU callback has
> already been scheduled via rcu_call() but not yet executed to avoid double
> RCU call complaints.

That's not the only problem there. You either then have to synchronously
wait for that flag / rcu_call to complete, or, if you modify the bitmap,
ensure it re-queues itself for another GP before committing, which is
starvation prone.

> In other code a possible alternative would be to
> allocate the RCU head data structure dynamically. However, I don't think
> that alternative is appropriate inside the lockdep code - I don't want to
> introduce a circular dependency between the lockdep code and the memory
> allocator.

Yes, that's a trainwreck waiting to happen ;-)
