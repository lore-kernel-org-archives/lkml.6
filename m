Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200B4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3A62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3A62124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeGMGuL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:50:11 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:50526 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeGMGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:50:11 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6D6ZZ1l029912
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jul 2018 15:35:35 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6D6ZZRi013368;
        Fri, 13 Jul 2018 15:35:35 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6D6YSGI006042;
        Fri, 13 Jul 2018 15:35:35 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1964812; Fri, 13 Jul 2018 15:31:27 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Fri,
 13 Jul 2018 15:31:26 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v5 05/11] mm, madvise_inject_error: Let memory_failure()
 optionally take a page reference
Thread-Topic: [PATCH v5 05/11] mm, madvise_inject_error: Let
 memory_failure() optionally take a page reference
Thread-Index: AQHUE+ETIYw2FKVFeEC6cnQsWjGMfKSMJ5yA
Date:   Fri, 13 Jul 2018 06:31:25 +0000
Message-ID: <20180713063125.GA10034@hori1.linux.bs1.fc.nec.co.jp>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153074044986.27838.16910122305490506387.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074044986.27838.16910122305490506387.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A161B23BB3FC5245AE184ADCF1A397DB@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Wed, Jul 04, 2018 at 02:40:49PM -0700, Dan Williams wrote:
> The madvise_inject_error() routine uses get_user_pages() to lookup the
> pfn and other information for injected error, but it does not release
> that pin. The assumption is that failed pages should be taken out of
> circulation.
>
> However, for dax mappings it is not possible to take pages out of
> circulation since they are 1:1 physically mapped as filesystem blocks,
> or device-dax capacity. They also typically represent persistent memory
> which has an error clearing capability.
>
> In preparation for adding a special handler for dax mappings, shift the
> responsibility of taking the page reference to memory_failure(). I.e.
> drop the page reference and do not specify MF_COUNT_INCREASED to
> memory_failure().
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/madvise.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4d3c922ea1a1..b731933dddae 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -631,11 +631,13 @@ static int madvise_inject_error(int behavior,
>
>
>  	for (; start < end; start += PAGE_SIZE << order) {
> +		unsigned long pfn;
>  		int ret;
>
>  		ret = get_user_pages_fast(start, 1, 0, &page);
>  		if (ret != 1)
>  			return ret;
> +		pfn = page_to_pfn(page);
>
>  		/*
>  		 * When soft offlining hugepages, after migrating the page
> @@ -651,17 +653,27 @@ static int madvise_inject_error(int behavior,
>
>  		if (behavior == MADV_SOFT_OFFLINE) {
>  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
> -						page_to_pfn(page), start);
> +					pfn, start);
>
>  			ret = soft_offline_page(page, MF_COUNT_INCREASED);
>  			if (ret)
>  				return ret;
>  			continue;
>  		}
> +
>  		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
> -						page_to_pfn(page), start);
> +				pfn, start);
> +
> +		ret = memory_failure(pfn, 0);
> +
> +		/*
> +		 * Drop the page reference taken by get_user_pages_fast(). In
> +		 * the absence of MF_COUNT_INCREASED the memory_failure()
> +		 * routine is responsible for pinning the page to prevent it
> +		 * from being released back to the page allocator.
> +		 */
> +		put_page(page);
>
> -		ret = memory_failure(page_to_pfn(page), MF_COUNT_INCREASED);

MF_COUNT_INCREASED means that the page refcount for memory error handling
is taken by the caller so you don't have to take one inside memory_failure().
So this code don't keep with the definition, then another refcount can be
taken in memory_failure() in normal LRU page's case for example.
As a result the error message "Memory failure: %#lx: %s still referenced by
%d users\n" will be dumped in page_action().

So if you want to put put_page() in madvise_inject_error(), I think that

 		put_page(page);
 		ret = memory_failure(pfn, 0);

can be acceptable because the purpose of get_user_pages_fast() here is
just getting pfn, and the refcount itself is not so important.
IOW, memory_failure() is called only with pfn which never changes depending
on the page's status.
In production system memory_failure() is called via machine check code
without taking any pagecount, so I don't think the this injection interface
is properly mocking the real thing. So I'm feeling that this flag will be
wiped out at some point.

Thanks,
Naoya Horiguchi
