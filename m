Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC860C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42E72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQ9aZaX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42E72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeJXLiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:38:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=106b6JsqMk6qG1rTgzIvpPYL/NlC9/vSE1gH3Z64aUk=; b=NQ9aZaX/NOs/zyEbYssW99Hde
        mgkpUqWF74Q84uqmQgknwl8sbnrT6gCo7yds9tK/SNeJPROkoo9Wob/ds16/uLzsIOSlOoPR9NwyJ
        GUEFgno2rA3Hh+8nS0Ug+5+1kPb5hBAVMWj9A0tvvWxKIIeEHhNVEe2Qv8AgG/O4TB1IvE/OiF3uK
        5pUb1mYJhlpYFruqE8mOwfymqEdAA53pN6jp6oooXilkvdGX0mSnC0j/zKaKwyD5/VeeKv+s4zMvA
        ztDpB7Wr4yKwvy3Br4ualAdu/OApidXWwk19Ad3+j2/jUOtPwQvE5jPqrFtZWxSkXAhQbR7JHJAou
        ecA6bCQcg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF9aS-0003TE-U3; Wed, 24 Oct 2018 03:12:00 +0000
Date:   Tue, 23 Oct 2018 20:12:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH 08/17] prmem: struct page: track vmap_area
Message-ID: <20181024031200.GC25444@bombadil.infradead.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-9-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-9-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:34:55AM +0300, Igor Stoppa wrote:
> The connection between each page and its vmap_area avoids more expensive
> searches through the btree of vmap_areas.

Typo -- it's an rbtree.

> +++ b/include/linux/mm_types.h
> @@ -87,13 +87,24 @@ struct page {
>  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
>  			pgoff_t index;		/* Our offset within mapping. */
> -			/**
> -			 * @private: Mapping-private opaque data.
> -			 * Usually used for buffer_heads if PagePrivate.
> -			 * Used for swp_entry_t if PageSwapCache.
> -			 * Indicates order in the buddy system if PageBuddy.
> -			 */
> -			unsigned long private;
> +			union {
> +				/**
> +				 * @private: Mapping-private opaque data.
> +				 * Usually used for buffer_heads if
> +				 * PagePrivate.
> +				 * Used for swp_entry_t if PageSwapCache.
> +				 * Indicates order in the buddy system if
> +				 * PageBuddy.
> +				 */
> +				unsigned long private;
> +				/**
> +				 * @area: reference to the containing area
> +				 * For pages that are mapped into a virtually
> +				 * contiguous area, avoids performing a more
> +				 * expensive lookup.
> +				 */
> +				struct vmap_area *area;
> +			};

Not like this.  Make it part of a different struct in the existing union,
not a part of the pagecache struct.  And there's no need to use ->private
explicitly.

> @@ -1747,6 +1750,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	if (!addr)
>  		return NULL;
>  
> +	va = __find_vmap_area((unsigned long)addr);
> +	for (i = 0; i < va->vm->nr_pages; i++)
> +		va->vm->pages[i]->area = va;

I don't like it that you're calling this for _every_ vmalloc() caller
when most of them will never use this.  Perhaps have page->va be initially
NULL and then cache the lookup in it when it's accessed for the first time.
