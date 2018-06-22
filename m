Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55D823D26
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXgxgxCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55D823D26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeFVEiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:38:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFVEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pI3/H+VocM9pXxC4tlm4I7EA74TtdEIYh6Pnm1Ll934=; b=iXgxgxCQy1OJ14oyiNOkeYS1X
        HLAMnVaFJEkfOpy2MlgWLkxS/wtgmKjb9Fk8CyVfqekMuv4hIqhdY8dlLwuhNdenQncgsA+KcbTf/
        vPBB9ZThudy7enIX1AY1/AD5rN4kArt4KTSQJoqhjuy6CaSanyXLMMYiX0lSl3k15CqYu8xaW0LbM
        HVRcLCfAM7uj7gKRXfLzTIeGDooyLWerbS+AzT3rVXbGFOEIr6SgDW1KUz/XI3FWXMR9nJ0mm7C8P
        khv4pGjA6hN6ESFu+elpeF0r3NJkvNIIgRZif6XO3c94mEvma2iOH9y33gIjNeCtlDfaKVBKklKV8
        ZfiKsYVhw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWDpw-0000iq-80; Fri, 22 Jun 2018 04:38:16 +0000
Date:   Thu, 21 Jun 2018 21:38:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
Message-ID: <20180622043815.GA31255@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-14-willy@infradead.org>
 <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:15:11PM +1000, Nicholas Piggin wrote:
> On Thu, 21 Jun 2018 14:28:22 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> >  static int alloc_context_id(int min_id, int max_id)
...
> > -	spin_lock(&mmu_context_lock);
> > -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
> > -	spin_unlock(&mmu_context_lock);
...
> > @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
> >  {
> >  	int index, context_id;
> >  
> > -	spin_lock(&mmu_context_lock);
> >  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
> >  		context_id = ctx->extended_id[index];
> >  		if (context_id)
> > -			ida_remove(&mmu_context_ida, context_id);
> > +			ida_free(&mmu_context_ida, context_id);
> >  	}
> > -	spin_unlock(&mmu_context_lock);
> >  }
> >  
> >  static void pte_frag_destroy(void *pte_frag)
> 
> This hunk should be okay because the mmu_context_lock does not protect
> the extended_id array, right Aneesh?

That's my understanding.  The code today does this:

static inline int alloc_extended_context(struct mm_struct *mm,
                                         unsigned long ea)
{
        int context_id;

        int index = ea >> MAX_EA_BITS_PER_CONTEXT;

        context_id = hash__alloc_context_id();
        if (context_id < 0)
                return context_id;

        VM_WARN_ON(mm->context.extended_id[index]);
        mm->context.extended_id[index] = context_id;

so it's not currently protected by this lock.  I suppose we are currently
protected from destroy_contexts() being called twice simultaneously, but
you'll notice that we don't zero the array elements in destroy_contexts(),
so if we somehow had a code path which could call it concurrently, we'd
be seeing warnings when the second caller tried to remove the context
IDs from the IDA.  I deduced that something else must be preventing
this situation from occurring (like, oh i don't know, this function only
being called on process exit, so implicitly only called once per context).

> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks.
