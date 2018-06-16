Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A8C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF9208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWbruW3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF9208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeFPEuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 00:50:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeFPEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 00:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vO7qBuc0OnHNekWaeFs7kkqXSzw6bPh4b7xlS4Avv58=; b=RWbruW3w73EcuwwqDE2b0udHd
        WF1OisjheKCLkuzs2SqX/DuWZ+Eavra80uVQM/PZryi08GBS269vtJIPAps865QzzUugrcahPwIrd
        Lyu84MFNNGDLynHNdVEjNk9FDUd82PDGfpyRw3AjL3YE/ubibXWfIo5KkM5d8moCJwxJfpMyHkpma
        WmQ6R92BG23UBIUBi8j+mb7ZiVRmIDgvOXm3UKnl0uzshL9/za1WURUJtLm+YuoU4v658BnxkYcli
        MFCY20vXrce4qc4k81QVs9+RZVQWhxhunfmZXjFTIi6bHwXsDx245taAB3QylmChLlyGiDLTRxmR0
        DMDjGohPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fU3A6-0001uC-30; Sat, 16 Jun 2018 04:50:06 +0000
Date:   Fri, 15 Jun 2018 21:50:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Message-ID: <20180616045005.GA14936@bombadil.infradead.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:43:10PM +0800, Wei Wang wrote:
> +/**
> + * get_from_free_page_list - get free page blocks from a free page list
> + * @order: the order of the free page list to check
> + * @buf: the array to store the physical addresses of the free page blocks
> + * @size: the array size
> + *
> + * This function offers hints about free pages. There is no guarantee that
> + * the obtained free pages are still on the free page list after the function
> + * returns. pfn_to_page on the obtained free pages is strongly discouraged
> + * and if there is an absolute need for that, make sure to contact MM people
> + * to discuss potential problems.
> + *
> + * The addresses are currently stored to the array in little endian. This
> + * avoids the overhead of converting endianness by the caller who needs data
> + * in the little endian format. Big endian support can be added on demand in
> + * the future.
> + *
> + * Return the number of free page blocks obtained from the free page list.
> + * The maximum number of free page blocks that can be obtained is limited to
> + * the caller's array size.
> + */

Please use:

 * Return: The number of free page blocks obtained from the free page list.

Also, please include a

 * Context: Any context.

or

 * Context: Process context.

or whatever other conetext this function can be called from.  Since you're
taking the lock irqsafe, I assume this can be called from any context, but
I wonder if it makes sense to have this function callable from interrupt
context.  Maybe this should be callable from process context only.

> +uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t size)
> +{
> +	struct zone *zone;
> +	enum migratetype mt;
> +	struct page *page;
> +	struct list_head *list;
> +	unsigned long addr, flags;
> +	uint32_t index = 0;
> +
> +	for_each_populated_zone(zone) {
> +		spin_lock_irqsave(&zone->lock, flags);
> +		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> +			list = &zone->free_area[order].free_list[mt];
> +			list_for_each_entry(page, list, lru) {
> +				addr = page_to_pfn(page) << PAGE_SHIFT;
> +				if (likely(index < size)) {
> +					buf[index++] = cpu_to_le64(addr);
> +				} else {
> +					spin_unlock_irqrestore(&zone->lock,
> +							       flags);
> +					return index;
> +				}
> +			}
> +		}
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	}
> +
> +	return index;
> +}

I wonder if (to address Michael's concern), you shouldn't instead use
the first free chunk of pages to return the addresses of all the pages.
ie something like this:

	__le64 *ret = NULL;
	unsigned int max = (PAGE_SIZE << order) / sizeof(__le64);

	for_each_populated_zone(zone) {
		spin_lock_irq(&zone->lock);
		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
			list = &zone->free_area[order].free_list[mt];
			list_for_each_entry_safe(page, list, lru, ...) {
				if (index == size)
					break;
				addr = page_to_pfn(page) << PAGE_SHIFT;
				if (!ret) {
					list_del(...);
					ret = addr;
				}
				ret[index++] = cpu_to_le64(addr);
			}
		}
		spin_unlock_irq(&zone->lock);
	}

	return ret;
}

You'll need to return the page to the freelist afterwards, but free_pages()
should take care of that.
