Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623F320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/MQ5KTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623F320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeIZTcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:32:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZTcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a7o/MvzR+wgeu2XexSdlcm6pU0risU3MGp5SPIORdsE=; b=Z/MQ5KTDjQ7g8x4tDdRBK8ia9
        jTQvcW9so8rkdotUMwEYrcgjfPc3fXe4b0KOWO9orugnA33H2Z9A08+W8iPsHz5HFVwi0p9VXFyfs
        Nu3G1lpKas7quejm5ljSmijwcB+v6BYw/utkOfI5NBMwyoQdwJeBSj+WdLv/21+mdxkMR2LWKUL7a
        dbVDcOmEO70JwxTljC4vUSzxlGCqZO3bTjIWpFvU3vsk10D9L6xNFiUIYItdtTzSFQy61r8ASutBI
        s/wQ1+agaocBJxH6c7YDjGxspmdMOI6ti+p65RnXhv6+hW2ozbyB2ifvFTgieXiDrRZwM5/4GabFu
        ZMLaGcqvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g59iH-00087H-8s; Wed, 26 Sep 2018 13:18:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F747200C9CBE; Wed, 26 Sep 2018 15:11:41 +0200 (CEST)
Date:   Wed, 26 Sep 2018 15:11:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Message-ID: <20180926131141.GA12444@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926125335.GG2979@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:53:35PM +0100, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 01:36:28PM +0200, Peter Zijlstra wrote:
> > +#ifndef tlb_flush
> > +
> > +#if defined(tlb_start_vma) || defined(tlb_end_vma)
> > +#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
> > +#endif
> > +
> > +#define tlb_flush tlb_flush
> 
> Do we need this #define?

Probably not, that was just my fingers doing the normal #ifndef #define
pattern. I'll take em out back for a 'hug' :-)

> > +static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > +{
> > +	if (tlb->fullmm)
> > +		return;
> > +
> > +	/*
> > +	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
> > +	 * mips-4k) flush only large pages.
> > +	 *
> > +	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
> > +	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
> > +	 * range.
> > +	 *
> > +	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
> > +	 * these values the batch is empty.
> > +	 */
> > +	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
> > +	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> 
> Hmm, does this result in code generation for archs that don't care about the
> vm_flags?

Yes. It's not much code, but if you deeply care we could frob things to
get rid of it.
