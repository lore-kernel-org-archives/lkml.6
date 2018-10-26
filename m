Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBEECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436F20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1F6jio+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1436F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJZSRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:17:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJZSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=12yu2//rJr5DMe6Xs212+GnjuBvECqEIB865SHmpats=; b=b1F6jio+XBPpKYaCFyXWeTKLX
        0YXjPfjW4OUpBKs6kq3RneDw5i5Gu4zlc+org+qK7VTwoQRAgE579i7J04e4uFIkMAVtT0/ArZYjY
        9zKYrVrVfnbSARe2wBt/mgBY+pGwmt5OyzzaMRNbkT3HY5Ybc+Hz9DGL4UHeV33eGcIS3edWEMHvQ
        DJvz+Ml7p+T93g6NBAAqAGrIoXeZ4KmshNPYXRSiUM2fvJrbWy4ma+PEgBN2eR4UFZAzihjlc9NCs
        Bm1zHcP7+YLlOlGguCNKaBNKRWGo1aUbA8/pxQoko0+0ic0SHnzCuiCYzxVdH3QjZMzf+qP2wEiiQ
        cwpzUinAw==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFyc7-0005NO-Lb; Fri, 26 Oct 2018 09:41:08 +0000
Received: by worktop (Postfix, from userid 1000)
        id B10AA6E07CA; Fri, 26 Oct 2018 11:41:05 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:41:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] prmem: write rare for static allocation
Message-ID: <20181026094105.GE3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-3-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-3-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:34:49AM +0300, Igor Stoppa wrote:
> +static __always_inline

That's far too large for inline.

> +bool wr_memset(const void *dst, const int c, size_t n_bytes)
> +{
> +	size_t size;
> +	unsigned long flags;
> +	uintptr_t d = (uintptr_t)dst;
> +
> +	if (WARN(!__is_wr_after_init(dst, n_bytes), WR_ERR_RANGE_MSG))
> +		return false;
> +	while (n_bytes) {
> +		struct page *page;
> +		uintptr_t base;
> +		uintptr_t offset;
> +		uintptr_t offset_complement;
> +
> +		local_irq_save(flags);
> +		page = virt_to_page(d);
> +		offset = d & ~PAGE_MASK;
> +		offset_complement = PAGE_SIZE - offset;
> +		size = min(n_bytes, offset_complement);
> +		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> +		if (WARN(!base, WR_ERR_PAGE_MSG)) {
> +			local_irq_restore(flags);
> +			return false;
> +		}
> +		memset((void *)(base + offset), c, size);
> +		vunmap((void *)base);

BUG

> +		d += size;
> +		n_bytes -= size;
> +		local_irq_restore(flags);
> +	}
> +	return true;
> +}
> +
> +static __always_inline

Similarly large

> +bool wr_memcpy(const void *dst, const void *src, size_t n_bytes)
> +{
> +	size_t size;
> +	unsigned long flags;
> +	uintptr_t d = (uintptr_t)dst;
> +	uintptr_t s = (uintptr_t)src;
> +
> +	if (WARN(!__is_wr_after_init(dst, n_bytes), WR_ERR_RANGE_MSG))
> +		return false;
> +	while (n_bytes) {
> +		struct page *page;
> +		uintptr_t base;
> +		uintptr_t offset;
> +		uintptr_t offset_complement;
> +
> +		local_irq_save(flags);
> +		page = virt_to_page(d);
> +		offset = d & ~PAGE_MASK;
> +		offset_complement = PAGE_SIZE - offset;
> +		size = (size_t)min(n_bytes, offset_complement);
> +		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> +		if (WARN(!base, WR_ERR_PAGE_MSG)) {
> +			local_irq_restore(flags);
> +			return false;
> +		}
> +		__write_once_size((void *)(base + offset), (void *)s, size);
> +		vunmap((void *)base);

Similarly BUG.

> +		d += size;
> +		s += size;
> +		n_bytes -= size;
> +		local_irq_restore(flags);
> +	}
> +	return true;
> +}

> +static __always_inline

Guess what..

> +uintptr_t __wr_rcu_ptr(const void *dst_p_p, const void *src_p)
> +{
> +	unsigned long flags;
> +	struct page *page;
> +	void *base;
> +	uintptr_t offset;
> +	const size_t size = sizeof(void *);
> +
> +	if (WARN(!__is_wr_after_init(dst_p_p, size), WR_ERR_RANGE_MSG))
> +		return (uintptr_t)NULL;
> +	local_irq_save(flags);
> +	page = virt_to_page(dst_p_p);
> +	offset = (uintptr_t)dst_p_p & ~PAGE_MASK;
> +	base = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> +	if (WARN(!base, WR_ERR_PAGE_MSG)) {
> +		local_irq_restore(flags);
> +		return (uintptr_t)NULL;
> +	}
> +	rcu_assign_pointer((*(void **)(offset + (uintptr_t)base)), src_p);
> +	vunmap(base);

Also still bug.

> +	local_irq_restore(flags);
> +	return (uintptr_t)src_p;
> +}

Also, I see an amount of duplication here that shows you're not nearly
lazy enough.

