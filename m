Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C451426E3C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uxp1bLyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C451426E3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754998AbeFZTav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:30:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeFZTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e8KsyTF2KlklHPfgGTBztDCH30Tv7O8EAlKqO4JBMsE=; b=Uxp1bLyFtyQ2u/hEj1JNXIMHM
        jm2dDtcM95J6m1kQtMZVFcUQVVlG68fK0ZeU+xHPr7xFgmv7+RGhPmOPbTReEl2drX68hEO1SAblb
        GGE2sbfuJUa6UqQftNUjPKqirKD5k9DRPvR84OUBNsyDLhn9Wpvrw52qsJr0LZvbrjuNPV54VwelG
        ls715xyqEowZqUPoJfIjTlbVtRYqeBKYEBVOLVEHdh7vlQq4BQ73B4FGC973WkVm9DWLBzF+kP8RO
        azDqKAu5nOeqjYG9So2xLx/gESSjdUfPGrxn0ONng28xsb8NLFKM8ZexGNbHkbcffBCsnpvfsy4U9
        2rgtxUVZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXtfl-0005Qx-Io; Tue, 26 Jun 2018 19:30:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 593382029FA0A; Tue, 26 Jun 2018 21:30:40 +0200 (CEST)
Date:   Tue, 26 Jun 2018 21:30:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCHv2 01/11] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180626193040.GO2494@hirez.programming.kicks-ass.net>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-2-mark.rutland@arm.com>
 <CAHp75Vdsu2LQtPdjaxfYhc3qT6gOe7bdGQKB==52W-WpORp-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdsu2LQtPdjaxfYhc3qT6gOe7bdGQKB==52W-WpORp-WQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:53:18PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 25, 2018 at 1:59 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > working after making the atomic_long interface type safe.
> >
> > Needing casts is bad form, which made me look at the code. There are no
> > ld_semaphore::count users outside of these functions so there is no
> > reason why it can not be an atomic_long_t in the first place, obviating
> > the need for this cast.
> >
> > That also ensures the loads use atomic_long_read(), which implies (at
> > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> >
> > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > very thin (the only difference is not changing *old on success, which
> > most callers don't seem to care about).
> >
> > So rework the whole thing to use atomic_long_t and its accessors
> > directly.
> >
> > While there, fixup all the horrible comment styles.
> 
> 
> > -               ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
> > +               atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
> 
> I suppose it's simple atomic_long_add() here?

Different ordering rules for those two. I didn't look hard enough to see
if that mattered here.
