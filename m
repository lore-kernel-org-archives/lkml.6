Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E42173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkEEXxqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E42173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeI1NVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:21:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1NVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h39s6quH6b+0Mgkwn1Bqeti62DjMaThH+cxhzVfUwao=; b=HkEEXxqr/cV460iFbAqxm71s1
        lXXXBKYZexyHBN/HTMhokqo+iF81FZvTGWzFNLYoU+Fk5jpyEsVEPudKvLrArz2SixUUvff47NCCc
        MnLNbLc9F535avmFs8qGSG2rV3jowL9Rt6504VxMj9ILHTLKp/8uH9lX5UIOnSygAMD8DpTjwr8bD
        FQOOMfb84qgHUqdSJ6eJRtVV871YOsLhH5U+wcDxMY8GEn/J07ZMghRPPZhKriXOim/a1iT0l6IEe
        q7wGA7DBjpOiD60DBLhIAlPyMA0gef8TfZLBNsb+UuA6MfXXHopK9czWh0Rf2YCINqQFLE+MTB4Om
        8y0FvqnEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5mjT-0003EC-8E; Fri, 28 Sep 2018 06:58:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64D182107093F; Fri, 28 Sep 2018 08:58:30 +0200 (CEST)
Date:   Fri, 28 Sep 2018 08:58:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tony.luck@intel.com, mingo@redhat.com, acme@kernel.org,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
Message-ID: <20180928065830.GE3439@hirez.programming.kicks-ass.net>
References: <cover.1537377064.git.reinette.chatre@intel.com>
 <20180920141150.GY24124@hirez.programming.kicks-ass.net>
 <77383a1e-f343-7529-24cf-874f0999507d@intel.com>
 <alpine.DEB.2.21.1809272123440.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809272123440.8118@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:39:01PM +0200, Thomas Gleixner wrote:
> On Fri, 21 Sep 2018, Reinette Chatre wrote:
> 
> > Dear Maintainers,
> 
> Sorry for replying late.
> 
> > On 9/20/2018 7:11 AM, Peter Zijlstra wrote:
> > > On Wed, Sep 19, 2018 at 10:29:05AM -0700, Reinette Chatre wrote:
> > >> Reinette Chatre (6):
> > >>   perf/core: Add sanity check to deal with pinned event failure
> > >>   perf/x86: Add helper to obtain performance counter index
> > >>   x86/intel_rdt: Remove local register variables
> > >>   x86/intel_rdt: Create required perf event attributes
> > >>   x86/intel_rdt: Use perf infrastructure for measurements
> > >>   x86/intel_rdt: Re-enable pseudo-lock measurements
> > >>
> > >>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
> > >>  arch/x86/events/core.c                      |  21 ++
> > >>  arch/x86/include/asm/perf_event.h           |   1 +
> > >>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 372 ++++++++++++--------
> > >>  kernel/events/core.c                        |   6 +
> > >>  5 files changed, 261 insertions(+), 161 deletions(-)
> > > 
> > > Yeah, these look good, thanks!
> > > 
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > 
> > Could you please consider this series for inclusion into v4.19?
> 
> So in principle I'm having no objections as this really is mostly a RDT
> only issue.
> 
> Peter, any objections against the Perf part of it, aside the core patch
> which is an obvious fix?

Nope, look up a few lines to observe my Ack ;-)
