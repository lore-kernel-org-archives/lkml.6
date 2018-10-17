Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B635ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA2C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9miJW9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2C2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJQTHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:07:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeJQTHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vAVsTLMJA6FiTXtENZZOQUCdwoBIYlRBqtoKLVH21YI=; b=Y9miJW9Tfmna8fTSyfgRTtcBa
        MiS7bVh/rqlCKet64Su/YrxOQFnGRhqamNadfzCBCXhoc6A/5LfbCcUlK8ORrP9IZRYWvAWbirl0o
        2rWfnFgTS+pxLI+prLZZO9oUfOaTvY989bdgj4rvEjnlXodxMPZ8DbMZEP0oegycNw3SVTLvU6+Tj
        tBAWBb+iwb+fFBdFBgFLobNp4OhU7xeCvoqSonBlKNwJsw5ossLT0MXOWB52BQ1gUJHtdij8qIW0f
        36dEkhwbgGWK9CWLglYJ0NYByLiVuUydnKnV3SWh3k/5Ya9KKqt1JUJCCbK9c70KhPED4YTWg2CrB
        1uS0nwikw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCjjv-0000pi-Hc; Wed, 17 Oct 2018 11:11:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E63EC2029856A; Wed, 17 Oct 2018 13:11:45 +0200 (CEST)
Date:   Wed, 17 Oct 2018 13:11:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:54:38AM +0000, David Laight wrote:
> From: Sebastian Andrzej Siewior
> > Sent: 16 October 2018 21:25
> > I've seen the WARN_ON_ONCE(__read_cr3() != build_cr3()) in
> > switch_mm_irqs_off() every once in a while during a snapshotted system
> > upgrade.
> > I also saw the warning early during which was introduced in commit
> > decab0888e6e ("x86/mm: Remove preempt_disable/enable() from
> > __native_flush_tlb()"). The callchain is
> > 
> >   get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()
> > 
> > with CONFIG_DEBUG_PAGEALLOC enabled.
> > 
> > Turns out, once I disable preemption around __flush_tlb_all() both
> > warnings do not appear.
> > 
> > Disable preemption during CR3 reset / __flush_tlb_all().
> > 
> > Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/x86/mm/pageattr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> > index 51a5a69ecac9f..fe6b21f0a6631 100644
> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
> >  	 * We should perform an IPI and flush all tlbs,
> >  	 * but that can deadlock->flush only current cpu:
> >  	 */
> > +	preempt_disable();
> >  	__flush_tlb_all();
> > +	preempt_enable();
> 
> Can it make any sense to flush the tlb with preemption enabled?
> Surely preemption must be disabled over something else as well?

This code is fishy anyway, for only doing that local invalidate.

Ideally we'd never ever merge anything that only does local invalidates,
on a global address space, that's just broken.


