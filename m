Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B35C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43CD2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRO1lI4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43CD2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeI0AWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:22:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0AWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xPe7pxKCu69oOGb3TwHqVaKYbaDBnsZk92wmer55T1w=; b=QRO1lI4E43Qtfk+Cz6/wEt5EZ
        a85bBHFBgmCCrN1qIV9nloagr0XjOpRJzm8jdNraMxkQGDkP/N2lls5cE9pfkqci0Fvga/EX1xKth
        8wLfsar1YUO2PIiMn4tibYsI25PnI/ikWQfL27jnxAhEprvByl4Kq5Xyqnymq1IuX7rsMdD28BUKP
        xhHXd8HspkWMqyJFeAC/ESSOg+qW0gYM2CXIU+5RUCr9WX567SquyWEK0NP12+Nvn4x5kqTMAcmn1
        +ophT85KmpTL5/2L74L1cjwgdcyuFsDFF6fbQtBkT7YzyY2CBLYY16iCAwb8qUA+uJOi/ieKJ2OsR
        spokpPedQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5EDg-0001zP-IZ; Wed, 26 Sep 2018 18:07:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57C18205FF762; Wed, 26 Sep 2018 20:07:27 +0200 (CEST)
Date:   Wed, 26 Sep 2018 20:07:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com
Subject: Re: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
Message-ID: <20180926180727.GA7455@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.770817616@infradead.org>
 <20180926125335.GG2979@brain-police>
 <20180926131141.GA12444@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926131141.GA12444@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 03:11:41PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 26, 2018 at 01:53:35PM +0100, Will Deacon wrote:

> > > +static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > > +{
> > > +	if (tlb->fullmm)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
> > > +	 * mips-4k) flush only large pages.
> > > +	 *
> > > +	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
> > > +	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
> > > +	 * range.
> > > +	 *
> > > +	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
> > > +	 * these values the batch is empty.
> > > +	 */
> > > +	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
> > > +	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> > 
> > Hmm, does this result in code generation for archs that don't care about the
> > vm_flags?
> 
> Yes. It's not much code, but if you deeply care we could frob things to
> get rid of it.

Something a little like the below... not particularly pretty but should
work.

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -305,7 +305,8 @@ static inline void __tlb_reset_range(str
 #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
 #endif
 
-#define tlb_flush tlb_flush
+#define generic_tlb_flush
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm || tlb->need_flush_all) {
@@ -391,12 +392,12 @@ static inline unsigned long tlb_get_unma
  * the vmas are adjusted to only cover the region to be torn down.
  */
 #ifndef tlb_start_vma
-#define tlb_start_vma tlb_start_vma
 static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
 		return;
 
+#ifdef generic_tlb_flush
 	/*
 	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
 	 * mips-4k) flush only large pages.
@@ -410,13 +411,13 @@ static inline void tlb_start_vma(struct
 	 */
 	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
+#endif
 
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);
 }
 #endif
 
 #ifndef tlb_end_vma
-#define tlb_end_vma tlb_end_vma
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
