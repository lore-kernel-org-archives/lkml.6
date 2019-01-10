Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E202C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A27208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzonvghC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfAJUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:20:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfAJUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Uck0g1nu/MAhAmoxyTpF+5QSanjNqtPY8ZILNK+8o0=; b=GzonvghCFo7WEr3DO/ZL6C84r
        yWD0TH/frRosT+n975ZUNinN4VEcDPstMq+TkIClJS0i8UMWg6oQ1Po1VTa9eUE0rLUoGR8iyX7N1
        uSa8g/IT8ian5jneVPr9bFf2U7xvCJPNB9Iudb0Z+uAfBOaU0bC5Cjn/F2GdL5itnhkBAb2Lscd4V
        ue6ZtLKlewKUE6FMLtatXkhU41g4r62/7ShAbx85tuxk6x4yxNmb9bUdBje8NXfMHZlTSgDm/UHmY
        4bHTZEZm/IO1XBQiuQe0UjFBb9XAHTMPT5+jc5XFxpoBYOUgJuT6fQTE58ec/vB1une5MRRtEA6Wq
        lJmjEquVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgoZ-00070M-J8; Thu, 10 Jan 2019 20:20:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 042E29844AF; Thu, 10 Jan 2019 21:20:29 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:20:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110202028.GJ2861@worktop.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
 <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:48:12PM +0100, Florian Westphal wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 	/*
> > 	 * Ensure contents of newinfo are visible before assigning to
> > 	 * private.
> > 	 */
> > 	smp_wmb();
> > 	table->private = newinfo;
> > 
> > we have:
> > 
> > 	smp_store_release(&table->private, newinfo);
> > 
> > But what store does that second smp_wmb() order against? The comment:
> > 
> > 	/* make sure all cpus see new ->private value */
> > 	smp_wmb();
> > 
> > makes no sense what so ever, no smp_*() barrier can provide such
> > guarantees.
> 
> IIRC I added this at the request of a reviewer of an earlier iteration
> of that patch.
> 
> IIRC the concern was that compiler/hw could re-order
> 
> smb_wmb();
> table->private = newinfo;
> /* wait until all cpus are done with old table */
> 
>  into:
> 
> smb_wmb();
> /* wait until all cpus are done with old table */
> ...
> table->private = newinfo;
> 
> and that (obviously) makes the wait-loop useless.

The thing is, the 'wait for all cpus' thing is pure loads, not stores,
so smp_wmb() is a complete NOP there.

If you want to ensure those loads happen after that store (which does
indeed seem like a sensible thing), you're going to have to use
smp_mb().
