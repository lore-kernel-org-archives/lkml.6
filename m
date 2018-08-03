Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88932177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmEVRfg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88932177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeHCTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:22:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeHCTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yeO2spQBAYXpjtYQITq9geif5AxCSzSVDS3zTlNgne8=; b=gmEVRfg48JJfn+evXnUrt9H+bn
        9xoWAUXGUmOqLOjPw1N8iFkV0284YbaG1UFNTmZ3r452yGoi55/UKQ3NY8qWPpnbgtOy78NL0c9mQ
        2jCjnJkLrhJhVPAqoF/ZzQaj9MP+n8FdexQtduuW1zDja2QonMr5xVzEFWkr/z31YbRHipscTlgsl
        /9vdZT5nFf2d+O0jk3gAQoyFOsJ9Q9WHt3Q1skb129yyOe1gkIZ5ahVzzPHQnLWApM0kgRLM5Pmc1
        dHXRZpWnS8tqVX+Ug7oOoZ2te/DwjIzC3Jx888/XYtG+DfKbafm0rE46mj8wzQDimSjiak14zf41W
        IVL26eIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldpF-0007Nd-GX; Fri, 03 Aug 2018 17:25:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46F8D20267E57; Fri,  3 Aug 2018 19:25:16 +0200 (CEST)
Date:   Fri, 3 Aug 2018 19:25:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com
Subject: Re: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180803172516.GM2458@hirez.programming.kicks-ass.net>
References: <20180801100255.4278-1-riel@surriel.com>
 <20180801100255.4278-12-riel@surriel.com>
 <20180803155618.GB2494@hirez.programming.kicks-ass.net>
 <1533314448.28585.101.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1533314448.28585.101.camel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:40:48PM -0400, Rik van Riel wrote:
> On Fri, 2018-08-03 at 17:56 +0200, Peter Zijlstra wrote:
> > On Wed, Aug 01, 2018 at 06:02:55AM -0400, Rik van Riel wrote:
> > > Conditionally skip lazy TLB mm refcounting. When an architecture
> > > has
> > > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> > > lazy TLB mode anywhere will get shot down from exit_mmap, and there
> > > in no need to incur the cache line bouncing overhead of refcounting
> > > a lazy TLB mm.
> > >=20
> > > Implement this by moving the refcounting of a lazy TLB mm to helper
> > > functions, which skip the refcounting when it is not necessary.
> > >=20
> > > Deal with use_mm and unuse_mm by fully splitting out the
> > > refcounting
> > > of the lazy TLB mm a kernel thread may have when entering use_mm
> > > from
> > > the refcounting of the mm that use_mm is about to start using.
> >=20
> >=20
> > > @@ -2803,16 +2803,29 @@ context_switch(struct rq *rq, struct
> > > task_struct *prev,
> > >  	 * membarrier after storing to rq->curr, before returning
> > > to
> > >  	 * user-space.
> > >  	 */
> > > +	/*
> > > +	 * kernel -> kernel	lazy + transfer active
> > > +	 *   user -> kernel	lazy + grab_lazy_mm active
> > > +	 *
> > > +	 * kernel ->   user	switch + drop_lazy_mm active
> > > +	 *   user ->   user	switch
> > > +	 */
> > > +	if (!mm) {				// to kernel
> > >  		next->active_mm =3D oldmm;
> > >  		enter_lazy_tlb(oldmm, next);
> > > +
> > > +		if (prev->mm)			// from user
> > > +			grab_lazy_mm(oldmm);
> > > +		else
> > > +			prev->active_mm =3D NULL;
> > > +	} else {				// to user
> > >  		switch_mm_irqs_off(oldmm, mm, next);
> > > =20
> > > +		if (!prev->mm) {		// from kernel
> > > +			/* will drop_lazy_mm() in
> > > finish_task_switch(). */
> > > +			rq->prev_mm =3D oldmm;
> > > +			prev->active_mm =3D NULL;
> > > +		}
> > >  	}
> >=20
> > So this still confuses the heck out of me; and the Changelog doesn't
> > seem to even mention it. You still track and swizzle ->active_mm but
> > no
> > longer refcount it.
> >=20
> > Why can't we skip the ->active_mm swizzle and keep ->active_mm =3D=3D
> > ->mm.
> >=20
> > Doing the swizzle but not the refcount just makes me itch.
>=20
> I am working on that now, it adds another 7-8
> patches on top of this series.

I thought those were taking ->active_mm out entirely, not avoiding the
swizzle, but I might have missed something in the middle :-)

> The big question is, do we want this optimization
> to wait for further cleanups, or should we run with
> code that seems to be stable right now, and put
> additional cleanups and enhancements on top of it
> later?

At the very least the Changelog needs to explain why we cannot do away
with the swizzle now and how doing the swizzle without the refcounting
is not completely broken (I think I see, but urgh).

