Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="alC2osDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfAJMlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:41:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfAJMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xCx8b08LW7Cc4m9Iovv8U6+26LBBjqnoySmyNAnN9Bg=; b=alC2osDXt6KDkZF3VBb3TWUeV
        sU6ZFqmcBvDa3HbA3nqg67bsUp1x1yGpbUl/rEHsKEeD2ZFqwBAzXHt0mV9mmI4w+XfwxsFrpFLOP
        gU21r8C9eVoNi0cUs0tkJUNfKNRSHjB7opYadFQjY8bEZ1/WxYXx/S61LgIt/3Q+EUhxksbeG72jY
        qVjml9W3toAgfPdy9Dw6bD6PX8yIysI6U1WX7zXH5OcXZD+EwcTrU/8MzJY8eqgN+FWgzOBOKV7me
        Nl0EZGZqZpVmoZ2I6Q/iT0bVGrCQF7soz1xt+MjEclEbCzjAr6q3914BEvfPRFZf+R5fvirtoVmq3
        rBu9CV+Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghZeI-0002re-Jx; Thu, 10 Jan 2019 12:41:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2A412081518E; Thu, 10 Jan 2019 13:41:23 +0100 (CET)
Date:   Thu, 10 Jan 2019 13:41:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110124123.GA21224@hirez.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:37:46PM +0100, Florian Westphal wrote:
> Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> > Or maybe xt_replace_table() can be enhanced? When I hear that
> > something waits until an event happens on all CPUs I think about
> > wait_event() function. Would it be better for xt_replace_table() to
> > introduce an atomic counter that is decremented by CPUs, and the main
> > CPU waits until the counter gets zero?
> 
> That would mean placing an additional atomic op into the
> iptables evaluation path (ipt_do_table and friends).
> 

For:

	/*
	 * Ensure contents of newinfo are visible before assigning to
	 * private.
	 */
	smp_wmb();
	table->private = newinfo;

we have:

	smp_store_release(&table->private, newinfo);

But what store does that second smp_wmb() order against? The comment:

	/* make sure all cpus see new ->private value */
	smp_wmb();

makes no sense what so ever, no smp_*() barrier can provide such
guarantees.

> Only alternative I see that might work is synchronize_rcu (the
> _do_table functions are called with rcu read lock held).
> 
> I guess current scheme is cheaper though.

Is performance a concern in this path? There is no comment justifying
this 'creative' stuff.

