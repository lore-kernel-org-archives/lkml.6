Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A25C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFF92084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFF92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKPIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:40:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:40:47 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A03C9949;
        Thu, 15 Nov 2018 22:31:04 +0000 (UTC)
Date:   Thu, 15 Nov 2018 14:31:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
Message-Id: <20181115143103.c6fa8fec343bb706b91f6c6c@linux-foundation.org>
In-Reply-To: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 12:57:34 +0300 Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:

> If all pages are deleted from the mapping by memory reclaim and also
> moved to the cleancache:
> 
> __delete_from_page_cache
>   (no shadow case)
>   unaccount_page_cache_page
>     cleancache_put_page
>   page_cache_delete
>     mapping->nrpages -= nr
>     (nrpages becomes 0)
> 
> We don't clean the cleancache for an inode after final file truncation
> (removal).
> 
> truncate_inode_pages_final
>   check (nrpages || nrexceptional) is false
>     no truncate_inode_pages
>       no cleancache_invalidate_inode(mapping)
> 
> These way when reading the new file created with same inode we may get
> these trash leftover pages from cleancache and see wrong data instead of
> the contents of the new file.
> 
> Fix it by always doing truncate_inode_pages which is already ready for
> nrpages == 0 && nrexceptional == 0 case and just invalidates inode.
> 

Data corruption sounds serious.  Shouldn't we backport this into
-stable kernels?

