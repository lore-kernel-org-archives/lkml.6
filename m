Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6719ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A382086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FeDBDsQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A382086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbeGQPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:38:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uS/bNO7OEQFQYbk+AM/okbMDh3fyHCh8zweXj8L6DkE=; b=FeDBDsQQAnEesRaRrTEjeAfOR
        7apJcQNZoDnCIl0kNyigeYoxHv7cM9j2PxnQFrKamxrvczR6yARyX31q0PW5slQ8OIgGoPayc/1JD
        QhEkN6sRZzEUFwe/kPwZ3bB2/LauojuEDhxe5AaRMwO3yJRAc7TKq+9cBmVQm71e9rBJkHmpai11R
        i7XQ+tBu9XLkM73kxIIyWV9Tb/YJIDgUySXsbdczWI8lyFzYbtdAHY8qAg95TjoOlB6Jm0Uj6Kp+r
        ruCwRwgzF7Xa6d9WTZXdZh7ylWgIZ4NUJyorSiQmrLK3aqYwDaY3XXJG1jPsWlNcK+zVpLFKNkyr5
        2hrO3vezw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRWq-0001Ax-UK; Tue, 17 Jul 2018 15:04:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7CE320275F38; Tue, 17 Jul 2018 17:04:39 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: waitqueue lockdep annotation V3
Message-ID: <20180717150439.GY2476@hirez.programming.kicks-ass.net>
References: <20171214152344.6880-1-hch@lst.de>
 <20180712191753.fvk2qersdvhcoqzp@linux-r8p5>
 <20180717142437.GA20286@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717142437.GA20286@lst.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:24:37PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 12, 2018 at 12:17:53PM -0700, Davidlohr Bueso wrote:
> > On Thu, 14 Dec 2017, Christoph Hellwig wrote:
> >
> >> Hi all,
> >>
> >> this series adds a strategic lockdep_assert_held to __wake_up_common
> >> to ensure callers really do hold the wait_queue_head lock when calling
> >> the unlocked wake_up variants.  It turns out epoll did not do this
> >> for a fairly common path (hit all the time by systemd during bootup),
> >> so the second patch fixed this instance as well.
> >
> > I ran into these changes because of patch 1 getting rid of ep->lock. Is
> > there any reason why this series was never picked up?
> 
> I'd love to see this merged, but I never heard back about it.

Seeing how it touched fs bits, I was expecting this to go through the
vfs tree; was that not the intended target?
