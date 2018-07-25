Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6507DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA720856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CA720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeGYC1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:27:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbeGYC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:27:13 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80415DC0;
        Wed, 25 Jul 2018 01:18:02 +0000 (UTC)
Date:   Tue, 24 Jul 2018 18:18:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] mm: move mirrored memory specific code outside of
 memmap_init_zone
Message-Id: <20180724181800.3f25fdf8bcf0d8fd05ea1f43@linux-foundation.org>
In-Reply-To: <20180724235520.10200-4-pasha.tatashin@oracle.com>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
        <20180724235520.10200-4-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 19:55:20 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> memmap_init_zone, is getting complex, because it is called from different
> contexts: hotplug, and during boot, and also because it must handle some
> architecture quirks. One of them is mirroed memory.
> 
> Move the code that decides whether to skip mirrored memory outside of
> memmap_init_zone, into a separate function.

Conflicts a bit with the page_alloc.c hunk from
http://ozlabs.org/~akpm/mmots/broken-out/mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-arm64.patch.  Please check my fixup:

void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
		unsigned long start_pfn, enum memmap_context context,
		struct vmem_altmap *altmap)
{
	unsigned long pfn, end_pfn = start_pfn + size;
	struct page *page;

	if (highest_memmap_pfn < end_pfn - 1)
		highest_memmap_pfn = end_pfn - 1;

	/*
	 * Honor reservation requested by the driver for this ZONE_DEVICE
	 * memory
	 */
	if (altmap && start_pfn == altmap->base_pfn)
		start_pfn += altmap->reserve;

	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
		/*
		 * There can be holes in boot-time mem_map[]s handed to this
		 * function.  They do not exist on hotplugged memory.
		 */
		if (context == MEMMAP_EARLY) {
			if (!early_pfn_valid(pfn)) {
				pfn = next_valid_pfn(pfn) - 1;
				continue;
			}
			if (!early_pfn_in_nid(pfn, nid))
				continue;
			if (overlap_memmap_init(zone, &pfn))
				continue;
			if (defer_init(nid, pfn, end_pfn))
				break;
		}

		page = pfn_to_page(pfn);
		__init_single_page(page, pfn, zone, nid);
		if (context == MEMMAP_HOTPLUG)
			SetPageReserved(page);

		/*
		 * Mark the block movable so that blocks are reserved for
		 * movable at startup. This will force kernel allocations
		 * to reserve their blocks rather than leaking throughout
		 * the address space during boot when many long-lived
		 * kernel allocations are made.
		 *
		 * bitmap is created for zone's valid pfn range. but memmap
		 * can be created for invalid pages (for alignment)
		 * check here not to call set_pageblock_migratetype() against
		 * pfn out of zone.
		 */
		if (!(pfn & (pageblock_nr_pages - 1))) {
			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
			cond_resched();
		}
	}
}

