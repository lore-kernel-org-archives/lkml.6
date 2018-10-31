Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00976C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2B20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D2B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeKABDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:03:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:47312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbeKABDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:03:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 09:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="96609430"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 31 Oct 2018 09:05:04 -0700
Message-ID: <a7c1bc0ed1e68cbc32c4dd6753fa9f8ff7f1421f.camel@linux.intel.com>
Subject: Re: [mm PATCH v4 3/6] mm: Use memblock/zone specific iterator for
 handling deferred page init
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yi.z.zhang@linux.intel.com" <yi.z.zhang@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Date:   Wed, 31 Oct 2018 09:05:04 -0700
In-Reply-To: <5b937f29-a6e1-6622-b035-246229021d3e@microsoft.com>
References: <20181017235043.17213.92459.stgit@localhost.localdomain>
         <20181017235419.17213.68425.stgit@localhost.localdomain>
         <5b937f29-a6e1-6622-b035-246229021d3e@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 15:40 +0000, Pasha Tatashin wrote:
> 
> On 10/17/18 7:54 PM, Alexander Duyck wrote:
> > This patch introduces a new iterator for_each_free_mem_pfn_range_in_zone.
> > 
> > This iterator will take care of making sure a given memory range provided
> > is in fact contained within a zone. It takes are of all the bounds checking
> > we were doing in deferred_grow_zone, and deferred_init_memmap. In addition
> > it should help to speed up the search a bit by iterating until the end of a
> > range is greater than the start of the zone pfn range, and will exit
> > completely if the start is beyond the end of the zone.
> > 
> > This patch adds yet another iterator called
> > for_each_free_mem_range_in_zone_from and then uses it to support
> > initializing and freeing pages in groups no larger than MAX_ORDER_NR_PAGES.
> > By doing this we can greatly improve the cache locality of the pages while
> > we do several loops over them in the init and freeing process.
> > 
> > We are able to tighten the loops as a result since we only really need the
> > checks for first_init_pfn in our first iteration and after that we can
> > assume that all future values will be greater than this. So I have added a
> > function called deferred_init_mem_pfn_range_in_zone that primes the
> > iterators and if it fails we can just exit.
> > 
> > On my x86_64 test system with 384GB of memory per node I saw a reduction in
> > initialization time from 1.85s to 1.38s as a result of this patch.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Hi Alex,
> 
> Could you please split this patch into two parts:
> 
> 1. Add deferred_init_maxorder()
> 2. Add memblock iterator?
> 
> This would allow a better bisecting in case of problems. Chaning two
> loops into deferred_init_maxorder() while a good idea, is still
> non-trivial and might lead to bugs.
> 
> Thank you,
> Pavel

I can do that, but I will need to flip the order. I will add the new
iterator first and then deferred_init_maxorder. Otherwise the
intermediate step ends up being too much throw-away code.

- Alex

