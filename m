Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7EFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AAB20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AAB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIDVSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:18:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeIDVSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:18:33 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxEZ8-0002di-8V; Tue, 04 Sep 2018 18:52:34 +0200
Date:   Tue, 4 Sep 2018 18:52:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
In-Reply-To: <alpine.DEB.2.21.1809040939400.1462@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809041835480.3395@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>  <1534814186-37067-6-git-send-email-bin.yang@intel.com>  <alpine.DEB.2.21.1809040023450.1462@nanos.tec.linutronix.de> <2ad0ff43ea406005890ad4fcbb7a42da747289d9.camel@intel.com>
 <alpine.DEB.2.21.1809040939400.1462@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, Yang, Bin wrote:
> > On Tue, 2018-09-04 at 00:27 +0200, Thomas Gleixner wrote:
> > > On Tue, 21 Aug 2018, Bin Yang wrote:
> > > > @@ -625,6 +625,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
> > > >  
> > > >  	psize = page_level_size(level);
> > > >  	pmask = page_level_mask(level);
> > > > +	addr = address & pmask;
> > > >  
> > > >  	/*
> > > >  	 * Calculate the number of pages, which fit into this large
> > > > @@ -636,6 +637,12 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
> > > >  		cpa->numpages = numpages;
> > > >  
> > > >  	/*
> > > > +	 * The old pgprot should not have any protection bit. Otherwise,
> > > > +	 * the existing mapping is wrong already.
> > > > +	 */
> > > > +	WARN_ON_ONCE(needs_static_protections(old_prot, addr, psize, old_pfn));
> > > 
> > > The check itself is fine, but it just emits a warning and goes on as if
> > > nothing happened.
> > > 
> > > We really want to think about a proper way to fix that up without overhead
> > > for the sane case.
> > 
> > could we change it as below? I think it should be safe to split large
> > page if current mapping is wrong already.
> > 
> >         if (needs_static_protections(old_prot, addr, psize, old_pfn)) {
> >                 WARN_ON_ONCE(1);
> >                 goto out_unlock;
> >         }
> 
> Sure, but what enforces the static protections on the pages which are not
> in the modified range of the current CPA call? Nothing.

I looked deeper into that. For the PMD split it's rather trivial to do, but
a PUD split would require a horrible pile of changes as we'd have to remove
the protections from the new PMD first, go all the way back and rescan the
new PMDs whether they need to be split up further. But that needs a lot of
refactoring and I'm not sure if it's worth the trouble right now.

As we haven't cared about that since CPA got introduced, I think we just do
the consistency check and warn. That's better what we have now and when it
ever triggers revisit it.

Thanks,

	tglx
