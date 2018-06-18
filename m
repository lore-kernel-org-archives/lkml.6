Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF310208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SGqwAmoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF310208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936022AbeFRJoy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:44:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755056AbeFRJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fs1wYfoe3guBtglX3Xc6bYm+R5vtZLQXcMFKCcWVbZg=; b=SGqwAmoDVwFnBI2aPSOHXj8qx
        0fcLyluZ9vCRqKTpbhvqPrwGgMYUHyzBNAIAm6MZGBRKr3mlvgaQPbYRxasfLTha9H3N5zKKJdC+Q
        bX9gWMUt/6OVi3BRjA4PCfNHAG9dAB1YEF5Lw1+sFdo1yXCrQUSkzliGu+F45+ZtrEV576AR9VUlx
        KSQm2Z9ZDDJxm+2Oap5gVINHwo854hI+HAPgnT9t9V5hmddAOcmvhVFisIDIKetSPr5mtwL9e6ydt
        RVCjMjU2sS2XQhovsK5Z1qrXoNvWOQt/kCrrppRsKFyi1RERCGui3Ctxomv81ZW4vmxBKHSi8K+Uz
        FbatiiC9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUqiP-0004ak-Du; Mon, 18 Jun 2018 09:44:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EB5B2029FA11; Mon, 18 Jun 2018 11:44:47 +0200 (CEST)
Date:   Mon, 18 Jun 2018 11:44:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
Message-ID: <20180618094447.GG2458@hirez.programming.kicks-ass.net>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
 <20180615193438.GE2458@hirez.programming.kicks-ass.net>
 <CAHmME9qr4PzsGKK2r2sGoCty_Yum_3UqUdL76CPOAOq18K+a4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qr4PzsGKK2r2sGoCty_Yum_3UqUdL76CPOAOq18K+a4A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:30:46PM +0200, Jason A. Donenfeld wrote:
> On Fri, Jun 15, 2018 at 9:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Didn't we recently do a bunch of crypto patches to help with this?
> >
> > I think they had the pattern:
> >
> >         kernel_fpu_begin();
> >         for (units-of-work) {
> >                 do_unit_of_work();
> >                 if (need_resched()) {
> >                         kernel_fpu_end();
> >                         cond_resched();
> >                         kernel_fpu_begin();
> >                 }
> >         }
> >         kernel_fpu_end();
> 
> Right, so that's the thing -- this is an optimization easily available
> to individual crypto primitives. But I'm interested in applying this
> kind of optimization to an entire queue of, say, tiny packets, where
> each packet is processed individually. Or, to a cryptographic
> construction, where several different primitives are used, such that
> it'd be meaningful not to have to get the performance hit of
> end()begin() in between each and everyone of them.

I'm confused.. how does the above not apply to your situation?
