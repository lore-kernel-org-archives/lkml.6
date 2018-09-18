Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA50CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BA0214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BA0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeISEJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:09:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeISEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:09:42 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Oa6-0005Rc-Mn; Wed, 19 Sep 2018 00:34:54 +0200
Date:   Wed, 19 Sep 2018 00:34:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 02/11] x86/mm/cpa: Split, rename and clean up
 try_preserve_large_page()
In-Reply-To: <20180918121416.GO24142@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809190034060.1468@nanos.tec.linutronix.de>
References: <20180917142906.384767038@linutronix.de> <20180917143545.830507216@linutronix.de> <20180918081909.GI24106@hirez.programming.kicks-ass.net> <20180918121416.GO24142@hirez.programming.kicks-ass.net>
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

On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 10:19:09AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 17, 2018 at 04:29:08PM +0200, Thomas Gleixner wrote:
> > > @@ -1288,23 +1287,23 @@ static int __change_page_attr(struct cpa
> > >  	err = split_large_page(cpa, kpte, address);
> > >  	if (!err) {
> > >  		/*
> > > +		 * Do a global flush tlb after splitting the large page
> > > +		 * and before we do the actual change page attribute in the PTE.
> > > +		 *
> > > +		 * With out this, we violate the TLB application note, that says
> > > +		 * "The TLBs may contain both ordinary and large-page
> > >  		 *  translations for a 4-KByte range of linear addresses. This
> > >  		 *  may occur if software modifies the paging structures so that
> > >  		 *  the page size used for the address range changes. If the two
> > >  		 *  translations differ with respect to page frame or attributes
> > >  		 *  (e.g., permissions), processor behavior is undefined and may
> > >  		 *  be implementation-specific."
> > > +		 *
> > > +		 * We do this global tlb flush inside the cpa_lock, so that we
> > >  		 * don't allow any other cpu, with stale tlb entries change the
> > >  		 * page attribute in parallel, that also falls into the
> > >  		 * just split large page entry.
> > > +		 */
> > >  		flush_tlb_all();
> > >  		goto repeat;
> > >  	}
> > 
> > this made me look at the tlb invalidation of that thing again; do we
> > want something like the below?
> > 
>
> Further cleanups are possible...

Yes please. Can you write up a changelog for that please?

Thanks,

	tglx
