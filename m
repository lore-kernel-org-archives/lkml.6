Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA66C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405DE2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405DE2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeKVBem convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:34:42 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:38337 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeKVBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:34:41 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wALExEHD018583
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:59:14 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wALExEhB020070;
        Wed, 21 Nov 2018 23:59:14 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wALExEb8015724;
        Wed, 21 Nov 2018 23:59:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5746986; Wed, 21 Nov 2018 23:58:23 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Wed,
 21 Nov 2018 23:58:22 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        kexec-ml <kexec@lists.infradead.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v1] makedumpfile: exclude pages that are logically
 offline
Thread-Topic: [PATCH v1] makedumpfile: exclude pages that are logically
 offline
Thread-Index: AQHUf/E+kWItx7ZrGU+02oZZ/VtfP6VZMgzw
Date:   Wed, 21 Nov 2018 14:58:22 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03561222@BPXM09GP.gisp.nec.co.jp>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101835.9140-1-david@redhat.com>
In-Reply-To: <20181119101835.9140-1-david@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.134.124]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> Linux marks pages that are logically offline via a page flag (map count).
> Such pages e.g. include pages infated as part of a balloon driver or
> pages that were not actually onlined when onlining the whole section.
> 
> While the hypervisor usually allows to read such inflated memory, we
> basically read and dump data that is completely irrelevant. Also, this
> might result in quite some overhead in the hypervisor. In addition,
> we saw some problems under Hyper-V, whereby we can crash the kernel by
> dumping, when reading memory of a partially onlined memory segment
> (for memory added by the Hyper-V balloon driver).
> 
> Therefore, don't read and dump pages that are marked as being logically
> offline.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  makedumpfile.c | 34 ++++++++++++++++++++++++++++++----
>  makedumpfile.h |  1 +
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 8923538..b8bfd4c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -88,6 +88,7 @@ mdf_pfn_t pfn_cache_private;
>  mdf_pfn_t pfn_user;
>  mdf_pfn_t pfn_free;
>  mdf_pfn_t pfn_hwpoison;
> +mdf_pfn_t pfn_offline;
> 
>  mdf_pfn_t num_dumped;
> 
> @@ -249,6 +250,21 @@ isHugetlb(unsigned long dtor)
>                      && (SYMBOL(free_huge_page) == dtor));
>  }
> 
> +static int
> +isOffline(unsigned long flags, unsigned int _mapcount)
> +{
> +	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
> +		return FALSE;

This is NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE), isn't it?
If so, I will correct it when merging.

Otherwise, looks good to me.

Thanks!
Kazu

> +
> +	if (flags & (1UL << NUMBER(PG_slab)))
> +		return FALSE;
> +
> +	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
> +		return TRUE;
> +
> +	return FALSE;
> +}
> +
>  static int
>  is_cache_page(unsigned long flags)
>  {
> @@ -2287,6 +2303,8 @@ write_vmcoreinfo_data(void)
>  	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
> 
>  	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> +	WRITE_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE",
> +		     PAGE_OFFLINE_MAPCOUNT_VALUE);
>  	WRITE_NUMBER("phys_base", phys_base);
> 
>  	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> @@ -2687,6 +2705,7 @@ read_vmcoreinfo(void)
>  	READ_SRCFILE("pud_t", pud_t);
> 
>  	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> +	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
>  	READ_NUMBER("phys_base", phys_base);
>  #ifdef __aarch64__
>  	READ_NUMBER("VA_BITS", VA_BITS);
> @@ -6041,6 +6060,12 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		else if (isHWPOISON(flags)) {
>  			pfn_counter = &pfn_hwpoison;
>  		}
> +		/*
> +		 * Exclude pages that are logically offline.
> +		 */
> +		else if (isOffline(flags, _mapcount)) {
> +			pfn_counter = &pfn_offline;
> +		}
>  		/*
>  		 * Unexcludable page
>  		 */
> @@ -7522,7 +7547,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  	 */
>  	if (info->flag_cyclic) {
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
> -		pfn_user = pfn_free = pfn_hwpoison = 0;
> +		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
>  		pfn_memhole = info->max_mapnr;
>  	}
> 
> @@ -8804,7 +8829,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  		 * Reset counter for debug message.
>  		 */
>  		pfn_zero = pfn_cache = pfn_cache_private = 0;
> -		pfn_user = pfn_free = pfn_hwpoison = 0;
> +		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
>  		pfn_memhole = info->max_mapnr;
> 
>  		/*
> @@ -9749,7 +9774,7 @@ print_report(void)
>  	pfn_original = info->max_mapnr - pfn_memhole;
> 
>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
> -	    + pfn_user + pfn_free + pfn_hwpoison;
> +	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
>  	shrinking = (pfn_original - pfn_excluded) * 100;
>  	shrinking = shrinking / pfn_original;
> 
> @@ -9763,6 +9788,7 @@ print_report(void)
>  	REPORT_MSG("    User process data pages : 0x%016llx\n", pfn_user);
>  	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
>  	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
> +	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
>  	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>  	    pfn_original - pfn_excluded);
>  	REPORT_MSG("  (The number of pages is reduced to %lld%%.)\n",
> @@ -9790,7 +9816,7 @@ print_mem_usage(void)
>  	pfn_original = info->max_mapnr - pfn_memhole;
> 
>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
> -	    + pfn_user + pfn_free + pfn_hwpoison;
> +	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
>  	shrinking = (pfn_original - pfn_excluded) * 100;
>  	shrinking = shrinking / pfn_original;
>  	total_size = info->page_size * pfn_original;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index f02f86d..e3a2b29 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1927,6 +1927,7 @@ struct number_table {
>  	long    PG_hwpoison;
> 
>  	long	PAGE_BUDDY_MAPCOUNT_VALUE;
> +	long	PAGE_OFFLINE_MAPCOUNT_VALUE;
>  	long	SECTION_SIZE_BITS;
>  	long	MAX_PHYSMEM_BITS;
>  	long    HUGETLB_PAGE_DTOR;
> --
> 2.17.2
> 


