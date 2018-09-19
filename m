Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDECA2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDECA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbeISUG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:06:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730986AbeISUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:06:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JEJkJT003543
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:28:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mkpubvrhy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:28:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 19 Sep 2018 15:28:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 15:28:12 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JESB0R30015492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 14:28:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 432AB11C04C;
        Wed, 19 Sep 2018 17:27:56 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32F011C054;
        Wed, 19 Sep 2018 17:27:55 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Sep 2018 17:27:55 +0100 (BST)
Date:   Wed, 19 Sep 2018 16:28:09 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] s390/tlb: convert to generic mmu_gather
In-Reply-To: <20180919123849.GF24124@hirez.programming.kicks-ass.net>
References: <20180918125151.31744-1-schwidefsky@de.ibm.com>
        <20180918125151.31744-3-schwidefsky@de.ibm.com>
        <20180919123849.GF24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091914-0016-0000-0000-000002078FEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091914-0017-0000-0000-0000325E7F3C
Message-Id: <20180919162809.30b5c416@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 14:38:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 18, 2018 at 02:51:51PM +0200, Martin Schwidefsky wrote:
> > +#define pte_free_tlb pte_free_tlb
> > +#define pmd_free_tlb pmd_free_tlb
> > +#define p4d_free_tlb p4d_free_tlb
> > +#define pud_free_tlb pud_free_tlb  
> 
> > @@ -121,9 +62,18 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
> >   * page table from the tlb.
> >   */
> >  static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> > +                                unsigned long address)
> >  {
> > +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> > +	tlb->mm->context.flush_mm = 1;
> > +	tlb->freed_tables = 1;
> > +	tlb->cleared_ptes = 1;
> > +	/*
> > +	 * page_table_free_rcu takes care of the allocation bit masks
> > +	 * of the 2K table fragments in the 4K page table page,
> > +	 * then calls tlb_remove_table.
> > +	 */
> > +        page_table_free_rcu(tlb, (unsigned long *) pte, address);  
> 
> (whitespace damage, fixed)
> 
> Also, could you perhaps explain the need for that
> page_table_alloc/page_table_free code? That is, I get the comment about
> using 2K page-table fragments out of 4k physical page, but why this
> custom allocator instead of kmem_cache? It feels like there's a little
> extra complication, but it's not immediately obvious what.

The kmem_cache code uses the fields of struct page for its tracking.
pgtable_page_ctor uses the same fields, e.g. for the ptl. Last time
I tried to convert the page_table_alloc/page_table_free to kmem_cache
it just crashed. Plus the split of 4K pages into 2 2K fragments is
done on a per mm basis, that should help a little bit with fragmentation.

> >  }  
> 
> We _could_ use __pte_free_tlb() here I suppose, but...
> 
> >  /*
> > @@ -139,6 +89,10 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> >  	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
> >  		return;
> >  	pgtable_pmd_page_dtor(virt_to_page(pmd));
> > +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> > +	tlb->mm->context.flush_mm = 1;
> > +	tlb->freed_tables = 1;
> > +	tlb->cleared_puds = 1;
> >  	tlb_remove_table(tlb, pmd);
> >  }
> >  
> > @@ -154,6 +108,10 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> >  {
> >  	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
> >  		return;
> > +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> > +	tlb->mm->context.flush_mm = 1;
> > +	tlb->freed_tables = 1;
> > +	tlb->cleared_p4ds = 1;
> >  	tlb_remove_table(tlb, p4d);
> >  }
> >  
> > @@ -169,19 +127,11 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> >  {
> >  	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
> >  		return;
> > +	tlb->mm->context.flush_mm = 1;
> > +	tlb->freed_tables = 1;
> > +	tlb->cleared_puds = 1;
> >  	tlb_remove_table(tlb, pud);
> >  }  
> 
> It's that ASCE limit that makes it impossible to use the generic
> helpers, right?

There are two problems, one of them is related to the ASCE limit:

1) s390 supports 4 different page table layouts. 2-levels (2^31 bytes) for 31-bit compat,
   3-levels (2^42 bytes) as the default for 64-bit, 4-levels (2^53) if 4 tera-bytes are
   not enough and 5-levels (2^64) for the bragging rights.
   The pxd_free_tlb() turn into nops if the number of page table levels require it.

2) The mm->context.flush_mm indication.
   That goes back to this beauty in the architecture:

    * "A valid table entry must not be changed while it is attached
    * to any CPU and may be used for translation by that CPU except to
    * (1) invalidate the entry by using INVALIDATE PAGE TABLE ENTRY,
    * or INVALIDATE DAT TABLE ENTRY, (2) alter bits 56-63 of a page
    * table entry, or (3) make a change by means of a COMPARE AND SWAP
    * AND PURGE instruction that purges the TLB."

   If one CPU is doing a mmu_gather page table operation on the only active thread
   in the system the individual page table updates are done in a lazy fashion with
   simple stores. If a second CPU picks up another thread for execution, the
   attach_count is increased and the page table updates are done with IPTE/IDTE
   from now on. But there might by TLBs of around that are not flushed yet.
   We may *not* let the second CPU see these TLBs, otherwise the CPU may start an
   instruction, then loose the TLB without being able to recreate it. Due to that
   the CPU can end up with a half finished instruction it can not roll back nor
   complete, ending in a check-stop. The simplest example is MVC with a length
   of e.g. 256 bytes. The instruction has to complete with all 256 bytes moved,
   or no bytes may have at all.
   That is where the mm->context.flush_mm indication comes into play, if the
   second CPU finds the bit set at the time it attaches a thread, it will to
   an IDTE for flush all TLBs for the mm.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

