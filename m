Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E1420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPbp7Sao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E1420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeGTJRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:17:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeGTJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s6dxkB0haAhsj4RtLapHFb+z/mLPPQaN3JNr93HIAIo=; b=PPbp7SaozxFGqNW0jIMqQ9BuX
        EmHDPSqPJd7fZwcRWq3JVjQJ6DoMuud2Qnj5YY4DfC6VY9L/pvNXWk4BblB+RcMW7VefAWPGEGbDj
        c8HmsXT3sPT5nfoB1UObCPFe18iDrQl/awDtVyLP6BWKbQo5U289FbcV6iT00mx6LfCXRkMmWtFxN
        C29vJu0b9vPenuBJd2Z6rcd1gcGGmgoNZvQ8mvbjbbpvA9bkLRk2otbITPvob7CzEcHExqH86fKMP
        mQRgH6VjikQDkayDN3xGLYPFcW5d+tMAlA7MHmku2FNoreASMDFNC4BpLgucuA+Y2yD5iSEngHwdA
        xo00Go3XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgQnq-0005CI-AN; Fri, 20 Jul 2018 08:30:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A165120275F47; Fri, 20 Jul 2018 10:30:16 +0200 (CEST)
Date:   Fri, 20 Jul 2018 10:30:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-s390@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720083016.GN2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:04:09AM -0700, Andy Lutomirski wrote:
> I added some more arch maintainers.  The idea here is that, on x86 at
> least, task->active_mm and all its refcounting is pure overhead.  When
> a process exits, __mmput() gets called, but the core kernel has a
> longstanding "optimization" in which other tasks (kernel threads and
> idle tasks) may have ->active_mm pointing at this mm.  This is nasty,
> complicated, and hurts performance on large systems, since it requires
> extra atomic operations whenever a CPU switches between real users
> threads and idle/kernel threads.
> 
> It's also almost completely worthless on x86 at least, since __mmput()
> frees pagetables, and that operation *already* forces a remote TLB
> flush, so we might as well zap all the active_mm references at the
> same time.

So I disagree that active_mm is complicated (the code is less than ideal
but that is actually fixable). And aside from the process exit case, it
does avoid CR3 writes when switching between user and kernel threads
(which can be far more often than exit if you have longer running
tasks).

Now agreed, recent x86 work has made that less important.

And I of course also agree that not doing those refcount atomics is
better.
