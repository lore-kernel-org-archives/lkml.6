Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4ECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDB920883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDB920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeKIVNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:13:24 -0500
Received: from foss.arm.com ([217.140.101.70]:57764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbeKIVNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:13:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B8480D;
        Fri,  9 Nov 2018 03:33:10 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6747D3F718;
        Fri,  9 Nov 2018 03:33:08 -0800 (PST)
Subject: Re: [RFC][PATCH v1 11/11] mm: hwpoison: introduce
 clear_hwpoison_free_buddy_page()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-12-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d37c1be2-2069-a147-9ba8-4749cd386d0b@arm.com>
Date:   Fri, 9 Nov 2018 17:03:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541746035-13408-12-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> The new function is a reverse operation of set_hwpoison_free_buddy_page()
> to adjust unpoison_memory() to the new semantics.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

snip

> +
> +/*
> + * Reverse operation of set_hwpoison_free_buddy_page(), which is expected
> + * to work only on error pages isolated from buddy allocator.
> + */
> +bool clear_hwpoison_free_buddy_page(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +	bool unpoisoned = false;
> +
> +	spin_lock(&zone->lock);
> +	if (TestClearPageHWPoison(page)) {
> +		unsigned long pfn = page_to_pfn(page);
> +		int migratetype = get_pfnblock_migratetype(page, pfn);
> +
> +		__free_one_page(page, pfn, zone, 0, migratetype);
> +		unpoisoned = true;
> +	}
> +	spin_unlock(&zone->lock);
> +	return unpoisoned;
> +}
>  #endif
> 

Though there are multiple page state checks in unpoison_memory() leading
upto clearing HWPoison flag, the page must not be in buddy already if
__free_one_page() would be called on it.
