Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0462229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfBNK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:29:05 -0500
Received: from relay.sw.ru ([185.231.240.75]:42772 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfBNK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:29:05 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1guEGN-00050x-1u; Thu, 14 Feb 2019 13:29:03 +0300
Subject: Re: [PATCH 4/4] mm: Generalize putback scan functions
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998445694.18704.16751838197928455484.stgit@localhost.localdomain>
 <20190213192011.62vmk5wyvxufcn4k@ca-dmjordan1.us.oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0add6f90-371d-c95b-7032-49f323f96b02@virtuozzo.com>
Date:   Thu, 14 Feb 2019 13:29:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213192011.62vmk5wyvxufcn4k@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 22:20, Daniel Jordan wrote:
> On Tue, Feb 12, 2019 at 06:14:16PM +0300, Kirill Tkhai wrote:
>> +static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>> +						     struct list_head *list)
>>  {
>>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +	int nr_pages, nr_moved = 0;
>>  	LIST_HEAD(pages_to_free);
>> +	struct page *page;
>> +	enum lru_list lru;
>>  
>> -	/*
>> -	 * Put back any unfreeable pages.
>> -	 */
>> -	while (!list_empty(page_list)) {
>> -		struct page *page = lru_to_page(page_list);
>> -		int lru;
>> -
>> -		VM_BUG_ON_PAGE(PageLRU(page), page);
>> -		list_del(&page->lru);
>> +	while (!list_empty(list)) {
>> +		page = lru_to_page(list);
>>  		if (unlikely(!page_evictable(page))) {
>> +			list_del_init(&page->lru);
>>  			spin_unlock_irq(&pgdat->lru_lock);
>>  			putback_lru_page(page);
>>  			spin_lock_irq(&pgdat->lru_lock);
>>  			continue;
>>  		}
>> -
>>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  
>> +		VM_BUG_ON_PAGE(PageLRU(page), page);
> 
> Nit, but moving the BUG down here weakens it a little bit since we miss
> checking it if the page is unevictable.

Yeah, this is bad.
 
> Maybe worth pointing out in the changelog that the main difference from
> combining these two functions is that we're now checking for !page_evictable
> coming from shrink_active_list, which shouldn't change any behavior since that
> path works with evictable pages only.

Sounds good.
