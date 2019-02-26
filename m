Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D3EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF52184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVRV37hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfBZLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:54:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBZLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v1NghnbTc7nCBxsYLExPUSuTxF3czfiFYG6o86E+sBE=; b=PVRV37hC+ztimpKp5Np2GaihJ
        rq/e2LfehYfF+HY/5y11br2t8TWS0BAK/yh3NutRwaRn3MG/FZLgx/rrSA+2HdH88fnV5nTTtSBCC
        gItRF6omahT1GM5WWyj2jepRND+hglxuXSWG6/iPURwsq3J3C15EZ86bQFlJIzfdeIa5Z06HT9o5X
        6OqP98p9hkHjWR1gy6ghIF3sU16moG7477A73kRwAy18K1QQu9ZPw3emsBfVeiTGki8nuFCwnChr1
        9I4TLrcBbB6EMFz9INtIZpnX2DZtuOIn7a8DI75dSXHHIy7pyq8s4a51rUim0RxFgC1Dbu1tLm3k3
        pYWmqEc7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gybJt-0005Eb-5C; Tue, 26 Feb 2019 11:54:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1E6520269AFC; Tue, 26 Feb 2019 12:54:41 +0100 (CET)
Date:   Tue, 26 Feb 2019 12:54:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/nmi: ratelimit unknown nmi logs
Message-ID: <20190226115441.GT32477@hirez.programming.kicks-ass.net>
References: <20190220014836.20510-1-olof@lixom.net>
 <20190220085947.GA17969@hirez.programming.kicks-ass.net>
 <CAOesGMj8SPbkNS_GOZa6nmBzud03_c-pB=xHMN+LxJdc-1aVJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMj8SPbkNS_GOZa6nmBzud03_c-pB=xHMN+LxJdc-1aVJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:00:28AM -0800, Olof Johansson wrote:
> On Wed, Feb 20, 2019 at 12:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Feb 19, 2019 at 05:48:36PM -0800, Olof Johansson wrote:
> > > Getting notified of unknown NMIs is obviously important, but getting
> > > notified on every single one, especially on larger systems with slow
> > > (serial) console causes more harm than good when it's a known noisy
> > > non-relevant event.
> > >
> > > So, let's ratelimit to avoid locking up the system.
> >
> > What kind of bonghit broken crap system is that?

Still interested to know what system and why this happens.

> > That is; this _really_ should not happen, and this is a bandaid, not
> > fixing the cause.
> 
> Oh, I agree -- this shouldn't happen, and it's being debugged and fixed.
> 
> So, I'm not looking at this as a bandaid to the real problem, but
> there's also no reason to DoS the system with prink when it does
> occur. If you want to configure the system to panic on unknown NMI
> there are already hooks for it.
> 
> I'm obviously happy to carry local patches for this, since it's a
> temporary problem. But yet again, I don't see a reason to have the
> kernel run off the rails for this condition.

Fair enough I suppose. Personally I don't care either way; you could
just boot without the slow serial in order to install a new kernel.
