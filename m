Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43057C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA6E2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vr3jxd9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6E2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeHBVrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:47:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SoFNaEJssEh5lDXOJmxu+4uTXbUwwRfiPoPNNxvlTrg=; b=Vr3jxd9KEbwhiFfta2h6u6LZa
        hejejq5JxR993WP87354daG1Tev7cOt+LFOHltR/OSUQzh7GwOYE1Rdnexc3YPW+63xOvzX77K0gI
        DAGMUy/xQkHHKZrXdX1Pd8oNN5HjC+X+S5fCnqkSkTkkzLYw2RIKb3MV3AtFAprwhWVIqRgHcmErN
        m918OIwZcs/Wws8C2xOqP5WBQ9PcsPQuNzQVMAVXkcE1ewFMEyXkLWnAUwkFafGdJqW7S6fa+mkkt
        ofjQliAd7hqW2C3MBIymB/OLEgVyM1TYeN0Q9JqBVRm3xYNXcimHSiLk2OKzdB5ww1HQCf5K02Ty0
        bTaxXX9Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flJfp-0008R9-B0; Thu, 02 Aug 2018 19:54:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBB8820267B1E; Thu,  2 Aug 2018 21:54:10 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:54:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180802195410.GR2494@hirez.programming.kicks-ass.net>
References: <cover.1533064851.git.reinette.chatre@intel.com>
 <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
 <1af731f8-b5d3-5aca-af02-575802a961b9@intel.com>
 <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
 <20180802173727.GP2494@hirez.programming.kicks-ass.net>
 <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:18:01AM -0700, Dave Hansen wrote:
> On 08/02/2018 10:37 AM, Peter Zijlstra wrote:
> >> I do not see how I can do so without incurring the cache hits and misses
> >> from the data needed and instructions run by this interface. Could you
> >> please share how I can do so and still obtain the accurate measurement
> >> of cache residency of a specific memory region?
> > That's the best you're going to get. You do _NOT_ get to use raw PMU.
> 
> Hi Peter,
> 
> This code is really fidgety.  It's really easily perturbed even by tiny
> things like implicit cache accesses from the page walker filling the TLB
> from the page tables.
> 
> Adding a bunch more code in the way is surely going to make it more
> fragile and imprecise.
> 
> I totally understand not wanting to fill the tree with code hijacking
> the raw PMU.  Is your reaction to this really around not wanting to
> start down the slippery slope that ends up with lots of raw PMU "owners"?

That and the fact that multiple owner directly contradicts what perf set
out to do, provide resource arbitration for the PMU.

Not being able to use both perf and this resctl thing at the same time
is utter crap. You will not get special dispensation.
