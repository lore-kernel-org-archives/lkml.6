Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC1C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5530D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a67LLsIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfBLM3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:29:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56658 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfBLM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xr7bqCJiI54yGklJuDMTx+dj7QMK1lT6F8mLmTV+W30=; b=a67LLsIqFy/WCGZTLMb8JVn22
        oNHRxicM5qqAeYh+/wVUQGDM47Kr7yO8goXG/vH+Gjd3/vacWRwmnx26ThvNn+keOik4il26F1O+F
        UXLF+tovYc+kG2OMiOcoJP9mBmh1teycVvrstW3ap4JblorozrGHF3pYid2/CiStj+q7J+xpc7qO7
        ewUorOH1Wos2yHu0qkLE6V6xCS8zcfoIvA7Rz9qpkptcNXEHeN4tjKu3rVdk/ox53/2MEjzhaey3q
        yeN3HdVOBCyX3dq8YHehFS6OsKsog6+z/n/Ja+ZzDXAZFaAIQKWuXwtd198eNdwQz+mRrQFzrRXOe
        aanWKjyGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtXBp-00041n-QW; Tue, 12 Feb 2019 12:29:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6085B23EB8AF7; Tue, 12 Feb 2019 13:29:26 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:29:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Upstream <linux.upstream@oneplus.com>,
        Chintan Pandya <chintan.pandya@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC 1/2] page-flags: Make page lock operation atomic
Message-ID: <20190212122926.GG32494@hirez.programming.kicks-ass.net>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
 <20190211125337.16099-2-chintan.pandya@oneplus.com>
 <20190211134607.GA32511@hirez.programming.kicks-ass.net>
 <364c7595-14f5-7160-d076-35a14c90375a@oneplus.com>
 <20190211174846.GM19029@quack2.suse.cz>
 <20190211175653.GE12668@bombadil.infradead.org>
 <20190212074535.GN19029@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212074535.GN19029@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:45:35AM +0100, Jan Kara wrote:
> On Mon 11-02-19 09:56:53, Matthew Wilcox wrote:
> > On Mon, Feb 11, 2019 at 06:48:46PM +0100, Jan Kara wrote:
> > > On Mon 11-02-19 13:59:24, Linux Upstream wrote:
> > > > > 
> > > > >> Signed-off-by: Chintan Pandya <chintan.pandya@oneplus.com>
> > > > > 
> > > > > NAK.
> > > > > 
> > > > > This is bound to regress some stuff. Now agreed that using non-atomic
> > > > > ops is tricky, but many are in places where we 'know' there can't be
> > > > > concurrency.
> > > > > 
> > > > > If you can show any single one is wrong, we can fix that one, but we're
> > > > > not going to blanket remove all this just because.
> > > > 
> > > > Not quite familiar with below stack but from crash dump, found that this
> > > > was another stack running on some other CPU at the same time which also
> > > > updates page cache lru and manipulate locks.
> > > > 
> > > > [84415.344577] [20190123_21:27:50.786264]@1 preempt_count_add+0xdc/0x184
> > > > [84415.344588] [20190123_21:27:50.786276]@1 workingset_refault+0xdc/0x268
> > > > [84415.344600] [20190123_21:27:50.786288]@1 add_to_page_cache_lru+0x84/0x11c
> > > > [84415.344612] [20190123_21:27:50.786301]@1 ext4_mpage_readpages+0x178/0x714
> > > > [84415.344625] [20190123_21:27:50.786313]@1 ext4_readpages+0x50/0x60
> > > > [84415.344636] [20190123_21:27:50.786324]@1 
> > > > __do_page_cache_readahead+0x16c/0x280
> > > > [84415.344646] [20190123_21:27:50.786334]@1 filemap_fault+0x41c/0x588
> > > > [84415.344655] [20190123_21:27:50.786343]@1 ext4_filemap_fault+0x34/0x50
> > > > [84415.344664] [20190123_21:27:50.786353]@1 __do_fault+0x28/0x88
> > > > 
> > > > Not entirely sure if it's racing with the crashing stack or it's simply
> > > > overrides the the bit set by case 2 (mentioned in 0/2).
> > > 
> > > So this is interesting. Looking at __add_to_page_cache_locked() nothing
> > > seems to prevent __SetPageLocked(page) in add_to_page_cache_lru() to get
> > > reordered into __add_to_page_cache_locked() after page is actually added to
> > > the xarray. So that one particular instance might benefit from atomic
> > > SetPageLocked or a barrier somewhere between __SetPageLocked() and the
> > > actual addition of entry into the xarray.
> > 
> > There's a write barrier when you add something to the XArray, by virtue
> > of the call to rcu_assign_pointer().
> 
> OK, I've missed rcu_assign_pointer(). Thanks for correction... but...
> rcu_assign_pointer() is __smp_store_release(&p, v) and that on x86 seems to
> be:
> 
>         barrier();                                                      \
>         WRITE_ONCE(*p, v);                                              \
> 
> which seems to provide a compiler barrier but not an SMP barrier? So is x86
> store ordering strong enough to make writes appear in the right order? So far
> I didn't think so... What am I missing?

X86 is TSO, and that is strong enough for this. The only visible
reordering on TSO is due to the store-buffer, that is: writes may happen
after later reads.

