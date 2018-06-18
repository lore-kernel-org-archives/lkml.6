Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC25C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170A208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2170A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeFRCQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:16:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754387AbeFRCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74880818A6A2;
        Mon, 18 Jun 2018 02:16:09 +0000 (UTC)
Received: from redhat.com (ovpn-121-19.rdu2.redhat.com [10.10.121.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43F3B111CB82;
        Mon, 18 Jun 2018 02:16:02 +0000 (UTC)
Date:   Mon, 18 Jun 2018 05:16:02 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Message-ID: <20180618051145-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <20180616045005.GA14936@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616045005.GA14936@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 02:16:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 02:16:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 09:50:05PM -0700, Matthew Wilcox wrote:
> I wonder if (to address Michael's concern), you shouldn't instead use
> the first free chunk of pages to return the addresses of all the pages.
> ie something like this:
> 
> 	__le64 *ret = NULL;
> 	unsigned int max = (PAGE_SIZE << order) / sizeof(__le64);
> 
> 	for_each_populated_zone(zone) {
> 		spin_lock_irq(&zone->lock);
> 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> 			list = &zone->free_area[order].free_list[mt];
> 			list_for_each_entry_safe(page, list, lru, ...) {
> 				if (index == size)
> 					break;
> 				addr = page_to_pfn(page) << PAGE_SHIFT;
> 				if (!ret) {
> 					list_del(...);
> 					ret = addr;
> 				}
> 				ret[index++] = cpu_to_le64(addr);
> 			}
> 		}
> 		spin_unlock_irq(&zone->lock);
> 	}
> 
> 	return ret;
> }
> 
> You'll need to return the page to the freelist afterwards, but free_pages()
> should take care of that.

Yes Wei already came up with the idea to stick this data into a
MAX_ORDER allocation. Are you sure just taking an entry off
the list like that has no bad side effects?
I have a vague memory someone complained that everyone
most go through get free pages/kmalloc, but I can't
find that anymore.


-- 
MST
