Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6D521529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tuheDMZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6D521529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJQXnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:43:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJQXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Maq3//GhW3E1VatW0DA2eLq4C//k/OXK+csI1Q56fMs=; b=tuheDMZP43pyuPaEa+XpMtjF0
        liW9AEVS1i71V7/GVXK2uhlV+Ad16061iTYuH2hSJYtm/vNZ+fqpmjNR/luIWzB7ApaQdoeCQQ6AS
        SPDW2VmEoIRd4iuWBV6CzQXyVYQ3Sar5NKtk9MUWY7fC5Sk1hoVmZYpVuAB6+huyI8K1eZDThVPYD
        dt/Pm7C4/cz/CUYhB+LQfheU3mR9wkxRAo4alZqTFTPMLrZkS3CT74JKVQJg7tB3MLaVL4YX7o4Nt
        n8FJ4uc/kiffz8phqny+VHGcGaZFHZ29cj+Az7tKnudaDdU+KfhRaVDiA8kqo8E5BMGsOYuOKu8rS
        80mOoEDDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCo2Q-00070J-AI; Wed, 17 Oct 2018 15:47:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2BE120297B7F; Wed, 17 Oct 2018 17:47:07 +0200 (CEST)
Date:   Wed, 17 Oct 2018 17:47:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017154707.GL3121@hirez.programming.kicks-ass.net>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
 <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1810171315250.6000@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810171315250.6000@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:17:18PM +0200, Thomas Gleixner wrote:
> On Wed, 17 Oct 2018, Peter Zijlstra wrote:
> > On Wed, Oct 17, 2018 at 09:54:38AM +0000, David Laight wrote:
> > > >  	 * We should perform an IPI and flush all tlbs,
> > > >  	 * but that can deadlock->flush only current cpu:
> > > >  	 */
> > > > +	preempt_disable();
> > > >  	__flush_tlb_all();
> > > > +	preempt_enable();
> > > 
> > > Can it make any sense to flush the tlb with preemption enabled?
> > > Surely preemption must be disabled over something else as well?
> > 
> > This code is fishy anyway, for only doing that local invalidate.
> > 
> > Ideally we'd never ever merge anything that only does local invalidates,
> > on a global address space, that's just broken.
> 
> A little bit late to lament about that.

For this, yes :/ But for future stuff we should really not allow such
things anymore.

> So should we just replace it with cpa_flush_all() ?

The comment there suggests that will deadlock, supposedly because the
kernel_map_page() call can happen with IRQs disabled or such.

I've not deeply looked at this.
