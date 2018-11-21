Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51382145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yj86HKkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51382145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeKUNvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:51:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53760 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKUNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:51:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAL3932Z162395;
        Wed, 21 Nov 2018 03:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=acu9R0ASxvr0lLC7/1hHolYn+0XLN4JwrW+Cl8p2rRA=;
 b=Yj86HKknQ6t3UFO/BPuNLoEtZ+IVSlkMoL47JU04MbI/M20UR8/C7J0DxGCE690WC1SE
 PT/MjP3EzIci6lXjrOMzCRsCyTsVjTYnUY759ziLQwoenlBXQeM1Igake0hH7k+tapHA
 mXGROqFlC42okkJj1TSNnVLi4Sy2nK7CR8SEbUZqlnIw+sKds4Q0jIlwa7GzzsvA3AuU
 gg4jXwkl/WMGVkrzi0dg4EBoiL+BzfWL38wFNmb6kUowCjCgPZxCd+P6RtG52Cg5sEqd
 qPASy5IxzvKzxjcic2XbZ5sidez8RkwcHY6+Zaf2zQCJlkpdTPhhR6Bd9hQxPxsrkrwn vQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ntadty6gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 03:18:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAL3IIZg031899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 03:18:18 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAL3IHjP012848;
        Wed, 21 Nov 2018 03:18:17 GMT
Received: from [10.159.138.59] (/10.159.138.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 19:18:17 -0800
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
 <20181118010229.esa32zk5hpob67y7@master>
 <d3e91590-adaa-11a5-67f9-0ef15df6b07d@oracle.com>
 <20181121030241.h7rgyjtlfcnm3hki@master>
From:   Wengang Wang <wen.gang.wang@oracle.com>
Organization: Oracle Corporation
Message-ID: <9e238df6-d018-68b8-1c79-0c248abf0804@oracle.com>
Date:   Tue, 20 Nov 2018 19:18:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121030241.h7rgyjtlfcnm3hki@master>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9083 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

I think you will receive my reply to Zhong, But I am copying my comments 
for that patch here (again):

Copy starts ==>

I am not sure if the patch you mentioned intended to fix the problem here.
With that patch the negative page->pobjects would become a large 
positive value,
it will win the compare with s->cpu_partial and go ahead to unfreeze the 
partial slabs.
Though it may be not a perfect fix for this issue, it really fixes (or 
workarounds) the issue here.
I'd like to skip my patch..

<=== Copy ends

thanks,

wengang


On 2018/11/20 19:02, Wei Yang wrote:
> On Tue, Nov 20, 2018 at 09:58:58AM -0800, Wengang Wang wrote:
>> Hi Wei,
>>
>>
>> On 2018/11/17 17:02, Wei Yang wrote:
>>> On Fri, Nov 16, 2018 at 05:33:35PM -0800, Wengang Wang wrote:
>>>> The this_cpu_cmpxchg makes the do-while loop pass as long as the
>>>> s->cpu_slab->partial as the same value. It doesn't care what happened to
>>>> that slab. Interrupt is not disabled, and new alloc/free can happen in the
>>> Well, I seems to understand your description.
>>>
>>> There are two slabs
>>>
>>>      * one which put_cpu_partial() trying to free an object
>>>      * one which is the first slab in cpu_partial list
>>>
>>> There is some tricky case, the first slab in cpu_partial list we
>>> reference to will change since interrupt is not disabled.
>> Yes, two slabs involved here just as you said above.
>> And yes, the case is really tricky, but it's there.
>>
>>>> interrupt handlers. Theoretically, after we have a reference to the it,
>>>                                                                    ^^^
>>> 							 one more word?
>> sorry, "the" should not be there.
>>
>>>> stored in _oldpage_, the first slab on the partial list on this CPU can be
>>>                                               ^^^
>>> One little suggestion here, mayby use cpu_partial would be more easy to
>>> understand. I confused this with the partial list in kmem_cache_node at
>>> the first time.  :-)
>> Right, making others understanding easily is very important. I just meant
>> cpu_partial.
>>
>>>> moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>>>> then somehow can be added back as head to partial list of current
>>>> kmem_cache_cpu, though that is a very rare case. If that rare case really
>>> Actually, no matter what happens after the removal of the first slab in
>>> cpu_partial, it would leads to problem.
>> Maybe you are right, what I see is the problem on the page->pobjects.
>>
>>>> happened, the reading of oldpage->pobjects may get a 0xdead0000
>>>> unexpectedly, stored in _pobjects_, if the reading happens just after
>>>> another CPU removed the slab from kmem_cache_node, setting lru.prev to
>>>> LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>>>> prevents slabs from being moved to kmem_cache_node and being finally freed.
>>>>
>>>> We see in a vmcore, there are 375210 slabs kept in the partial list of one
>>>> kmem_cache_cpu, but only 305 in-use objects in the same list for
>>>> kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>>>> with negative _pobjects_ has the value of 0xdead0004, the next page looks
>>>> good (_pobjects is 1).
>>>>
>>>> For the fix, I wanted to call this_cpu_cmpxchg_double with
>>>> oldpage->pobjects, but failed due to size difference between
>>>> oldpage->pobjects and cpu_slab->partial. So I changed to call
>>>> this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>>>> happen in between, but just want to make sure the first slab did expereince
>>>> a remove and re-add. This patch is more to call for ideas.
>>> Maybe not an exact solution.
>>>
>>> I took a look into the code and change log.
>>>
>>> _tid_ is introduced by commit 8a5ec0ba42c4 ('Lockless (and preemptless)
>>> fastpaths for slub'), which is used to guard cpu_freelist. While we don't
>>> modify _tid_ when cpu_partial changes.
>>>
>>> May need another _tid_ for cpu_partial?
>> Right, _tid_ changes later than cpu_partial changes.
>>
>> As pointed out by Zhong Jiang, the pobjects issue is fixed by commit
> Where you discussed this issue? Any reference I could get a look?
>
>> e5d9998f3e09 (not sure if by side effect, see my replay there),
> I took a look at this commit e5d9998f3e09 ('slub: make ->cpu_partial
> unsigned int'), but not see some relationship between them.
>
> Would you mind show me a link or cc me in case you have further
> discussion?
>
> Thanks.
>
>> I'd skip this patch.?? If we found other problems regarding the change of
>> cpu_partial, let's fix them. What do you think?
>>
>> thanks,
>> wengang

