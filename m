Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtnaBgYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BE8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeK1CHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:07:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeK1CHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+uVL2ZrmjWILmDoizKBAAZNDQbF6qn8AHLW+SNPL4Q4=; b=dtnaBgYq2MV7o0QR7lQi43RiN
        t6W4fvq7a+zdXVirIBh9xWhZzFTN3BLEbyYqgFNAA65fZRxbmXXHYlc8yHfQlyOD7dMfLYy13Q0Y8
        NKP8TvPI+8g7yToj3k9JR1/2B5Z6DQzYOkBKrgTx1JeoPe15ZrEZ/dLZW0OnpdHmz8PnqMqXjmyii
        roVIXaiLMjwT3Xvm5yyJBidUOevCjPkI1BemXEpKX/jEa3BRSDrI7y7sIyEvDBttB+9opM1JtvvcY
        m6bf5NSDm5eD0n9W1nUA3vAv89o0doVmxRyCbm6SgMeUk0wddmULmalubVUizVDgfJHHT1f5Q9rnr
        o/0oym5QQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gReyq-0000AN-Cz; Tue, 27 Nov 2018 15:08:52 +0000
Date:   Tue, 27 Nov 2018 07:08:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix insert_pfn() return value
Message-ID: <20181127150852.GA10377@bombadil.infradead.org>
References: <20181127144351.9137-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127144351.9137-1-mans@mansr.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:43:51PM +0000, Mans Rullgard wrote:
> Commit 9b5a8e00d479 ("mm: convert insert_pfn() to vm_fault_t") accidentally
> made insert_pfn() always return an error.  Fix this.

Umm.  VM_FAULT_NOPAGE is not an error.  It's saying "I inserted the PFN,
there's no struct page for the core VM to do anything with".  Which is
the correct response from a device driver which has called insert_pfn().

Could you explain a bit more what led you to think there's a problem here?

Also, rather rude of you not to cc the patch author when you claim to
be fixing a bug in their patch.

> Fixes: 9b5a8e00d479 ("mm: convert insert_pfn() to vm_fault_t")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  mm/memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ad2d293ddc2..15baf50e3908 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1524,12 +1524,14 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  			pfn_t pfn, pgprot_t prot, bool mkwrite)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	int retval;
>  	pte_t *pte, entry;
>  	spinlock_t *ptl;
>  
>  	pte = get_locked_pte(mm, addr, &ptl);
>  	if (!pte)
>  		return VM_FAULT_OOM;
> +	retval = VM_FAULT_NOPAGE;
>  	if (!pte_none(*pte)) {
>  		if (mkwrite) {
>  			/*
> @@ -1567,9 +1569,10 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  	set_pte_at(mm, addr, pte, entry);
>  	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
>  
> +	retval = 0;
>  out_unlock:
>  	pte_unmap_unlock(pte, ptl);
> -	return VM_FAULT_NOPAGE;
> +	return retval;
>  }
>  
>  /**
> -- 
> 2.19.2
> 
