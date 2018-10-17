Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B3821523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B3821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJQRGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeJQRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2BDAAE62;
        Wed, 17 Oct 2018 09:11:54 +0000 (UTC)
Date:   Wed, 17 Oct 2018 11:11:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [mm PATCH v3 3/6] mm: Use memblock/zone specific iterator for
 handling deferred page init
Message-ID: <20181017091154.GK18839@dhcp22.suse.cz>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202709.2171.75580.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015202709.2171.75580.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-10-18 13:27:09, Alexander Duyck wrote:
> This patch introduces a new iterator for_each_free_mem_pfn_range_in_zone.
> 
> This iterator will take care of making sure a given memory range provided
> is in fact contained within a zone. It takes are of all the bounds checking
> we were doing in deferred_grow_zone, and deferred_init_memmap. In addition
> it should help to speed up the search a bit by iterating until the end of a
> range is greater than the start of the zone pfn range, and will exit
> completely if the start is beyond the end of the zone.
> 
> This patch adds yet another iterator called
> for_each_free_mem_range_in_zone_from and then uses it to support
> initializing and freeing pages in groups no larger than MAX_ORDER_NR_PAGES.
> By doing this we can greatly improve the cache locality of the pages while
> we do several loops over them in the init and freeing process.
> 
> We are able to tighten the loops as a result since we only really need the
> checks for first_init_pfn in our first iteration and after that we can
> assume that all future values will be greater than this. So I have added a
> function called deferred_init_mem_pfn_range_in_zone that primes the
> iterators and if it fails we can just exit.

Numbers please.

Besides that, this adds a lot of code and I am not convinced the result
is so much better to justify that. 

> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  include/linux/memblock.h |   58 +++++++++++++++
>  mm/memblock.c            |   63 ++++++++++++++++
>  mm/page_alloc.c          |  176 ++++++++++++++++++++++++++++++++--------------
>  3 files changed, 242 insertions(+), 55 deletions(-)
-- 
Michal Hocko
SUSE Labs
