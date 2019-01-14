Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A898FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7089C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ckHtDQ6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfANMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:52:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OEJRUpnqbA30v8lY8V1rG6FxqBUP8Aqg55SRfudJNLY=; b=ckHtDQ6+EhIfErOQNLDJaEOzr
        yhkC9nSjg7nDB4OaYKecEyYtbwn0sffgMmbhsxpPAsKec6jrNTsptQsNtRssjSwEUBDNnvs5KnjtO
        wVn537tC5EY9ARmlU5QeJXYtIK0N9aOyNIvC7EfpFq547n69mwskyrlmJEnCadzcbkvCN2qRJZl/B
        W35PuDEkfhFvOEpIGZQMX62KHMPWvTxELpGfIHlxvA8MBaZWnCQROrYn1+rXAePH2nKFC2MT3nHhJ
        L3ma/e4FdOJ2Um5NWBopZ5aFoIOI3ucZaYqUGbp1q+RXIzTgbof4sd/bg+KP+UxFMgjJH4Cu7LLo6
        tOo1UQfzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj1jI-0004ur-Gb; Mon, 14 Jan 2019 12:52:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2231F2080B952; Mon, 14 Jan 2019 13:52:35 +0100 (CET)
Date:   Mon, 14 Jan 2019 13:52:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
Message-ID: <20190114125235.GB20726@hirez.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
 <20190111124835.GP1900@hirez.programming.kicks-ass.net>
 <1547222103.83374.72.camel@acm.org>
 <20190111165529.GA14054@worktop.programming.kicks-ass.net>
 <1547226101.83374.80.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547226101.83374.80.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:01:41AM -0800, Bart Van Assche wrote:
> On Fri, 2019-01-11 at 17:55 +0100, Peter Zijlstra wrote:
> > On Fri, Jan 11, 2019 at 07:55:03AM -0800, Bart Van Assche wrote:
> > > On Fri, 2019-01-11 at 13:48 +0100, Peter Zijlstra wrote:
> > > > I spotted this new v6 in my inbox and have rebased to it.
> > > 
> > > Thanks!
> > > 
> > > > On Wed, Jan 09, 2019 at 01:01:48PM -0800, Bart Van Assche wrote:
> > > > 
> > > > > The changes compared to v5 are:
> > > > > - Modified zap_class() such that it doesn't try to free a list entry that
> > > > >   is already being freed.
> > > > 
> > > > I however have a question on this; this seems wrong. Once a list entry
> > > > is enqueued it should not be reachable anymore. If we can reach an entry
> > > > after call_rcu() happened, we've got a problem.
> > > 
> > > Apparently I confused you - sorry that I was not more clear. What I meant is
> > > that I changed a single if test into a loop. The graph lock is held while that
> > > loop is being executed so the code below is serialized against the code called
> > > from inside the RCU callback:
> > > 
> > > @@ -4574,8 +4563,9 @@ static void zap_class(struct pending_free *pf, struct lock
> > > _class *class)
> > >                 entry = list_entries + i;
> > >                 if (entry->class != class && entry->links_to != class)
> > >                         continue;
> > > -               if (__test_and_set_bit(i, pf->list_entries_being_freed))
> > > +               if (list_entry_being_freed(i))
> > >                         continue;
> > 
> > Yes, it is the above change that caught my eye.. That checks _both_ your
> > lists. One is your current open one (@pf), but the other could already
> > be pending the call_rcu().
> > 
> > So my question is why do we have to check both ?! How come the old code,
> > that only checked @pf, is wrong?
> > 
> > > +               set_bit(i, pf->list_entries_being_freed);
> > >                 nr_list_entries--;
> > >                 list_del_rcu(&entry->entry);
> > >         }
> 
> The list_del_rcu() call must only happen once. 

Yes; obviously. But if we need to check all @pf's, that means the entry
is still reachable after a single reset_lock()/free_key_range(), which
is a bug.

> I ran into complaints reporting that
> the list_del_rcu() call triggered list corruption. This change made these complaints
> disappear.

I'm saying this solution buggy, because that means the entry is still
reachable after we do call_rcu() (which is a straight up UAF).

Also put it differently, what guarantees checking those two @pf's is
sufficient. Suppose your earlier @pf already did the RCU callback and
freed stuff while the second is in progress. Then you're poking into
dead space.
