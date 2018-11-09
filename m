Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB163C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCEE20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCEE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeKIU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:27:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKIU1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:27:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68978A78;
        Fri,  9 Nov 2018 02:47:00 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258723F718;
        Fri,  9 Nov 2018 02:46:57 -0800 (PST)
Subject: Re: [RFC][PATCH v1 04/11] mm: madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-5-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <21e5b9ca-ad72-b0d5-3397-4b65831b236b@arm.com>
Date:   Fri, 9 Nov 2018 16:16:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541746035-13408-5-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> Currently madvise_inject_error() pins the target page when calling
> memory error handler, but it's not good because the refcount is just
> an artifact of error injector and mock nothing about hw error itself.
> IOW, pinning the error page is part of error handler's task, so
> let's stop doing it.

Did not get that. Could you please kindly explain how an incremented
ref count through get_user_pages_fast() was a mocking the HW error
previously ? Though I might be missing the some context here.

> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  mm/madvise.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git v4.19-mmotm-2018-10-30-16-08/mm/madvise.c v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
> index 6cb1ca9..9fa0225 100644
> --- v4.19-mmotm-2018-10-30-16-08/mm/madvise.c
> +++ v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
> @@ -637,6 +637,16 @@ static int madvise_inject_error(int behavior,
>  		ret = get_user_pages_fast(start, 1, 0, &page);
>  		if (ret != 1)
>  			return ret;
> +		/*
> +		 * The get_user_pages_fast() is just to get the pfn of the
> +		 * given address, and the refcount has nothing to do with
> +		 * what we try to test, so it should be released immediately.
> +		 * This is racy but it's intended because the real hardware
> +		 * errors could happen at any moment and memory error handlers
> +		 * must properly handle the race.
> +		 */
> +		put_page(page);
> +
>  		pfn = page_to_pfn(page);
>  
>  		/*
> @@ -646,16 +656,11 @@ static int madvise_inject_error(int behavior,
>  		 */
>  		order = compound_order(compound_head(page));
>  
> -		if (PageHWPoison(page)) {
> -			put_page(page);
> -			continue;
> -		}
> -
>  		if (behavior == MADV_SOFT_OFFLINE) {
>  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>  					pfn, start);
>  
> -			ret = soft_offline_page(page, MF_COUNT_INCREASED);
> +			ret = soft_offline_page(page, 0);

Probably something defined as a new "ignored" in the memory faults flag
enumeration instead of passing '0' directly.
