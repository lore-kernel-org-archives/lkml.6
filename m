Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C42C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EE120882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EE120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeILSIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:08:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbeILSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:08:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CD1Z90144218
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:04:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf1fgdgv1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:04:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 12 Sep 2018 14:04:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 14:03:59 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CD3wB930081184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 13:03:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6287A4051;
        Wed, 12 Sep 2018 16:03:46 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A65BA404D;
        Wed, 12 Sep 2018 16:03:46 +0100 (BST)
Received: from thinkpad (unknown [9.152.212.168])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Sep 2018 16:03:46 +0100 (BST)
Date:   Wed, 12 Sep 2018 15:03:56 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com, osalvador@suse.de
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
In-Reply-To: <20180910131754.GG10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
        <20180910131754.GG10951@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091213-0020-0000-0000-000002C53239
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091213-0021-0000-0000-00002112888A
Message-Id: <20180912150356.642c1dab@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 15:17:54 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> [Cc Pavel]
> 
> On Mon 10-09-18 14:35:27, Mikhail Zaslonko wrote:
> > If memory end is not aligned with the linux memory section boundary, such
> > a section is only partly initialized. This may lead to VM_BUG_ON due to
> > uninitialized struct pages access from is_mem_section_removable() or
> > test_pages_in_a_zone() function.
> > 
> > Here is one of the panic examples:
> >  CONFIG_DEBUG_VM_PGFLAGS=y
> >  kernel parameter mem=3075M  
> 
> OK, so the last memory section is not full and we have a partial memory
> block right?
> 
> >  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))  
> 
> OK, this means that the struct page is not fully initialized. Do you
> have a specific place which has triggered this assert?
> 
> >  ------------[ cut here ]------------
> >  Call Trace:
> >  ([<000000000039b8a4>] is_mem_section_removable+0xcc/0x1c0)
> >   [<00000000009558ba>] show_mem_removable+0xda/0xe0
> >   [<00000000009325fc>] dev_attr_show+0x3c/0x80
> >   [<000000000047e7ea>] sysfs_kf_seq_show+0xda/0x160
> >   [<00000000003fc4e0>] seq_read+0x208/0x4c8
> >   [<00000000003cb80e>] __vfs_read+0x46/0x180
> >   [<00000000003cb9ce>] vfs_read+0x86/0x148
> >   [<00000000003cc06a>] ksys_read+0x62/0xc0
> >   [<0000000000c001c0>] system_call+0xdc/0x2d8
> > 
> > This fix checks if the page lies within the zone boundaries before
> > accessing the struct page data. The check is added to both functions.
> > Actually similar check has already been present in
> > is_pageblock_removable_nolock() function but only after the struct page
> > is accessed.
> >   
> 
> Well, I am afraid this is not the proper solution. We are relying on the
> full pageblock worth of initialized struct pages at many other place. We
> used to do that in the past because we have initialized the full
> section but this has been changed recently. Pavel, do you have any ideas
> how to deal with this partial mem sections now?

This is not about partly initialized pageblocks, it is about partly
initialized struct pages for memory (hotplug) blocks. And this also
seems to "work as designed", i.e. memmap_init_zone() will stop at
zone->spanned_pages, and not initialize the full memory block if
you specify a not-memory-block-aligned mem= parameter.

"Normal" memory management code should never get in touch with the
uninitialized part, only the 2 memory hotplug sysfs handlers for
"valid_zones" and "removable" will iterate over a complete memory block.

So it does seem rather straight-forward to simply fix those 2 functions,
and not let them go beyond zone->spanned_pages, which is what Mikhails patch
would do. What exactly is wrong with that approach, and how would you rather
have it fixed? A patch that changes memmap_init_zone() to initialize all
struct pages of the last memory block, even beyond zone->spanned_pages?
Could this be done w/o side-effects?

If you look at test_pages_in_a_zone(), there is already some logic that
obviously assumes that at least the first page of the memory block is
initialized, and then while iterating over the rest, a check for
zone_spans_pfn() can easily be added. Mikhail applied the same logic
to is_mem_section_removable(), and his patch does fix the panic (or access
to uninitialized struct pages w/o DEBUG_VM poisoning).

BTW, those sysfs attributes are world-readable, so anyone can trigger
the panic by simply reading them, or just run lsmem (also available for
x86 since util-linux 2.32). OK, you need a special not-memory-block-aligned
mem= parameter and DEBUG_VM for poison check, but w/o DEBUG_VM you would
still access uninitialized struct pages. This sounds very wrong, and I
think it really should be fixed.

> 
> > Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/memory_hotplug.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 9eea6e809a4e..8e20e8fcc3b0 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1229,9 +1229,8 @@ static struct page *next_active_pageblock(struct page *page)
> >  	return page + pageblock_nr_pages;
> >  }
> >  
> > -static bool is_pageblock_removable_nolock(struct page *page)
> > +static bool is_pageblock_removable_nolock(struct page *page, struct zone **zone)
> >  {
> > -	struct zone *zone;
> >  	unsigned long pfn;
> >  
> >  	/*
> > @@ -1241,15 +1240,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
> >  	 * We have to take care about the node as well. If the node is offline
> >  	 * its NODE_DATA will be NULL - see page_zone.
> >  	 */
> > -	if (!node_online(page_to_nid(page)))
> > -		return false;
> > -
> > -	zone = page_zone(page);
> >  	pfn = page_to_pfn(page);
> > -	if (!zone_spans_pfn(zone, pfn))
> > +	if (*zone && !zone_spans_pfn(*zone, pfn))
> >  		return false;
> > +	if (!node_online(page_to_nid(page)))
> > +		return false;
> > +	*zone = page_zone(page);
> >  
> > -	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
> > +	return !has_unmovable_pages(*zone, page, 0, MIGRATE_MOVABLE, true);
> >  }
> >  
> >  /* Checks if this range of memory is likely to be hot-removable. */
> > @@ -1257,10 +1255,11 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
> >  {
> >  	struct page *page = pfn_to_page(start_pfn);
> >  	struct page *end_page = page + nr_pages;
> > +	struct zone *zone = NULL;
> >  
> >  	/* Check the starting page of each pageblock within the range */
> >  	for (; page < end_page; page = next_active_pageblock(page)) {
> > -		if (!is_pageblock_removable_nolock(page))
> > +		if (!is_pageblock_removable_nolock(page, &zone))
> >  			return false;
> >  		cond_resched();
> >  	}
> > @@ -1296,6 +1295,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
> >  				i++;
> >  			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
> >  				continue;
> > +			/* Check if we got outside of the zone */
> > +			if (zone && !zone_spans_pfn(zone, pfn))
> > +				return 0;
> >  			page = pfn_to_page(pfn + i);
> >  			if (zone && page_zone(page) != zone)
> >  				return 0;
> > -- 
> > 2.16.4  
> 

