Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB980C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A52150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A52150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeISPpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeISPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:46 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2ZPK-0006it-UI; Wed, 19 Sep 2018 12:08:31 +0200
Date:   Wed, 19 Sep 2018 12:08:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [PATCH 1/8] x86/mm/cpa: Use flush_tlb_all()
In-Reply-To: <20180919091517.GX24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809191146310.18945@nanos.tec.linutronix.de>
References: <20180919085016.164552924@infradead.org> <20180919085947.831102058@infradead.org> <20180919091517.GX24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Peter Zijlstra wrote:
> On Wed, Sep 19, 2018 at 10:50:17AM +0200, Peter Zijlstra wrote:
> > Instead of open-coding it..
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/mm/pageattr.c |   12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -285,16 +285,6 @@ static void cpa_flush_all(unsigned long
> >  	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
> >  }
> >  
> > -static void __cpa_flush_range(void *arg)
> > -{
> > -	/*
> > -	 * We could optimize that further and do individual per page
> > -	 * tlb invalidates for a low number of pages. Caveat: we must
> > -	 * flush the high aliases on 64bit as well.
> > -	 */
> > -	__flush_tlb_all();
> > -}
> 
> Hmm,.. so in patch #4 I do switch to flush_tlb_kernel_range(). What are
> those high aliases that comment talks about?

We have two mappings for the kernel. The 'real one' and the direct mapping
alias and for most of the operations, we have to make sure that the table
entries are identical in both maps.

The comments in that code probably need some care.

Thanks,

	tglx
