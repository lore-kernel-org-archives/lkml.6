Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827CC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pc7486n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5141F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeIMTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbeIMTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RsKEFjVUdLjMxDGhHTOS4QxgGqOmxh4XtX8l1E+1dWs=; b=Pc7486n0DGUhvxdHCvv8GVp6J
        uqRanaalfwDf2FBo5FhhRkn31EuiDoM6iwBcmaXeeZOtb10eCbkgiNOGnPDGsMFB/Ez6736SMOMLd
        vDCB78Cg8ksdiE89nRiqAgkW4m83LDzraw/fspL5Zisu94o4raDXZ5AdDP/eNZJBkReKVDOGFEVh8
        teeDtV0BbURZw6bAnSEdTM77RbTPam7qVnOWER+OVLqT2Uw4PECulMeQ4uV71Kdyl92QE/QF9YsBP
        x2LwFqWb81NBvRzkKo4VMvknAO78FxyzEGolCNfQKkZsf1B+kDo+ANJboUCTTAtp1PNOgBf+Fglkj
        VyTtvEE3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0SGG-0003V2-PT; Thu, 13 Sep 2018 14:06:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A171720587692; Thu, 13 Sep 2018 16:06:21 +0200 (CEST)
Date:   Thu, 13 Sep 2018 16:06:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, npiggin@gmail.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
Message-ID: <20180913140621.GY24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.132208484@infradead.org>
 <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez01-iQ5fyZjOJxQyOk9xRkra6bYyUAvUbVLheuABOQi8Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:09:47PM +0200, Jann Horn wrote:
> On Thu, Sep 13, 2018 at 3:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Provide a generic tlb_flush() implementation that relies on
> > flush_tlb_range(). This is a little awkward because flush_tlb_range()
> > assumes a VMA for range invalidation, but we no longer have one.
> >
> > Audit of all flush_tlb_range() implementations shows only vma->vm_mm
> > and vma->vm_flags are used, and of the latter only VM_EXEC (I-TLB
> > invalidates) and VM_HUGETLB (large TLB invalidate) are used.
> >
> > Therefore, track VM_EXEC and VM_HUGETLB in two more bits, and create a
> > 'fake' VMA.
> >
> > This allows architectures that have a reasonably efficient
> > flush_tlb_range() to not require any additional effort.
> [...]
> > +#define tlb_flush tlb_flush
> > +static inline void tlb_flush(struct mmu_gather *tlb)
> > +{
> > +       if (tlb->fullmm || tlb->need_flush_all) {
> > +               flush_tlb_mm(tlb->mm);
> > +       } else {
> > +               struct vm_area_struct vma = {
> > +                       .vm_mm = tlb->mm,
> > +                       .vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
> > +                                   tlb->vma_huge ? VM_HUGETLB : 0,
> 
> This looks wrong to me. Bitwise OR has higher precedence than the
> ternary operator, so I think this code is equivalent to:
> 
> .vm_flags = tlb->vma_exec ? VM_EXEC    : (0 | tlb->vma_huge) ? VM_HUGETLB : 0
> 
> meaning that executable+huge mappings would only get VM_EXEC, but not
> VM_HUGETLB.

Bah. Fixed that. Thanks!

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -309,8 +309,8 @@ static inline void tlb_flush(struct mmu_
 	} else {
 		struct vm_area_struct vma = {
 			.vm_mm = tlb->mm,
-			.vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
-				    tlb->vma_huge ? VM_HUGETLB : 0,
+			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
+				    (tlb->vma_huge ? VM_HUGETLB : 0),
 		};
 
 		flush_tlb_range(&vma, tlb->start, tlb->end);

