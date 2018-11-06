Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F278C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A62081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcmS2Lu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1A62081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeKFRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:44:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKFRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u83gyhzFurb5QKDqHvJAZVQNtWakrvZ/YT8iZtTmPK8=; b=lcmS2Lu+wP51e0cmSDwmIa61U
        jRGxcKG5NaLozal88IoiSTs8nHqjgPQQz2gVOtjJ/neRzux2sX0GJiyI0OUJ3CNyue3mw+7Rg9Cg+
        W4tKsRkThqEYUqZ2BbuQqmZQNc58G3z0MbWE+GsA1LBwH4qBANln4PBlRyZY11EoYt9MrwBLECUVt
        5nNSOLFeRb3+j297eorEwImusMB8j6fswLFZuA0j1GoqhxlKzD373Ms1jJ84TrwFUmmpnnpW4olcB
        TvnYIZi6tsB/tYFnhOMLtvcUxut3Yhnddh7+qh8bHTRI2O67JFJTuPz5yj8fEel4jw5vw+9Xnrk2l
        sylwyjO8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJwaz-00018k-Q1; Tue, 06 Nov 2018 08:20:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CE932029F9FF; Tue,  6 Nov 2018 09:20:19 +0100 (CET)
Date:   Tue, 6 Nov 2018 09:20:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Message-ID: <20181106082019.GF22431@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
 <20181105133041.GC22467@hirez.programming.kicks-ass.net>
 <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 06:04:42PM +0000, Nadav Amit wrote:
> From: Peter Zijlstra
> Sent: November 5, 2018 at 1:30:41 PM GMT
> > To: Nadav Amit <namit@vmware.com>
> > Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, H. Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
> > Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
> > 
> > 
> > On Fri, Nov 02, 2018 at 04:29:45PM -0700, Nadav Amit wrote:
> >> +	unuse_temporary_mm(prev);
> >> +
> >> +	pte_unmap_unlock(ptep, ptl);
> > 
> > That; that does kunmap_atomic() on 32bit.
> > 
> > I've been thinking that the whole kmap_atomic thing on x86_32 is
> > terminally broken, and with that most of x86_32 is.
> > 
> > kmap_atomic does the per-cpu fixmap pte fun-and-games we're here saying
> > is broken. Yes, only the one CPU will (explicitly) use those fixmap PTEs
> > and thus the local invalidate _should_ work. However nothing prohibits
> > speculation on another CPU from using our fixmap addresses. Which can
> > lead to the remote CPU populating its TLBs for our fixmap entry.
> > 
> > And, as we've found, there are AMD parts that #MC when there are
> > mis-matched TLB entries.
> > 
> > So what do we do? mark x86_32 SMP broken?
> 
> pte_unmap() seems to only use kunmap_atomic() when CONFIG_HIGHPTE is set, no?
> 
> Do most distributions run with CONFIG_HIGHPTE?

Sure; but all of x86_32 relies on kmap_atomic. This was just the the one
way I ran into it again.

By our current way of thinking, kmap_atomic simply is not correct.
