Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CA4223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CA4223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeKNSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:25:21 -0500
Received: from foss.arm.com ([217.140.101.70]:39688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbeKNSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:25:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3983EBD;
        Wed, 14 Nov 2018 00:23:09 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884BF3F5CF;
        Wed, 14 Nov 2018 00:23:07 -0800 (PST)
Subject: Re: [RFC][PATCH v1 11/11] mm: hwpoison: introduce
 clear_hwpoison_free_buddy_page()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-12-git-send-email-n-horiguchi@ah.jp.nec.com>
 <d37c1be2-2069-a147-9ba8-4749cd386d0b@arm.com>
 <20181113001907.GD5945@hori1.linux.bs1.fc.nec.co.jp>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b5fb36d0-487c-cf6d-3aa0-a5b43c51b2d6@arm.com>
Date:   Wed, 14 Nov 2018 13:53:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113001907.GD5945@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2018 05:49 AM, Naoya Horiguchi wrote:
> On Fri, Nov 09, 2018 at 05:03:06PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
>>> The new function is a reverse operation of set_hwpoison_free_buddy_page()
>>> to adjust unpoison_memory() to the new semantics.
>>>
>>> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>
>> snip
>>
>>> +
>>> +/*
>>> + * Reverse operation of set_hwpoison_free_buddy_page(), which is expected
>>> + * to work only on error pages isolated from buddy allocator.
>>> + */
>>> +bool clear_hwpoison_free_buddy_page(struct page *page)
>>> +{
>>> +	struct zone *zone = page_zone(page);
>>> +	bool unpoisoned = false;
>>> +
>>> +	spin_lock(&zone->lock);
>>> +	if (TestClearPageHWPoison(page)) {
>>> +		unsigned long pfn = page_to_pfn(page);
>>> +		int migratetype = get_pfnblock_migratetype(page, pfn);
>>> +
>>> +		__free_one_page(page, pfn, zone, 0, migratetype);
>>> +		unpoisoned = true;
>>> +	}
>>> +	spin_unlock(&zone->lock);
>>> +	return unpoisoned;
>>> +}
>>>  #endif
>>>
>>
>> Though there are multiple page state checks in unpoison_memory() leading
>> upto clearing HWPoison flag, the page must not be in buddy already if
>> __free_one_page() would be called on it.
> 
> Yes, you're right.
> clear_hwpoison_free_buddy_page() is intended to cancel the isolation by
> set_hwpoison_free_buddy_page() which removes the target page from buddy allocator,
> so the page clear_hwpoison_free_buddy_page() tries to handle is not a buddy page
> actually (not linked to any freelist).

Got it. Thanks for the explanation.
