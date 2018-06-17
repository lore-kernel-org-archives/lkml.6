Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEBC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7422088E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7422088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756956AbeFQAHq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:07:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:6353 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756924AbeFQAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:07:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2018 17:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,232,1526367600"; 
   d="scan'208";a="65181993"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2018 17:07:43 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 16 Jun 2018 17:07:43 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 16 Jun 2018 17:07:43 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Sun, 17 Jun 2018 08:07:41 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v33 1/4] mm: add a function to get free page blocks
Thread-Topic: [PATCH v33 1/4] mm: add a function to get free page blocks
Thread-Index: AQHUBGbzlrVfblBI3Uy7QJ/rUPSUs6RhzBKAgAEz9TA=
Date:   Sun, 17 Jun 2018 00:07:40 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A6415@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <20180616045005.GA14936@bombadil.infradead.org>
In-Reply-To: <20180616045005.GA14936@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDc4ZWY0MWMtMzkwYy00ZmU5LTk3NWEtZDUxZTBhNTI2NjJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNm8wbno4OHo1MnlyeGYycnBcL291VVpoRU53MGkwNmdkM2dSbEw0MnErbEhhWUU2dm1CVzVDbkx6YWVIQmJKdGIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 16, 2018 12:50 PM, Matthew Wilcox wrote:
> On Fri, Jun 15, 2018 at 12:43:10PM +0800, Wei Wang wrote:
> > +/**
> > + * get_from_free_page_list - get free page blocks from a free page
> > +list
> > + * @order: the order of the free page list to check
> > + * @buf: the array to store the physical addresses of the free page
> > +blocks
> > + * @size: the array size
> > + *
> > + * This function offers hints about free pages. There is no guarantee
> > +that
> > + * the obtained free pages are still on the free page list after the
> > +function
> > + * returns. pfn_to_page on the obtained free pages is strongly
> > +discouraged
> > + * and if there is an absolute need for that, make sure to contact MM
> > +people
> > + * to discuss potential problems.
> > + *
> > + * The addresses are currently stored to the array in little endian.
> > +This
> > + * avoids the overhead of converting endianness by the caller who
> > +needs data
> > + * in the little endian format. Big endian support can be added on
> > +demand in
> > + * the future.
> > + *
> > + * Return the number of free page blocks obtained from the free page list.
> > + * The maximum number of free page blocks that can be obtained is
> > +limited to
> > + * the caller's array size.
> > + */
> 
> Please use:
> 
>  * Return: The number of free page blocks obtained from the free page list.
> 
> Also, please include a
> 
>  * Context: Any context.
> 
> or
> 
>  * Context: Process context.
> 
> or whatever other conetext this function can be called from.  Since you're
> taking the lock irqsafe, I assume this can be called from any context, but I
> wonder if it makes sense to have this function callable from interrupt context.
> Maybe this should be callable from process context only.

Thanks, sounds better to make it process context only.

> 
> > +uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t
> > +size) {
> > +	struct zone *zone;
> > +	enum migratetype mt;
> > +	struct page *page;
> > +	struct list_head *list;
> > +	unsigned long addr, flags;
> > +	uint32_t index = 0;
> > +
> > +	for_each_populated_zone(zone) {
> > +		spin_lock_irqsave(&zone->lock, flags);
> > +		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> > +			list = &zone->free_area[order].free_list[mt];
> > +			list_for_each_entry(page, list, lru) {
> > +				addr = page_to_pfn(page) << PAGE_SHIFT;
> > +				if (likely(index < size)) {
> > +					buf[index++] = cpu_to_le64(addr);
> > +				} else {
> > +					spin_unlock_irqrestore(&zone->lock,
> > +							       flags);
> > +					return index;
> > +				}
> > +			}
> > +		}
> > +		spin_unlock_irqrestore(&zone->lock, flags);
> > +	}
> > +
> > +	return index;
> > +}
> 
> I wonder if (to address Michael's concern), you shouldn't instead use the first
> free chunk of pages to return the addresses of all the pages.
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

Thanks for sharing. But probably we would not take this approach for the reasons below:

1) I'm not sure if getting a block of free pages to use could be that simple (just pluck it from the list as above). I think it is more prudent to let the callers allocate the array via the regular allocation functions. 

2) Callers may need to use this with their own defined protocols, and they want the header and payload (i.e. the obtained hints) to locate in physically continuous memory (there are tricks they can use to make it work with non-physically continuous memory, but that would just complicate all the things) . In this case, it is better to have callers allocate the memory on their own, and pass the payload part memory to this API to get the payload filled.

Best,
Wei

