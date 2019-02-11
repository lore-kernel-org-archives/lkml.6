Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79424C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D4C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0U7b+TSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfBKK5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:57:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H4FKzYfPZLq064fpvMaxRyPbo6mwWdcW0fXgF0VWycY=; b=0U7b+TSCrog3RuwY+5aIN+sYF
        hv/X24vYbiLjaTad2ObIWMdW7Cp2r/5OoaUpAoXctxc/VYvLlvd8Jg876MzN8pgTjMW8CZ3P1r/K0
        V/l2fLFDfV1pgkRUFU9xzkmvMbliuyWhgYyM+5CQxhzMD875i3oOU3bLFnwzd6Z1n69EGanR7kB8K
        jwNrR1x25pUNYuM1WWMfiO/CFWtHodA2Mmztx2gmUubEivvDlwHAS5qsyCdKdk3uPgvtfWI5OmsKO
        4D+eGwN6yN1S/MmNn/tvUdF/HvrjMc60lzn96bluUcUP+BS/cOvXQ1En41wBhdBg2BY4eZU6c4md3
        EkSdmP65w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt9HI-0007Ng-0y; Mon, 11 Feb 2019 10:57:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 535FA20D0E3CF; Mon, 11 Feb 2019 11:57:29 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:57:29 +0100
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
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105729.GH32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
 <20190211094044.GG32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:40:44AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > > +{
> > > +	long tmp;
> > > +
> > > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > > +			return 1;
> > 
> > That really wants to be:
> > 
> > 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> > 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> > 
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> 
> Also, the is the one case where LL/SC can actually do 'better'. Do you
> have benchmarks for say PowerPC or ARM64 ?

Ah, I see they already used asm-generic/rwsem.h which has similar code
to the above.
