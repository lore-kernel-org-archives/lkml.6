Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30ACC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5FD208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5FD208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeGJKRu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:17:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:18782 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeGJKRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:17:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 03:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="70129616"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2018 03:17:01 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 10 Jul 2018 03:17:01 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 10 Jul 2018 03:17:00 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.17]) with mapi id 14.03.0319.002;
 Tue, 10 Jul 2018 18:16:58 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v35 1/5] mm: support to get hints of free page blocks
Thread-Topic: [PATCH v35 1/5] mm: support to get hints of free page blocks
Thread-Index: AQHUGDRRNGdK3F5na0yhzVOAicw6EaSIOJOA
Date:   Tue, 10 Jul 2018 10:16:57 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396E91B6@SHSMSX101.ccr.corp.intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGYxODllNmQtZDQ2OS00MzA1LWIxMzAtNmMxMTc3NzU0MWUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRTVISVlRWmFiQmE5TVU0ZEplc25lNnloRjhpQmx1Zm12dkRURFFRSVZNUGpkZlh0QVwvdlJ1Q3pYNjZGYU9xMGwifQ==
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

On Tuesday, July 10, 2018 5:31 PM, Wang, Wei W wrote:
> Subject: [PATCH v35 1/5] mm: support to get hints of free page blocks
> 
> This patch adds support to get free page blocks from a free page list.
> The physical addresses of the blocks are stored to a list of buffers passed
> from the caller. The obtained free page blocks are hints about free pages,
> because there is no guarantee that they are still on the free page list after the
> function returns.
> 
> One use example of this patch is to accelerate live migration by skipping the
> transfer of free pages reported from the guest. A popular method used by
> the hypervisor to track which part of memory is written during live migration
> is to write-protect all the guest memory. So, those pages that are hinted as
> free pages but are written after this function returns will be captured by the
> hypervisor, and they will be added to the next round of memory transfer.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/mm.h |  3 ++
>  mm/page_alloc.c    | 98
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h index a0fbb9f..5ce654f
> 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2007,6 +2007,9 @@ extern void free_area_init(unsigned long *
> zones_size);  extern void free_area_init_node(int nid, unsigned long *
> zones_size,
>  		unsigned long zone_start_pfn, unsigned long *zholes_size);
> extern void free_initmem(void);
> +unsigned long max_free_page_blocks(int order); int
> +get_from_free_page_list(int order, struct list_head *pages,
> +			    unsigned int size, unsigned long *loaded_num);
> 
>  /*
>   * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index 1521100..b67839b
> 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5043,6 +5043,104 @@ void show_free_areas(unsigned int filter,
> nodemask_t *nodemask)
>  	show_swap_cache_info();
>  }
> 
> +/**
> + * max_free_page_blocks - estimate the max number of free page blocks
> + * @order: the order of the free page blocks to estimate
> + *
> + * This function gives a rough estimation of the possible maximum
> +number of
> + * free page blocks a free list may have. The estimation works on an
> +assumption
> + * that all the system pages are on that list.
> + *
> + * Context: Any context.
> + *
> + * Return: The largest number of free page blocks that the free list can have.
> + */
> +unsigned long max_free_page_blocks(int order) {
> +	return totalram_pages / (1 << order);
> +}
> +EXPORT_SYMBOL_GPL(max_free_page_blocks);
> +
> +/**
> + * get_from_free_page_list - get hints of free pages from a free page
> +list
> + * @order: the order of the free page list to check
> + * @pages: the list of page blocks used as buffers to load the
> +addresses
> + * @size: the size of each buffer in bytes
> + * @loaded_num: the number of addresses loaded to the buffers
> + *
> + * This function offers hints about free pages. The addresses of free
> +page
> + * blocks are stored to the list of buffers passed from the caller.
> +There is
> + * no guarantee that the obtained free pages are still on the free page
> +list
> + * after the function returns. pfn_to_page on the obtained free pages
> +is
> + * strongly discouraged and if there is an absolute need for that, make
> +sure
> + * to contact MM people to discuss potential problems.
> + *
> + * The addresses are currently stored to a buffer in little endian.
> +This
> + * avoids the overhead of converting endianness by the caller who needs
> +data
> + * in the little endian format. Big endian support can be added on
> +demand in
> + * the future.
> + *
> + * Context: Process context.
> + *
> + * Return: 0 if all the free page block addresses are stored to the buffers;
> + *         -ENOSPC if the buffers are not sufficient to store all the
> + *         addresses; or -EINVAL if an unexpected argument is received (e.g.
> + *         incorrect @order, empty buffer list).
> + */
> +int get_from_free_page_list(int order, struct list_head *pages,
> +			    unsigned int size, unsigned long *loaded_num) {


Hi Linus,

We  took your original suggestion - pass in pre-allocated buffers to load the addresses (now we use a list of pre-allocated page blocks as buffers). Hope that suggestion is still acceptable (the advantage of this method was explained here: https://lkml.org/lkml/2018/6/28/184).
Look forward to getting your feedback. Thanks.

Best,
Wei 
