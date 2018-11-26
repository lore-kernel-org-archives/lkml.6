Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF58720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gny2btUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeK0DxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:53:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:53:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQGrkf9133617;
        Mon, 26 Nov 2018 16:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YmIfZUKsusEwPzQJ+x9Ah6VYs08Xx4LmFf/R4kPx+qo=;
 b=gny2btUd2YCyLv4Q6FA4Xd6HKSpEtvm5eAbNEKrLsqh766/2Zb3QLT3YFzasmQ8D0n5d
 O31LDVV+cwbWfKkVxsX98LVwG6ub8Gw5354q30AEBLknhN3hYXCGB+TicTfWktWwxtbQ
 x+cbY4VK5WbHApCUrAHbhrS5a3Eskwfh2UpZvVhjLOFerNI+0ch0R+qpnV1i1tTJ/ibw
 RNeYYfNSdiQEiWWFEfVb4Dvlnc1YPLObGLD6jB80ageDqearBSGJHzyqyxnsxE7lcCV6
 aUmRKqZ7m28VbbMQ4aLOsEifuZc86pSdIoEI+hxOmkskz/alU1HYftuuroYtBsPxkNAK pg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9qy02c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 16:58:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQGvxDM015330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 16:57:59 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQGvwKJ017120;
        Mon, 26 Nov 2018 16:57:59 GMT
Received: from [10.159.138.192] (/10.159.138.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 08:57:57 -0800
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
To:     Wei Yang <richard.weiyang@gmail.com>,
        zhong jiang <zhongjiang@huawei.com>
Cc:     Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
 <5BF36EE9.9090808@huawei.com>
 <CADZGycb=kxdqSdbdXNWwmgyWp2CtC3-UFmy1-PqtdgS2BrmyjA@mail.gmail.com>
From:   Wengang Wang <wen.gang.wang@oracle.com>
Organization: Oracle Corporation
Message-ID: <476b5d35-1894-680c-2bd9-b399a3f4d9ed@oracle.com>
Date:   Mon, 26 Nov 2018 08:57:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADZGycb=kxdqSdbdXNWwmgyWp2CtC3-UFmy1-PqtdgS2BrmyjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/25 17:59, Wei Yang wrote:
> On Tue, Nov 20, 2018 at 10:58 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> On 2018/11/17 9:33, Wengang Wang wrote:
>>> The this_cpu_cmpxchg makes the do-while loop pass as long as the
>>> s->cpu_slab->partial as the same value. It doesn't care what happened to
>>> that slab. Interrupt is not disabled, and new alloc/free can happen in the
>>> interrupt handlers. Theoretically, after we have a reference to the it,
>>> stored in _oldpage_, the first slab on the partial list on this CPU can be
>>> moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>>> then somehow can be added back as head to partial list of current
>>> kmem_cache_cpu, though that is a very rare case. If that rare case really
>>> happened, the reading of oldpage->pobjects may get a 0xdead0000
>>> unexpectedly, stored in _pobjects_, if the reading happens just after
>>> another CPU removed the slab from kmem_cache_node, setting lru.prev to
>>> LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>>> prevents slabs from being moved to kmem_cache_node and being finally freed.
>>>
>>> We see in a vmcore, there are 375210 slabs kept in the partial list of one
>>> kmem_cache_cpu, but only 305 in-use objects in the same list for
>>> kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>>> with negative _pobjects_ has the value of 0xdead0004, the next page looks
>>> good (_pobjects is 1).
>>>
>>> For the fix, I wanted to call this_cpu_cmpxchg_double with
>>> oldpage->pobjects, but failed due to size difference between
>>> oldpage->pobjects and cpu_slab->partial. So I changed to call
>>> this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>>> happen in between, but just want to make sure the first slab did expereince
>>> a remove and re-add. This patch is more to call for ideas.
>> Have you hit the really issue or just review the code ?
>>
>> I did hit the issue and fixed in the upstream patch unpredictably by the following patch.
>> e5d9998f3e09 ("slub: make ->cpu_partial unsigned int")
>>
> Zhong,
>
> I took a look into your upstream patch, while I am confused how your patch
> fix this issue?
>
> In put_cpu_partial(), the cmpxchg compare cpu_slab->partial (a page struct)
> instead of the cpu_partial (an unsigned integer). I didn't get the
> point of this fix.

I think the patch can't prevent pobjects from being set as 0xdead0000 
(the primary 4 bytes of LIST_POISON2).
But if pobjects is treated as unsigned integer,

2266                         pobjects = oldpage->pobjects;
2267                         pages = oldpage->pages;
2268                         if (drain && pobjects > s->cpu_partial) {
2269                                 unsigned long flags;

line 2268 will be true in put_cpu_partial(), thus code goes to 
unfreeze_partials(). This way the slabs in the cpu partial list can be 
moved to kmem_cache_nod and then freed. So it fixes (or say workarounds) 
the problem I see here (huge number of empty slabs stay in cpu partial 
list).

thanks
wengang

>> Thanks,
>> zhong jiang
>>> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
>>> ---
>>>   mm/slub.c | 20 +++++++++++++++++---
>>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index e3629cd..26539e6 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>>>   {
>>>   #ifdef CONFIG_SLUB_CPU_PARTIAL
>>>        struct page *oldpage;
>>> +     unsigned long tid;
>>>        int pages;
>>>        int pobjects;
>>>
>>> @@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>>>        do {
>>>                pages = 0;
>>>                pobjects = 0;
>>> -             oldpage = this_cpu_read(s->cpu_slab->partial);
>>>
>>> +             tid = this_cpu_read(s->cpu_slab->tid);
>>> +             /* read tid before reading oldpage */
>>> +             barrier();
>>> +
>>> +             oldpage = this_cpu_read(s->cpu_slab->partial);
>>>                if (oldpage) {
>>>                        pobjects = oldpage->pobjects;
>>>                        pages = oldpage->pages;
>>> @@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>>>                page->pobjects = pobjects;
>>>                page->next = oldpage;
>>>
>>> -     } while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
>>> -                                                             != oldpage);
>>> +             /* we dont' change tid, but want to make sure it didn't change
>>> +              * in between. We don't really hope alloc/free not happen on
>>> +              * this CPU, but don't want the first slab be removed from and
>>> +              * then re-added as head to this partial list. If that case
>>> +              * happened, pobjects may read 0xdead0000 when this slab is just
>>> +              * removed from kmem_cache_node by other CPU setting lru.prev
>>> +              * to LIST_POISON2.
>>> +              */
>>> +     } while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
>>> +                                      oldpage, tid, page, tid) == 0);
>>> +
>>>        if (unlikely(!s->cpu_partial)) {
>>>                unsigned long flags;
>>>
>>

