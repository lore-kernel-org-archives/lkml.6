Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398512173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLSAJM2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfAGPyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:54:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EB8jJo74ngJGhrjSVclXwp46WwssCxFPErndM29eks4=; b=JLSAJM2YVQOUjWUV138MvuYR9
        3dPjf9waKIDM2/SO2xRhDIZubSfm4WiTjU1KRVlE61YjDLJBX6BUQeR6hXY70aeXEitHFolg5nUWF
        BaJYfMxGBI5kEhXiGbsj4uGDUZOO0cKwQ5TgztVLIm0k1/Hvw9xclye+ufU0bEAbJ6UEANhk8ffkc
        h0Rd/oZ/ZVFxuhY1jj5oXhfWd4feL+hb9fzMcpe5C8RYWl/rF4Cemdu+QVbcrvCfOzQAKAU9eXjfG
        A7P6JZ5ObfZZxoErjKxkU3AM7TO+uz8iQYnhPcQg5ui+LYFSbIOHWiMF42+c9mZkfoYcQ8U43sJO7
        kecSpl8eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggXEP-0006cV-MG; Mon, 07 Jan 2019 15:54:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3023020074A04; Mon,  7 Jan 2019 16:54:23 +0100 (CET)
Date:   Mon, 7 Jan 2019 16:54:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Message-ID: <20190107155423.GM2218@hirez.programming.kicks-ass.net>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
 <20190107094610.GA2861@worktop.programming.kicks-ass.net>
 <20190107082223-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107082223-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:

> > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > implications at all. The address dependency is strictly weaker than an
> > rmb in that it will only order the two loads in qestion and not, like
> > rmb, any prior to any later load.
> 
> So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> 
> 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> the madatory one can't, so assuming we do not want
> it to be stronger than rmp then either we want
> smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> or we just will specify that dependent_ptr() works for
> both DMA and SMP.

The latter; the construct simply generates dependent loads. It is up to
the CPU as to what all that works for.

> 2. Down the road, someone might want to order a store after a load.
> Address dependency does that for us too. Assuming we make
> dependent_ptr a NOP on x86, we will want an mb variant
> which isn't a NOP on x86. Will we want to rename
> dependent_ptr to dependent_ptr_rmb at that point?

Not sure; what is the actual overhead of the construct on x86 vs the
NOP?
