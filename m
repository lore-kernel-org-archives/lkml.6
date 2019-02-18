Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E581C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693E0218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfBRIUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:20:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:46304 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBRIUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:20:34 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gveA0-0007p3-1w; Mon, 18 Feb 2019 11:20:20 +0300
Subject: Re: [PATCH v2 4/4] mm: Generalize putback scan functions
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <155014039859.28944.1726860521114076369.stgit@localhost.localdomain>
 <155014053725.28944.7960592286711533914.stgit@localhost.localdomain>
 <20190215203926.ldpfniqwpn7rtqif@ca-dmjordan1.us.oracle.com>
 <b2fcd214-52a5-6284-81b9-8a09de27fbea@virtuozzo.com>
 <20190215221335.32zqxhwtcr2kmgku@ca-dmjordan1.us.oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3e408cad-38f3-e15d-f2b8-d0c136707c9a@virtuozzo.com>
Date:   Mon, 18 Feb 2019 11:20:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215221335.32zqxhwtcr2kmgku@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2019 01:13, Daniel Jordan wrote:
> On Fri, Feb 15, 2019 at 10:01:05PM +0000, Kirill Tkhai wrote:
>> On 15.02.2019 23:39, Daniel Jordan wrote:
>>> On Thu, Feb 14, 2019 at 01:35:37PM +0300, Kirill Tkhai wrote:
>>>> +static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>>> +						     struct list_head *list)
>>>>  {
>>>>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>> +	int nr_pages, nr_moved = 0;
>>>>  	LIST_HEAD(pages_to_free);
>>>> +	struct page *page;
>>>> +	enum lru_list lru;
>>>>  
>>>> -	/*
>>>> -	 * Put back any unfreeable pages.
>>>> -	 */
>>>> -	while (!list_empty(page_list)) {
>>>> -		struct page *page = lru_to_page(page_list);
>>>> -		int lru;
>>>> -
>>>> +	while (!list_empty(list)) {
>>>> +		page = lru_to_page(list);
>>>>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>>>> -		list_del(&page->lru);
>>>>  		if (unlikely(!page_evictable(page))) {
>>>> +			list_del_init(&page->lru);
>>>
>>> Why change to list_del_init?  It's more special than list_del but doesn't seem
>>> needed since the page is list_add()ed later.
>>
>> Not something special is here, I'll remove this _init.
>>  
>>> That postprocess script from patch 1 seems kinda broken before this series, and
>>> still is.  Not that it should block this change.  Out of curiosity did you get
>>> it to run?
>>
>> I fixed all new warnings, which come with my changes, so the patch does not make
>> the script worse.
>>
>> If you change all already existing warnings by renaming variables in appropriate
>> places, the script will work in some way. But I'm not sure this is enough to get
>> results correct, and I have no a big wish to dive into perl to fix warnings
>> introduced by another people, so I don't plan to do with this script something else.
> 
> Ok, was asking in case I was doing something wrong.
> 
> With the above change, for the series, you can add
> 
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Ok, thanks.
