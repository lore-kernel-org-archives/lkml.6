Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D6C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037320853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="16uIiXoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9037320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeIMX7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:59:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeIMX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W4rjV+TQUP/YM2Y7Ikkl1zM4f26pbnxFmdZi0+KtWKo=; b=16uIiXoqfCQjoF0xWsek6SUCJ
        JAJ3a+Qbzp2WLOTpZdDi5gWyKufJ1j2Qh/937mvYbo5Fst5tdoirlLc2fljwS+Ipzelwa6ykjgxUT
        la7yGZM4x3RkmQ/PVkBtuKxNYBGJBi1IUhx/Vij4DXEwZMMSWDxLdM4f+H9vcRXNRY/1rukkasVwq
        E/xdv+NrYtnsuY4r8NCF88zASLEcxc3VTcinq3fHxoUfmC5XMjDprcjElsgGevd8UjkZSlFJvGFO9
        /pN22SmbSJClWBSAM3aks4RbsZizb3O0xAor7FcKV82L5QoHMPQxGw9+ryHoboeuseq4kloAwCzq1
        0SsVeOo0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0WfN-0004iL-Qh; Thu, 13 Sep 2018 18:48:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7269E2009C64B; Thu, 13 Sep 2018 20:48:36 +0200 (CEST)
Date:   Thu, 13 Sep 2018 20:48:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 03/11] x86/mm: Page size aware flush_tlb_mm_range()
Message-ID: <20180913184836.GN24142@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.012757318@infradead.org>
 <f89e61a3-0eb0-3d00-fbaa-f30c2cf60be3@linux.intel.com>
 <20180913184230.GD24124@hirez.programming.kicks-ass.net>
 <20180913184632.GM24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913184632.GM24142@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 08:46:32PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 13, 2018 at 08:42:30PM +0200, Peter Zijlstra wrote:
> > > > +#define flush_tlb_range(vma, start, end)			\
> > > > +		flush_tlb_mm_range((vma)->vm_mm, start, end,	\
> > > > +				(vma)->vm_flags & VM_HUGETLB ? PMD_SHIFT : PAGE_SHIFT)
> > > 
> > > This is safe.  But, Couldn't this PMD_SHIFT also be PUD_SHIFT for a 1G
> > > hugetlb page?
> > 
> > It could be, but can we tell at that point?
> 
> I had me a look in higetlb.h, would something like so work?
> 
> #define flush_tlb_range(vma, start, end)			\
> 	flush_tlb_mm_range((vma)->vm_mm, start, end,		\
> 			   huge_page_shift(hstate_vma(vma)))
> 

D'uh

#define flush_tlb_range(vma, start, end)			\
	flush_tlb_mm_range((vma)->vm_mm, start, end,		\
	   (vma)->vm_flags & VM_HUGETLB ? huge_page_shift(hstate_vma(vma)) : PAGE_SHIFT)
