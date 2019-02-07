Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC46C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4542175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBGB0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:26:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBGB0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 20:26:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C663C002970;
        Thu,  7 Feb 2019 01:26:44 +0000 (UTC)
Received: from redhat.com (ovpn-120-253.rdu2.redhat.com [10.10.120.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4008E6A526;
        Thu,  7 Feb 2019 01:26:43 +0000 (UTC)
Date:   Wed, 6 Feb 2019 20:26:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 3/6] mm/balloon_compaction: list interfaces
Message-ID: <20190206202628-mutt-send-email-mst@kernel.org>
References: <20190206235706.4851-1-namit@vmware.com>
 <20190206235706.4851-4-namit@vmware.com>
 <20190206191936-mutt-send-email-mst@kernel.org>
 <0DFA5F3F-8358-4268-83C7-9937C5F0CFFF@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0DFA5F3F-8358-4268-83C7-9937C5F0CFFF@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 01:26:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 12:43:51AM +0000, Nadav Amit wrote:
> > On Feb 6, 2019, at 4:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Wed, Feb 06, 2019 at 03:57:03PM -0800, Nadav Amit wrote:
> >> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> >> of pages. These interfaces reduce the overhead of storing and restoring
> >> IRQs by batching the operations. In addition they do not panic if the
> >> list of pages is empty.
> >> 
> 
> [Snip]
> 
> First, thanks for the quick feedback.
> 
> >> +
> >> +/**
> >> + * balloon_page_list_enqueue() - inserts a list of pages into the balloon page
> >> + *				 list.
> >> + * @b_dev_info: balloon device descriptor where we will insert a new page to
> >> + * @pages: pages to enqueue - allocated using balloon_page_alloc.
> >> + *
> >> + * Driver must call it to properly enqueue a balloon pages before definitively
> >> + * removing it from the guest system.
> >> + */
> >> +void balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> >> +			       struct list_head *pages)
> >> +{
> >> +	struct page *page, *tmp;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> >> +	list_for_each_entry_safe(page, tmp, pages, lru)
> >> +		balloon_page_enqueue_one(b_dev_info, page);
> >> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> > 
> > As this is scanning pages one by one anyway, it will be useful
> > to have this return the # of pages enqueued.
> 
> Sure.
> 
> > 
> >> +}
> >> +EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> >> +
> >> +/**
> >> + * balloon_page_list_dequeue() - removes pages from balloon's page list and
> >> + *				 returns a list of the pages.
> >> + * @b_dev_info: balloon device decriptor where we will grab a page from.
> >> + * @pages: pointer to the list of pages that would be returned to the caller.
> >> + * @n_req_pages: number of requested pages.
> >> + *
> >> + * Driver must call it to properly de-allocate a previous enlisted balloon pages
> >> + * before definetively releasing it back to the guest system. This function
> >> + * tries to remove @n_req_pages from the ballooned pages and return it to the
> >> + * caller in the @pages list.
> >> + *
> >> + * Note that this function may fail to dequeue some pages temporarily empty due
> >> + * to compaction isolated pages.
> >> + *
> >> + * Return: number of pages that were added to the @pages list.
> >> + */
> >> +int balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >> +			       struct list_head *pages, int n_req_pages)
> > 
> > Are we sure this int never overflows? Why not just use u64
> > or size_t straight away?
> 
> size_t it is.
> 
> > 
> >> +{
> >> +	struct page *page, *tmp;
> >> +	unsigned long flags;
> >> +	int n_pages = 0;
> >> +
> >> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> >> +	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> >> +		/*
> >> +		 * Block others from accessing the 'page' while we get around
> >> +		 * establishing additional references and preparing the 'page'
> >> +		 * to be released by the balloon driver.
> >> +		 */
> >> +		if (!trylock_page(page))
> >> +			continue;
> >> +
> >> +		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
> >> +		    PageIsolated(page)) {
> >> +			/* raced with isolation */
> >> +			unlock_page(page);
> >> +			continue;
> >> +		}
> >> +		balloon_page_delete(page);
> >> +		__count_vm_event(BALLOON_DEFLATE);
> >> +		unlock_page(page);
> >> +		list_add(&page->lru, pages);
> >> +		if (++n_pages >= n_req_pages)
> >> +			break;
> >> +	}
> >> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> >> +
> >> +	return n_pages;
> >> +}
> >> +EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >> +
> > 
> > This looks quite reasonable. In fact virtio can be reworked to use
> > this too and then the original one can be dropped.
> > 
> > Have the time?
> 
> Obviously not, but I am willing to make the time. What I cannot “make" is an
> approval to send patches for other hypervisors. Let me run a quick check
> with our FOSS people here.
> 
> Anyhow, I hope it would not prevent the patches from getting to the next
> release.
> 

No, that's not a blocker.

-- 
MST
