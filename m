Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F5322429
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qkbzckh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5322429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeHJUMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:12:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V8RdC5qmKJ8AGHFUOg59Pn9TQgr5sGwRDgnvNqYW7dc=; b=Qkbzckh7P98BYxal74QNbgVYe
        9vIvitp7RNVOK7cawUlKur+Y5ZSbYYIun/untQCi4lAHa6r2UK0B+TuMamcy96wcYgzj4/6+hmZXJ
        nqqesLqL4W5fEbajUCwKrq6Saw2YoHXn9DaKw/tlAOGCTwBFe48mIRj0+D4LUqYAsuOvP9xXQp4SV
        WWukynckxH2L/h+6f1LTw7dgB58aPSWuGgwKfhAI1DEW+l/ZyuduTl6eSig9HGQflnh90PIQBBF3s
        WxWY5wfGUZLZL/72E9E8lYRs3pGw/nOuxy6Ho7uCRy+tq7CIA1JsmCsv9m0cg8ttZIGPPjrhh6HrX
        dUtn595FQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1foBQ6-0007Qb-MH; Fri, 10 Aug 2018 17:41:50 +0000
Date:   Fri, 10 Aug 2018 10:41:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v7 PATCH 1/4] mm: refactor do_munmap() to extract the
 common part
Message-ID: <20180810174150.GA6487@bombadil.infradead.org>
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
 <1533857763-43527-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533857763-43527-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:36:00AM +0800, Yang Shi wrote:
> +static inline bool addr_ok(unsigned long start, size_t len)

Maybe munmap_range_ok()?  Otherwise some of the conditions here don't make
sense for such a generic sounding function.

>  {
> -	unsigned long end;
> -	struct vm_area_struct *vma, *prev, *last;
> -
>  	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> -		return -EINVAL;
> +		return false;
>  
> -	len = PAGE_ALIGN(len);
> -	if (len == 0)
> -		return -EINVAL;
> +	if (PAGE_ALIGN(len) == 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * munmap_lookup_vma: find the first overlap vma and split overlap vmas.
> + * @mm: mm_struct
> + * @start: start address
> + * @end: end address
> + *
> + * returns the pointer to vma, NULL or err ptr when spilt_vma returns error.

kernel-doc prefers:

 * Return: %NULL if no VMA overlaps this range.  An ERR_PTR if an
 * overlapping VMA could not be split.  Otherwise a pointer to the first
 * VMA which overlaps the range.

> + */
> +static struct vm_area_struct *munmap_lookup_vma(struct mm_struct *mm,
> +			unsigned long start, unsigned long end)
> +{
> +	struct vm_area_struct *vma, *prev, *last;
>  
>  	/* Find the first overlapping VMA */
>  	vma = find_vma(mm, start);
>  	if (!vma)
> -		return 0;
> -	prev = vma->vm_prev;
> -	/* we have  start < vma->vm_end  */
> +		return NULL;
>  
> +	/* we have  start < vma->vm_end  */

Can you remove the duplicate spaces here?

