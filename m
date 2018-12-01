Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C72C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7242147D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn3UpkeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7242147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLBHiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:38:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V7JmJEgFhjQIBn/2wtZ18og/+Z+YdLIC324QEXo42bE=; b=Qn3UpkeRQkjVfbW1Pn2pkXUH0
        9s3T/dUsciaSFh9re2TCvCOcPruEN8g0JVH6fzco/hhwTGUDGnjJ2PspljcmOcIfc+N5pWV9KRZZ9
        eQrq1N3nPhYfep5Hll9CXXov2a+0H+Bsa9U+0HS97vpsM3SmUEoftOZNYx+Z0hOOSLMQAhyO3OBGS
        7hp8Ew9Y1LL5DmHzLNzifSxq5I04ijoZ+Jn0DWdSSlw+AuLr09UXunJY9xaY0u4QAzu+1A4mDAVPU
        WvbWWQAO3c5yEwz2o2hFpOfxIwTRoKBiaZz9EBzMfheffF8BYxGgMVHx7E0rZvo3rsdnysER0RcUC
        Kq0GWGdYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTBom-0004G9-Hw; Sat, 01 Dec 2018 20:24:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E94D42029FD58; Sat,  1 Dec 2018 21:24:46 +0100 (CET)
Date:   Sat, 1 Dec 2018 21:24:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
Message-ID: <20181201202446.GA19706@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-23-bvanassche@acm.org>
 <20181129104902.GH2131@hirez.programming.kicks-ass.net>
 <20181129120143.GG2149@hirez.programming.kicks-ass.net>
 <1543510130.185366.139.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543510130.185366.139.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:48:50AM -0800, Bart Van Assche wrote:
> On Thu, 2018-11-29 at 13:01 +0100, Peter Zijlstra wrote:
> > On Thu, Nov 29, 2018 at 11:49:02AM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 28, 2018 at 03:43:20PM -0800, Bart Van Assche wrote:
> > > >  	/*
> > > >  	 * Remove all dependencies this lock is
> > > >  	 * involved in:
> > > >  	 */
> > > > +	list_for_each_entry_safe(entry, tmp, &all_list_entries, alloc_entry) {
> > > >  		if (entry->class != class && entry->links_to != class)
> > > >  			continue;
> > > >  		links_to = entry->links_to;
> > > >  		WARN_ON_ONCE(entry->class == links_to);
> > > >  		list_del_rcu(&entry->lock_order_entry);
> > > > +		list_move(&entry->alloc_entry, &free_list_entries);
> > > >  		entry->class = NULL;
> > > >  		entry->links_to = NULL;
> > > >  		check_free_class(zapped_classes, class);
> > > 
> > > Hurm.. I'm confused here.
> > > 
> > > The reason you cannot re-use lock_order_entry for the free list is
> > > because list_del_rcu(), right? But if so, then what ensures the
> > > list_entry is not re-used before it's grace-period?
> > 
> > Also; if you have to grow lock_list by 16 bytes just to be able to free
> > it, a bitmap allocator is much cheaper, space wise.
> > 
> > Some people seem to really care about the static image size, and
> > lockdep's .data section does matter to them.
> 
> How about addressing this by moving removed list entries to a "zapped_entries"
> list and only moving list entries from the zapped_entries list to the
> free_list_entries list after an RCU grace period? I'm not sure that it is
> possible to implement that approach without introducing a new list_head in
> struct lock_list.

I think we can do this with a free bitmap and an array of 2 pending
bitmaps and an index. Add newly freed entries to the pending bitmap
indicated by the current index, when complete flip the index -- such
that further new bits go to the other pending bitmap -- and call_rcu().

Then, on the call_rcu() callback, ie. after a GP has happened, OR our
pending bitmap into the free bitmap, and when the other pending bitmap
isn't empty, flip the index again and start it all again.

This ensures there is at least one full GP between setting a bit and it
landing in the free mask.

