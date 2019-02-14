Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B492229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393159AbfBNKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:30:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:42820 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388383AbfBNKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:30:41 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1guEHu-00051w-Bd; Thu, 14 Feb 2019 13:30:38 +0300
Subject: Re: [PATCH 2/4] mm: Move nr_deactivate accounting to
 shrink_active_list()
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998444590.18704.9387109537711017589.stgit@localhost.localdomain>
 <20190213191348.tpwwu3m7o3cmg7ma@ca-dmjordan1.us.oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4e6627e9-ef49-9636-cc36-ccba295ad9bf@virtuozzo.com>
Date:   Thu, 14 Feb 2019 13:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213191348.tpwwu3m7o3cmg7ma@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 22:13, Daniel Jordan wrote:
> On Tue, Feb 12, 2019 at 06:14:05PM +0300, Kirill Tkhai wrote:
>> We know, which LRU is not active.
> 
> s/,//
> 
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/vmscan.c |   10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 84542004a277..8d7d55e71511 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2040,12 +2040,6 @@ static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
>>  		}
>>  	}
>>  
>> -	if (!is_active_lru(lru)) {
>> -		__count_vm_events(PGDEACTIVATE, nr_moved);
>> -		count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
>> -				   nr_moved);
>> -	}
>> -
>>  	return nr_moved;
>>  }
>>  
>> @@ -2137,6 +2131,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>>  
>>  	nr_activate = move_active_pages_to_lru(lruvec, &l_active, &l_hold, lru);
>>  	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, &l_hold, lru - LRU_ACTIVE);
>> +
>> +	__count_vm_events(PGDEACTIVATE, nr_deactivate);
>> +	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
> 
> Nice, you're using the irq-unsafe one since irqs are already disabled.  I guess
> this was missed in c3cc39118c361.  Do you want to insert a patch before this
> one that converts all instances of this pattern in vmscan.c over?

I had that in plan, but I'm not sure I want to do that in this patchset. Maybe,
something next later on top of this.

> There's a similar oversight in lru_lazyfree_fn with count_memcg_page_event, but
> that'd mean __count_memcg_page_event which is probably overkill.
