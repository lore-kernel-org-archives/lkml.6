Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56CAC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6712147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GD6MNJTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBGTqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:46:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d2Auinqj+iinWuACUh1zWQLvdx+uvY34M1d8kVvscRo=; b=GD6MNJTH7ahxODIJwjMRtXdnR
        RGD+hw9J+ZDL8sz/xbv/d7Zqgil1ESzAyfO7J6vTAR0eOBQbKA+2n1dr0BkrZrWBaHsHiinLNErB3
        g+h3oZHOrxMVq84OJ9xWE4MvvJNsJ7gMZziSCkHMHlorLYek/Ay+0h+X4Ff02okQAYSM9Q9kbsEYG
        sP6vzRH/Aw3OMOnEjV905Mx2248RvsaFgDw5pfYmQN1OH4MoKxYYnGwKbb1rQt3d/GT/GYTWx5Omh
        KzbHIoABiKb148eXjHvwxsrvCmrg26erty1ERFcwZ5kSKWjGzDj0O5Sh8u0FqWgxN6v7ekPCAzKqa
        wmJhspFPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grpcH-00070v-BQ; Thu, 07 Feb 2019 19:45:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01FBD2029E062; Thu,  7 Feb 2019 20:45:42 +0100 (CET)
Date:   Thu, 7 Feb 2019 20:45:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip 15/22] locking/rwsem: Merge owner into count on x86-64
Message-ID: <20190207194542.GG32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-16-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549566446-27967-16-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:07:19PM -0500, Waiman Long wrote:
> On 32-bit architectures, there aren't enough bits to hold both.
> 64-bit architectures, however, can have enough bits to do that. For
> x86-64, the physical address can use up to 52 bits. That is 4PB of
> memory. That leaves 12 bits available for other use. The task structure
> pointer is also aligned to the L1 cache size. That means another 6 bits
> (64 bytes cacheline) will be available. Reserving 2 bits for status
> flags, we will have 16 bits for the reader count.  That can supports
> up to (64k-1) readers.

*groan*...

So take qrwlock's idea for a queue, then make the count value (similar
to the new mutex); that is have a bit0 be a r/w bit, when w bits 6-N are
owner, when r they are reader-count. bit1 can be a pending bit, bit2 a
handoff bit etc..

That should fit and work on 32bit and 64bit without issue.

I have a half-arsed rwsem-atomic.c somewhere that does just that. I just
never got around to doing all the optimistic spin and steal crap that
makes our current rwsem fly.

And that nicely gets rid of that mind bending BIAS crud.
